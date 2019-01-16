#include "TFile.h"

int test()
{
TFile *f=TFile::Open("root://eosatlas//eos/atlas/atlastier0/rucio/data16_cos/physics_CosmicCalo/00298111/data16_cos.00298111.physics_CosmicCalo.merge.HIST.x416_h122/data16_cos.00298111.physics_CosmicCalo.merge.HIST.x416_h122._0001.1");
if(!f) return -1; 
f->ls();
return 0;
}

int main(int argc, char **argv)
{
 return test();
}
