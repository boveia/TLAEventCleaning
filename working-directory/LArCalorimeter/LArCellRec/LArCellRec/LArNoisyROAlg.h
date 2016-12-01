#ifndef LARNOISYROALG_H
#define LARNOISYROALG_H



/** 
@class LArNoisyROAlg
@brief Find list of suspicious preamplifiers and Front End Boards from cell collection

 Created September 28, 2009  L. Duflot
 Modified May, 2014 B.Trocme 
 - Remove saturated medium cut
 - Create a new weighted Std algorithm

*/



#include "AthenaBaseComps/AthAlgorithm.h"
#include "GaudiKernel/ToolHandle.h"
#include "CaloInterface/ILArNoisyROTool.h"


class LArNoisyROAlg : public AthAlgorithm
{
 public:

  LArNoisyROAlg(const std::string &name,ISvcLocator *pSvcLocator);
  virtual StatusCode initialize();
  virtual StatusCode execute();   
  virtual StatusCode finalize();

  enum LARFLAGREASON { BADFEBS=0, MEDIUMSATURATEDQ=1, TIGHTSATURATEDQ=2, BADFEBS_W=3} ;

 private:  // classes
  unsigned m_event_counter;

  ToolHandle<ILArNoisyROTool> m_noisyROTool;

  std::string m_CaloCellContainerName;
  std::string m_outputKey;

};


#endif
