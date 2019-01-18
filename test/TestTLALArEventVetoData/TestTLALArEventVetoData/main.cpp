//
//  main.cpp
//  TestTLALArEventVetoData
//
//  Created by boveia on 1/17/16.
//

#include <iostream>
#include <cassert>
#include <vector>
#include <boost/random.hpp>
#include <boost/timer/timer.hpp>
#include "TLAEventCleaning/TLALArEventVetoData.h"

using namespace std;

int main(int argc, const char * argv[]) {
  
  // replace this path with the path to your event veto data directory
  string path_to_data = "./TLAEventCleaning/data/event-veto-info-run2/";
  
  struct TextFileInterval {
    unsigned long start;
    unsigned long stop;
    uint32_t startSec() const {
      return (start/1000000000ul);
    }
    uint32_t startNSOffset() const {
      return (start%1000000000ul);
    }
    uint32_t stopSec() const {
      return (stop/1000000000ul);
    }
    uint32_t stopNSOffset() const {
      return (stop%1000000000ul);
    }
  };

  {
    cout << " starting spot-check results of event veto data..." << endl;

    TLALArEventVetoData data;
    data.loadFromDirectory( path_to_data );

    // check a run that is not in the list
    {
      bool missing = false;
      try {
        bool veto = data.shouldVeto(499420, 0, 1447419981013013504/1000000000ul, 0);
      } catch (...) {
        missing = true;
      }
      cout << " missing run exception verified" << endl;
      assert( missing && "missing run should throw an exception" );
    }
    
    // check some against some events that we know are in the database/nearby
    {
      TextFileInterval i{1446420481863193344,1446420481913271040};
      // 50 ms duration
      bool veto = data.shouldVeto(284420, 254, i.startSec(), i.startNSOffset()+25);
      assert( veto && "should veto this event" );
      cout << " veto of event in known 288420 interval verified" << endl;
    }

    {
      // Event Veto ['NoiseBurst'], Sun Nov  1 23:21:05 2015 UTC-Sun Nov  1 23:21:05 2015 UTC (0.050 )  Run 284420, LB 247 (1446420065592197888.000000,1446420065541909760.000000)
      // Event Veto ['NoiseBurst'], Sun Nov  1 23:21:06 2015 UTC-Sun Nov  1 23:21:06 2015 UTC (0.089 )  Run 284420, LB 247 (1446420066520062976.000000,1446420066431450112.000000)
      // about 0.7 between
        // note: recall that the showEventVeto log format is (stop,start), not (start,stop)
      TextFileInterval a{1446420065541909760,1446420065592197888};
      TextFileInterval b{1446420066431450112,1446420066520062976};
      bool veto = data.shouldVeto(284420, 247, a.startSec(), a.startNSOffset()+100);
      assert( veto && "should veto this event" );
      cout << " veto of event in known 288420 interval verified" << endl;
      veto = data.shouldVeto(284420, 247, a.stopSec(), a.stopNSOffset()+1);
      assert( !veto && "should not veto this event" );
      cout << " non-veto of event known to be outside 288420 intervals verified" << endl;
      veto = data.shouldVeto(284420, 247, b.startSec(), b.startNSOffset()-25);
      assert( !veto && "should not veto this event" );
      cout << " non-veto of event known to be outside 288420 intervals verified" << endl;
      // Event Veto ['NoiseBurst'], Wed Oct 26 20:35:00 2016 UTC-Wed Oct 26 20:35:00 2016 UTC (0.020 )  Run 311481, LB 859 (1477514100558606336.000000,1477514100538863872.000000)
      // Event Veto ['MiniNoiseBurst'], Wed Oct 26 20:35:15 2016 UTC-Wed Oct 26 20:35:15 2016 UTC (0.001 )  Run 311481, LB 859 (1477514115985445376.000000,1477514115984445440.000000)
      TextFileInterval c{1477514115984445440,1477514115985445376};
      veto = data.shouldVeto(311481, 859, c.startSec(), c.startNSOffset()-500);
      assert( !veto && "should not veto this event" );
      cout << " veto of event in known 288420 mininoiseburst interval verified" << endl;
      veto = data.shouldVeto(311481, 859, c.startSec(), c.startNSOffset()+100);
      assert( veto && "should veto this event" );
      cout << " non-veto of event known to be outside 288420 intervals verified" << endl;
    }
  }
  
  // now stress test the lookup.
  // create this list with "ls -1 event-veto-*.txt | awk -F '-' '{print $3}' | awk -F '.' '{print $1}' > runs.txt" and then regex replace "^J" with ,
  std::vector<uint32_t> run_numbers_2016{276073,276147,276161,276176,276181,276183,276189,276212,276245,276262,276329,276330,276336,276416,276511,276689,276731,276778,276790,276952,276954,277025,278727,278729,278731,278734,278748,278880,278912,278968,278970,279169,279259,279279,279284,279345,279515,279598,279685,279764,279813,279867,279928,279932,279984,280231,280273,280319,280368,280422,280423,280464,280500,280520,280614,280673,280753,280853,280862,280950,280977,281070,281074,281075,281130,281143,281317,281327,281381,281385,281411,282625,282631,282712,282784,282992,283074,283155,283270,283429,283608,283780,284006,284154,284213,284285,284420,284427,284473,284484,301912,301918,301932,301973,302053,302137,302265,302269,302300,302347,302380,302391,302393,302737,302829,302831,302872,302919,302925,302956,303007,303059,303079,303201,303208,303264,303266,303291,303304,303338,303421,303499,303560,303638,303832,303846,303892,303943,304006,304008,304128,304178,304198,304211,304243,304308,304337,304409,304431,304494,305380,305543,305571,305618,305671,305674,305723,305727,305735,305777,305811,305920,306269,306278,306310,306384,306419,306442,306448,306451,307126,307195,307259,307306,307354,307358,307394,307454,307514,307539,307569,307601,307619,307656,307710,307716,307732,307861,307935,308047,308084,309375,309390,309440,309516,309640,309674,309759,310015,310247,310249,310341,310370,310405,310468,310473,310634,310691,310738,310809,310863,310872,310969,311071,311170,311244,311287,311321,311365,311402,311473,311481};
  std::vector<uint32_t> run_numbers_2018{276073,276147,276161,276176,276181,276183,276189,276212,276245,276262,276329,276330,276336,276416,276511,276689,276731,276778,276790,276952,276954,277025,278727,278729,278731,278734,278748,278880,278912,278968,278970,279169,279259,279279,279284,279345,279515,279598,279685,279764,279813,279867,279928,279932,279984,280231,280273,280319,280368,280422,280423,280464,280500,280520,280614,280673,280753,280853,280862,280950,280977,281070,281074,281075,281130,281143,281317,281327,281381,281385,281411,282625,282631,282712,282784,282992,283074,283155,283270,283429,283608,283780,284006,284154,284213,284285,284420,284427,284473,284484,301912,301915,301918,301932,301973,302053,302137,302269,302300,302347,302393,302829,302831,302872,302919,302925,302956,303007,303059,303079,303201,303208,303264,303266,303291,303304,303338,303421,303499,303560,303638,303726,303811,303817,303819,303832,303846,303892,303943,304006,304008,304128,304178,304198,304211,304243,304308,304337,304409,304431,304494,305291,305293,305380,305543,305571,305618,305671,305674,305723,305727,305735,305777,305811,305920,306247,306269,306278,306310,306384,306419,306442,306448,306451,306556,306655,306657,306714,307124,307126,307195,307259,307306,307354,307358,307394,307454,307514,307539,307569,307601,307619,307656,307710,307716,307732,307861,307935,308047,308084,309375,309390,309440,309516,309640,309674,309759,310015,310210,310247,310249,310341,310370,310405,310468,310473,310574,310634,310691,310738,310781,310809,310863,310872,310969,311071,311170,311244,311287,311321,311365,311402,311473,311481,325713,325789,325790,326439,326446,326468,326551,326657,326695,326834,326870,326923,326945,327057,327103,327265,327342,327490,327582,327636,327662,327745,327761,327764,327860,327862,328017,328042,328099,328221,328263,328333,328374,328393,329385,329484,329542,329716,329778,329780,329829,329835,329869,329964,330025,330074,330079,330101,330160,330166,330203,330294,330328,330470,331033,331082,331085,331129,331215,331239,331462,331466,331479,331697,331710,331742,331772,331804,331825,331860,331875,331905,331951,331975,332303,332304,332720,332896,332915,332953,332955,333181,333192,333367,333380,333426,333469,333487,333519,333650,333707,333778,333828,333853,333904,333979,333994,334264,334317,334350,334384,334413,334443,334455,334487,334564,334580,334588,334637,334678,334710,334737,334779,334842,334849,334878,334890,334907,334960,334993,335016,335022,335056,335082,335083,335131,335170,335177,335222,335282,335290,336505,336506,336548,336567,336630,336678,336719,336782,336832,336852,336915,336927,336944,336998,337005,337052,337107,337156,337176,337215,337263,337335,337371,337404,337451,337491,337542,337662,337705,337833,338183,338220,338259,338263,338349,338377,338480,338498,338608,338675,338712,338767,338834,338846,338897,338933,338967,338987,339037,339070,339205,339346,339387,339396,339435,339500,339535,339562,339590,339758,339849,339957,340030,340072,340368,340453,340644,340683,340697,340718,340814,340849,340850,340910,340918,340925,340973,341027,341123,341184,341294,341312,341419,341534,341615,341649,348197,348251,348354,348403,348495,348511,348609,348610,348618,348836,348885,348894,348895,349011,349014,349033,349051,349111,349114,349169,349263,349268,349309,349327,349335,349451,349481,349498,349526,349533,349534,349582,349592,349637,349646,349693,349841,349842,349944,349977,350013,350067,350121,350144,350160,350184,350220,350310,350361,350431,350440,350479,350531,350682,350749,350751,350803,350842,350848,350880,350923,351062,351160,351223,351296,351325,351359,351364,351455,351550,351628,351636,351671,351698,351832,351894,351969,352056,352107,352123,352274,352340,352394,352436,352448,352494,352514,354396,355261,355273,355331,355389,355416,355468,355529,355544,355563,355599,355650,355651,355754,355848,355861,355877,355995,356077,356095,356124,356177,356205,356250,356259,357193,357283,357293,357355,357409,357451,357500,357539,357620,357679,357713,357750,357772,357821,357887,357962,358031,358096,358115,358175,358215,358233,358300,358325,358333,358395,358516,358541,358577,358615,358656,358985,359010,359058,359124,359170,359171,359191,359279,359286,359310,359355,359398,359441,359472,359541,359586,359593,359623,359677,359678,359717,359735,359766,359823,359872,359918,360026,360063,360129,360161,360209,360244,360293,360309,360348,360373,360402,360414,361738,361795,361862,362204,362297,362345,362354,362388,362445,362552,362619,362661,362776,363033,363096,363129,363198,363262,363400,363664,363710,363738,363830,363910,363947,363979,364030,364076,364098,364160,364214,364292};
  std::vector<uint32_t> run_numbers{run_numbers_2018};
  assert( run_numbers.size()==654 );
  boost::random::mt19937 gen;
  boost::random::uniform_int_distribution<uint32_t> make_run(0,run_numbers.size()-1);
  boost::random::uniform_int_distribution<uint32_t> make_lbn(1,2000);
    boost::random::uniform_int_distribution<unsigned long> make_ts(1439413081827032064,1446530604045700352); // smallest and largest timestamps in the veto list (approximately 82 days difference)
  // or to the end of 2016 data: 1477516533236929024

  {
    cout << " starting data-like single-run test..." << endl;
    boost::timer::cpu_timer timer;
    timer.start();
    TLALArEventVetoData data;
    data.loadFromDirectory( path_to_data );
    unsigned long niterations = 10000000ul;
    unsigned long nvetos = 0ul;
    uint32_t run = run_numbers[make_run(gen)];
    for( unsigned long iev=0; iev!=niterations; ++iev ) {
      // progress every 1M events
      if( iev%1000000==0 ) {
        cout << " processing event " << iev << endl;
      }
      uint32_t lbn = make_lbn(gen);
      unsigned long ts_long = make_ts(gen);
      uint32_t ts = static_cast<uint32_t>(ts_long/1000000000ul);
      uint32_t ts_ns = static_cast<uint32_t>(ts_long%1000000000ul);
      //    timer.resume();
      bool veto = data.shouldVeto(run, lbn, ts, ts_ns);
      if( veto ) { ++nvetos; }
      //    timer.stop();
    }
    timer.stop();
    cout << " timer: " << niterations << " iterations: " << timer.format() << endl;
    cout << " number of vetoes: " << nvetos << " (" << nvetos/(float)niterations << ")" << endl;
  }
  {
    cout << " starting data-like run-progression test..." << endl;
    boost::timer::cpu_timer timer;
    timer.start();
    TLALArEventVetoData data;
    data.loadFromDirectory( path_to_data );
    unsigned long niterations = 10000000ul;
    unsigned long nvetos = 0ul;
    uint32_t run = run_numbers[make_run(gen)];
    for( unsigned long iev=0; iev!=niterations; ++iev ) {
      // progress every 1M events
      if( iev%1000000==0 ) {
        cout << " processing event " << iev << endl;
      }
      // change run number every 100k events
      if( iev%100000==0 ) {
        run = run_numbers[make_run(gen)];
      }
      uint32_t lbn = make_lbn(gen);
      unsigned long ts_long = make_ts(gen);
      uint32_t ts = static_cast<uint32_t>(ts_long/1000000000ul);
      uint32_t ts_ns = static_cast<uint32_t>(ts_long%1000000000ul);
      //    timer.resume();
      bool veto = data.shouldVeto(run, lbn, ts, ts_ns);
      if( veto ) { ++nvetos; }
      //    timer.stop();
    }
    timer.stop();
    cout << " timer: " << niterations << " iterations: " << timer.format() << endl;
    cout << " number of vetoes: " << nvetos << " (" << nvetos/(float)niterations << ")" << endl;
  }
  
  {
    cout << " starting random-run test..." << endl;
    // randomly access runs (thrash the cache)
    boost::timer::cpu_timer timer;
    timer.start();
    TLALArEventVetoData data;
    data.loadFromDirectory( path_to_data );
    unsigned long niterations = 10000000ul;
    unsigned long nvetos = 0ul;
    for( unsigned long iev=0; iev!=niterations; ++iev ) {
      // progress every 1M events
      if( iev%1000000==0 ) {
        cout << " processing event " << iev << endl;
      }
      uint32_t run = run_numbers[make_run(gen)];
      uint32_t lbn = make_lbn(gen);
      unsigned long ts_long = make_ts(gen);
      uint32_t ts = static_cast<uint32_t>(ts_long/1000000000ul);
      uint32_t ts_ns = static_cast<uint32_t>(ts_long%1000000000ul);
      //    timer.resume();
      bool veto = data.shouldVeto(run, lbn, ts, ts_ns);
      if( veto ) { ++nvetos; }
      //    timer.stop();
    }
    timer.stop();
    
    cout << " timer: " << niterations << " iterations: " << timer.format() << endl;
    cout << " number of vetoes: " << nvetos << " (" << nvetos/(float)niterations << ")" << endl;
  }
  
  return 0;
}
