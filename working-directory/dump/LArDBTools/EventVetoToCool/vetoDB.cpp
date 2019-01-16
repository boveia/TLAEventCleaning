#include "vetoDB.h"
#include "CoolApplication/DatabaseSvcFactory.h"
#include "CoolKernel/RecordSpecification.h"

#include <set>

const uint32_t noiseWord=0x1U<<15;
const uint32_t miniNoiseWord=0x1U<<16;
const uint32_t corruptedWord=0x80U<<24;

bool checkOverlaps(const std::vector<VetoRange_t>& vetoRanges) {

  bool failure=false;
  cool::ValidityKey lastIOVEnd=0;
  for (const auto& rg : vetoRanges) {
    if (rg.startTime<lastIOVEnd) {
      std::cout << "ERROR, found overlappig IOV" << std::endl;
      failure=true;
    }
    lastIOVEnd=rg.stopTime;
  }
  return failure;
}

VetoDB::VetoDB(const std::string& dbName, const std::string& fdName, const std::string& EStagName, const std::string& BKtagName, bool create) 
  : m_dbName(dbName),
    m_fdName(fdName),
    m_ESTagName(EStagName),
    m_BKTagName(BKtagName),
    m_dbOk(false),
    m_create(create) {

  //Open the database and do a few sanity checks
  if(create) {
    m_db = cool::DatabaseSvcFactory::databaseService().createDatabase(m_dbName);
    std::string desc="<timeStamp>time</timeStamp><addrHeader><address_header service_type=\"71\" clid=\"40774348\" /></addrHeader><typeName>AthenaAttributeList</typeName>";
    cool::RecordSpecification rspec = cool::RecordSpecification();
    rspec.extend("EventVeto",cool::StorageType::UInt32);
    cool::FolderSpecification spec(cool::FolderVersioning::MULTI_VERSION, rspec);
    m_db->createFolder(fdName,spec,desc, true);
    
  } else {
     this->open();
  }

  // Get folder description
  if (!m_db) return; //ERROR, failed to open 


  if (!m_db->existsFolder(m_fdName)) {
    std::stringstream errmsg;
    errmsg << " Folder " << m_fdName << " does not exist.";
#ifdef ERS_ERS_H
    daq::rc::BadVetoDB i(ERS_HERE, errmsg.str().c_str());
    ers::error(i);
#else
    std::cout << "ERROR: " << errmsg.str() << std::endl;
#endif
    return; //ERROR, folder doesn't exist
  }

  //Get folder specs
  cool::IFolderPtr folder=m_db->getFolder(m_fdName);
  m_spec=folder->payloadSpecification();

  if(create){
      //folder->tagCurrentHead(m_ESTagName);
      //folder->cloneTagAsUserTag(m_ESTagName,m_BKTagName);
  } else {
    //Check if tags exists
    const std::vector<std::string>& allTags=folder->listTags();

    std::string errmsg("Folder ");
    errmsg+=m_fdName + ", Tag(s) [ ";
    bool destinationTagNotFound=false;
    if (m_ESTagName.size()>0 && std::find(allTags.begin(),allTags.end(),m_ESTagName)==allTags.end()) {
      destinationTagNotFound=true;
      errmsg += m_ESTagName+" ";
    }
    if (std::find(allTags.begin(),allTags.end(),m_BKTagName)==allTags.end()) {
      errmsg += m_BKTagName+" ";
      destinationTagNotFound=true;
    }
    errmsg+="] not found";

    if (destinationTagNotFound) {
#ifdef ERS_ERS_H
      daq::rc::BadVetoDB i(ERS_HERE, errmsg.c_str());
      ers::error(i);
#else
      std::cout << "ERROR " << errmsg << std::endl;
#endif
      return; //ERROR, tags don't exists
    }//else if tag not found
  }

  m_dbOk=true; //DB looks ok if we reached this point

  //close database now, reopen if when needed
  m_db->closeDatabase();
  return;
}

VetoDB::~VetoDB(){
  this->close();
  if (s_verbose > 0) std::cout << "Database " << m_dbName << " now closed." << std::endl;
}

 bool VetoDB::open() {
   if (m_db && m_db->isOpen()) {
     if (s_verbose > 0) std::cout << "Database already open." << std::endl;
     return true;
   }

   try {
     m_db = cool::DatabaseSvcFactory::databaseService().openDatabase(m_dbName, false);     // true = read_only
     if (s_verbose > 0) std::cout << "Database " << m_dbName << " sucessfully opened." << std::endl;
   }
   catch (std::exception &ex) {
#ifdef ERS_ERS_H
     daq::rc::BadVetoDB i(ERS_HERE, ex.what());
     ers::error(i);
#else
     std::cout << "ERROR: Failed to connect to database " << m_dbName << std::endl;
     std::cout << ex.what() << std::endl;
#endif
     return false;
   }
   return true;
 }

void VetoDB::close() {
  if (m_db && m_db->isOpen()) m_db->closeDatabase();
  m_db=0;
}


void VetoDB::purgeRecentRanges(const uint64_t ignoreOlderThan) {

  std::vector<VetoRange_t> previousRecentRanges;
  previousRecentRanges.reserve(m_recentRanges.size());
  
  previousRecentRanges.swap(m_recentRanges);


  for (const VetoRange_t& rg : previousRecentRanges) {
    if (rg.startTime>ignoreOlderThan) m_recentRanges.push_back(rg);
  }

  return;
} 

void VetoDB::purgeDuplicateRanges(std::vector<VetoRange_t>& inputRanges) const {

  std::vector<VetoRange_t> purged;
  purged.reserve(inputRanges.size());

  if (m_recentRanges.size()==0) {
    purged=inputRanges;
  }
  else {
    //Compare every input range with every recent range to find duplicates
    for (const VetoRange_t& input : inputRanges) {
      bool drop=false;
      for (const VetoRange_t& recent : m_recentRanges) {
	if (recent.startTime <= input.startTime && recent.stopTime >= input.stopTime) { // this input range is completly contained 
	  if (s_verbose) std::cout << "Veto range " << input.startTime << " - " << input.stopTime 
				   << " competly overlapping with recently uploaded veto range" << std::endl;
	  drop=true;
	  break;
	}
      }//end inner loop
      if (!drop) purged.push_back(input);
    }//end outer loop
  } // end size!=0

  
  inputRanges.swap(purged);
  return;
} 

std::vector<VetoRange_t> VetoDB::handleOverlaps(const std::vector<VetoRange_t>& ranges_std, const std::vector<VetoRange_t>& ranges_mnb, const std::vector<VetoRange_t>& ranges_cc) const {

  std::vector<VetoRange_t> result;

  if(ranges_std.size()==0 && ranges_mnb.size()==0 && ranges_cc.size()==0) return result;

  //Merge the veto periods into a single set of veto periods
  std::vector<VetoRange_t> tmpres = handleOverlaps2(ranges_std, ranges_mnb);
  result = handleOverlaps2(tmpres, ranges_cc);

  return result;
}

std::vector<VetoRange_t> VetoDB::handleOverlaps2(const std::vector<VetoRange_t>& ranges1, const std::vector<VetoRange_t>& ranges2) const {

  //Organising the Time stamps from 2 list
  std::vector<TimeStamps> timestampvector = buildTSvector(ranges1,ranges2);
  //Recreate veto periods 
  std::vector<VetoRange_t>mergedranges=mergevetoperiods(timestampvector);
    
  return mergedranges ;

}

std::vector<TimeStamps> VetoDB::buildTSvector(const std::vector<VetoRange_t>& ranges1, const std::vector<VetoRange_t>& ranges2) const {

  std::vector<TimeStamps> orederedtimestamps ;
  std::vector<VetoRange_t>::const_iterator ib1=ranges1.begin();
  std::vector<VetoRange_t>::const_iterator ib2=ranges2.begin();
  std::vector<VetoRange_t>::const_iterator ie1=ranges1.end();
  std::vector<VetoRange_t>::const_iterator ie2=ranges2.end();
  std::vector<VetoRange_t>::const_iterator i1 ;
  std::vector<VetoRange_t>::const_iterator i2 ;

  //Fill vector of Time stamps (with status before, after and from which list it comes)
  for (i1=ib1;i1<ie1 ; i1++){
    TimeStamps TSB ;
    TSB.timeStamp=(*i1).startTime;
    TSB.flagBefore =0 ;
    TSB.flagAfter = (*i1).flag ;
    TSB.algoType = 1 ;
    orederedtimestamps.push_back(TSB);
    
    TimeStamps TSE ;
    TSE.timeStamp=(*i1).stopTime;
    TSE.flagBefore =(*i1).flag ;
    TSE.flagAfter = 0 ;
    TSE.algoType = 1 ;
    orederedtimestamps.push_back(TSE);
  }

  for (i2=ib2 ;i2 <ie2 ; i2++){
    TimeStamps TSB ;
    TSB.timeStamp=(*i2).startTime;
    TSB.flagBefore =0 ;
    TSB.flagAfter = (*i2).flag ;
    TSB.algoType = 2 ;
    orederedtimestamps.push_back(TSB);

    TimeStamps TSE ;
    TSE.timeStamp=(*i2).stopTime;
    TSE.flagBefore =(*i2).flag ;
    TSE.flagAfter = 0 ;
    TSE.algoType = 2 ;
    orederedtimestamps.push_back(TSE);
  }

  //Ordering the Time stamp vector by time
  orderingbytime orderingfunc ;
  std::sort (orederedtimestamps.begin(), orederedtimestamps.end(), orderingfunc) ;
  return orederedtimestamps ;
}

int VetoDB::updateStatus(uint8_t& status1, uint8_t& status2 , TimeStamps TS ) const{
  if (TS.algoType==1){
    status1=TS.flagAfter;
  }
  else {
    status2=TS.flagAfter;
  }

  return 0;
} 

std::vector<VetoRange_t> VetoDB::mergevetoperiods(const std::vector<TimeStamps>& TimeStampsvector ) const {

  std::vector<VetoRange_t> mergedlist ;
  std::vector<TimeStamps>::const_iterator ib=TimeStampsvector.begin(); 
  std::vector<TimeStamps>::const_iterator ie=TimeStampsvector.end();
  std::vector<TimeStamps>::const_iterator i ;              
  
  int numberTimeStamps=0;
  uint8_t status1=0;
  uint8_t status2=0;
    
  for (i=ib;i<ie ; i++){//Loop over all the ordered time stamps
    int statusint1=status1;
    int statusint2=status2;
    TimeStamps thisTS=(*i);
    if (numberTimeStamps==0){ //If first time stamp just update status
      updateStatus(status1,status2,thisTS);
      numberTimeStamps++;
      continue ;
    }
    TimeStamps previousTS=(*(i-1)); // If two time stamps are the same just adjust the status word
    if (thisTS.timeStamp==previousTS.timeStamp){
      updateStatus(status1,status2,thisTS);
      numberTimeStamps++;
      continue;
    }
    else if (status1+status2==0){
      updateStatus(status1,status2,thisTS);
      numberTimeStamps++;
      continue;
    }
    else { // Else create veto period between pervious and current time stamp with summ of status
      
      VetoRange_t *localperiod = new VetoRange_t(previousTS.timeStamp,thisTS.timeStamp,status1+status2) ;
      std::vector<unsigned> dummyvector ;
      mergedlist.push_back((*localperiod));
      delete localperiod ;
      updateStatus(status1,status2,thisTS);
      numberTimeStamps++;
      
    }
  }
  
  return mergedlist ;

}

bool VetoDB::store(std::vector<VetoRange_t>& vetoRanges) {

  if (vetoRanges.size()==0) return true; //Do nothing if no input

  //purge any duplicate ranges 
  
  purgeDuplicateRanges(vetoRanges);

  const cool::ChannelId chId(0);

  if (!this->open()) {
    std::cout << "ERROR while uploading: Failed to open destination database!" << std::endl;
    return false;
  }

  cool::IFolderPtr folder=m_db->getFolder(m_fdName);

  if (s_verbose) std::cout << "Start writing ..." << std::endl;

  cool::Record payload(folder->payloadSpecification()); //FIXME, can we re-use the same obj?
  //try:
  //catch
  for (const auto& rg : vetoRanges) {
    if (s_verbose) std::cout << "IOV start: " << rg.startTime << ", stop " << rg.stopTime << ", nEvents=" << rg.evtIndices.size() << " flag "<< unsigned(rg.flag)<< std::endl; 
    cool:: HvsTagLock::Status lockstat;
    uint32_t vetoWord=0U;
    if(0x3 & rg.flag) vetoWord |= noiseWord;
    if((0x20 & rg.flag) || (0x40 & rg.flag)) vetoWord |= miniNoiseWord; //0x20 is MININOISEBURSTTIGHT and it is accompanied with 0x40 MININOISEBURSTPSVETO
    if(0x80 &rg.flag) vetoWord |= corruptedWord;
    if(!vetoWord) {
          unsigned int uf=rg.flag;
          std::cout << "Wrong flag 0x"<<std::hex<<uf<<std::dec<<" NOT WRITING !! "<<std::endl; 
          continue;
    }
    std::cout<<"vetoword "<<vetoWord<<std::endl;
    payload["EventVeto"].setValue(vetoWord);
    try {
      //1. Store data for express processing
      if(m_ESTagName.size() > 0) {
         if(m_create) {
            folder->storeObject(rg.startTime,rg.stopTime,payload,chId,m_ESTagName);      //Store data with folder-level tag for express processing
         } else {
            lockstat=folder->tagLockStatus(m_ESTagName);                                                                  //Remember previous locking state
            if (lockstat!=cool::HvsTagLock::UNLOCKED) folder->setTagLockStatus(m_ESTagName,cool::HvsTagLock::UNLOCKED);   //Set the lock state to unlock
            folder->storeObject(rg.startTime,rg.stopTime,payload,chId,m_ESTagName);      //Store data with folder-level tag for express processing
            if (lockstat!=cool::HvsTagLock::UNLOCKED) folder->setTagLockStatus(m_ESTagName,lockstat);                     //Relock if it was locked before
         }
      }


      //2. Store the same for bulk processing
      if(m_BKTagName.size() > 0) {
       if(m_create) {
         folder->storeObject(rg.startTime,rg.stopTime,payload,chId,m_BKTagName);      //Store data with folder-level tag for bulk processing
       } else {
        lockstat=folder->tagLockStatus(m_BKTagName);                                                                  //Remember previous locking state
        if (lockstat!=cool::HvsTagLock::UNLOCKED) folder->setTagLockStatus(m_BKTagName,cool::HvsTagLock::UNLOCKED);   //Set the lock-state to unlock
        folder->storeObject(rg.startTime,rg.stopTime,payload,chId,m_BKTagName);      //Store data with folder-level tag for bulk processing
        if (lockstat!=cool::HvsTagLock::UNLOCKED) folder->setTagLockStatus(m_BKTagName,lockstat);                     //Relock if it was locked before
       }
     }
    }
    catch (...) {
#ifdef ERS_ERS_H
      daq::rc::BadVetoDB i(ERS_HERE, "Exception caught while uploading to database. Will retry later");
      ers::error(i);
#else
      std::cout << "ERROR: Exception caught while uploading to database. Will retry later" << std::endl;
#endif
      return false;
    }
    m_recentRanges.push_back(rg);
  }//end loop over ranges
  return true;
}

bool VetoDB::storeToSqlite(const std::vector<VetoRange_t>& vetoRanges, const std::string& sqlitelocation) const {
  
  const std::string descr="<timeStamp>time</timeStamp><addrHeader><address_header service_type=\"71\" clid=\"40774348\" /></addrHeader><typeName>AthenaAttributeList</typeName>";
  
  cool::RecordSpecification spec;
  spec.extend("EventVeto",cool::StorageType::UInt32);
  
  cool::FolderSpecification folderSpec(cool::FolderVersioning::MULTI_VERSION,spec);

  //char sqlitespec[1024];
  //snprintf(sqlitespec,1023,"sqlite://;schema=%s;dbname=CONDBR2",sqlitelocation);
  //sqlitespec[1023]='\0'; 

  std::string sqlitespec=std::string("sqlite://;schema=")+sqlitelocation+";dbname=CONDBR2";

  cool::IDatabasePtr sqDB= cool::DatabaseSvcFactory::databaseService().createDatabase(sqlitespec); 
  if (sqDB  && sqDB->isOpen())
    if (s_verbose) std::cout << "Successfully opend sqlite " << sqlitespec << std::endl;
  else {
    std::cout << "ERROR, failed to open sqlite file " << sqlitespec << std::endl;
    return false;
  }

  
  cool::IFolderPtr folder;
  if (sqDB->existsFolder(m_fdName))
    folder=sqDB->getFolder(m_fdName);
  else
    folder=sqDB->createFolder(m_fdName,folderSpec,descr,true);
 
  const cool::ChannelId chId(0);
  cool::Record payload(spec); //FIXME, can we re-use the same obj?


  for (const auto& rg : vetoRanges) {
    if (s_verbose) std::cout << "IOV start: " << rg.startTime << ", length " << rg.stopTime-rg.startTime << ", nEvents=" << rg.evtIndices.size() << std::endl; 
    uint32_t vetoWord=0U;
    if(0x2 & rg.flag) vetoWord |= noiseWord; 
    if((0x20 & rg.flag) || (0x10 & rg.flag)) vetoWord |= miniNoiseWord; 
    if(0x80 & rg.flag) vetoWord |= corruptedWord; 
    if(!vetoWord) {
          unsigned int uf=rg.flag;
          std::cout << "Wrong flag 0x"<<std::hex<<uf<<std::dec<<" NOT WRITING !! "<<std::endl; 
          continue;
    }
    payload["EventVeto"].setValue(vetoWord);
    try {
      folder->storeObject(rg.startTime,rg.stopTime,payload,chId,m_BKTagName);  //Store data with folder-level tag for bulk processing
    }
    catch (...) {
#ifdef ERS_ERS_H
      daq::rc::BadVetoDB i(ERS_HERE, "Exception caught while uploading to sqlite backup.");
      ers::error(i);
#else
      std::cout << "ERROR: Exception caught while uploading to sqlite backup." << std::endl;
#endif
      return false;
    }
  }

  sqDB->closeDatabase();
  return true;
}
