#ifndef FILLLARNOISEBURSTCANDIDATES_H
#define FILLLARNOISEBURSTCANDIDATES_H

#include <vector>
#include <string>

class VetoBuilder;
class TFile;

extern int s_verbose;

class FillLArNoiseBurstCandidates {

public:
 FillLArNoiseBurstCandidates(int RunNumber, bool fromCosmicCalo=true, bool fromExpress=true, bool fromMain=false, bool fromNoiseBurst=true, bool copytotemp=false, const char *infile=0);
 bool isInit(){return m_init;}
 bool fill(VetoBuilder *nb, bool fillNoise=true, bool fillCorruption=true,
         std::vector<std::pair<std::pair<unsigned long, unsigned long>, std::vector<unsigned> > > *missingFebs = nullptr);

 void removeTmpfiles();

 unsigned int getNfiles() const {return m_histofiles.size();}

private:

 void fillNoiseFromROOT(VetoBuilder *nb, TFile *f, std::string tname);
 void fillCorruptionFromROOT(VetoBuilder *nb, TFile *f, std::string tname,
              std::vector<std::pair<std::pair<unsigned long, unsigned long>, std::vector<unsigned> > > *missingFebs);


 int m_run;
 bool m_init;
 std::vector<std::string> m_histofiles;
 std::string m_tempdir;
};
#endif
