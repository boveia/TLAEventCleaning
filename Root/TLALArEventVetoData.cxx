
#include "TLAEventCleaning/TLALArEventVetoData.h"

#include <iostream>
#include <array>
#include <string>
#include <tuple>
#include <utility>
#include <exception>
#include <boost/algorithm/string.hpp>
#include <boost/format.hpp>
#include <boost/lexical_cast.hpp>
#include <boost/filesystem.hpp>
#include <boost/filesystem/fstream.hpp>
#include <boost/iostreams/device/file.hpp>
#include <boost/iostreams/filtering_stream.hpp>
#include <boost/iostreams/filter/bzip2.hpp>

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
  , _debug{false}
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

  // iterate over text files in this directory and construct file handles. do not load anything from disk (lazy loading).
  bool found_something{false};
  for( auto dir_entry : directory_iterator(data_directory) ) {
    
    bool ok{loadRunFromFilename( dir_entry.path() , true /*testOnly=true*/ )};
    if( !ok ) { 
      cout << "TLALArEventVetoData::loadFromDirectory failed to read " << dir_entry.path() << endl;
      return false;
    }
    found_something = true;
    // create file handle for later use

  } // loop over each text file in directory

  // any checks that the table contents are sane?
  if( _debug ) {
      dumpLoadedTable();
  }

  if( !found_something ) {
    cout << " TLALArEventVetoData: no event veto data found! " << endl;
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
TLALArEventVetoData::loadRunFromFilename( const boost::filesystem::path filename , const bool testOnly )
{
  // open the file. if the extension indicates it is a bzip2 file, decompress it on the fly.
  string extension = boost::filesystem::extension(filename);
  boost::iostreams::filtering_istream file;
  if( boost::algorithm::icontains( extension , ".bz2" ) ||
      boost::algorithm::icontains( extension , ".bzip2" ) ) {
    file.push( boost::iostreams::bzip2_decompressor{} );
  }
  auto file_source{ boost::iostreams::file_source(filename.string()) };
  if( !file_source.is_open() ) { return false; }
  file.push( file_source );

  bool any_insertions{false};
  set<RunNumberType> found_runs;
  
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
    
    // normal line:
    // Event Veto ['MiniNoiseBurst'], Mon Aug 15 00:21:38 2016 UTC-Mon Aug 15 00:21:38 2016 UTC (0.010 )  Run 306310, LB 1003 (1471220498122718208.000000,1471220498112718080.000000)

    vector<string> fields(25); // 24 space-or-comma-or-parentheses-or-period-or-...-separated fields in a veto line
    split( fields , line , is_any_of(" ,().[]'") , token_compress_on );
    // field(0-21) / desc
    // 2: veto interval type
    // 17: run number
    // 18: 'LB' if one LB, 'LBs' if range of LBs
    // 19: lumi block
    // 22,20: stop and start (note reversed order)

    // with mini noise bursts, some lines can look like:
    // Event Veto ['NoiseBurst', 'MiniNoiseBurst'], Mon Aug 15 00:21:52 2016 UTC-Mon Aug 15 00:21:52 2016 UTC (0.010 )  Run 306310, LB 1003 (1471220512684932864.000000,1471220512674932736.000000)
    // in this case, concatenate the elements of the vector to give 'NoiseBurst+MiniNoiseBurst'
    if (fields.size()==26) {
      vector<string> newfields(fields);
      newfields[2] = newfields[2]+"+"+newfields[3];
      newfields.erase(newfields.cbegin()+3);
      fields.swap(newfields);
    }

    if( fields.size()!=25 ) {
      cout << "TLALaArEventVetoData::loadRunFromFilename could not parse " << filename << " at line:" << endl;
      cout << line << endl;
      cout << "fields.size() = " << fields.size() << endl;
      return false;
    }
    const string line_interval_type{fields[2]};
    // bool lbn_range{false};
    RunNumberType line_run;
    LumiBlockType line_lbni;
    LumiBlockType line_lbnf;
    unsigned long line_tsi;
    unsigned long line_tsf;
    try {
      line_run = lexical_cast<RunNumberType>(fields[17]);
      if( fields[18]=="LBs" ) {
        // lbn_range = true;
        vector<string> lbn_fields;
        split( lbn_fields , fields[19] , is_any_of("-") , token_compress_on );
        line_lbni = lexical_cast<LumiBlockType>(lbn_fields[0]);
        line_lbnf = lexical_cast<LumiBlockType>(lbn_fields[1]);
      } else {
        // lbn_range = false;
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

    // if testOnly, then do not insert entries into the table. just return an empty table for the current run number.
    if( testOnly ) {
      if( _t.find(line_run)!=_t.end() ) {
        cout << "TLALaArEventVetoData::loadRunFromFilename run data already read for " << line_run << endl;
        return false;
      }
      _t[line_run] = EventVetoFileHandle(filename,false,EventVetoLumiBlocks());
      return true;
    }
    
    assert( !testOnly );
    
    // insert this interval into the table
    for( auto lbn = line_lbni; lbn!=(line_lbnf+1); ++lbn ) {
      // insertInterval( line_run , lbn , line_tsi , line_tsf );
      if( _debug ) {
        cout << " inserting interval:"
             << " run " << line_run
             << " LBN " << lbn
             << " start: " << line_tsi
             << " end " << line_tsf
             << " type " << line_interval_type
             << endl;
      }
      insertInterval( line_run , lbn , line_tsi , line_tsf, line_interval_type );
      any_insertions = true;
      found_runs.insert( line_run );
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
    _t[run] = EventVetoFileHandle(filename,true/*load completed*/,EventVetoLumiBlocks());
  }

  // sort all intervals in the run for rapid search
  for( auto ri=std::begin(found_runs), rf=std::end(found_runs); ri!=rf; ++ri ) {
    auto found_run{*ri};
    EventVetoTable::iterator thi = _t.find(found_run);
    assert( thi!=_t.end() ); // each run in the found_runs set should have been inserted, by definition.
    // mark loaded
    std::get<1>(thi->second) = true;
    // sort each interval range
    for( auto li=std::begin(std::get<2>(thi->second)), lf=std::end(std::get<2>(thi->second)); li!=lf; ++li ) {
      sort( std::begin(li->second) , std::end(li->second) ,
            [](const TimeStampRange& a, const TimeStampRange& b) {
              return ((a.start.ts<b.start.ts) || (a.start.ts==b.start.ts && (a.start.ts_ns_offset < b.start.ts_ns_offset)));
            } );
    }
  }

  if( _debug ) {
    dumpLoadedTable();
  }
    
  // done
  return true;
}

void
TLALArEventVetoData::insertInterval( const RunNumberType& run , const LumiBlockType& lbn ,
                                    const unsigned long& begin_ts , const unsigned long& end_ts, 
                                    const std::string& interval_type)
{
  // first check if loaded is true. if so, we have to invalidate the run cache first
  if( _loaded ) {
    _currun = 0;
    _lbns_for_currun = nullptr;
  }
  // insert
  EventVetoIntervals& intervals = std::get<2>(_t[run])[lbn];
  TimeStampType begin_ts_sec{static_cast<uint32_t>(begin_ts / 1000000000ul)};
  TimeStampType end_ts_sec{static_cast<uint32_t>(end_ts / 1000000000ul)};
  TimeStampType begin_ts_ns{static_cast<uint32_t>(begin_ts % 1000000000ul)};
  TimeStampType end_ts_ns{static_cast<uint32_t>(end_ts % 1000000000ul)};
  intervals.emplace_back( TimeStampRange({{begin_ts_sec,begin_ts_ns},{end_ts_sec,end_ts_ns},interval_type}) );
}

void
TLALArEventVetoData::dumpLoadedTable()
{
  cout << "TLALArEventVetoData::dumpLoadedTable(): " << endl;
  // compute some statistics
  unsigned long nIntervals{0ul};
  unsigned long nLBs{0ul};
  for( auto ri=std::begin(_t), rf=std::end(_t); ri!=rf; ++ri ) {
    auto hi=ri->second;
    for( auto li=std::begin(std::get<2>(hi)), lf=std::end(std::get<2>(hi)); li!=lf; ++li ) {
      int intervals = std::distance( std::begin(li->second) , std::end(li->second) );
      cout << "run: " << ri->first << " LB " << li->first << " nIntervals: " << intervals << endl;
      for( auto ii=std::begin(li->second), fi=std::end(li->second); ii!=fi; ++ii ) {
        cout << "run: " << ri->first
             << " LB " << li->first
             << " start: " << (ii->start.ts*1000000000ul)+ii->start.ts_ns_offset
             << " stop: " << (ii->stop.ts*1000000000ul)+ii->stop.ts_ns_offset
             << endl;
      }
    }
  }
  cout << " TLALArEventVetoData: contains " << _t.size() << " runs"
       << " in " << nLBs << " LBs"
       << endl; // << " LBs from directory " << directory_path << endl;
}


bool
TLALArEventVetoData::shouldVeto( const RunNumberType& run , const LumiBlockType& lbn ,
                                 const TimeStampType& ts , const TimeStampType& ts_ns_offset )
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
    
  // look up run. check 'cached' run first.
  updateRunCache(run);

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
  
  return false;
}


std::string
TLALArEventVetoData::vetoType( const RunNumberType& run , const LumiBlockType& lbn ,
                              const TimeStampType& ts , const TimeStampType& ts_ns_offset )
{
  // Check the type of LAr event veto that has fired for the event
  // recorded at the given timestamp (which has two parts, 'ts'
  // (seconds) and 'ts_ns_offset' (nanoseconds)) for the lumiblock
  // 'lbn' during run number 'run'. All four variables can be found
  // from the EventInfo header for an event.
  //
  // Returns a string e.g. "NoiseBurst", "MiniNoiseBurst", "MoiseBurst+MiniNoiseBurts"
  // based on the entry in the input file. Returns "none" if event not vetoed.
  // Throws an exception if the event veto data has not been loaded, or if
  // the event did not re is no (even empty) event veto data provided for the given run.
    
  // look up run. check 'cached' run first. 
  updateRunCache(run);
  
  // look up LB
  const EventVetoLumiBlocks& blocks{*_lbns_for_currun};
  auto il = blocks.find(lbn);
  if( il == blocks.end() ) { throw std::exception(); }
  
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
    return interval.interval_type;
  }

  return "none";
}


void
TLALArEventVetoData::updateRunCache(const RunNumberType& run)
{
  if (run!=0 && run==_currun && _lbns_for_currun!=nullptr ) { return; }
  // need to switch runs.
  auto ir{_t.find(run)};
  if( ir==_t.end() ) { throw std::exception(); }
  // do we need to load the current run from disk?
  const EventVetoFileHandle* lbns_handle{&(ir->second)};
  if( !std::get<1>(*lbns_handle) ) {
    // we need to load the run data from disk
    bool ok{ loadRunFromFilename( std::get<0>(*lbns_handle) , false /*testOnly=false*/ ) };
    if( !ok ) { 
      cout << "TLALArEventVetoData::loadFromDirectory failed to read " << std::get<0>(*lbns_handle) << endl;
      throw std::exception();
    }
    ir = _t.find(run);
    if( ir==_t.end() ) { throw std::exception(); }
    _currun = run;
    lbns_handle = &(ir->second);
    // list may be empty if run does not contain any veto periods
    // it is normal for some runs (e.g. short ones) to have no veto periods
    const bool loaded{ std::get<1>(*lbns_handle) };
    assert( loaded );
  }
  if( _debug ) {
    cout << " TLALArEventVetoData: switched to run " << run << endl;
  }
  _currun = run;
  _lbns_for_currun = &(std::get<2>(_t.find(_currun)->second));
}
