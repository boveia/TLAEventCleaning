#ifndef TILERECUTILS_TILERAWCORRELATEDNOISE_H
#define TILERECUTILS_TILERAWCORRELATEDNOISE_H

/********************************************************************
 *
 * NAME:     TileRawCorrelatedNoise 
 * PACKAGE:  offline/TileCalorimeter/TileRecUtils
 *
 * AUTHOR :  F. Veloso
 * CREATED:  12.07.2010
 *
 ********************************************************************/

// Gaudi includes
#include "GaudiKernel/ToolHandle.h"

// Atlas includes
#include "AthenaBaseComps/AthAlgorithm.h"

class TileRawChannelBuilder;

class TileRawCorrelatedNoise: public AthAlgorithm {

  public:
    // constructor
    TileRawCorrelatedNoise(const std::string& name, ISvcLocator* pSvcLocator);
    // destructor
    virtual ~TileRawCorrelatedNoise();

    virtual StatusCode initialize();
    virtual StatusCode execute();
    virtual StatusCode finalize();

  private:

    // name of TDS container with input TileDigits
    std::string m_TileDigitsInputContainer;

    // name of TDS container with output TileDigits
    std::string m_TileDigitsOutputContainer;

    // RMS threshold
    float m_nRMS_threshold;

    // file names
    std::string m_AlphaMatrixFilePrefix;
    std::string m_Sample3RMSFilePrefix;
    std::string m_MeanFilePrefix;

    // matrices
    float AlphaMatrix[4][64][48][48];
    float MeanSamples[4][64][48][7];
    float Sample3RMS[4][64][48];

    bool m_useMeanFiles;
    bool m_pmtOrder;
};
#endif
