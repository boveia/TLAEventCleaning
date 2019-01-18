#ifndef WRAP_TLALAREVENTVETODATA_H
#define WRAP_TLALAREVENTVETODATA_H

#include <string>
#include <vector>
#include <map>
#include <tuple>
#include <utility>

#include <boost/filesystem/path.hpp>
//namespace boost {
//  namespace filesystem {
//    class path;
//  }
//}


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
                   const TimeStampType& ts , const TimeStampType& ts_ns_offset );

  std::string vetoType( const RunNumberType& run , const LumiBlockType& lbn ,
			const TimeStampType& ts , const TimeStampType& ts_ns_offset );

private:
  bool _loaded;
  bool _debug;

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
    std::string interval_type;
  };
  using EventVetoIntervals = std::vector<TimeStampRange>;
  using EventVetoLumiBlocks = std::map<LumiBlockType,EventVetoIntervals>;
  // in an EventVetoFileHandle, the first element is the path to the
  // event veto data file for a particular run, the second element is
  // whether that file has already been loaded from disk
  // (true=loaded), and the last is the map of EventVetoLumiBlocks.
  using EventVetoFileHandle = std::tuple<boost::filesystem::path,bool,EventVetoLumiBlocks>;
  using EventVetoTable = std::map<RunNumberType,EventVetoFileHandle>;

  EventVetoTable _t;
  // cache the run number lookup.
  mutable RunNumberType _currun;
  mutable const EventVetoLumiBlocks* _lbns_for_currun;
  
private:
  bool loadRunFromFilename( const boost::filesystem::path filename , const bool testOnly = false );
  RunNumberType runNumberFromFilename( const boost::filesystem::path filename ) const;
  void insertInterval( const RunNumberType& run , const LumiBlockType& lbn ,
                       const unsigned long& begin_ts , const unsigned long& end_ts,
		       const std::string& interval_type );
  void updateRunCache(const RunNumberType& run);
  using ParseResult = std::tuple<RunNumberType,LumiBlockType,LumiBlockType,unsigned long,unsigned long,std::string>;
  const ParseResult parseVetoLine16(const std::string& line);
  const ParseResult parseVetoLine18(const std::string& line);
  void dumpLoadedTable();
};

#endif // WRAP_TLALAREVENTVETODATA_H
