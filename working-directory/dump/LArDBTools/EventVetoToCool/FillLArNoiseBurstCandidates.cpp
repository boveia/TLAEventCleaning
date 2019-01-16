#include "FillLArNoiseBurstCandidates.h"

#include <iostream>
#include <cstdio>

#include "boost/filesystem.hpp"

#include <vector>

//#include "TSQLServer.h"
//#include "TSQLResult.h"
//#include "TSQLRow.h"
#include "TFile.h"
#include "TTree.h"

#include "noiseVetoStructs.h"
#include "vetoBuilder.h"

const char *pathrucio="/eos/atlas/atlastier0/rucio";
const char *pathlnb="/eos/atlas/atlascerngroupdisk/det-larg/Tier0/perm";
const char *lfile="/afs/cern.ch/user/l/larcalib/LArDBTools/EventVetoToCool/atlasdatadisk_data16_13TeV.txt";
//const char *stream[4]={"physics_CosmicCalo","express_express","physics_Main","calibration_LArNoiseBurst"};
// for the HI:
const char *stream[4]={"physics_CosmicCalo","express_express","physics_HardProbes","calibration_LArNoiseBurst"};
const char *streamtag[4]={"x","x","f","c"};
const char *eoscmd="eos ";
const char *copycmd="xrdcopy ";
const std::string treename_noise("/LAr/NoisyRO/LArNoise");
const std::string treename_corrupt("/LAr/FEBMon/Summary/LArCorrupted");


FillLArNoiseBurstCandidates::FillLArNoiseBurstCandidates(int RunNumber, bool fromCosmicCalo, bool fromExpress, bool fromMain, bool fromNoiseBurst, bool copytotemp, const char *infile):m_run(RunNumber),m_init(false),m_tempdir("")
{
 if(infile) {
     m_histofiles.push_back(std::string(infile));
     m_init=true;
     return;
 }  
 if(copytotemp) {
   m_tempdir=getenv("TMPDIR");
   if (m_tempdir.size()==0) {
     if(getpid()>0) m_tempdir = "/tmp/"+std::to_string(getpid()); else m_tempdir = "/tmp";
   }
   if (!boost::filesystem::exists(m_tempdir)){
    if(!boost::filesystem::create_directory(m_tempdir)){
      std::cout<<"Could not create the dir "<<m_tempdir<<std::endl;
      m_tempdir="";
      return;
    }
   }
 }
 // get project name for run
 char cmd[2500];
 /*
 TSQLServer *sfodb=TSQLServer::Connect("oracle://atlr-s.cern.ch:10121/ATLAS_T0","ATLAS_SFO_T0_R","readmesfotz2008");
 if(!sfodb) {
   std::cout<<"Could not connect to SFO database for project tag !!!"<<std::endl;
   return;
 }  
 sprintf(cmd,"SELECT PROJECT FROM SFO_TZ_RUN WHERE RUNNR=%d",RunNumber);
 TSQLResult *res=sfodb->Query(cmd);
 if((!res) || res->GetRowCount() < 2) {
   std::cout<<"Could not get info from SFO DB for run: "<<RunNumber<<std::endl;
   return;
 }
 const char *pname=res->Next()->GetField(0);
 */
 sprintf(cmd,"python /afs/cern.ch/user/l/larcalib/LArDBTools/python/GetProjectTag.py %d",RunNumber);
 FILE* pp = popen(cmd, "r");
 char pname[20];
 if (!pp || fgets(pname, 19, pp) == NULL) {
    std::cout<<"Could not get the project tag"<<std::endl;
    pclose(pp);
    return;
 }
 pclose(pp);
 //for(unsigned i=0; i<20;++i) if(pname[i]=='\n') pname[i]='\0'; 
 pname[strlen(pname)-1]='\0';
 if(strcmp(pname,"data16_calib")==0) sprintf(pname,"data16_cos");
 if(strcmp(pname,"data17_calib")==0) sprintf(pname,"data17_13TeV");
 if(strcmp(pname,"data18_calib")==0) sprintf(pname,"data18_13TeV");
 if(s_verbose) std::cout<<"Found project tag "<<pname<<" for run "<<RunNumber<<std::endl;
 bool haveCosmicCalo=false, haveExpress=false, haveMain=false, haveNoiseBurst=false;
 const char *path;
 for(unsigned istr=0; istr<4; ++istr) {
   if(istr==0 && !fromCosmicCalo) continue;
   if(istr==1 && !fromExpress) continue;
   if(istr==2 && !fromMain) continue;
   if(istr==3 && !fromNoiseBurst) continue;
   if(istr==3) path = pathlnb; else path = pathrucio;
   char lpath[1000];
   sprintf(lpath,"%s/%s/%s/%08d",path,pname,stream[istr],RunNumber);
   if(s_verbose) std::cout<<lpath<<std::endl;
   char filenamestart[100], filenamecont[100];
   sprintf(filenamestart,"%s.%08d.%s",pname,RunNumber,stream[istr]);
   if(istr==3) sprintf(filenamecont,"HIST_LARNOISE.%s",streamtag[istr]);  else sprintf(filenamecont,"HIST.%s",streamtag[istr]);
   if(s_verbose) std::cout<<"Looking for sub-directory starting with "<<filenamestart<<std::endl;
   sprintf(cmd,"bash -l -c '%s ls %s'",eoscmd,lpath);
   if(s_verbose) std::cout<<"with command "<<cmd<<std::endl;
   //std::shared_ptr<FILE> pipe(popen(cmd, "r"), pclose);
   FILE* pipe = popen(cmd, "r");
   if (!pipe) {
    std::cout<<"Could not list the directory"<<std::endl;
    return;
   }
   char buffer[2000];
   while (!feof(pipe)) {
       if (fgets(buffer, 2000, pipe) != NULL){
            buffer[strlen(buffer)-1]='\0';
            std::string sbuf(buffer);
            if( sbuf.find(filenamestart,0) <sbuf.size() && sbuf.find(filenamecont,0) <sbuf.size()) { // list this directory
                char buffer1[2000];
                sprintf(cmd,"bash -l -c '%s ls %s/%s'",eoscmd,lpath,buffer); 
                if(s_verbose) std::cout<<"Looking in "<<lpath<<"/"<<buffer<<std::endl;
                FILE* pipe1 = popen(cmd, "r");
                if(!pipe1) {
                  std::cout<<"Could not list "<<cmd<<std::endl;
                  continue;
                }
                while (!feof(pipe1)) {
                  if (fgets(buffer1, 2000, pipe1) != NULL){
                     buffer1[strlen(buffer1)-1]='\0';
                     if( sscanf(buffer1,"%s",filenamestart) > 0) {
                          if(copytotemp) {
                            //sprintf(cmd,"%s cp %s %s/%s",eoscmd,(std::string(lpath)+"/"+buffer+"/"+buffer1).c_str(),m_tempdir.c_str(),buffer1); 
                            sprintf(cmd,"bash -l -c 'xrdcp %s %s/%s'",(std::string(lpath)+"/"+buffer+"/"+buffer1).c_str(),m_tempdir.c_str(),buffer1); 
                            std::cout<<"Copy: "<<cmd<<std::endl;
                            //sprintf(cmd,"%s root://eosatlas/%s %s/%s",copycmd,(std::string(lpath)+"/"+buffer+"/"+buffer1).c_str(),m_tempdir.c_str(),buffer1); 
                            //sprintf(cmd,"xrdcp root://eosatlas/%s %s/%s",(std::string(lpath)+"/"+buffer+"/"+buffer1).c_str(),m_tempdir.c_str(),buffer1); 
                            FILE* pipe2 = popen(cmd, "r");
                            if(!pipe2) {
                                 std::cout<<"Could not copy file "<<cmd<<std::endl;
                                 continue;
                            }
                            while (!feof(pipe2)) { fgets(cmd, 1000, pipe2);} 
                            m_histofiles.push_back(std::string(m_tempdir)+"/"+buffer1); 
                            pclose(pipe2);
                          } else {
                            m_histofiles.push_back(std::string(lpath)+"/"+buffer+"/"+buffer1);
                          }
                          switch(istr) {
                              case 0:{haveCosmicCalo=true; break;}
                              case 1:{haveExpress=true; break;}
                              case 2:{haveMain=true; break;}
                              case 3:{haveNoiseBurst=true; break;}
                          }
                          if(s_verbose) std::cout<<"Added: "<<std::string(lpath)+"/"+buffer+"/"+buffer1<<std::endl;
                     }
                  }
                }
                pclose(pipe1);
            }
       }
    }
    pclose(pipe);
 }  
 if(m_histofiles.size() == 0) { // try another location of data, rucio on datadisk
   for(unsigned istr=0; istr<4; ++istr) {
      if(istr==0 && !fromCosmicCalo) continue;
      if(istr==1 && !fromExpress) continue;
      if(istr==2 && !fromMain) continue;
      if(istr==3 && !fromNoiseBurst) continue;
      if(istr==3) path = pathlnb; else path = pathrucio;
      char filenamefilter[20];
      char filenamefilter1[20];
      //sprintf(filenamefilter,"| grep HIST.%s | grep %s | grep %08d | grep %s",streamtag[istr],pname,RunNumber,stream[istr]);
      sprintf(filenamefilter,"%08d",RunNumber);
      if(istr==3) sprintf(filenamefilter1,"HIST_LARNOISE.%s",streamtag[istr]);  else sprintf(filenamefilter1,"HIST.%s",streamtag[istr]);
      FILE* pipe = fopen(lfile, "r");
      if (!pipe) {
              if(s_verbose) std::cout<<"Could not open the file "<<lfile<<std::endl;
              continue;
      }
      char buffer[2000];
      while (!feof(pipe)) {
             if (fgets(buffer, 2000, pipe) != NULL){
                buffer[strlen(buffer)-1]='\0';
                std::string sbuf(buffer);
                if( sbuf.find(filenamefilter,0) < sbuf.size() && sbuf.find(filenamefilter1,0) < sbuf.size() &&
                    sbuf.find(pname,0) <sbuf.size() && sbuf.find(stream[istr],0) <sbuf.size()) { // this is our file
                   if(copytotemp) {
                            sprintf(cmd,"env -i bash -l '%s cp %s %s/'",eoscmd,buffer,m_tempdir.c_str()); 
                            //sprintf(cmd,"xrdcp root://eosatlas/%s %s/%s",(std::string(lpath)+"/"+buffer+"/"+buffer1).c_str(),m_tempdir.c_str(),buffer1); 
                            FILE* pipe2 = popen(cmd, "r");
                            if(!pipe2) {
                                 std::cout<<"Could not copy file "<<cmd<<std::endl;
                                 continue;
                            }
                            while (!feof(pipe2)) { fgets(cmd, 1000, pipe2);} 
                            m_histofiles.push_back(std::string(m_tempdir)+"/"+&(sbuf[sbuf.rfind("/")+1])); 
                            pclose(pipe2);
                   } else {
                          m_histofiles.push_back(buffer);
                   }
                          switch(istr) {
                              case 0:{haveCosmicCalo=true; break;}
                              case 1:{haveExpress=true; break;}
                              case 2:{haveMain=true; break;}
                              case 3:{haveNoiseBurst=true; break;}
                          }
                          if(s_verbose) std::cout<<"Added: "<<buffer<<std::endl;

                }
             }
           }
   } //istr
 } // empty histofiles
 if(s_verbose) std::cout<<"Has "<<m_histofiles.size()<<" files "<<std::endl;
 if(fromCosmicCalo && !haveCosmicCalo) return;
 if(fromExpress && !haveExpress) return;
 if(fromMain && !haveMain) return;
 if(fromNoiseBurst && !haveNoiseBurst) return;

 m_init=true;
}

bool FillLArNoiseBurstCandidates::fill(VetoBuilder *nb, bool fillNoise, bool fillCorruption,
                std::vector<std::pair<std::pair<unsigned long, unsigned long>, std::vector<unsigned> > > *missingFebs)
{
  // loop over files and fill the candidates
  unsigned nn=0, nc=0;
  for(unsigned i=0; i<m_histofiles.size(); ++i) {
    TFile *inf=0;
    if(m_histofiles[i].find("eos")==std::string::npos) inf=TFile::Open(m_histofiles[i].c_str());
    else inf=TFile::Open(("root://eosatlas/"+m_histofiles[i]).c_str());
    if(!inf) {
      std::cout<<"Could not open file: "<<m_histofiles[i]<<" continue..."<<std::endl;
      continue;
    }
    TList *tl=inf->GetListOfKeys();
    for(unsigned l=0; l<tl->GetSize(); ++l) {
      const char *nm=tl->At(l)->GetName();
      if(nm[0]=='r'&&nm[1]=='u'&&nm[2]=='n'&&nm[3]=='_') {
        if(fillNoise) {
          fillNoiseFromROOT(nb,inf,nm+treename_noise);
          ++nn;
        } 
        if(fillCorruption) {
          fillCorruptionFromROOT(nb,inf,nm+treename_corrupt,missingFebs);
          ++nc;
        } 
      }
    }//keys
    if(inf && inf->IsOpen()) {inf->Close(); }
  }//m_histofiles
  std::cout<<"Filled from "<<nn<<" noise trees and "<<nc<<" corruption trees"<<std::endl;
  return true;
}

void FillLArNoiseBurstCandidates::fillNoiseFromROOT(VetoBuilder *nb, TFile *f, std::string tname) {

  TTree *t=(TTree*)f->Get(tname.c_str());
  if(!t) {
    std::cout<<"Could not read tree "<<tname<<" from file "<<f->GetName()<<std::endl;
    return;
  }
  if(t->GetEntriesFast()==0) return;

  UInt_t ut;
  UInt_t ut_ns;
  UChar_t algo;
  t->SetMakeClass(1);
  t->SetBranchAddress("time",&ut);
  t->SetBranchAddress("time_ns",&ut_ns);
  t->SetBranchAddress("algo",&algo);

  std::vector<NoiseCand_t> cand;
  for(unsigned i=0; i<t->GetEntries(); ++i) {
    t->GetEntry(i);
    if(!(algo & nb->getWord())) continue; // not our candidate flag
    const uint64_t ts=1000000000l*ut+ut_ns;
    //const uint8_t  fl=(algo | 0x00);
    //cand.push_back(NoiseCand_t(ts,fl));
    cand.push_back(NoiseCand_t(ts,algo));
  }
  nb->addCandidates(cand); 
  return; 
}

void FillLArNoiseBurstCandidates::fillCorruptionFromROOT(VetoBuilder *nb, TFile *f, std::string tname,
      std::vector<std::pair<std::pair<unsigned long, unsigned long>, std::vector<unsigned> > > *missingFebs) {

  TTree *t=(TTree*)f->Get(tname.c_str());
  if(!t) {
    std::cout<<"Could not read tree "<<tname<<" from file "<<f->GetName()<<std::endl;
    return;
  }
  std::cout<<"Filling corruption, MF size "<<missingFebs->size()<<std::endl;

  if(t->GetEntriesFast()==0) return;

  UInt_t          ut;
  UInt_t          ut_ns;
  std::vector<int>     *febHwId;
  TBranch        *b_febHwId;
  t->SetMakeClass(1);
  febHwId=0;
  t->SetBranchAddress("time", &ut);
  t->SetBranchAddress("time_ns", &ut_ns);
  t->SetBranchAddress("febHwId", &febHwId, &b_febHwId);

  std::vector<NoiseCand_t> cand;
  const uint8_t  fl=0x80; // our definition of corruption
  if(s_verbose) std::cout<<"Corr. tree has: "<<t->GetEntries()<<" entries"<<std::endl;
  for(unsigned i=0; i<t->GetEntries(); ++i) {
    t->GetEntry(i);
    const uint64_t ts=1000000000l*ut+ut_ns;
    // here we should check the MissingFEBs DB, not implemented yet
    std::vector<bool> ismissing;
    if(missingFebs->size()) {
      for (unsigned l=0; l<missingFebs->size(); ++l) {
        if(ts > missingFebs->at(l).first.first && ts < missingFebs->at(l).first.second) {
          ismissing.resize(febHwId->size());
          for (unsigned ll=0; ll<febHwId->size(); ++ll) {
             ismissing[ll]=false;
          }
          for (unsigned ll=0; ll<febHwId->size(); ++ll) {
            if (std::find(missingFebs->at(l).second.begin(), missingFebs->at(l).second.end(), febHwId->at(ll)) != missingFebs->at(l).second.end()) ismissing[ll] = true;
          }
        }
      }
      unsigned ll;
      for(ll=0; ll<ismissing.size(); ++ll) {
        if(! ismissing[ll]) break;
      } 
      if(ll < ismissing.size()) cand.push_back(NoiseCand_t(ts,fl));
    } else {
      cand.push_back(NoiseCand_t(ts,fl));
    }
  }
  nb->addCandidates(cand); 
  return; 
}

void FillLArNoiseBurstCandidates::removeTmpfiles()
{
 char cmd[2000];
 for(unsigned i=0; i<m_histofiles.size(); ++i) {
    sprintf(cmd,"/bin/rm -f %s",m_histofiles[i].c_str());
    FILE* pipe = popen(cmd, "r");
    if(!pipe) {
           std::cout<<"Could not remove "<<m_histofiles[i]<<std::endl;
           continue;
    }
 } 
}  
