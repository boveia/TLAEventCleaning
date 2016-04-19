
#include "TLAEventCleaning/TLALArEventVetoData.h"

#include <iostream>
#include <array>
#include <string>
#include <exception>
#include <boost/algorithm/string.hpp>
#include <boost/format.hpp>
#include <boost/lexical_cast.hpp>
#include <boost/filesystem.hpp>
#include <boost/filesystem/fstream.hpp>

using namespace std;
using namespace boost;
using namespace boost::algorithm;
using namespace boost::filesystem;
using boost::lexical_cast;
using boost::bad_lexical_cast;

TLALArEventVetoData::TLALArEventVetoData()
  : _loaded{false}
  , _currun{0}
  , _lbns_for_currun{nullptr}
{}

bool
TLALArEventVetoData::loadFromDirectory( const std::string directory_path )
{
  // try to load the event veto data found at the supplied
  // directory. Returns true if this succeeds.
  path data_directory(directory_path);
  
  if( !exists(data_directory) || !is_directory(data_directory) ) {
    cout << "TLALArEventVetoData::loadFromDirectory could not find the data directory at " << data_directory << endl;
    return false;
  }

  // iterate over text files in this directory
  bool loaded_something{false};
  for( auto dir_entry : directory_iterator(data_directory) ) {
    bool ok{loadRunFromFilename( dir_entry.path() )};
    if( !ok ) { 
      cout << "TLALArEventVetoData::loadFromDirectory failed to read " << dir_entry.path() << endl;
      return false;
    }
    loaded_something = true;
  } // loop over each text file in directory

  // sort all intervals for rapid search
  for( auto ri=std::begin(_t), rf=std::end(_t); ri!=rf; ++ri ) {
    for( auto li=std::begin(ri->second), lf=std::end(ri->second); li!=lf; ++li ) {
      sort( std::begin(li->second) , std::end(li->second) ,
            [](const TimeStampRange& a, const TimeStampRange& b) {
              return ((a.start.ts<b.start.ts) || (a.start.ts==b.start.ts && (a.start.ts_ns_offset < b.start.ts_ns_offset)));
            } );
    }
  }

  // any checks that the table contents are sane?
  if( true ) {
    // compute some statistics
    unsigned long nIntervals{0ul};
    unsigned long nLBs{0ul};
    unsigned long min_ts{std::numeric_limits<unsigned long>::max()};
    unsigned long max_ts{0ul};
    for( auto ri=std::begin(_t), rf=std::end(_t); ri!=rf; ++ri ) {
      for( auto li=std::begin(ri->second), lf=std::end(ri->second); li!=lf; ++li ) {
        ++nLBs;
        nIntervals += std::distance( std::begin(li->second) , std::end(li->second) );
        for( auto ii=std::begin(li->second), fi=std::end(li->second); ii!=fi; ++ii ) {
          min_ts = std::min( (ii->start.ts*1000000000ul)+ii->start.ts_ns_offset , min_ts );
          max_ts = std::max( (ii->stop.ts*1000000000ul)+ii->stop.ts_ns_offset , max_ts );
        }
      }
    }
    cout << " TLALArEventVetoData: loaded " << _t.size() << " runs "
    << "with " << nIntervals << " intervals in " << nLBs << " LBs from directory " << directory_path << endl;
    cout << " Minimum/Maximum timestamps: " << min_ts << " / " << max_ts << endl;
  }

  if( !loaded_something ) {
    cout << " TLALArEventVetoData: nothing loaded! " << endl;
    return false;
  }

  _loaded = true;
  
  return true;
}

TLALArEventVetoData::RunNumberType
TLALArEventVetoData::runNumberFromFilename( const boost::filesystem::path filename ) const
{
  // what is the run number? filename format should be event-veto-${runnumber}.txt
  // return 0 if failure.
  vector<string> filename_parts;
  split( filename_parts , filename.filename().string() , is_any_of("-.") );
  if( filename_parts.size()<3 ) { return 0; }
  try {
    RunNumberType run{lexical_cast<RunNumberType>(filename_parts[2])};
    return run;
  } catch( const bad_lexical_cast& ) { return 0; }
  return 0;
}


bool
TLALArEventVetoData::loadRunFromFilename( const boost::filesystem::path filename )
{
  // open the file 
  boost::filesystem::ifstream file( filename );
  if( !file || !file.is_open() ) { return false; }

  bool any_insertions{false};
  
  while( !file.eof() ) {

    // read the next line (of up to buffer_length) from the file
    constexpr unsigned int buffer_length{1024u};
    std::array<char,buffer_length> l_arr;
    file.getline(&l_arr[0],buffer_length);
    string line(l_arr.data());

    // is this an event veto line? if not, skip it.
    if( ! starts_with(line,"Event Veto ['") ) { continue; }

    // parse the run, lbn, and timestamp info. the lbn can either be a single number or
    // a range "2-3".
    
    vector<string> fields(25); // 24 space-or-comma-or-parentheses-or-period-or-...-separated fields in a veto line
    split( fields , line , is_any_of(" ,().[]'") , token_compress_on );
    // field(0-21) / desc
    // 2: veto interval type
    // 17: run number
    // 18: 'LB' if one LB, 'LBs' if range of LBs
    // 19: lumi block
    // 22,20: stop and start (note reversed order)
    if( fields.size()!=25 ) {
      cout << "TLALaArEventVetoData::loadRunFromFilename could not parse " << filename << " at line:" << endl;
      cout << line << endl;
      return false;
    }
    const string line_interval_type{fields[2]};
    bool lbn_range{false};
    RunNumberType line_run;
    LumiBlockType line_lbni;
    LumiBlockType line_lbnf;
    unsigned long line_tsi;
    unsigned long line_tsf;
    try {
      line_run = lexical_cast<RunNumberType>(fields[17]);
      if( fields[18]=="LBs" ) {
        lbn_range = true;
        vector<string> lbn_fields;
        split( lbn_fields , fields[19] , is_any_of("-") , token_compress_on );
        line_lbni = lexical_cast<LumiBlockType>(lbn_fields[0]);
        line_lbnf = lexical_cast<LumiBlockType>(lbn_fields[1]);
      } else {
        lbn_range = false;
        line_lbni = lexical_cast<LumiBlockType>(fields[19]);
        line_lbnf = line_lbni;
      }
      line_tsi = lexical_cast<unsigned long>(fields[22]);
      line_tsf = lexical_cast<unsigned long>(fields[20]);
    } catch( const bad_lexical_cast& ) {
      cout << "TLALaArEventVetoData::loadRunFromFilename could not parse run/lbn/timestamp info from " << filename << "  at line:" << endl;
      cout << line << endl;
      return false;
    }
    // sanity check that run number is correct? no, forget about
    // whether run is contained in a single file---allow text files
    // to be any combination of runs, i.e. just any pile of lines that start with "Event Veto"...
    
    //cout << boost::format("%1% %2% %3% %4% %5% %6%") % line_interval_type % line_run % line_lbni % line_lbnf % line_tsi % line_tsf << endl;
    
    // insert this interval into the table
    for( auto lbn = line_lbni; lbn!=(line_lbnf+1); ++lbn ) {
      insertInterval( line_run , lbn , line_tsi , line_tsf );
      any_insertions = true;
    }
    
  } // for each line in the file

  if( !any_insertions ) {
    // insert an empty run into the table. get the run number from
    // the filename, since it did not appear in any veto lines.
    RunNumberType run{runNumberFromFilename( filename )};
    if( run==0 ) { 
      cout << "TLALaArEventVetoData::loadRunFromFilename could not parse the filename " << filename << " for the run number." << endl;
      return false;
    }
    if( _t.find(run)!=_t.end() ) {
      cout << "TLALaArEventVetoData::loadRunFromFilename warning: run for " << filename << " already present." << endl;
    }
    _t[ run ] = EventVetoLumiBlocks();
  }

  // done
  return true;
}

void
TLALArEventVetoData::insertInterval( const RunNumberType& run , const LumiBlockType& lbn ,
                                     const unsigned long& begin_ts , const unsigned long& end_ts )
{
  // first check if loaded is true. if so, we have to invalidate the run cache first
  if( _loaded ) {
    _currun = 0;
    _lbns_for_currun = nullptr;
  }
  // insert
  EventVetoIntervals& intervals{_t[run][lbn]};
  TimeStampType begin_ts_sec{static_cast<uint32_t>(begin_ts / 1000000000ul)};
  TimeStampType end_ts_sec{static_cast<uint32_t>(end_ts / 1000000000ul)};
  TimeStampType begin_ts_ns{static_cast<uint32_t>(begin_ts % 1000000000ul)};
  TimeStampType end_ts_ns{static_cast<uint32_t>(end_ts % 1000000000ul)};
  intervals.emplace_back( TimeStampRange({{begin_ts_sec,begin_ts_ns},{end_ts_sec,end_ts_ns}}) );
}

bool
TLALArEventVetoData::shouldVeto( const RunNumberType& run , const LumiBlockType& lbn ,
                                 const TimeStampType& ts , const TimeStampType& ts_ns_offset ) const
{
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
    
  // look up run. check 'cached' run first. since the LBN table for the run will never be changed
  // during a job, we'll
  
  if( (run!=0 && run!=_currun) || _lbns_for_currun==nullptr ) {
    auto ir = _t.find(run);
    if( ir==_t.end() ) { throw std::exception(); }
    _currun = run;
    _lbns_for_currun = &(ir->second);
  }  

  // look up LB
  const EventVetoLumiBlocks& blocks{*_lbns_for_currun};
  auto il = blocks.find(lbn);
  if( il == blocks.end() ) { return false; }
  
  // do any intervals contain this timestamp?
  //   - std::function<bool(const TimeStampType&,const TimeStampType&>> 
  //     auto ts_compare = ((a.start.ts<b.start.ts) || (a.start.ts==b.start.ts && (a.start.ts_ns_offset < b.start.ts_ns_offset)));
  const EventVetoIntervals& intervals(il->second);
  EventTimeStamp event_ts{ts,ts_ns_offset};

  // do any intervals contain this timestamp?
  for( auto interval : intervals ) {
    if( event_ts < interval.start ) { continue; }
    if( interval.stop < event_ts ) { continue; }
    // yes
    return true;
  }
  
  // // find first element whose start time is >= this event timestamp
  // auto i = std::lower_bound( std::begin(intervals) , std::end(intervals) , ts ,
  //                            [](const TimeStampRange& a, const TimeStampRange& b) {
  //                              return((a.start.ts<b.start.ts) || (a.start.ts==b.start.ts && (a.start.ts_ns_offset < b.start.ts_ns_offset)));
  //                            } );
  
  return false;
}
