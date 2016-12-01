#include "LArCellRec/LArCellRescaler.h" 
#include "GaudiKernel/MsgStream.h"
#include "StoreGate/StoreGateSvc.h"
#include "CaloEvent/CaloCell.h"
#include "CaloIdentifier/CaloCell_ID.h"

LArCellRescaler::LArCellRescaler (const std::string& type, 
				  const std::string& name, 
				  const IInterface* parent) :
  CaloCellCorrection(type, name, parent) { 
  declareInterface<CaloCellCorrection>(this); 
  declareProperty("CorrectionKey",m_key="ZeeCalibration",
		  "Key of the CaloCellFactor object to be used");

}
                                                                                

LArCellRescaler::~LArCellRescaler() {}


StatusCode LArCellRescaler::initialize() {
  MsgStream log(msgSvc(), name());
  log << MSG::INFO << " initialization " << endreq;

  // sc=m_detStore->regHandle(m_factors,m_key);
//   if (sc.isFailure()) {
//     log << MSG::ERROR << "Cound not register DataHandle<CaloRec::CaloCellFactor> with key "
// 	<< m_key << endreq;
//     return sc;
//   }


  ATH_CHECK( detStore()->regFcn(&LArCellRescaler::checkConstants,
                                dynamic_cast<LArCellRescaler*>(this),
                                m_factors,m_key) );

  return StatusCode::SUCCESS;
}


StatusCode LArCellRescaler::checkConstants(IOVSVC_CALLBACK_ARGS) {
  MsgStream log(msgSvc(), name());
  const CaloCell_ID* cellID;
  ATH_CHECK( detStore()->retrieve(cellID) );
  IdentifierHash emMin, emMax;
  cellID->calo_cell_hash_range(CaloCell_ID::LAREM,emMin,emMax);
  if (m_factors->size() != emMax) {
    log << MSG::ERROR << "CaloCellFactor object with key " << m_key 
	<< " has wrong size " << m_factors->size() 
	<< " HashMax is " <<  emMax << endreq;
    return StatusCode::FAILURE;
  }
  log << MSG::DEBUG << "CaloCellFactor object with key " << m_key << " has proper size." << endreq;
  return StatusCode::SUCCESS;
}



void LArCellRescaler::MakeCorrection(CaloCell* theCell) {
  const IdentifierHash& hash_id=theCell->caloDDE()->calo_hash();
  if (m_factors.isValid() && hash_id<m_factors->size())
    theCell->setEnergy(theCell->energy()*(*m_factors)[hash_id]);
  return;
}
