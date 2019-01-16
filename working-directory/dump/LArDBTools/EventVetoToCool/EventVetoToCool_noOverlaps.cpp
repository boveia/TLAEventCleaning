// Offline version of event veto uploading algorithm
// based on Online version by Walter
//
#include <stdlib.h>
#include <signal.h>
#include <unistd.h>
#include <boost/program_options.hpp>
#include <iostream>

#include "noiseVetoStructs.h"

#include "vetoBuilder.h"
#include "vetoDB.h"

#include <thread>

#define EV_OFFLINE

#include "Larg/LArNoiseBurstCandidates.h"
#include "FillLArNoiseBurstCandidates.h"

int s_verbose=0;

uint8_t stdnoise_word=0x2;
//uint8_t mnb_word=0x20;
uint8_t mnb_word=0x10;
//uint8_t cc_word=0xFF;
uint8_t cc_word=0x80;

// --------------------- MAIN ----------------------------//
int main(int argc, char **argv)
{
  // parse commandline parameters
  boost::program_options::options_description desc("This program uploads veto periods to oracle based on time-stamps");
  desc.add_options()
    ("help,h", "help message")
    ("run,r", boost::program_options::value<int>(), "RunNumber")
    ("coolDb,d", boost::program_options::value<std::string>(), "Name of COOL database")
    ("folder,f", boost::program_options::value<std::string>(), "Name of the COOL folder")
    ("EStag,t", boost::program_options::value<std::string>(), "Name of the COOL folder-level tag for express processing")
    ("BKtag,b", boost::program_options::value<std::string>(), "Name of the COOL folder-level tag for bulk processing")
    ("fromCosmicCalo,s", boost::program_options::value<bool>(), "Read from CosmicCalo histograms")
    ("fromExpress,e", boost::program_options::value<bool>(), "Read from Express histograms")
    ("fromMain", boost::program_options::value<bool>(), "Read from Main histograms")
    ("fromNoiseBurst", boost::program_options::value<bool>(), "Read from NoiseBursts histograms")
    ("withNoise,n", boost::program_options::value<bool>(), "Fill noise bursts")
    ("withMNB,y", boost::program_options::value<bool>(), "Fill mini-noise bursts")
    ("withCorruption,x", boost::program_options::value<bool>(), "Fill data corruption")
    ("verbose,v", boost::program_options::value<int>(), "Verbose")
    ("timeWindow,w",boost::program_options::value<float>(),"Length of the veto period in seconds")
    ("timeWindowMNB,l",boost::program_options::value<float>(),"Length of the MNB veto period in seconds")
    ("minCandidates,c",boost::program_options::value<unsigned>(),"Requried number of noise-burst candidates with a time-window to form a noise burst")
    ("minCandidatesMNB,j",boost::program_options::value<unsigned>(),"Requried number of MNB noise-burst candidates with a time-window to form a noise burst")
    ("minStdFlag,ms",boost::program_options::value<unsigned>(),"Requried number of noise-burst candidates with a standard flag")
    ("minStdFlagMNB,k",boost::program_options::value<unsigned>(),"Requried number of MNB noise-burst candidates with a standard flag")
    ("uploadInterval,u", boost::program_options::value<unsigned>(),"Don't upload more often than every <uploadInterval> seconds")
    ("ignoreOlderThan,i",boost::program_options::value<unsigned>(),"Ignore noise-burst candidates that are older than <ignoreOlderThan> seconds")
    ("guardRegion,g",boost::program_options::value<unsigned>(),"Leave noise-bursts ending later than now-<guardRegion> to the next evaluation")
    ("backupPath,a", boost::program_options::value<std::string>(), "Path where to store a backup sqlite file")
    ("inputFile,p", boost::program_options::value<std::string>(), "Absolute innput file name")
    ("createDB,z", boost::program_options::value<bool>(), "Create new DB (used for sqlite files)")
    ("copytotemp,o", boost::program_options::value<bool>(), "Copy input files to tempdir before processing");

  boost::program_options::variables_map vm;
  boost::program_options::store(boost::program_options::parse_command_line(argc, argv, desc), vm);
  boost::program_options::notify(vm);

  std::string dbName, dbFolderName="/LAR/BadChannelsOfl/EventVeto", ESTagName="", BKTagName, backupsqlite, inFile;
  int run;

  if (vm.count("help")) {
    std::cout << desc << std::endl;
    return EXIT_SUCCESS;
  }

  if (vm.count("run") && vm.count("coolDb") && vm.count("BKtag") ) {
    run          = vm["run"].as<int>();
    dbName       = vm["coolDb"].as<std::string>();
    BKTagName    = vm["BKtag"].as<std::string>();
  } else {
    std::cout << desc << std::endl;
    std::cout<<"missing arguments <coolDb> <folder> <BKtag>"<<std::endl;
    return EXIT_FAILURE;
  }

  float timeWindow=0.05; //50 milliseconds
  unsigned minCandidates=2;//At least 2 noise burst candidates per 0.2 seconds
  unsigned minStdFlag=1;//Of which at least 1 has to have the 'std' flag

  float timeWindowMNB=0.05; //50 milliseconds
  unsigned minCandidatesMNB=1;//At least 2 noise burst candidates per 0.2 seconds
  unsigned minStdFlagMNB=1;//Of which at least 1 has to have the 'std' flag

  //Configuration parameters needed by the threads are static
  unsigned s_guardRegion=10;//Don't upload vetos from teh last 10 seconds - wait for (possible) more candidate events to arrive

  bool fromCosmicCalo=true; // read from CosmicCalo histos
  bool fromExpress=true; // read from Express histos
  bool fromMain=false; // read from Main histos
  bool fromNoiseBurst=true; // read from NoiseBursts histos
  bool withNoise=true; // fill the noise bursts flags
  bool withMNB=true; // fill the MNB flags
  bool withCorruption=true; // fill the corrupded data periods

  bool create=false; // create new DB ?
  bool copytotmp=false; //copy input files to tmpdir ?

  if (vm.count("folder"))  dbFolderName = vm["folder"].as<std::string>();
  if (vm.count("EStag"))   ESTagName    = vm["EStag"].as<std::string>();
  if (vm.count("timeWindow")) timeWindow=vm["timeWindow"].as<float>();
  if (vm.count("timeWindowMNB")) timeWindowMNB=vm["timeWindowMNB"].as<float>();
  if (vm.count("minCandidates")) minCandidates=vm["minCandidates"].as<unsigned>();
  if (vm.count("minStdFlag")) minStdFlag=vm["minStdFlag"].as<unsigned>();
  if (vm.count("minCandidatesMNB")) minCandidatesMNB=vm["minCandidatesMNB"].as<unsigned>();
  if (vm.count("minStdFlagMNB")) minStdFlagMNB=vm["minStdFlagMNB"].as<unsigned>();
  if (vm.count("guardRegion")) s_guardRegion=vm["guardRegion"].as<unsigned>();

  if (vm.count("verbose")) s_verbose = vm["verbose"].as<int>();
  
  if (vm.count("fromCosmicCalo")) fromCosmicCalo = vm["fromCosmicCalo"].as<bool>();
  if (vm.count("fromExpress")) fromExpress = vm["fromExpress"].as<bool>();
  if (vm.count("fromMain")) fromMain = vm["fromMain"].as<bool>();
  if (vm.count("fromNoiseBurst")) fromNoiseBurst = vm["fromNoiseBurst"].as<bool>();

  if (vm.count("withNoise")) withNoise = vm["withNoise"].as<bool>();
  if (vm.count("withMNB")) withMNB = vm["withMNB"].as<bool>();
  if (vm.count("withCorruption")) withCorruption = vm["withCorruption"].as<bool>();
  if (vm.count("createDB")) create = vm["createDB"].as<bool>();
  if (vm.count("copytotemp")) copytotmp = vm["copytotemp"].as<bool>();

  if (!create) {
   if (vm.count("EStag") ) {
       ESTagName  = vm["EStag"].as<std::string>();
   } else {
       std::cout << desc << std::endl;
       std::cout<<"missing arguments <EStag>"<<std::endl;
       return EXIT_FAILURE;
   }
  }

  if (vm.count("backupPath")) {
    std::string backupPath=vm["backupPath"].as<std::string>();
    //Check if the file can be opend:
    if (access(backupPath.c_str(),W_OK)==0) {
      char filename[32];
      snprintf(filename,31,"EventVetoBackup_%i.db",getpid());
      filename[31]='\0';
      backupsqlite=backupPath+"/"+filename;
    }
    else {
      std::cout << "ERROR, failed to access path for sqlite backup " << backupPath << std::endl;
      backupsqlite.clear();
    }

  }
  if (vm.count("inputFile")) {
    std::string inf=vm["inputFile"].as<std::string>();
    //Check if the file can be opend:
    if (access(inf.c_str(),R_OK)==0) {
        inFile=inf;
    } else {
         std::cout << "ERROR, failed to access path for input file " << inf << std::endl;
         inFile.clear();
    }
   }
   //Some sanity checks
  if (minStdFlag>minCandidates) {
    std::cout<<"Inconsistent arguments: minStdFlag ist greater than minCandidates"<<std::endl;
    return EXIT_FAILURE;
  }  

  if (s_verbose) {
    std::cout << "Done with parameter parsing" << std::endl;
    std::cout << "TimeWindow=" << timeWindow << " sec" << std::endl;
    std::cout << "minCandidates=" << minCandidates << std::endl;
    std::cout << "minStdFlag=" <<  minStdFlag << std::endl;

    std::cout << "guardRegion=" << s_guardRegion << " sec" << std::endl;

    std::cout << "Database folder: " <<  dbFolderName << std::endl;
    std::cout << "Express-processing tag: " << ESTagName << std::endl;
    std::cout << "Bulk-processing tag: " <<  BKTagName << std::endl;
    std::cout << "Run number:          " << run <<  std::endl;

    std::cout << "withNoise: "<<withNoise<<", withMNB: "<<withMNB<<" and withCorruption: "<<withCorruption<<std::endl;
    std::cout << "fromCosmicCalo: "<<fromCosmicCalo<<" and fromExpress: "<<fromExpress<<std::endl;
    std::cout << "fromMain: "<<fromMain<<" and fromNoiseBurst: "<<fromNoiseBurst<<std::endl;
    std::cout << "CreateDB: "<<create<<std::endl;

    if (backupsqlite.size()) 
      std::cout << "Backup sqlite file:" << backupsqlite << std::endl;
    else
      std::cout << "Backup sqlite file: None " <<  std::endl;
    if (inFile.size()) 
      std::cout << "input file:" << inFile << std::endl;
    else
      std::cout << "input file: None " <<  std::endl;
  }


 
  VetoBuilder *vetoBuilder = new VetoBuilder(timeWindow, minCandidates, minStdFlag, stdnoise_word);
  if (s_verbose) std::cout << "Instantiated new Std. VetoBuilder" << std::endl;

  VetoBuilder *vetoBuilderMNB = new VetoBuilder(timeWindowMNB, minCandidatesMNB, minStdFlagMNB, mnb_word);
  if (s_verbose) std::cout << "Instantiated new MNB VetoBuilder" << std::endl;
  
  VetoBuilder *vetoBuilderCC = new VetoBuilder(0.5, 2, 2, cc_word);
  if (s_verbose) std::cout << "Instantiated new Corrupt VetoBuilder" << std::endl;
  
  FillLArNoiseBurstCandidates *fillCandidates;
  if (inFile.size()) fillCandidates = new FillLArNoiseBurstCandidates(run, fromCosmicCalo, fromExpress, fromMain, fromNoiseBurst, copytotmp, inFile.c_str());
  else fillCandidates = new FillLArNoiseBurstCandidates(run, fromCosmicCalo, fromExpress, fromMain, fromNoiseBurst, copytotmp);

  if(fillCandidates->getNfiles() == 0 || !fillCandidates->isInit()) {
     std::cout<<" Not all input files !!!"<<std::endl;
     return EXIT_FAILURE;
  }

  if (s_verbose) std::cout << "Instantiated new filler" << std::endl;
  if(fillCandidates->isInit()) {
      if(withNoise) fillCandidates->fill(vetoBuilder, withNoise, false);
      if(withMNB) fillCandidates->fill(vetoBuilderMNB, true, false);
      if(withCorruption) fillCandidates->fill(vetoBuilderCC, false, withCorruption);
  }

  std::vector<VetoRange_t> rangesFailedToStore;
  std::vector<VetoRange_t> rangesNeverStored;

  uint64_t dropOlderThanTS=0;
  uint64_t retainAfterTimeStamp=0;
  std::vector<VetoRange_t> ranges_std;
  if(withNoise) ranges_std=vetoBuilder->evaluate(dropOlderThanTS, retainAfterTimeStamp);
  std::vector<VetoRange_t> ranges_mnb;
  if(withMNB) ranges_mnb=vetoBuilderMNB->evaluate(dropOlderThanTS, retainAfterTimeStamp);
  std::vector<VetoRange_t> ranges_cc;
  if(withCorruption) ranges_cc=vetoBuilderCC->evaluate(dropOlderThanTS, retainAfterTimeStamp);


  if(ranges_std.size() > 0 || ranges_mnb.size() > 0 || ranges_cc.size() > 0) {
     VetoDB dbHandler(dbName, dbFolderName, ESTagName, BKTagName, create);
     if (!dbHandler.isOk()) {
       std::cout << "ERROR: Failed to set up dbHandler" << std::endl;
       return EXIT_FAILURE;
     } 
     if (s_verbose) std::cout << "Database connection ok" << std::endl;
     // Here we should handle overlaps
     // no Overlap handling in this version
     //std::vector<VetoRange_t> ranges = dbHandler.handleOverlaps(ranges_std, ranges_mnb, ranges_cc); 
     //if (s_verbose) std::cout << "Have "<<ranges.size()<<" veto periods after overlap removal"<<std::endl;
     std::vector<VetoRange_t> ranges;
     if(ranges_std.size() > 0) { 
          ranges = ranges_std;
     } else if(ranges_mnb.size() > 0) {
          ranges = ranges_mnb;
     } else ranges = ranges_cc; 

     //Add ranges that failed to upload the last time (if there are any...)
     for (const VetoRange_t& oldRange : rangesFailedToStore) {
      if (oldRange.startTime>dropOlderThanTS) //young veto ranges: Will re-try to upload to oracle
	ranges.push_back(oldRange);
      else                                    //old veto range: Will not re-try but dump to sqlite at the end of teh job 
	rangesNeverStored.push_back(oldRange);
     }

    
     if (!ranges.empty()) {
      //std::sort(ranges.begin(),ranges.end()); //Basically inverts the sort order, so we upload the oldest burst first. Only really needed with a SV folder
      bool writesuccess=dbHandler.store(ranges);
      if (!writesuccess) {
	//in case of an error (eg failed to open database) retain the ranges for the next upload attempt
	rangesFailedToStore.swap(ranges);
      } else rangesFailedToStore.clear();
   
     }
    
     if (rangesNeverStored.size()>0) {
       std::cout << "ERROR, a total of " << rangesNeverStored.size() 
	      << " veto ranges could not be uploaded to the main database because of connection problems." << std::endl;

       if (backupsqlite.size()) {
          std::cout << "Will try to store these ranges in a local sqlite file (Bulk-tag only)" << std::endl;
     
          dbHandler.storeToSqlite(rangesNeverStored,backupsqlite);
       } else std::cout << "No backup sqlite file location given" << std::endl;
     }
     dbHandler.close();
  } else {
     std::cout<<"No event veto periods created......"<<std::endl;
  }

  //std::cout << "\nFinal statistics:" << std::endl;
  //vetoBuilder->printStats();

  //Now clean up:
  if(copytotmp) fillCandidates->removeTmpfiles();
  delete vetoBuilder;
  delete vetoBuilderMNB;
  delete vetoBuilderCC;
 return EXIT_SUCCESS;
}
