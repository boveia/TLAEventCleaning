
#include "TLAEventCleaning/TLALArEventVetoData.h"

#include <iostream>
#include <array>
#include <string>
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
  for( auto dir_entry : directory_iterator(data_directory) ) {
    bool ok = loadRunFromFilename( dir_entry.path() );
    if( !ok ) { 
      cout << "TLALArEventVetoData::loadFromDirectory failed to read " << dir_entry.path() << endl;
      return false;
    }
  } // loop over each text file in directory

  // any checks that the table contents are sane?
  
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
    RunNumberType run = lexical_cast<RunNumberType>(filename_parts[2]);
    return run;
  } catch( const bad_lexical_cast& ) { return 0; }
  return 0;
}


bool
TLALArEventVetoData::loadRunFromFilename( const boost::filesystem::path filename )
{
  // get the run number from the filename
  RunNumberType run = runNumberFromFilename( filename );
  if( run==0 ) { 
    cout << "TLALaArEventVetoData::loadRunFromFilename could not parse the filename " << filename << " for the run number." << endl;
    return false;
  }
  
  // open the file for the run number
  boost::filesystem::ifstream file( filename );
  if( !file || !file.is_open() ) { return false; }

  while( !file.eof() ) {

    // read the next line (of up to buffer_length) from the file
    constexpr unsigned int buffer_length = 1024u;
    std::array<char,buffer_length> l_arr;
    file.getline(&l_arr[0],buffer_length);
    string line(l_arr.data());

    // is this an event veto line? if not, skip it.
    if( ! starts_with(line,"Event Veto ['") ) { continue; }

    // parse the run, lbn, and timestamp info
    vector<string> fields(25); // 24 space-or-comma-or-parentheses-or-period-or-...-separated fields in a veto line
    split( fields , line , is_any_of(" ,().[]'") , token_compress_on );
    // field(0-21) / desc
    // 2: veto interval type
    // 17: run number
    // 18: 'LB' if one LB, 'LBs' if range of LBs
    // 19: lumi block
    // 20,22: start and stop
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
      line_tsi = lexical_cast<unsigned long>(fields[20]);
      line_tsf = lexical_cast<unsigned long>(fields[22]);
    } catch( const bad_lexical_cast& ) {
      cout << "TLALaArEventVetoData::loadRunFromFilename could not parse run/lbn/timestamp info from " << filename << "  at line:" << endl;
      cout << line << endl;
      return false;
    }
    cout << boost::format("%1% %2% %3% %4% %5% %6%") % line_interval_type % line_run % line_lbni % line_lbnf % line_tsi % line_tsf << endl;
  } // for each line in the file
  // done
  return true;
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
  return true;
}
