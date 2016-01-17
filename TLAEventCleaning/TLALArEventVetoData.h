#ifndef WRAP_TLALAREVENTVETODATA_H
#define WRAP_TLALAREVENTVETODATA_H

#include <string>
#include <vector>
#include <map>
#include <utility>

// namespace xAOD {
//   class EventInfo;
// }

namespace boost {
  namespace filesystem {
    class path;
  }
}


class
TLALArEventVetoData
{
public:
  // doubt these will change type; defined in xAOD::EventAuxInfo
  using RunNumberType = uint32_t;
  using LumiBlockType = uint32_t;
  using TimeStampType = uint32_t;
public:
  TLALArEventVetoData();
  virtual ~TLALArEventVetoData() {}

  // try to load the event veto data found at the supplied
  // directory. Returns true if this succeeds.
  
  bool loadFromDirectory( const std::string directoryPath );

  // Look up whether the LAr event veto has fired for the event
  // recorded at the given timestamp (which has two parts, 'ts'
  // (seconds) and 'ts_ns_offset' (nanoseconds)) for the lumiblock
  // 'lbn' during run number 'run'. All four variables can be found
  // from the EventInfo header for an event.
  //
  // The LAr event veto indicates when data should be excluded because
  // of noise bursts or data corruption.
  //
  // Returns true if the event should be excluded, false otherwise.
  // Throws an exception if the event veto data has not been loaded, or if
  // there is no (even empty) event veto data provided for the given run.
  
  bool shouldVeto( const RunNumberType& run , const LumiBlockType& lbn ,
                   const TimeStampType& ts , const TimeStampType& ts_ns_offset ) const;
private:
  bool _loaded;

  struct EventTimeStamp {
    TimeStampType ts;
    TimeStampType ts_ns_offset;
    bool operator<(const EventTimeStamp& rhs) const {
      return( this->ts < rhs.ts || (this->ts==rhs.ts && this->ts_ns_offset<rhs.ts_ns_offset) );
    }
  };
  struct TimeStampRange {
    EventTimeStamp start;
    EventTimeStamp stop;
  };
  using EventVetoIntervals = std::vector<TimeStampRange>;
  using EventVetoLumiBlocks = std::map<LumiBlockType,EventVetoIntervals>;
  using EventVetoTable = std::map<RunNumberType,EventVetoLumiBlocks>;

  EventVetoTable _t;
private:
  bool loadRunFromFilename( const boost::filesystem::path filename );
  RunNumberType runNumberFromFilename( const boost::filesystem::path filename ) const;
  void insertInterval( const RunNumberType& run , const LumiBlockType& lbn ,
                       const unsigned long& begin_ts , const unsigned long& end_ts );
};

#endif // WRAP_TLALAREVENTVETODATA_H
