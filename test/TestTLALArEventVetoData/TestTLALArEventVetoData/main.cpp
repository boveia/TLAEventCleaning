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
  TLALArEventVetoData data;
  // replace this path with the path to your event veto data directory
  data.loadFromDirectory("/Users/boveia/Documents/Code/particle-physics/TLA/git-modules/TLAEventCleaning/test/TestTLALArEventVetoData/TestTLALArEventVetoData/../../../data/event-veto-data/");
  
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
  
  // check a run that is not in the list
  {
    bool missing = false;
    try {
      bool veto = data.shouldVeto(499420, 0, 1447419981013013504/1000000000ul, 0);
    } catch (...) {
      missing = true;
    }
    assert( missing && "missing run should throw an exception" );
  }
  
  // check some against some events that we know are in the database/nearby
  {
    TextFileInterval i{1446420481863193344,1446420481913271040};
    // 50 ms duration
    bool veto = data.shouldVeto(284420, 254, i.startSec(), i.startNSOffset()+25);
    assert( veto && "should veto this event" );
  }

  {
    // Event Veto ['NoiseBurst'], Sun Nov  1 23:21:05 2015 UTC-Sun Nov  1 23:21:05 2015 UTC (0.050 )  Run 284420, LB 247 (1446420065592197888.000000,1446420065541909760.000000)
    // Event Veto ['NoiseBurst'], Sun Nov  1 23:21:06 2015 UTC-Sun Nov  1 23:21:06 2015 UTC (0.089 )  Run 284420, LB 247 (1446420066520062976.000000,1446420066431450112.000000)
    // about 0.7 between
    TextFileInterval a{1446420065541909760,1446420065592197888};
    TextFileInterval b{1446420066431450112,1446420066520062976};
    bool veto = data.shouldVeto(284420, 247, a.startSec(), a.startNSOffset()+100);
    assert( veto && "should veto this event" );
    veto = data.shouldVeto(284420, 247, a.stopSec(), a.stopNSOffset()+1);
    assert( !veto && "should not veto this event" );
    veto = data.shouldVeto(284420, 247, b.startSec(), b.startNSOffset()-25);
    assert( !veto && "should not veto this event" );
  }
  
  // now stress test the lookup.
  std::vector<uint32_t> run_numbers{276073,276147,276161,276176,276181,276183,276189,276212,276245,276262,276329,276330,276336,276416,276511,276689,276731,276778,276790,276952,276954,277025,278727,278729,278731,278734,278748,278880,278912,278968,278970,279169,279259,279279,279284,279345,279515,279598,279685,279764,279813,279867,279928,279932,279984,280231,280273,280319,280368,280422,280423,280464,280500,280520,280614,280673,280753,280853,280862,280950,280977,281070,281074,281075,281130,281143,281317,281327,281381,281385,281411,282625,282631,282712,282784,282992,283074,283155,283270,283429,283608,283780,284006,284154,284213,284285,284420,284427,284473,284484};
  assert( run_numbers.size()==90 );
  boost::random::mt19937 gen;
  boost::random::uniform_int_distribution<uint32_t> make_run(0,run_numbers.size()-1);
  boost::random::uniform_int_distribution<uint32_t> make_lbn(1,2000);
  boost::random::uniform_int_distribution<unsigned long> make_ts(1439413081827032064,1446530604045700352); // smallest and largest timestamps in the veto list (approximately 82 days difference)
  
  boost::timer::cpu_timer timer;
  timer.start();
  unsigned long niterations = 10000000ul;
  unsigned long nvetos = 0ul;
  for( unsigned long iev=0; iev!=niterations; ++iev ) {
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
  
  return 0;
}
