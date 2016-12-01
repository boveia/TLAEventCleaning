#Wed Dec 16 17:55:47 2015"""Automatically generated. DO NOT EDIT please"""
from GaudiKernel.GaudiHandles import *
from GaudiKernel.Proxy.Configurable import *

class TileBeamInfoProvider( ConfigurableAlgTool ) :
  __slots__ = { 
    'MonitorService' : 'MonitorSvc', # str
    'OutputLevel' : 7, # int
    'AuditTools' : False, # bool
    'AuditInitialize' : False, # bool
    'AuditStart' : False, # bool
    'AuditStop' : False, # bool
    'AuditFinalize' : False, # bool
    'EvtStore' : ServiceHandle('StoreGateSvc'), # GaudiHandle
    'DetStore' : ServiceHandle('StoreGateSvc/DetectorStore'), # GaudiHandle
    'UserStore' : ServiceHandle('UserDataSvc/UserDataSvc'), # GaudiHandle
    'TileBeamElemContainer' : '', # str
    'TileDigitsContainer' : '', # str
    'TileRawChannelContainer' : '', # str
    'TileTriggerContainer' : '', # str
    'TileLaserObject' : '', # str
    'CheckDCS' : False, # bool
    'SimulateTrips' : False, # bool
    'RndmSvc' : ServiceHandle('AtRndmGenSvc'), # GaudiHandle
  }
  _propertyDocDct = { 
    'DetStore' : """ Handle to a StoreGateSvc/DetectorStore instance: it will be used to retrieve data during the course of the job """,
    'SimulateTrips' : """ Simulate drawer trips (default=false) """,
    'UserStore' : """ Handle to a UserDataSvc/UserDataSvc instance: it will be used to retrieve user data during the course of the job """,
    'RndmSvc' : """ Random Number Service used in TileCondToolTrip """,
    'EvtStore' : """ Handle to a StoreGateSvc instance: it will be used to retrieve data during the course of the job """,
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(TileBeamInfoProvider, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'TileRecUtils'
  def getType( self ):
      return 'TileBeamInfoProvider'
  pass # class TileBeamInfoProvider

class TileCellBuilder( ConfigurableAlgTool ) :
  __slots__ = { 
    'MonitorService' : 'MonitorSvc', # str
    'OutputLevel' : 7, # int
    'AuditTools' : False, # bool
    'AuditInitialize' : False, # bool
    'AuditStart' : False, # bool
    'AuditStop' : False, # bool
    'AuditFinalize' : False, # bool
    'EvtStore' : ServiceHandle('StoreGateSvc'), # GaudiHandle
    'DetStore' : ServiceHandle('StoreGateSvc/DetectorStore'), # GaudiHandle
    'UserStore' : ServiceHandle('UserDataSvc/UserDataSvc'), # GaudiHandle
    'TileRawChannelContainer' : 'TileRawChannelCnt', # str
    'MBTSContainer' : 'MBTSContainer', # str
    'E4prContainer' : 'E4prContainer', # str
    'TileDSPRawChannelContainer' : 'TileRawChannelCnt', # str
    'TileBadChanTool' : PublicToolHandle('TileBadChanTool'), # GaudiHandle
    'TileCondToolEmscale' : PublicToolHandle('TileCondToolEmscale'), # GaudiHandle
    'TileCondToolTiming' : PublicToolHandle('TileCondToolTiming'), # GaudiHandle
    'BeamInfo' : PublicToolHandle('TileBeamInfoProvider/TileBeamInfoProvider'), # GaudiHandle
    'NoiseFilterTools' : PublicToolHandleArray([]), # GaudiHandleArray
    'MinEnergyChan' : -5000.00, # float
    'MinEnergyGap' : -10000.0, # float
    'MinEnergyMBTS' : -999999., # float
    'EThreshold' : -100000., # float
    'MaxTimeDiff' : 100000., # float
    'MaxTime' : 100000., # float
    'MinTime' : -100000., # float
    'MaxChi2' : 100000., # float
    'MinChi2' : -100000., # float
    'fullSizeCont' : True, # bool
    'maskBadChannels' : True, # bool
    'fakeCrackCells' : False, # bool
    'BadChannelZeroEnergy' : 0.500000, # float
    'EneForTimeCut' : 35.0000, # float
    'EneForTimeCutMBTS' : 0.0367500, # float
    'QualityCut' : 254, # int
    'correctTime' : False, # bool
    'correctAmplitude' : False, # bool
    'OF2' : True, # bool
    'mergeChannels' : False, # bool
    'AmpMinForAmpCorrection' : 15.0000, # float
    'TimeMinForAmpCorrection' : -25.0000, # float
    'TimeMaxForAmpCorrection' : 25.0000, # float
    'SkipGain' : -1, # int
  }
  _propertyDocDct = { 
    'DetStore' : """ Handle to a StoreGateSvc/DetectorStore instance: it will be used to retrieve data during the course of the job """,
    'UserStore' : """ Handle to a UserDataSvc/UserDataSvc instance: it will be used to retrieve user data during the course of the job """,
    'EvtStore' : """ Handle to a StoreGateSvc instance: it will be used to retrieve data during the course of the job """,
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(TileCellBuilder, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'TileRecUtils'
  def getType( self ):
      return 'TileCellBuilder'
  pass # class TileCellBuilder

class TileCellFakeProb( ConfigurableAlgTool ) :
  __slots__ = { 
    'MonitorService' : 'MonitorSvc', # str
    'OutputLevel' : 7, # int
    'AuditTools' : False, # bool
    'AuditInitialize' : False, # bool
    'AuditStart' : False, # bool
    'AuditStop' : False, # bool
    'AuditFinalize' : False, # bool
    'EvtStore' : ServiceHandle('StoreGateSvc'), # GaudiHandle
    'DetStore' : ServiceHandle('StoreGateSvc/DetectorStore'), # GaudiHandle
    'UserStore' : ServiceHandle('UserDataSvc/UserDataSvc'), # GaudiHandle
    'DeadDrawerList' : [  ], # list
  }
  _propertyDocDct = { 
    'DetStore' : """ Handle to a StoreGateSvc/DetectorStore instance: it will be used to retrieve data during the course of the job """,
    'UserStore' : """ Handle to a UserDataSvc/UserDataSvc instance: it will be used to retrieve user data during the course of the job """,
    'EvtStore' : """ Handle to a StoreGateSvc instance: it will be used to retrieve data during the course of the job """,
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(TileCellFakeProb, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'TileRecUtils'
  def getType( self ):
      return 'TileCellFakeProb'
  pass # class TileCellFakeProb

class TileCellMaskingTool( ConfigurableAlgTool ) :
  __slots__ = { 
    'MonitorService' : 'MonitorSvc', # str
    'OutputLevel' : 7, # int
    'AuditTools' : False, # bool
    'AuditInitialize' : False, # bool
    'AuditStart' : False, # bool
    'AuditStop' : False, # bool
    'AuditFinalize' : False, # bool
    'EvtStore' : ServiceHandle('StoreGateSvc'), # GaudiHandle
    'DetStore' : ServiceHandle('StoreGateSvc/DetectorStore'), # GaudiHandle
    'UserStore' : ServiceHandle('UserDataSvc/UserDataSvc'), # GaudiHandle
    'RejectedTileDrawer' : [  ], # list
    'RejectedTileMB' : [  ], # list
    'RejectedTileDigitizer' : [  ], # list
    'RejectedTileDMU' : [  ], # list
    'RejectedTileChannels' : [  ], # list
    'BadChannelZeroEnergy' : 0.500000, # float
  }
  _propertyDocDct = { 
    'DetStore' : """ Handle to a StoreGateSvc/DetectorStore instance: it will be used to retrieve data during the course of the job """,
    'UserStore' : """ Handle to a UserDataSvc/UserDataSvc instance: it will be used to retrieve user data during the course of the job """,
    'EvtStore' : """ Handle to a StoreGateSvc instance: it will be used to retrieve data during the course of the job """,
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(TileCellMaskingTool, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'TileRecUtils'
  def getType( self ):
      return 'TileCellMaskingTool'
  pass # class TileCellMaskingTool

class TileCellNoiseFilter( ConfigurableAlgTool ) :
  __slots__ = { 
    'MonitorService' : 'MonitorSvc', # str
    'OutputLevel' : 7, # int
    'AuditTools' : False, # bool
    'AuditInitialize' : False, # bool
    'AuditStart' : False, # bool
    'AuditStop' : False, # bool
    'AuditFinalize' : False, # bool
    'EvtStore' : ServiceHandle('StoreGateSvc'), # GaudiHandle
    'DetStore' : ServiceHandle('StoreGateSvc/DetectorStore'), # GaudiHandle
    'UserStore' : ServiceHandle('UserDataSvc/UserDataSvc'), # GaudiHandle
    'TileCondToolEmscale' : PublicToolHandle('TileCondToolEmscale'), # GaudiHandle
    'TileCondToolNoiseSample' : PublicToolHandle('TileCondToolNoiseSample'), # GaudiHandle
    'CaloNoiseTool' : PublicToolHandle('CaloNoiseTool'), # GaudiHandle
    'UseTwoGaussNoise' : False, # bool
    'UseTileNoiseDB' : True, # bool
    'TruncationThresholdOnAbsEinSigma' : 4.00000, # float
    'MinimumNumberOfTruncatedChannels' : 0.600000, # float
    'MaxNoiseSigma' : 5.00000, # float
  }
  _propertyDocDct = { 
    'DetStore' : """ Handle to a StoreGateSvc/DetectorStore instance: it will be used to retrieve data during the course of the job """,
    'UserStore' : """ Handle to a UserDataSvc/UserDataSvc instance: it will be used to retrieve user data during the course of the job """,
    'MaxNoiseSigma' : """ Channels with noise more than that value are igonred in calculation of correction """,
    'EvtStore' : """ Handle to a StoreGateSvc instance: it will be used to retrieve data during the course of the job """,
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(TileCellNoiseFilter, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'TileRecUtils'
  def getType( self ):
      return 'TileCellNoiseFilter'
  pass # class TileCellNoiseFilter

class TileRawChannelBuilderFitFilter( ConfigurableAlgTool ) :
  __slots__ = { 
    'MonitorService' : 'MonitorSvc', # str
    'OutputLevel' : 7, # int
    'AuditTools' : False, # bool
    'AuditInitialize' : False, # bool
    'AuditStart' : False, # bool
    'AuditStop' : False, # bool
    'AuditFinalize' : False, # bool
    'EvtStore' : ServiceHandle('StoreGateSvc'), # GaudiHandle
    'DetStore' : ServiceHandle('StoreGateSvc/DetectorStore'), # GaudiHandle
    'UserStore' : ServiceHandle('UserDataSvc/UserDataSvc'), # GaudiHandle
    'TileRawChannelContainer' : 'TileRawChannelFit', # str
    'calibrateEnergy' : False, # bool
    'correctTime' : False, # bool
    'AmpMinForAmpCorrection' : 15.0000, # float
    'TimeMinForAmpCorrection' : -25.0000, # float
    'TimeMaxForAmpCorrection' : 25.0000, # float
    'RunType' : 0, # int
    'BeamInfo' : PublicToolHandle('TileBeamInfoProvider/TileBeamInfoProvider'), # GaudiHandle
    'NoiseFilterTools' : PublicToolHandleArray([]), # GaudiHandleArray
    'DataPoolSize' : -1, # int
    'UseDSPCorrection' : True, # bool
    'FrameLength' : 9, # int
    'MaxIterate' : 9, # int
    'NoiseLowGain' : 0.60000000, # float
    'NoiseHighGain' : 1.5000000, # float
    'RMSChannelNoise' : 3, # int
    'ExtraSamplesLeft' : 0, # int
    'ExtraSamplesRight' : 0, # int
    'SaturatedSampleError' : 6.0000000, # float
    'ZeroSampleError' : 100.00000, # float
    'NoiseThresholdRMS' : 3.0000000, # float
    'MaxTimeFromPeak' : 250.00000, # float
  }
  _propertyDocDct = { 
    'DetStore' : """ Handle to a StoreGateSvc/DetectorStore instance: it will be used to retrieve data during the course of the job """,
    'UserStore' : """ Handle to a UserDataSvc/UserDataSvc instance: it will be used to retrieve user data during the course of the job """,
    'EvtStore' : """ Handle to a StoreGateSvc instance: it will be used to retrieve data during the course of the job """,
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(TileRawChannelBuilderFitFilter, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'TileRecUtils'
  def getType( self ):
      return 'TileRawChannelBuilderFitFilter'
  pass # class TileRawChannelBuilderFitFilter

class TileRawChannelBuilderFitFilterCool( ConfigurableAlgTool ) :
  __slots__ = { 
    'MonitorService' : 'MonitorSvc', # str
    'OutputLevel' : 7, # int
    'AuditTools' : False, # bool
    'AuditInitialize' : False, # bool
    'AuditStart' : False, # bool
    'AuditStop' : False, # bool
    'AuditFinalize' : False, # bool
    'EvtStore' : ServiceHandle('StoreGateSvc'), # GaudiHandle
    'DetStore' : ServiceHandle('StoreGateSvc/DetectorStore'), # GaudiHandle
    'UserStore' : ServiceHandle('UserDataSvc/UserDataSvc'), # GaudiHandle
    'TileRawChannelContainer' : 'TileRawChannelFitCool', # str
    'calibrateEnergy' : False, # bool
    'correctTime' : False, # bool
    'AmpMinForAmpCorrection' : 15.0000, # float
    'TimeMinForAmpCorrection' : -25.0000, # float
    'TimeMaxForAmpCorrection' : 25.0000, # float
    'RunType' : 0, # int
    'BeamInfo' : PublicToolHandle('TileBeamInfoProvider/TileBeamInfoProvider'), # GaudiHandle
    'NoiseFilterTools' : PublicToolHandleArray([]), # GaudiHandleArray
    'DataPoolSize' : -1, # int
    'UseDSPCorrection' : True, # bool
    'FrameLength' : 9, # int
    'MaxIterate' : 9, # int
    'NoiseLowGain' : 0.60000000, # float
    'NoiseHighGain' : 1.5000000, # float
    'RMSChannelNoise' : 3, # int
    'ExtraSamplesLeft' : 0, # int
    'ExtraSamplesRight' : 0, # int
    'SaturatedSampleError' : 6.0000000, # float
    'ZeroSampleError' : 100.00000, # float
    'NoiseThresholdRMS' : 3.0000000, # float
    'MaxTimeFromPeak' : 250.00000, # float
    'TileCondToolPulseShape' : PublicToolHandle('TileCondToolPulseShape'), # GaudiHandle
    'TileCondToolLeak100Shape' : PublicToolHandle('TileCondToolLeak100Shape'), # GaudiHandle
    'TileCondToolLeak5p2Shape' : PublicToolHandle('TileCondToolLeak5p2Shape'), # GaudiHandle
    'TileCondToolPulse5p2Shape' : PublicToolHandle('TileCondToolPulse5p2Shape'), # GaudiHandle
    'TileCondToolNoiseSample' : PublicToolHandle('TileCondToolNoiseSample'), # GaudiHandle
  }
  _propertyDocDct = { 
    'DetStore' : """ Handle to a StoreGateSvc/DetectorStore instance: it will be used to retrieve data during the course of the job """,
    'UserStore' : """ Handle to a UserDataSvc/UserDataSvc instance: it will be used to retrieve user data during the course of the job """,
    'EvtStore' : """ Handle to a StoreGateSvc instance: it will be used to retrieve data during the course of the job """,
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(TileRawChannelBuilderFitFilterCool, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'TileRecUtils'
  def getType( self ):
      return 'TileRawChannelBuilderFitFilterCool'
  pass # class TileRawChannelBuilderFitFilterCool

class TileRawChannelBuilderFlatFilter( ConfigurableAlgTool ) :
  __slots__ = { 
    'MonitorService' : 'MonitorSvc', # str
    'OutputLevel' : 7, # int
    'AuditTools' : False, # bool
    'AuditInitialize' : False, # bool
    'AuditStart' : False, # bool
    'AuditStop' : False, # bool
    'AuditFinalize' : False, # bool
    'EvtStore' : ServiceHandle('StoreGateSvc'), # GaudiHandle
    'DetStore' : ServiceHandle('StoreGateSvc/DetectorStore'), # GaudiHandle
    'UserStore' : ServiceHandle('UserDataSvc/UserDataSvc'), # GaudiHandle
    'TileRawChannelContainer' : 'TileRawChannelFlat', # str
    'calibrateEnergy' : False, # bool
    'correctTime' : False, # bool
    'AmpMinForAmpCorrection' : 15.0000, # float
    'TimeMinForAmpCorrection' : -25.0000, # float
    'TimeMaxForAmpCorrection' : 25.0000, # float
    'RunType' : 0, # int
    'BeamInfo' : PublicToolHandle('TileBeamInfoProvider/TileBeamInfoProvider'), # GaudiHandle
    'NoiseFilterTools' : PublicToolHandleArray([]), # GaudiHandleArray
    'DataPoolSize' : -1, # int
    'UseDSPCorrection' : True, # bool
    'PedStart' : 0, # int
    'PedLength' : 1, # int
    'PedOffset' : 0, # int
    'SignalStart' : 1, # int
    'SignalLength' : 8, # int
    'FilterLength' : 5, # int
    'FrameLength' : 9, # int
    'DeltaCutLo' : 4.5000000, # float
    'DeltaCutHi' : 8.5000000, # float
    'RMSCutLo' : 1.0000000, # float
    'RMSCutHi' : 2.5000000, # float
  }
  _propertyDocDct = { 
    'DetStore' : """ Handle to a StoreGateSvc/DetectorStore instance: it will be used to retrieve data during the course of the job """,
    'UserStore' : """ Handle to a UserDataSvc/UserDataSvc instance: it will be used to retrieve user data during the course of the job """,
    'EvtStore' : """ Handle to a StoreGateSvc instance: it will be used to retrieve data during the course of the job """,
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(TileRawChannelBuilderFlatFilter, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'TileRecUtils'
  def getType( self ):
      return 'TileRawChannelBuilderFlatFilter'
  pass # class TileRawChannelBuilderFlatFilter

class TileRawChannelBuilderMF( ConfigurableAlgTool ) :
  __slots__ = { 
    'MonitorService' : 'MonitorSvc', # str
    'OutputLevel' : 7, # int
    'AuditTools' : False, # bool
    'AuditInitialize' : False, # bool
    'AuditStart' : False, # bool
    'AuditStop' : False, # bool
    'AuditFinalize' : False, # bool
    'EvtStore' : ServiceHandle('StoreGateSvc'), # GaudiHandle
    'DetStore' : ServiceHandle('StoreGateSvc/DetectorStore'), # GaudiHandle
    'UserStore' : ServiceHandle('UserDataSvc/UserDataSvc'), # GaudiHandle
    'TileRawChannelContainer' : 'TileRawChannelMF', # str
    'calibrateEnergy' : False, # bool
    'correctTime' : False, # bool
    'AmpMinForAmpCorrection' : 15.0000, # float
    'TimeMinForAmpCorrection' : -25.0000, # float
    'TimeMaxForAmpCorrection' : 25.0000, # float
    'RunType' : 0, # int
    'BeamInfo' : PublicToolHandle('TileBeamInfoProvider/TileBeamInfoProvider'), # GaudiHandle
    'NoiseFilterTools' : PublicToolHandleArray([]), # GaudiHandleArray
    'DataPoolSize' : -1, # int
    'UseDSPCorrection' : True, # bool
    'TileCondToolTiming' : PublicToolHandle('TileCondToolTiming'), # GaudiHandle
    'TileCondToolOfc' : PublicToolHandle('TileCondToolOfc'), # GaudiHandle
    'TileCondToolOfcCool' : PublicToolHandle('TileCondToolOfcCool'), # GaudiHandle
    'TileCondToolNoiseSample' : PublicToolHandle('TileCondToolNoiseSample'), # GaudiHandle
    'AmplitudeCorrection' : False, # bool
    'PedestalMode' : 1, # int
    'DefaultPedestal' : 0.0000000, # float
    'MF' : 0, # int
    'MaxIterations' : 5, # int
    'BestPhase' : False, # bool
    'TimeFromCOF' : False, # bool
    'OfcfromCool' : False, # bool
  }
  _propertyDocDct = { 
    'DetStore' : """ Handle to a StoreGateSvc/DetectorStore instance: it will be used to retrieve data during the course of the job """,
    'UserStore' : """ Handle to a UserDataSvc/UserDataSvc instance: it will be used to retrieve user data during the course of the job """,
    'TileCondToolOfc' : """ TileCondToolOfc """,
    'EvtStore' : """ Handle to a StoreGateSvc instance: it will be used to retrieve data during the course of the job """,
    'TileCondToolOfcCool' : """ TileCondToolOfcCool """,
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(TileRawChannelBuilderMF, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'TileRecUtils'
  def getType( self ):
      return 'TileRawChannelBuilderMF'
  pass # class TileRawChannelBuilderMF

class TileRawChannelBuilderManyAmps( ConfigurableAlgTool ) :
  __slots__ = { 
    'MonitorService' : 'MonitorSvc', # str
    'OutputLevel' : 7, # int
    'AuditTools' : False, # bool
    'AuditInitialize' : False, # bool
    'AuditStart' : False, # bool
    'AuditStop' : False, # bool
    'AuditFinalize' : False, # bool
    'EvtStore' : ServiceHandle('StoreGateSvc'), # GaudiHandle
    'DetStore' : ServiceHandle('StoreGateSvc/DetectorStore'), # GaudiHandle
    'UserStore' : ServiceHandle('UserDataSvc/UserDataSvc'), # GaudiHandle
    'TileRawChannelContainer' : 'TileRawChannelManyAmps', # str
    'calibrateEnergy' : False, # bool
    'correctTime' : False, # bool
    'AmpMinForAmpCorrection' : 15.0000, # float
    'TimeMinForAmpCorrection' : -25.0000, # float
    'TimeMaxForAmpCorrection' : 25.0000, # float
    'RunType' : 0, # int
    'BeamInfo' : PublicToolHandle('TileBeamInfoProvider/TileBeamInfoProvider'), # GaudiHandle
    'NoiseFilterTools' : PublicToolHandleArray([]), # GaudiHandleArray
    'DataPoolSize' : -1, # int
    'UseDSPCorrection' : True, # bool
    'FilterMode' : 2, # int
    'FilterLevel' : 5, # int
    'FilterTester' : 0, # int
  }
  _propertyDocDct = { 
    'DetStore' : """ Handle to a StoreGateSvc/DetectorStore instance: it will be used to retrieve data during the course of the job """,
    'UserStore' : """ Handle to a UserDataSvc/UserDataSvc instance: it will be used to retrieve user data during the course of the job """,
    'EvtStore' : """ Handle to a StoreGateSvc instance: it will be used to retrieve data during the course of the job """,
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(TileRawChannelBuilderManyAmps, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'TileRecUtils'
  def getType( self ):
      return 'TileRawChannelBuilderManyAmps'
  pass # class TileRawChannelBuilderManyAmps

class TileRawChannelBuilderOpt2Filter( ConfigurableAlgTool ) :
  __slots__ = { 
    'MonitorService' : 'MonitorSvc', # str
    'OutputLevel' : 7, # int
    'AuditTools' : False, # bool
    'AuditInitialize' : False, # bool
    'AuditStart' : False, # bool
    'AuditStop' : False, # bool
    'AuditFinalize' : False, # bool
    'EvtStore' : ServiceHandle('StoreGateSvc'), # GaudiHandle
    'DetStore' : ServiceHandle('StoreGateSvc/DetectorStore'), # GaudiHandle
    'UserStore' : ServiceHandle('UserDataSvc/UserDataSvc'), # GaudiHandle
    'TileRawChannelContainer' : 'TileRawChannelOpt2', # str
    'calibrateEnergy' : False, # bool
    'correctTime' : False, # bool
    'AmpMinForAmpCorrection' : 15.0000, # float
    'TimeMinForAmpCorrection' : -25.0000, # float
    'TimeMaxForAmpCorrection' : 25.0000, # float
    'RunType' : 0, # int
    'BeamInfo' : PublicToolHandle('TileBeamInfoProvider/TileBeamInfoProvider'), # GaudiHandle
    'NoiseFilterTools' : PublicToolHandleArray([]), # GaudiHandleArray
    'DataPoolSize' : -1, # int
    'UseDSPCorrection' : True, # bool
    'TileCondToolTiming' : PublicToolHandle('TileCondToolTiming'), # GaudiHandle
    'TileCondToolOfc' : PublicToolHandle('TileCondToolOfc'), # GaudiHandle
    'TileCondToolOfcCool' : PublicToolHandle('TileCondToolOfcCool'), # GaudiHandle
    'TileCondToolNoiseSample' : PublicToolHandle('TileCondToolNoiseSample'), # GaudiHandle
    'MaxIterations' : 5, # int
    'PedestalMode' : 17, # int
    'TimeForConvergence' : 0.50000000, # float
    'ConfTB' : False, # bool
    'OF2' : True, # bool
    'Minus1Iteration' : False, # bool
    'AmplitudeCorrection' : False, # bool
    'BestPhase' : False, # bool
    'OfcfromCool' : False, # bool
    'EmulateDSP' : False, # bool
  }
  _propertyDocDct = { 
    'DetStore' : """ Handle to a StoreGateSvc/DetectorStore instance: it will be used to retrieve data during the course of the job """,
    'UserStore' : """ Handle to a UserDataSvc/UserDataSvc instance: it will be used to retrieve user data during the course of the job """,
    'TileCondToolOfc' : """ TileCondToolOfc """,
    'EvtStore' : """ Handle to a StoreGateSvc instance: it will be used to retrieve data during the course of the job """,
    'TileCondToolOfcCool' : """ TileCondToolOfcCool """,
    'TileCondToolNoiseSample' : """ TileCondToolNoiseSample """,
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(TileRawChannelBuilderOpt2Filter, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'TileRecUtils'
  def getType( self ):
      return 'TileRawChannelBuilderOpt2Filter'
  pass # class TileRawChannelBuilderOpt2Filter

class TileRawChannelBuilderOptFilter( ConfigurableAlgTool ) :
  __slots__ = { 
    'MonitorService' : 'MonitorSvc', # str
    'OutputLevel' : 7, # int
    'AuditTools' : False, # bool
    'AuditInitialize' : False, # bool
    'AuditStart' : False, # bool
    'AuditStop' : False, # bool
    'AuditFinalize' : False, # bool
    'EvtStore' : ServiceHandle('StoreGateSvc'), # GaudiHandle
    'DetStore' : ServiceHandle('StoreGateSvc/DetectorStore'), # GaudiHandle
    'UserStore' : ServiceHandle('UserDataSvc/UserDataSvc'), # GaudiHandle
    'TileRawChannelContainer' : 'TileRawChannelOpt', # str
    'calibrateEnergy' : False, # bool
    'correctTime' : False, # bool
    'AmpMinForAmpCorrection' : 15.0000, # float
    'TimeMinForAmpCorrection' : -25.0000, # float
    'TimeMaxForAmpCorrection' : 25.0000, # float
    'RunType' : 0, # int
    'BeamInfo' : PublicToolHandle('TileBeamInfoProvider/TileBeamInfoProvider'), # GaudiHandle
    'NoiseFilterTools' : PublicToolHandleArray([]), # GaudiHandleArray
    'DataPoolSize' : -1, # int
    'UseDSPCorrection' : True, # bool
    'MaxIterations' : 5, # int
    'PedestalMode' : 17, # int
    'TimeForConvergence' : 0.50000000, # float
    'ConfTB' : False, # bool
    'OF2' : True, # bool
    'Minus1Iteration' : False, # bool
    'AmplitudeCorrection' : False, # bool
  }
  _propertyDocDct = { 
    'DetStore' : """ Handle to a StoreGateSvc/DetectorStore instance: it will be used to retrieve data during the course of the job """,
    'UserStore' : """ Handle to a UserDataSvc/UserDataSvc instance: it will be used to retrieve user data during the course of the job """,
    'EvtStore' : """ Handle to a StoreGateSvc instance: it will be used to retrieve data during the course of the job """,
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(TileRawChannelBuilderOptFilter, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'TileRecUtils'
  def getType( self ):
      return 'TileRawChannelBuilderOptFilter'
  pass # class TileRawChannelBuilderOptFilter

class TileRawChannelMaker( ConfigurableAlgorithm ) :
  __slots__ = { 
    'OutputLevel' : 0, # int
    'Enable' : True, # bool
    'ErrorMax' : 1, # int
    'ErrorCount' : 0, # int
    'AuditAlgorithms' : False, # bool
    'AuditInitialize' : False, # bool
    'AuditReinitialize' : False, # bool
    'AuditRestart' : False, # bool
    'AuditExecute' : False, # bool
    'AuditFinalize' : False, # bool
    'AuditBeginRun' : False, # bool
    'AuditEndRun' : False, # bool
    'AuditStart' : False, # bool
    'AuditStop' : False, # bool
    'MonitorService' : 'MonitorSvc', # str
    'RegisterForContextService' : False, # bool
    'EvtStore' : ServiceHandle('StoreGateSvc'), # GaudiHandle
    'DetStore' : ServiceHandle('StoreGateSvc/DetectorStore'), # GaudiHandle
    'UserStore' : ServiceHandle('UserDataSvc/UserDataSvc'), # GaudiHandle
    'TileDigitsContainer' : 'TileDigitsCnt', # str
    'TileRawChannelBuilder' : PublicToolHandleArray([]), # GaudiHandleArray
    'FitOverflow' : False, # bool
    'TileRawChannelBuilderFitOverflow' : PublicToolHandle('TileRawChannelBuilder'), # GaudiHandle
  }
  _propertyDocDct = { 
    'DetStore' : """ Handle to a StoreGateSvc/DetectorStore instance: it will be used to retrieve data during the course of the job """,
    'RegisterForContextService' : """ The flag to enforce the registration for Algorithm Context Service """,
    'UserStore' : """ Handle to a UserDataSvc/UserDataSvc instance: it will be used to retrieve user data during the course of the job """,
    'FitOverflow' : """ Fit or not overflows """,
    'EvtStore' : """ Handle to a StoreGateSvc instance: it will be used to retrieve data during the course of the job """,
    'TileRawChannelBuilderFitOverflow' : """ Tool to fit overflows """,
    'TileRawChannelBuilder' : """ List Of Tools """,
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(TileRawChannelMaker, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'TileRecUtils'
  def getType( self ):
      return 'TileRawChannelMaker'
  pass # class TileRawChannelMaker

class TileRawChannelNoiseFilter( ConfigurableAlgTool ) :
  __slots__ = { 
    'MonitorService' : 'MonitorSvc', # str
    'OutputLevel' : 7, # int
    'AuditTools' : False, # bool
    'AuditInitialize' : False, # bool
    'AuditStart' : False, # bool
    'AuditStop' : False, # bool
    'AuditFinalize' : False, # bool
    'EvtStore' : ServiceHandle('StoreGateSvc'), # GaudiHandle
    'DetStore' : ServiceHandle('StoreGateSvc/DetectorStore'), # GaudiHandle
    'UserStore' : ServiceHandle('UserDataSvc/UserDataSvc'), # GaudiHandle
    'TileCondToolEmscale' : PublicToolHandle('TileCondToolEmscale'), # GaudiHandle
    'TileCondToolNoiseSample' : PublicToolHandle('TileCondToolNoiseSample'), # GaudiHandle
    'TileBadChanTool' : PublicToolHandle('TileBadChanTool'), # GaudiHandle
    'BeamInfo' : PublicToolHandle('TileBeamInfoProvider/TileBeamInfoProvider'), # GaudiHandle
    'TruncationThresholdOnAbsEinSigma' : 3.00000, # float
    'MinimumNumberOfTruncatedChannels' : 0.600000, # float
    'UseTwoGaussNoise' : False, # bool
    'UseGapCells' : False, # bool
    'MaxNoiseSigma' : 5.00000, # float
  }
  _propertyDocDct = { 
    'DetStore' : """ Handle to a StoreGateSvc/DetectorStore instance: it will be used to retrieve data during the course of the job """,
    'UserStore' : """ Handle to a UserDataSvc/UserDataSvc instance: it will be used to retrieve user data during the course of the job """,
    'MaxNoiseSigma' : """ Channels with noise more than that value are igonred in calculation of correction """,
    'EvtStore' : """ Handle to a StoreGateSvc instance: it will be used to retrieve data during the course of the job """,
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(TileRawChannelNoiseFilter, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'TileRecUtils'
  def getType( self ):
      return 'TileRawChannelNoiseFilter'
  pass # class TileRawChannelNoiseFilter

class TileRawChannelVerify( ConfigurableAlgorithm ) :
  __slots__ = { 
    'OutputLevel' : 0, # int
    'Enable' : True, # bool
    'ErrorMax' : 1, # int
    'ErrorCount' : 0, # int
    'AuditAlgorithms' : False, # bool
    'AuditInitialize' : False, # bool
    'AuditReinitialize' : False, # bool
    'AuditRestart' : False, # bool
    'AuditExecute' : False, # bool
    'AuditFinalize' : False, # bool
    'AuditBeginRun' : False, # bool
    'AuditEndRun' : False, # bool
    'AuditStart' : False, # bool
    'AuditStop' : False, # bool
    'MonitorService' : 'MonitorSvc', # str
    'RegisterForContextService' : False, # bool
    'EvtStore' : ServiceHandle('StoreGateSvc'), # GaudiHandle
    'DetStore' : ServiceHandle('StoreGateSvc/DetectorStore'), # GaudiHandle
    'UserStore' : ServiceHandle('UserDataSvc/UserDataSvc'), # GaudiHandle
    'TileRawChannelContainer1' : 'TileRawChannelContainer1', # str
    'TileRawChannelContainer2' : 'TileRawChannelContainer2', # str
    'Precision' : 0.0000000, # float
    'DumpRawChannels' : False, # bool
    'SortFlag' : False, # bool
  }
  _propertyDocDct = { 
    'DetStore' : """ Handle to a StoreGateSvc/DetectorStore instance: it will be used to retrieve data during the course of the job """,
    'RegisterForContextService' : """ The flag to enforce the registration for Algorithm Context Service """,
    'UserStore' : """ Handle to a UserDataSvc/UserDataSvc instance: it will be used to retrieve user data during the course of the job """,
    'EvtStore' : """ Handle to a StoreGateSvc instance: it will be used to retrieve data during the course of the job """,
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(TileRawChannelVerify, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'TileRecUtils'
  def getType( self ):
      return 'TileRawChannelVerify'
  pass # class TileRawChannelVerify

class TileRawCorrelatedNoise( ConfigurableAlgorithm ) :
  __slots__ = { 
    'OutputLevel' : 0, # int
    'Enable' : True, # bool
    'ErrorMax' : 1, # int
    'ErrorCount' : 0, # int
    'AuditAlgorithms' : False, # bool
    'AuditInitialize' : False, # bool
    'AuditReinitialize' : False, # bool
    'AuditRestart' : False, # bool
    'AuditExecute' : False, # bool
    'AuditFinalize' : False, # bool
    'AuditBeginRun' : False, # bool
    'AuditEndRun' : False, # bool
    'AuditStart' : False, # bool
    'AuditStop' : False, # bool
    'MonitorService' : 'MonitorSvc', # str
    'RegisterForContextService' : False, # bool
    'EvtStore' : ServiceHandle('StoreGateSvc'), # GaudiHandle
    'DetStore' : ServiceHandle('StoreGateSvc/DetectorStore'), # GaudiHandle
    'UserStore' : ServiceHandle('UserDataSvc/UserDataSvc'), # GaudiHandle
    'TileDigitsContainer' : 'TileDigitsCnt', # str
    'TileDigitsOutputContainer' : 'NewDigitsContainer', # str
    'nRMSThreshold' : 2.00000, # float
    'AlphaMatrixFilePrefix' : 'AlphaMatrix', # str
    'MeanFilePrefix' : 'Mean', # str
    'Sample3RMSFilePrefix' : 'RMS', # str
    'UseMeanFiles' : True, # bool
    'PMTOrder' : False, # bool
  }
  _propertyDocDct = { 
    'DetStore' : """ Handle to a StoreGateSvc/DetectorStore instance: it will be used to retrieve data during the course of the job """,
    'RegisterForContextService' : """ The flag to enforce the registration for Algorithm Context Service """,
    'UserStore' : """ Handle to a UserDataSvc/UserDataSvc instance: it will be used to retrieve user data during the course of the job """,
    'EvtStore' : """ Handle to a StoreGateSvc instance: it will be used to retrieve data during the course of the job """,
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(TileRawCorrelatedNoise, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'TileRecUtils'
  def getType( self ):
      return 'TileRawCorrelatedNoise'
  pass # class TileRawCorrelatedNoise

class TileTowerBuilderTool( ConfigurableAlgTool ) :
  __slots__ = { 
    'MonitorService' : 'MonitorSvc', # str
    'OutputLevel' : 7, # int
    'AuditTools' : False, # bool
    'AuditInitialize' : False, # bool
    'AuditStart' : False, # bool
    'AuditStop' : False, # bool
    'AuditFinalize' : False, # bool
    'EvtStore' : ServiceHandle('StoreGateSvc'), # GaudiHandle
    'DetStore' : ServiceHandle('StoreGateSvc/DetectorStore'), # GaudiHandle
    'UserStore' : ServiceHandle('UserDataSvc/UserDataSvc'), # GaudiHandle
    'CellContainerName' : 'AllCalo', # str
    'IncludedCalos' : [ 'LAREM' , 'LARHEC' , 'LARFCAL' , 'TILE' ], # list
    'DumpTowers' : False, # bool
    'DumpWeightMap' : False, # bool
  }
  _propertyDocDct = { 
    'DetStore' : """ Handle to a StoreGateSvc/DetectorStore instance: it will be used to retrieve data during the course of the job """,
    'UserStore' : """ Handle to a UserDataSvc/UserDataSvc instance: it will be used to retrieve user data during the course of the job """,
    'EvtStore' : """ Handle to a StoreGateSvc instance: it will be used to retrieve data during the course of the job """,
  }
  def __init__(self, name = Configurable.DefaultName, **kwargs):
      super(TileTowerBuilderTool, self).__init__(name)
      for n,v in kwargs.items():
         setattr(self, n, v)
  def getDlls( self ):
      return 'TileRecUtils'
  def getType( self ):
      return 'TileTowerBuilderTool'
  pass # class TileTowerBuilderTool
