//
//  main.cpp
//  TestTLALArEventVetoData
//
//  Created by boveia on 1/17/16.
//

#include <iostream>
#include "TLAEventCleaning/TLALArEventVetoData.h"

int main(int argc, const char * argv[]) {
  TLALArEventVetoData data;
  data.loadFromDirectory("/Users/boveia/Documents/Code/particle-physics/TLA/git-modules/TLAEventCleaning/test/TestTLALArEventVetoData/TestTLALArEventVetoData/../../../data/event-veto-data/");
  
  return 0;
}
