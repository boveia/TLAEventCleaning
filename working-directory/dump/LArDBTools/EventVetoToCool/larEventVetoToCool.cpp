// Online version of event veto uploading algorithm
// walter.lampl@cern.ch

#include <stdlib.h>
#include <signal.h>
#include <unistd.h>
#include <boost/program_options.hpp>

// DAQ include
#include "ers/ers.h"
#include "ipc/core.h"
//#include "ipc/partition.h"
//#innclude "pmg/pmg_initSync.h"
#include "is/inforeceiver.h"
#include "RunControl/Common/Exceptions.h"

#include "Larg/LArNoiseBurstCandidates.h"
#include "noiseVetoStructs.h"
#include <chrono>
#include <thread>


using namespace Larg;

// ***********************************************************************/
// Custom ERS exceptions

namespace daq {
  ERS_DECLARE_ISSUE(rc,
    BadVetoDB,
    "Writing Event Veto to COOL failed because " << explanation,
    ((const char *)explanation)
    )

}

// ***********************************************************************/


static int s_verbose=0;

//The following code is shared with the offline version:
#include "vetoBuilder.cpp"
#include "vetoDB.cpp"

static bool s_shutdown=false;
//Semaphore sem(0U);

// IS Information Name
//const std::string IS_NoiseCandidate_Name = "WALTERIS.NoiseBurstCandidate";

//The VetoBuilder is filled by the IS callback method and read by the main thread
static VetoBuilder* s_vetoBuilder=0;


// ***********************************
// Signal Handler
// ***********************************
extern "C" void signalhandler(int)
{
  signal(SIGINT, SIG_DFL);
  signal(SIGTERM, SIG_DFL);
  s_shutdown=true;
  ERS_INFO("Terminating larEventVetoTooCool...");
}

// ******************************************************************
// IS callback functions
// ******************************************************************

void IS_callback(ISCallbackInfo *isc) {

  if (isc->reason() == is::Deleted) return; 

  //if (s_verbose > 0) std::cout << "IS callback received." << std::endl;

  // Read info from IS
  LArNoiseBurstCandidates candidates_in;
  isc->value(candidates_in);

  const size_t nCand=candidates_in.TimeStamp.size();
  //Check if sizes are in sync....

  std::vector<NoiseCand_t> candidates;
  candidates.reserve(nCand);

  for (size_t i=0;i<nCand;++i) {
    candidates.emplace_back(candidates_in.TimeStamp[i]*1000000000ULL + candidates_in.TimeStamp_ns[i], candidates_in.Flag[i]);
  }

  //if (s_verbose > 0) std::cout << "Got " << nCand << " new noise-burst candidates" << std::endl;
  if (s_verbose > 0 && nCand>0) { //FIXME: This is not thread-safe b/c of ctime usage
    std::cout << getTimeForLog() << " Received IS callback with " << nCand << " noise-burst candidates" << std::endl;
    std::cout << "TimeStamp of first candidate event: " << candidates_in.TimeStamp[0] << "s +" 
             <<  candidates_in.TimeStamp_ns[0] << "ns, Flag=" <<  (int)candidates_in.Flag[0] 
             << " " << time(nullptr) - candidates_in.TimeStamp[0] << " seconds old"  << std::endl;
  }
  s_vetoBuilder->addCandidates(candidates); //This method uses internally a mutex to protect the vector operation
  return;
}



// --------------------- MAIN ----------------------------//
int main(int argc, char **argv)
{
  try {
    IPCCore::init(argc, argv);
  }
  catch (daq::ipc::CannotInitialize& e) {
    ers::fatal(e);
    abort();
  }
  catch (daq::ipc::AlreadyInitialized& e) {
    ers::warning(e);
  }

  // parse commandline parameters
  boost::program_options::options_description desc("This program uploads veto periods to oracle based on time-stamps of noise burst candidates received from IS.");
  desc.add_options()
    ("help,h", "help message")
    ("partition,p", boost::program_options::value<std::string>(), "Name of TDAQ partition")
    //("ISName,n", boost::program_options::value<std::string>(),"Name of the IS information")
    ("ISServerName,n", boost::program_options::value<std::string>(),"Name of the IS Server")
    ("ISInformation,r", boost::program_options::value<std::string>(),"Name of the IS Information (regex)")
    ("coolDb,d", boost::program_options::value<std::string>(), "Name of COOL database")
    ("folder,f", boost::program_options::value<std::string>(), "Name of the COOL folder")
    ("EStag,t", boost::program_options::value<std::string>(), "Name of the COOL folder-level tag for express processing")
    ("BKtag,b", boost::program_options::value<std::string>(), "Name of the COOL folder-level tag for bulk processing")
    ("verbose,v", boost::program_options::value<int>(), "Verbose")
    ("timeWindow,w",boost::program_options::value<float>(),"Length of the veto period in seconds")
    ("minCandidates,c",boost::program_options::value<unsigned>(),"Requried number of noise-burst candidates with a time-window to form a noise burst")
    ("minStdFlag,s",boost::program_options::value<unsigned>(),"Requried number of noise-burst candidates with a standard flag")
    ("uploadInterval,u", boost::program_options::value<unsigned>(),"Don't upload more often than every <uploadInterval> seconds")
    ("ignoreOlderThan,i",boost::program_options::value<unsigned>(),"Ignore noise-burst candidates that are older than <ignoreOlderThan> seconds")
    ("guardRegion,g",boost::program_options::value<unsigned>(),"Leave noise-bursts ending later than now-<guardRegion> to the next evaluation")
    ("backupPath,a", boost::program_options::value<std::string>(), "Path where to store a backup sqlite file");

  boost::program_options::variables_map vm;
  boost::program_options::store(boost::program_options::parse_command_line(argc, argv, desc), vm);
  boost::program_options::notify(vm);

  std::string dbName, dbFolderName, ESTagName, BKTagName, partition, isServer, isInfo, backupsqlite;

  if (vm.count("help")) {
    std::cout << desc << std::endl;
    return EXIT_SUCCESS;
  }

  if (vm.count("coolDb") && vm.count("folder") && vm.count("partition") && vm.count("EStag") && vm.count("BKtag") && vm.count("ISServerName") && vm.count("ISInformation")) {
    dbName       = vm["coolDb"].as<std::string>();
    dbFolderName = vm["folder"].as<std::string>();
    ESTagName    = vm["EStag"].as<std::string>();
    BKTagName    = vm["BKtag"].as<std::string>();

    partition    = vm["partition"].as<std::string>();
    isServer     = vm["ISServerName"].as<std::string>();
    isInfo       = vm["ISInformation"].as<std::string>();
  } else {
    std::cout << desc << std::endl;
    daq::rc::CmdLineError issue(ERS_HERE, "missing arguments <coolDb> <folder> <partition> <EStag> <BKtag> <ISServerName> <ISInformation>");
    ers::fatal(issue);
    return EXIT_FAILURE;
  }

  float timeWindow=0.2; //200 milliseconds
  unsigned minCandidates=2;//At least 2 noise burst candidates per 0.2 seconds
  unsigned minStdFlag=1;//Of which at least 1 has to have the 'std' flag

  //Configuration parameters needed by the threads are static
  unsigned s_uploadInterval=2*60; //Don't upload more ofthen than every 2 minutes
  unsigned s_ignoreOlderThan=7*60; //Ignore noise-burst candidates that are older than 7 minutes
  unsigned s_guardRegion=10;//Don't upload vetos from teh last 10 seconds - wait for (possible) more candidate events to arrive


  if (vm.count("timeWindow")) timeWindow=vm["timeWindow"].as<float>();
  if (vm.count("minCandidates")) minCandidates=vm["minCandidates"].as<unsigned>();
  if (vm.count("minStdFlag")) minStdFlag=vm["minStdFlag"].as<unsigned>();
  if (vm.count("uploadInterval")) s_uploadInterval=vm["uploadInterval"].as<unsigned>();  
  if (vm.count("ignoreOlderThan")) s_ignoreOlderThan=vm["ignoreOlderThan"].as<unsigned>();  
  if (vm.count("guardRegion")) s_guardRegion=vm["guardRegion"].as<unsigned>();

  if (vm.count("verbose")) s_verbose = vm["verbose"].as<int>();
  
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
      daq::rc::CmdLineError issue(ERS_HERE, "Can't access path for sqlite backup");
      ers::error(issue);
      backupsqlite.clear();
    }

  }
   //Some sanity checks
  if (minStdFlag>minCandidates) {
    daq::rc::CmdLineError issue(ERS_HERE, "Inconsistent arguments: minStdFlag ist greater than minCandidates");
    ers::fatal(issue);
    return EXIT_FAILURE;
  }  


  if (s_uploadInterval>s_ignoreOlderThan && s_ignoreOlderThan!=0) {
    daq::rc::CmdLineError issue(ERS_HERE, "Inconsistent arguments: uploadInterval is greater than ignoreOlderThan");
    ers::fatal(issue);
    return EXIT_FAILURE;
  }  

  if (s_guardRegion>=s_ignoreOlderThan && s_ignoreOlderThan!=0) {
    daq::rc::CmdLineError issue(ERS_HERE, "Inconsistent arguments: guardRegion is greater than ignoreOlderThan");
    ers::fatal(issue);
    return EXIT_FAILURE;
  }  
     
  if (s_verbose) {
    std::cout << "Done with parameter parsing" << std::endl;
    std::cout << "TimeWindow=" << timeWindow << " sec" << std::endl;
    std::cout << "minCandidates=" << minCandidates << std::endl;
    std::cout << "minStdFlag=" <<  minStdFlag << std::endl;

    std::cout << "uploadInterval=" << s_uploadInterval << " sec" << std::endl;
    std::cout << "ignoreOlderThan="<< s_ignoreOlderThan << " sec" << std::endl;
    std::cout << "guardRegion=" << s_guardRegion << " sec" << std::endl;

    std::cout << "Database folder: " <<  dbFolderName << std::endl;
    std::cout << "Express-processing tag: " << ESTagName << std::endl;
    std::cout << "Bulk-processing tag: " <<  BKTagName << std::endl;

    if (backupsqlite.size()) 
      std::cout << "Backup sqlite file:" << backupsqlite << std::endl;
    else
      std::cout << "Backup sqlite file: None " <<  std::endl;
  }


  VetoDB dbHandler(dbName, dbFolderName, ESTagName, BKTagName);
  if (!dbHandler.isOk()) {
    std::cout << "ERROR: Failed to set up dbHandler" << std::endl;
    return EXIT_FAILURE;
  } 
  if (s_verbose) std::cout << "Database connection ok" << std::endl;
 
  s_vetoBuilder = new VetoBuilder(timeWindow, minCandidates, minStdFlag);
  if (s_verbose) std::cout << "Instantiated new VetoBuilder" << std::endl;

  //  std::string partitionName(partition.c_str());
  IPCPartition ipcP(partition);

  ISInfoReceiver infoRec(ipcP,false); //False means to run multi-threaded
  try {
    infoRec.subscribe(isServer, isInfo  ,IS_callback);
    if (s_verbose > 0) std::cout << "Subscribed to IS server " << isServer << " ISinfo " << isInfo << std::endl;
  }
  catch (daq::is::Exception & ex) {
    ers::fatal(ex);
    delete s_vetoBuilder;
    return EXIT_FAILURE;
  }

  // Install signal handler
  signal(SIGINT, signalhandler);
  signal(SIGTERM, signalhandler);

  // Tell PMG that now we are ready!
  // pmg_initSync();

  std::cout << "Waiting for IS callbacks...." << std::endl;

  std::chrono::seconds sleeptime(1);
  std::vector<VetoRange_t> rangesFailedToStore;
  std::vector<VetoRange_t> rangesNeverStored;
  do {

    for(unsigned countSeconds=0;countSeconds<s_uploadInterval && !s_shutdown; ++countSeconds)   {
      std::this_thread::sleep_for(sleeptime);
    }
  
    const uint64_t now=std::chrono::duration_cast<std::chrono::nanoseconds>(std::chrono::system_clock::now().time_since_epoch()).count();
    uint64_t dropOlderThanTS=0;
    if (s_ignoreOlderThan>0) 
      dropOlderThanTS=now-s_ignoreOlderThan*1000000000ULL;

    uint64_t retainAfterTimeStamp=0;
    if (!s_shutdown && s_guardRegion>0) {
      //Unless this is the last time we upload noise-bursts to the DB, leave the last noise-burst to the next upload (in case more events arriving)
      retainAfterTimeStamp=now - s_guardRegion*1000000000ULL; 
    }
   
    //Remove veto ranges older than 's_ignoreOlderThan' from cache of recently uploaded ranges
    dbHandler.purgeRecentRanges(dropOlderThanTS);

    //Now search for veto periodes (eg groups of candidates close in time). 
    //Time-stamps older than 'dropOlderThanTS' will be dropped. 
    //Time-stamps belonging to veto ranges younger 'retainAfterTimeStamp' will be kept
    std::vector<VetoRange_t> ranges=s_vetoBuilder->evaluate(dropOlderThanTS, retainAfterTimeStamp);

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
      }
      else
	rangesFailedToStore.clear();
   
    }

  }while(!s_shutdown);


  
  //Approaching the end fo the job.  Unsubscribe from IS, but let the last callbacks finish (wait for completion)
  try {
    infoRec.unsubscribe(isServer, isInfo,true);
    std::cout << "Unsubscribed from IS" << std::endl;
  }catch (ers::Issue & e) {} //Dont' really care if anything goes wrong here.

 
  //Do a last upload if needed:
  uint64_t dropOlderThanTS=0;
  if (s_ignoreOlderThan>0) {
    const uint64_t now=std::chrono::duration_cast<std::chrono::nanoseconds>(std::chrono::system_clock::now().time_since_epoch()).count();
    dropOlderThanTS=now-s_ignoreOlderThan*1000000000ULL;
  }

  std::vector<VetoRange_t> ranges=s_vetoBuilder->evaluate(dropOlderThanTS, 0);
  //Add ranges that we failed to upload the last time (if there are any...)
  for (const VetoRange_t& oldRange : rangesFailedToStore) {
      if (oldRange.startTime>dropOlderThanTS) //young veto ranges: Will re-try to upload to oracle
	ranges.push_back(oldRange);
      else                                    //old veto range: Will not re-try but dump to sqlite at the end of teh job 
	rangesNeverStored.push_back(oldRange);
    }

  if (!ranges.empty()) {
    //std::sort(ranges.begin(),ranges.end()); 
     bool writesuccess=dbHandler.store(ranges);
     if (!writesuccess) {
       //Failed to write, keep ranges to dump to sqlite
       rangesNeverStored.insert(rangesNeverStored.end(),ranges.begin(),ranges.end());
     }
  }
    
  if (rangesNeverStored.size()>0) {
    std::cout << "ERROR, a total of " << rangesNeverStored.size() 
	      << " veto ranges could not be uploaded to the main database because of connection problems." << std::endl;

    if (backupsqlite.size()) {
      std::cout << "Will try to store these ranges in a local sqlite file (Bulk-tag only)" << std::endl;
     
      dbHandler.storeToSqlite(rangesNeverStored,backupsqlite);
    }
    else
      std::cout << "No backup sqlite file location given" << std::endl;
  }
  dbHandler.close();



  std::cout << "\nFinal statistics:" << std::endl;
  s_vetoBuilder->printStats();

  //Now clean up:
  delete s_vetoBuilder;

  return EXIT_SUCCESS;
}
