#ifndef VETOBUILDER_H
#define VETOBUILDER_H

#include <vector>
#include <algorithm>
#include "stdint.h"
#include <iostream>
#include <ctime>

#include <mutex>

extern int s_verbose;

class VetoBuilder {
public:
  VetoBuilder() = delete;
  
  VetoBuilder(const float timeWindow, const unsigned minCandidates, const unsigned minStdFlag, const uint8_t usedflag=0, const uint8_t stdflagdef=0);
  
  void addCandidates(const std::vector<NoiseCand_t>& newCandidates);

  void addCandidate(const NoiseCand_t& newCandidate);

  //inline unsigned getNCandidates() const {return m_candidateCache.size();}  //Not thread save! 
  
  std::vector<VetoRange_t> evaluate(const uint64_t discardOlderThanTimeStamp, const uint64_t retainAfterTimeStamp=0);

  inline const std::vector<NoiseCand_t>& candidates() const { return m_candidateCache;}  //Not thread save! 

  void printConfig() const;

  void printStats() const; 

  uint8_t getWord(){ return m_usedflag;} 

private:
  //Configuration information:
  uint64_t m_timeWindow; //in milliseconds
  unsigned m_minCandidates;
  unsigned m_minStdFlag;
  uint8_t m_usedflag;
  uint64_t m_retainAfterTime;
  uint8_t m_stdflagdef;
  //Internal cache of caniddates
  std::vector<NoiseCand_t> m_candidateCache;
  std::mutex m_candCacheMtx;


  //Internal counter (for debugging)
  unsigned m_nDropped;
  unsigned m_periodsCounter;
  unsigned m_nEventsInBursts;
  uint64_t m_totalVetoLenght;

  //private methods:
  //This method sorts the noise-burst candidates in decending order, discards too old candidates and purges duplicates.
  void sortAndClean(std::vector<NoiseCand_t>& candidates, const uint64_t discardOlderThanTimeStamp);

 
};
#endif
