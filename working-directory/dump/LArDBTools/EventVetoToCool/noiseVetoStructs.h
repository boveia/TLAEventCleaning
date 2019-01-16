#ifndef LARNOISEVETOSTRUCTS_H
#define LARNOISEVETOSTRUCTS_H

#include <cstdint>
#include <vector>

class NoiseCand_t {
public:
  uint64_t timeStamp;
  uint8_t flag;

  NoiseCand_t(const uint64_t ts, const uint8_t fl) : timeStamp(ts), flag(fl) {};
  inline bool isStdFlag(uint8_t word ) { if(flag & word) return 1 ; else return 0;}
  inline bool operator<(const NoiseCand_t& other) const {return (this->timeStamp < other.timeStamp);}
  inline bool operator==(const NoiseCand_t& other) const {return (this->timeStamp==other.timeStamp);}
};


struct VetoRange_t {
  uint64_t startTime;
  uint64_t stopTime;
  uint8_t  flag;
  std::vector<unsigned> evtIndices;
  VetoRange_t(const uint64_t start, const uint64_t stop, const uint8_t word, std::vector<unsigned>&& indices) : startTime(start), stopTime(stop), flag(word), evtIndices(indices){};
  VetoRange_t(const uint64_t start, const uint64_t stop, const uint8_t word): startTime(start), stopTime(stop), flag(word) {};
  inline bool operator<(const VetoRange_t& other) const {return (this->startTime < other.startTime);}
};


struct TimeStamps {

  uint8_t flagBefore =0 ;
  uint8_t flagAfter = 0 ;
  uint64_t timeStamp =0 ;
  int algoType = 0 ;

};



#endif
