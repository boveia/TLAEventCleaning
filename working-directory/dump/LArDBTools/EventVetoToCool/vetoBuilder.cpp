#include "noiseVetoStructs.h"

#include "vetoBuilder.h"

#define INIT_CAND_VECTOR_SIZE 1000


std::string getTimeForLog(time_t t=0) {
  char output[32];
  if (t==0) t=time(nullptr);
  strftime(output,32,"%Y-%m-%d %H:%M:%S",std::localtime(&t));
  output[31]='\0'; //Just to be sure ....
  return std::string(output);
}


VetoBuilder::VetoBuilder(const float timeWindow, const unsigned minCandidates, const unsigned minStdFlag, const uint8_t usedflag,const uint8_t stdflagdef ) :
  m_timeWindow(timeWindow*1000000000L), 
  m_minCandidates(minCandidates), 
  m_minStdFlag(minStdFlag),
  m_usedflag(usedflag),
  m_nDropped(0),
  m_periodsCounter(0),
  m_nEventsInBursts(0),
  m_stdflagdef(stdflagdef),
  m_totalVetoLenght(0)
{

  m_candidateCache.reserve(INIT_CAND_VECTOR_SIZE);

}

void VetoBuilder::printConfig() const {
  std::cout << "Configuration of VetoBuilder:" << std::endl;
  std::cout << "Time Window: " << m_timeWindow << " ns (" << float(m_timeWindow/1000000000L) << " sec)" << std::endl;
  std::cout << "Required number of noise-burst candidate events with a time window to create a veto period: " << m_minCandidates << std::endl;
  std::cout << "with at least " << m_minStdFlag << " events from LArNoisyRO_Std" << std::endl;
  return;
}


void VetoBuilder::addCandidates(const std::vector<NoiseCand_t>& newCandidates) {
  std::lock_guard<std::mutex> lock(m_candCacheMtx);
  m_candidateCache.insert(m_candidateCache.end(),newCandidates.begin(),newCandidates.end());
  return;
}

void VetoBuilder::addCandidate(const NoiseCand_t& newCandidate) {
  std::lock_guard<std::mutex> lock(m_candCacheMtx);
  m_candidateCache.push_back(newCandidate);
  return;
}



void  VetoBuilder::sortAndClean(std::vector<NoiseCand_t>& candidates, const uint64_t discardOlderThanTimeStamp) {
  //sort noise-burst candidates by time-stamp
  //Decsending order: newest candiddate first, oldest last.
  std::sort(candidates.begin(),candidates.end(),[](const NoiseCand_t& nc1, const NoiseCand_t& nc2) {return nc1.timeStamp > nc2.timeStamp;});
  

  //Clean out elements older than guard region
  NoiseCand_t forgetBefore(discardOlderThanTimeStamp,0);
  std::vector<NoiseCand_t>::iterator earliest=std::upper_bound(candidates.begin(),candidates.end(),forgetBefore,[](const NoiseCand_t& nc1, const NoiseCand_t& nc2) {return nc1.timeStamp > nc2.timeStamp;});
  
  if (earliest!=candidates.end() && s_verbose) {
    //time_t timeStampSec= discardOlderThanTimeStamp/1000000000L;
    std::cout << "Discarding " << candidates.end()-earliest 
	      << " noise bursts candidates that are older than "<< getTimeForLog(discardOlderThanTimeStamp/1000000000L) << std::endl;
  }

  //Purgen duplicates: A duplicate time-stamp would become a noise-burst
  std::vector<NoiseCand_t>::iterator newEnd=std::unique(candidates.begin(),earliest);
  if (earliest!=newEnd && s_verbose)
    if (s_verbose) std::cout << "Removing " << earliest-newEnd << " duplicate time-stamps" << std::endl;
 
  candidates.erase(newEnd,candidates.end());
  m_nDropped+=candidates.end()-newEnd; 
  return;
}


  std::vector<VetoRange_t> VetoBuilder::evaluate(const uint64_t discardOlderThanTimeStamp, const uint64_t retainAfterTimeStamp) {

  std::vector<VetoRange_t> vetoRange; //Return value
  std::vector<NoiseCand_t> candidates; //Candidates not (yet) part of a noise-burst
  std::vector<NoiseCand_t> remainingCandidates; //Candidates not (yet) part of a noise-burst
  

  candidates.reserve(INIT_CAND_VECTOR_SIZE);


  //swap the current list of candidate events to a local variable and release the lock (go out of scope)
  {
    std::lock_guard<std::mutex> lock(m_candCacheMtx);
    m_candidateCache.swap(candidates);
  }
 
  if (s_verbose>0)  {
    std::cout << getTimeForLog() << " VetoBuilder::evaluate: Inital number of candidates=" << candidates.size() << std::endl;
  } 
  //if (s_verbose>0)  {
    //time_t now = time(0);
    //std::cout << std::asctime(std::gmtime(&now)) << " VetoBuilder::evaluate: Inital number of candidates=" << candidates.size() << std::endl;
  //}

  sortAndClean(candidates,discardOlderThanTimeStamp); 

  if (s_verbose>0)  std::cout << " VetoBuilder::evaluate: after sortAndClean candidates=" << candidates.size() << std::endl;
  const size_t nCand=candidates.size();
  

  if (nCand >= m_minCandidates ) {//need at least m_minCandidates noise burst candidates
   
    const uint64_t halfWindow=m_timeWindow/2;
    
    size_t i=0;
    unsigned nIsolatedEvt=0;

    while (i<nCand){
      unsigned int ui=candidates[i].flag;
      unsigned int uw = m_usedflag;
      std::cout<<i<<" "<<std::hex<<ui<<" / "<<uw<<std::dec<<std::endl;
      if (!(candidates[i].flag & m_usedflag)) {++i; continue;} // only our candidates
      unsigned j=1;
      unsigned nStd=0;

      nStd=candidates[i].isStdFlag(m_stdflagdef) ? 1 : 0;
      //i..starting index, j..range-length, i+j..ending index

      //We start at index i and extend the range as long as we are:
      //Within the total length
      //and 
      //the step between two candidate events is smaller than the time window
      std::vector<unsigned> evtIndices(1,i);
      while (i+j<=nCand && (candidates[i+j-1].timeStamp-candidates[i+j].timeStamp<m_timeWindow)){
        if (!(candidates[i+j].flag & m_usedflag)) {++j; continue;} // only our candidates
	
	if ( candidates[i+j].isStdFlag(m_stdflagdef) ) nStd++; //Count number of 'std' type noise burst candidate events
	evtIndices.push_back(i+j);
	++j;
      }//end inner loop
      //std::cout << "Evts: " << i+j << "/" << nCand << ", nStd=" << nStd << "/" << m_minStdFlag << std::endl;

      if ( j<m_minCandidates || nStd<m_minStdFlag) { //ignore this burst, not enough events #print j,nEvents,nStd,minStd
	//Re-evaluate, starting one event further
	remainingCandidates.push_back(candidates[i]);
	++i;
	++nIsolatedEvt;
      }
      else {
	//Found a veto periode
        unsigned int uf=m_usedflag;
	if(s_verbose) std::cout << "vetoBuilder::evaluate, usedflag: 0x"<<std::hex<<uf<<std::dec<<" creating veto period: "<<candidates[i+j-1].timeStamp-halfWindow<<" "<<candidates[i].timeStamp+halfWindow<<" : 0x"<<std::hex<<ui<<std::dec<<std::endl;
	vetoRange.emplace_back(candidates[i+j-1].timeStamp-halfWindow,candidates[i].timeStamp+halfWindow,candidates[i].flag,std::move(evtIndices));
	i+=j;
      }
    }//end outer loop

    if (retainAfterTimeStamp>0 && vetoRange.size()>0) {
      //Remember, the first element is the latest burst
      std::vector<VetoRange_t>::iterator latestBurstIt=vetoRange.begin();
      for (;latestBurstIt!=vetoRange.end() && latestBurstIt->stopTime-halfWindow >retainAfterTimeStamp; ++latestBurstIt);
      if (s_verbose) {
	//time_t timeStampSec= retainAfterTimeStamp/1000000000L;
        if(s_verbose) std::cout << getTimeForLog() << " Found " << latestBurstIt-vetoRange.begin() 
                  << " veto ranges ending later than " << getTimeForLog(retainAfterTimeStamp/1000000000L) // std::asctime(std::gmtime(&timeStampSec)) 
		  << ". Retained for next evaluation" << std::endl;
      }

      //Retain the candidates of the retained noise-bursts
      for(auto it=vetoRange.begin();it!=latestBurstIt;++it) {
	for (unsigned i : it->evtIndices) {
	  remainingCandidates.push_back(candidates[i]);
	}//end loop over event indices
      }//end loop over retained veto periods

      vetoRange.erase(vetoRange.begin(),latestBurstIt); //erase veto periodes to be retained
    } //end if retainAfterTimeStamp>0 && vetoRange.size()>0


    //Some counters for debugging purposes
    unsigned nEvtInBursts=0;
    for (const auto& rg : vetoRange) {
      ++m_periodsCounter;
      m_totalVetoLenght+=(rg.stopTime-rg.startTime);
      nEvtInBursts+=rg.evtIndices.size();
    }
    m_nEventsInBursts+=nEvtInBursts;

    if (s_verbose) {
      std::cout << getTimeForLog() << " Result of evaluation:" << std::endl;
      std::cout << "Input set: " << nCand << " Noise burst candidate events" << std::endl;
      std::cout << "Found " << vetoRange.size() << " Veto Ranges with " << nEvtInBursts << " events" << std::endl;
      std::cout << "Found " << nIsolatedEvt <<  " isolated events" << std::endl;
      std::cout << "Retaining " << remainingCandidates.size() << " events" << std::endl;
    }


    //insert the remaining candidates to the cache:
    this->addCandidates(remainingCandidates);
  }//end if have sufficient candidates     

  return vetoRange;
}

void VetoBuilder::printStats() const {
  std::cout << "Found " << m_periodsCounter << " veto periods, spanning a total " << (double)m_totalVetoLenght/1e9 
	    << " seconds, containing  " <<  m_nEventsInBursts << " noise burst candidate events." << std::endl;
  std::cout << "Dropped " << m_nDropped << " isolated events" << std::endl;
  std::cout << "Remaining number of candidates:" << m_candidateCache.size() << std::endl;
  return;
}



#undef INIT_CAND_VECTOR_SIZE
