#ifndef TILERECUTILS_TILERAWCHANNELBUILDEROPT2FILTER_H
#define TILERECUTILS_TILERAWCHANNELBUILDEROPT2FILTER_H

//////////////////////////////////////////////////////////////////////
//
//     Based on the code of Ximo Poveda@cern.ch. June 2007
//     Andrei.Artamonov@cern.ch, July 2008
//
//     TileRawChannelBuilderOpt2Filter.h
//
//     implementation of the Optimal Filtering based on Lagrange multipliers
//       for energy/time reconstruction in TileCal 
//
//////////////////////////////////////////////////////////////////////

// Tile includes
#include "TileRecUtils/TileRawChannelBuilder.h"
#include "TileConditions/ITileCondToolOfc.h"
#include "TileConditions/TileCondToolOfcCool.h"
#include "TileConditions/TileCondToolTiming.h"
#include "TileConditions/TileCondToolNoiseSample.h"

#include <vector>
#include <string>

/**
 *
 * @class TileRawChannelBuilderOpt2Filter
 * @brief Reconstructs Tile digitized pulses (ie, computes amplitude, time and pedestal) as a linear combination of the samples
 *
 * This class implements an energy recontruction method known as Optimal
 * Filtering. It takes as input the digital samples from the digitizer boards
 * in the front-end electronics and outputs the amplitude, time and pedestal
 * of the pulse. Full details and fundaments of the method can be found in
 * the ATL-TILECAL-2005-001 note. Two different versions of the algorithms
 * are currently used: OF1 (with 2 parameters: amplitude and time) and OF2
 * (with 3 parameters (amplitude, time and pedestal).
 *
 * OFCs are calculated on-the-fly (using TileCondToolOfc) or are extracted
 * from COOL database (TileCondToolOfcCool). In case of non-iterative
 * procedure, optionally, the initial, "best phase", can be extracted
 * from COOL DB by means of TileCondToolTiming.
 */
class TileRawChannelBuilderOpt2Filter: public TileRawChannelBuilder {
  public:

    TileRawChannelBuilderOpt2Filter(const std::string& type, const std::string& name,
        const IInterface *parent); //!< Constructor
    ~TileRawChannelBuilderOpt2Filter(); //!< Destructor

    // virtual methods
    virtual StatusCode initialize(); //!< Initialize method
    //virtual StatusCode execute();
    virtual StatusCode finalize(); //!< Finalize method

    // Inherited from TileRawChannelBuilder
    virtual TileRawChannel * rawChannel(const TileDigits* digits);

    /**
     * AlgTool InterfaceID
     */
    static const InterfaceID& interfaceID();

  private:

    //!< Callback added to handle Data-driven GeoModel initialization
    virtual StatusCode geoInit(IOVSVC_CALLBACK_ARGS);

    ToolHandle<TileCondToolTiming> m_tileToolTiming;
    ToolHandle<ITileCondToolOfc> m_tileCondToolOfc;
    ToolHandle<TileCondToolOfcCool> m_tileCondToolOfcCool;
    ToolHandle<TileCondToolNoiseSample> m_tileToolNoiseSample; //!< tool which provides noise values

    double Filter(int, int, int, int &, double &, double &, double &); //!< Applies OF algorithm
    float FindMaxDigit();  //!< Finds maximum digit position in the pulse
    float SetPedestal(int, int, int, int); //!< Sets pedestal estimation for OF1
    int Iterator(int, int, int, int, double &, double &, double &, double &); //!< Apply the number of iterations needed for reconstruction by calling the Filter method
    double Compute(int, int, int, int, double &, double &, double &, double); //!< Computes A,time,ped using OF. If iterations are required, the Iterator method is used
    void BuildPulseShape(std::vector<double> &m_pulseShape, std::vector<double> &m_pulseShapeX
        , std::vector<double> &m_pulseShapeT, int dignum, MsgStream &log); //!< Builds pulse shapes

    void ofc2int(int ndigits, double* w_off, short* w_int, short& scale); // convert weights to dsp short int format

    int m_maxIterations; //!< maximum number of iteration to perform
    int m_pedestalMode;  //!< pedestal mode to use
    bool m_ConfTB;       //!< use testbeam configuration
    double m_timeForConvergence; //!< minimum time difference to quit iteration procedure
    bool m_of2;    //!< bool variable for OF method: true=> OF2;  false=> OF1
    bool m_minus1Iter;   //!< bool variable for whether to apply -1 iteration (initial phase guess)
    bool m_correctAmplitude; //!< If true, resulting amplitude is corrected when using weights for tau=0 without iteration

    bool m_bestphase; // if true, use best phase from COOL DB in "fixed phase" mode (i.e., no iterations)
    bool m_ofcfromcool; // if true, take OFCs from DB (no on-fly calculations)
    bool m_emulatedsp; // if true, emulate DSP reconstruction algorithm
    int c_signal; //!< internal counters
    int c_negat;  //!< internal counters
    int c_center; //!< internal counters
    int c_const;  //!< internal counters

    int m_NSamp; //!< number of samples in the data
    int m_t0Samp;  //!< position of peak sample = (m_NSamp-1)/2
    double m_maxTime; //!< max allowed time = 25*(m_NSamp-1)/2
    double m_minTime; //!< min allowed time = -25*(m_NSamp-1)/2

    std::vector<double> m_LpulseShape_cis;  //!< vector for low gain/CIS pulse shape
    std::vector<double> m_HpulseShape_cis;  //!< vector for high gain/CIS pulse shape
    std::vector<double> m_LpulseShape_phys; //!< vector for low gain/Physics pulse shape
    std::vector<double> m_HpulseShape_phys; //!< vector for high gain/Physics pulse shape

    std::vector<double> m_LdpulseShape_cis;  //!< vector for low gain/CIS pulse derivative
    std::vector<double> m_HdpulseShape_cis;  //!< vector for high gain/CIS pulse derivative
    std::vector<double> m_LdpulseShape_phys; //!< vector for low gain/Physics pulse derivative
    std::vector<double> m_HdpulseShape_phys; //!< vector for high gain/Physics pulse derivative

    std::vector<float> OptFilterDigits;
};

#endif
