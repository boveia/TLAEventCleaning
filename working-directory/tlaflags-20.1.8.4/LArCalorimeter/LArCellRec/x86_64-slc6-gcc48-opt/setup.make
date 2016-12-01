----------> uses
# use AtlasPolicy AtlasPolicy-*  (no_version_directory)
#   use ExternalPolicy ExternalPolicy-* External (no_version_directory)
#     use PlatformPolicy PlatformPolicy-* External (no_version_directory)
#       use GaudiPolicy *  (no_version_directory)
#         use LCG_Settings *  (no_version_directory)
#         use Python * LCG_Interfaces (no_auto_imports) (no_version_directory) (native_version=2.7.6)
#           use LCG_Configuration v*  (no_version_directory)
#           use LCG_Settings v*  (no_version_directory)
#         use tcmalloc * LCG_Interfaces (no_auto_imports) (no_version_directory) (native_version=1.7p3)
#           use LCG_Configuration v*  (no_version_directory)
#           use LCG_Settings v*  (no_version_directory)
#           use libunwind v* LCG_Interfaces (no_version_directory) (native_version=5c2cade)
#             use LCG_Configuration v*  (no_version_directory)
#             use LCG_Settings v*  (no_version_directory)
#         use Reflex v* LCG_Interfaces (no_auto_imports) (no_version_directory)
#       use AtlasCommonPolicy AtlasCommonPolicy-*  (no_version_directory)
#         use LCG_Platforms *  (no_version_directory)
#         use AtlasDoxygen AtlasDoxygen-* Tools (no_version_directory) (native_version=)
#           use LCG_Settings *  (no_version_directory)
#           use LCG_Configuration *  (no_version_directory)
#             use LCG_Platforms *  (no_version_directory)
#     use Mac105_Compat Mac105_Compat-* External (no_version_directory) (native_version=1.0.0)
#       use AtlasExternalArea AtlasExternalArea-* External (no_version_directory)
#         use LCG_Settings v*  (no_version_directory)
#         use PlatformPolicy PlatformPolicy-* External (no_version_directory)
#       use PlatformPolicy PlatformPolicy-* External (no_version_directory)
#   use AtlasCxxPolicy AtlasCxxPolicy-*  (no_version_directory)
#     use GaudiPolicy v*  (no_auto_imports) (no_version_directory)
#     use ExternalPolicy ExternalPolicy-* External (no_version_directory)
#     use AtlasCompilers AtlasCompilers-* External (no_version_directory)
#       use LCG_Platforms *  (no_version_directory)
#     use CheckerGccPlugins CheckerGccPlugins-* External (no_version_directory) (native_version=CheckerGccPlugins-00-01-12)
#       use ExternalPolicy ExternalPolicy-* External (no_version_directory)
#       use AtlasCompilers AtlasCompilers-* External (no_version_directory)
#   use AtlasCommonPolicy AtlasCommonPolicy-*  (no_version_directory)
#   use GaudiPolicy v*  (no_auto_imports) (no_version_directory)
#   use CodeCheck CodeCheck-* Tools (no_version_directory)
#   use AtlasDoxygen AtlasDoxygen-* Tools (no_version_directory) (native_version=)
# use AthenaKernel AthenaKernel-* Control (no_version_directory)
#   use AtlasPolicy AtlasPolicy-*  (no_version_directory)
#   use uuid v* LCG_Interfaces (no_version_directory) (native_version=dummy)
#     use LCG_Configuration v*  (no_version_directory)
#     use LCG_Settings v*  (no_version_directory)
#   use GaudiInterface GaudiInterface-* External (no_version_directory)
#     use ExternalPolicy ExternalPolicy-00-* External (no_version_directory)
#     use GaudiKernel v*  (no_version_directory)
#       use GaudiPolicy *  (no_version_directory)
#       use GaudiPluginService *  (no_version_directory)
#         use GaudiPolicy *  (no_version_directory)
#       use Reflex * LCG_Interfaces (no_version_directory)
#         use LCG_Configuration v*  (no_version_directory)
#         use LCG_Settings v*  (no_version_directory)
#         use ROOT v* LCG_Interfaces (no_auto_imports) (no_version_directory) (native_version=5.34.25)
#       use Boost * LCG_Interfaces (no_version_directory) (native_version=1.55.0_python2.7)
#         use LCG_Configuration v*  (no_version_directory)
#         use LCG_Settings v*  (no_version_directory)
#         use Python v* LCG_Interfaces (no_auto_imports) (no_version_directory) (native_version=2.7.6)
#   use DataModelRoot DataModelRoot-* Control (no_version_directory)
#     use AtlasPolicy AtlasPolicy-*  (no_version_directory)
#     use AtlasROOT AtlasROOT-* External (no_version_directory)
#       use ExternalPolicy ExternalPolicy-* External (no_version_directory)
#       use ROOT v* LCG_Interfaces (no_version_directory) (native_version=5.34.25)
#         use LCG_Configuration v*  (no_version_directory)
#         use LCG_Settings v*  (no_version_directory)
#         use GCCXML v* LCG_Interfaces (no_auto_imports) (no_version_directory) (native_version=0.9.0_20131026)
#           use LCG_Configuration v*  (no_version_directory)
#           use LCG_Settings v*  (no_version_directory)
#         use Python v* LCG_Interfaces (no_auto_imports) (no_version_directory) (native_version=2.7.6)
#         use xrootd v* LCG_Interfaces (no_version_directory) (native_version=3.3.6)
#           use LCG_Configuration v*  (no_version_directory)
#           use LCG_Settings v*  (no_version_directory)
#     use AtlasReflex AtlasReflex-* External (no_version_directory)
#       use ExternalPolicy ExternalPolicy-* External (no_version_directory)
#       use Reflex v* LCG_Interfaces (no_version_directory)
#       use AtlasRELAX AtlasRELAX-00-* External (no_auto_imports) (no_version_directory)
#         use ExternalPolicy ExternalPolicy-* External (no_version_directory)
#         use RELAX v* LCG_Interfaces (no_version_directory) (native_version=RELAX_1_3_0p)
#           use LCG_Configuration v*  (no_version_directory)
#           use LCG_Settings v*  (no_version_directory)
#   use CxxUtils CxxUtils-* Control (no_version_directory)
#     use AtlasPolicy AtlasPolicy-*  (no_version_directory)
#     use AtlasBoost AtlasBoost-* External (no_version_directory)
#       use AtlasPolicy AtlasPolicy-*  (no_version_directory)
#       use Boost v* LCG_Interfaces (no_version_directory) (native_version=1.55.0_python2.7)
#   use AtlasBoost AtlasBoost-* External (no_version_directory)
#   use Scripts Scripts-* Tools (no_auto_imports) (no_version_directory)
#     use AtlasPolicy AtlasPolicy-*  (no_version_directory)
# use StoreGate StoreGate-* Control (no_version_directory)
#   use AtlasPolicy AtlasPolicy-*  (no_version_directory)
#   use CxxUtils CxxUtils-* Control (no_version_directory)
#   use AthenaKernel AthenaKernel-* Control (no_version_directory)
#   use SGTools SGTools-* Control (no_version_directory)
#     use AtlasPolicy AtlasPolicy-*  (no_version_directory)
#     use CxxUtils CxxUtils-* Control (no_version_directory)
#     use AthenaKernel AthenaKernel-* Control (no_version_directory)
#     use AtlasBoost AtlasBoost-* External (no_version_directory)
#     use GaudiInterface GaudiInterface-* External (no_version_directory)
#   use AtlasBoost AtlasBoost-* External (no_version_directory)
#   use GaudiInterface GaudiInterface-* External (no_version_directory)
#   use AthAllocators AthAllocators-* Control (no_version_directory)
#     use AtlasPolicy AtlasPolicy-*  (no_version_directory)
#     use GaudiInterface GaudiInterface-* External (no_version_directory)
#     use AtlasBoost AtlasBoost-* External (no_version_directory)
#   use AthContainersInterfaces AthContainersInterfaces-* Control (no_version_directory)
#     use AtlasPolicy AtlasPolicy-*  (no_version_directory)
#     use SGTools SGTools-* Control (no_version_directory)
#     use CxxUtils CxxUtils-* Control (no_version_directory)
#     use AtlasBoost AtlasBoost-* External (no_version_directory)
# use AthenaBaseComps AthenaBaseComps-* Control (no_version_directory)
#   use AtlasPolicy AtlasPolicy-*  (no_version_directory)
#   use GaudiInterface GaudiInterface-* External (no_version_directory)
#   use AtlasROOT AtlasROOT-* External (no_version_directory)
#   use AthenaKernel AthenaKernel-* Control (no_version_directory)
#   use StoreGate StoreGate-* Control (no_version_directory)
#   use SGTools SGTools-* Control (no_version_directory)
#   use CxxUtils CxxUtils-* Control (no_version_directory)
# use CxxUtils CxxUtils-* Control (no_version_directory)
# use AtlasDetDescr AtlasDetDescr-* DetectorDescription (no_version_directory)
#   use AtlasPolicy AtlasPolicy-*  (no_version_directory)
#   use Identifier Identifier-* DetectorDescription (no_version_directory)
#     use AtlasPolicy AtlasPolicy-*  (no_version_directory)
#     use AtlasCxxPolicy AtlasCxxPolicy-*  (no_version_directory)
#     use AtlasBoost AtlasBoost-* External (no_version_directory)
#   use IdDict IdDict-* DetectorDescription (no_version_directory)
#     use AtlasPolicy AtlasPolicy-*  (no_version_directory)
#     use Identifier Identifier-* DetectorDescription (no_version_directory)
#   use CLIDSvc CLIDSvc-* Control (no_version_directory)
#     use AtlasPolicy AtlasPolicy-*  (no_version_directory)
#     use SGTools SGTools-* Control (no_version_directory)
#     use AtlasPython AtlasPython-* External (no_auto_imports) (no_version_directory)
#       use ExternalPolicy ExternalPolicy-00-* External (no_version_directory)
#       use Python v* LCG_Interfaces (no_version_directory) (native_version=2.7.6)
# use Identifier Identifier-* DetectorDescription (no_version_directory)
# use AtlasCLHEP AtlasCLHEP-* External (no_version_directory)
#   use ExternalPolicy ExternalPolicy-00-* External (no_version_directory)
#   use CLHEP v* LCG_Interfaces (no_version_directory) (native_version=2.1.2.3)
#     use LCG_Configuration v*  (no_version_directory)
#     use LCG_Settings v*  (no_version_directory)
# use GaudiInterface GaudiInterface-* External (no_version_directory)
# use CaloInterface CaloInterface-* Calorimeter (no_version_directory)
#   use AtlasPolicy AtlasPolicy-*  (no_version_directory)
#   use GaudiInterface GaudiInterface-* External (no_version_directory)
#   use AthenaKernel AthenaKernel-* Control (no_version_directory)
#   use Identifier Identifier-* DetectorDescription (no_version_directory)
#   use CaloIdentifier CaloIdentifier-* Calorimeter (no_version_directory)
#     use AtlasPolicy AtlasPolicy-*  (no_version_directory)
#     use CLIDSvc CLIDSvc-* Control (no_version_directory)
#     use SGTools SGTools-* Control (no_version_directory)
#     use GaudiInterface GaudiInterface-* External (no_version_directory)
#     use AtlasBoost AtlasBoost-* External (no_version_directory)
#     use AtlasDetDescr AtlasDetDescr-* DetectorDescription (no_version_directory)
#     use Identifier Identifier-* DetectorDescription (no_version_directory)
#     use IdDict IdDict-* DetectorDescription (no_version_directory)
#     use GaudiInterface GaudiInterface-* External (no_version_directory)
#     use CaloGeoHelpers CaloGeoHelpers-* Calorimeter (no_version_directory)
#       use AtlasPolicy AtlasPolicy-*  (no_version_directory)
#       use CxxUtils CxxUtils-* Control (no_version_directory)
#   use CaloEvent CaloEvent-* Calorimeter (no_version_directory)
#     use AtlasPolicy AtlasPolicy-*  (no_version_directory)
#     use CxxUtils CxxUtils-* Control (no_version_directory)
#     use CLIDSvc CLIDSvc-* Control (no_version_directory)
#     use AthLinks AthLinks-* Control (no_version_directory)
#       use AtlasPolicy AtlasPolicy-*  (no_version_directory)
#       use AthenaKernel AthenaKernel-* Control (no_version_directory)
#       use SGTools SGTools-* Control (no_version_directory)
#       use CxxUtils CxxUtils-* Control (no_version_directory)
#       use AtlasBoost AtlasBoost-* External (no_version_directory)
#       use GaudiInterface GaudiInterface-* External (no_version_directory)
#       use AtlasReflex AtlasReflex-* External (no_version_directory)
#     use DataModel DataModel-* Control (no_version_directory)
#       use AtlasPolicy AtlasPolicy-*  (no_version_directory)
#       use SGTools SGTools-* Control (no_version_directory)
#       use AthAllocators AthAllocators-* Control (no_version_directory)
#       use AthLinks AthLinks-* Control (no_version_directory)
#       use AthContainers AthContainers-* Control (no_version_directory)
#         use AtlasPolicy AtlasPolicy-*  (no_version_directory)
#         use AthenaKernel AthenaKernel-* Control (no_version_directory)
#         use SGTools SGTools-* Control (no_version_directory)
#         use CxxUtils CxxUtils-* Control (no_version_directory)
#         use AthContainersInterfaces AthContainersInterfaces-* Control (no_version_directory)
#         use AthLinks AthLinks-* Control (no_version_directory)
#         use AtlasBoost AtlasBoost-* External (no_version_directory)
#         use GaudiInterface GaudiInterface-* External (no_version_directory)
#       use CxxUtils CxxUtils-* Control (no_version_directory)
#     use Navigation Navigation-* Control (no_version_directory)
#       use AtlasPolicy AtlasPolicy-*  (no_version_directory)
#       use AtlasBoost AtlasBoost-* External (no_version_directory)
#       use CxxUtils CxxUtils-* Control (no_version_directory)
#       use AthAllocators AthAllocators-* Control (no_version_directory)
#       use AthLinks AthLinks-* Control (no_version_directory)
#       use DataModel DataModel-* Control (no_version_directory)
#       use AthenaKernel AthenaKernel-* Control (no_version_directory)
#     use AthContainers AthContainers-* Control (no_version_directory)
#     use AthAllocators AthAllocators-* Control (no_version_directory)
#     use Identifier Identifier-* DetectorDescription (no_version_directory)
#     use EventKernel EventKernel-* Event (no_version_directory)
#       use AtlasPolicy AtlasPolicy-*  (no_version_directory)
#       use AtlasCLHEP AtlasCLHEP-* External (no_version_directory)
#       use DataModel DataModel-* Control (no_version_directory)
#       use SGTools SGTools-* Control (no_version_directory)
#       use Navigation Navigation-* Control (no_version_directory)
#       use VxVertex VxVertex-* Tracking/TrkEvent (no_version_directory)
#         use AtlasPolicy AtlasPolicy-*  (no_version_directory)
#         use TrkEventPrimitives TrkEventPrimitives-* Tracking/TrkEvent (no_version_directory)
#           use AtlasPolicy AtlasPolicy-*  (no_version_directory)
#           use GaudiInterface GaudiInterface-* External (no_version_directory)
#           use EventPrimitives EventPrimitives-* Event (no_version_directory)
#             use AtlasPolicy AtlasPolicy-*  (no_version_directory)
#             use AtlasEigen AtlasEigen-* External (no_version_directory)
#               use AtlasPolicy AtlasPolicy-*  (no_version_directory)
#               use PyCmt PyCmt-* Tools (no_auto_imports) (no_version_directory)
#                 use AtlasPolicy AtlasPolicy-*  (no_version_directory)
#                 use AtlasPython AtlasPython-* External (no_auto_imports) (no_version_directory)
#             use AtlasCLHEP AtlasCLHEP-* External (no_version_directory)
#           use GeoPrimitives GeoPrimitives-* DetectorDescription (no_version_directory)
#             use AtlasPolicy AtlasPolicy-*  (no_version_directory)
#             use AtlasEigen AtlasEigen-* External (no_version_directory)
#             use EventPrimitives EventPrimitives-* Event (no_version_directory)
#             use AtlasCLHEP AtlasCLHEP-* External (no_version_directory)
#             use CxxUtils CxxUtils-* Control (no_version_directory)
#         use CLIDSvc CLIDSvc-* Control (no_version_directory)
#         use DataModel DataModel-* Control (no_version_directory)
#         use TrkParameters TrkParameters-* Tracking/TrkEvent (no_version_directory)
#           use AtlasPolicy AtlasPolicy-*  (no_version_directory)
#           use TrkParametersBase TrkParametersBase-* Tracking/TrkEvent (no_version_directory)
#             use AtlasPolicy AtlasPolicy-*  (no_version_directory)
#             use GaudiInterface GaudiInterface-* External (no_version_directory)
#             use GeoPrimitives GeoPrimitives-* DetectorDescription (no_version_directory)
#             use EventPrimitives EventPrimitives-* Event (no_version_directory)
#             use TrkEventPrimitives TrkEventPrimitives-* Tracking/TrkEvent (no_version_directory)
#           use TrkSurfaces TrkSurfaces-* Tracking/TrkDetDescr (no_version_directory)
#             use AtlasPolicy AtlasPolicy-*  (no_version_directory)
#             use GaudiInterface GaudiInterface-* External (no_version_directory)
#             use DataModel DataModel-* Control (no_version_directory)
#             use CLIDSvc CLIDSvc-* Control (no_version_directory)
#             use Identifier Identifier-* DetectorDescription (no_version_directory)
#             use TrkDetDescrUtils TrkDetDescrUtils-* Tracking/TrkDetDescr (no_version_directory)
#               use AtlasPolicy AtlasPolicy-*  (no_version_directory)
#               use CLIDSvc CLIDSvc-* Control (no_version_directory)
#               use GaudiInterface GaudiInterface-* External (no_version_directory)
#               use GeoPrimitives GeoPrimitives-* DetectorDescription (no_version_directory)
#               use TrkEventPrimitives TrkEventPrimitives-* Tracking/TrkEvent (no_version_directory)
#             use TrkDetElementBase TrkDetElementBase-* Tracking/TrkDetDescr (no_version_directory)
#               use AtlasPolicy AtlasPolicy-*  (no_version_directory)
#               use Identifier Identifier-* DetectorDescription (no_version_directory)
#               use GeoPrimitives GeoPrimitives-* DetectorDescription (no_version_directory)
#               use GeoModelKernel GeoModelKernel-* DetectorDescription/GeoModel (no_version_directory)
#                 use AtlasPolicy AtlasPolicy-*  (no_version_directory)
#                 use AtlasCxxPolicy AtlasCxxPolicy-*  (no_version_directory)
#                 use AtlasCLHEP AtlasCLHEP-* External (no_version_directory)
#               use EventPrimitives EventPrimitives-* Event (no_version_directory)
#             use TrkParametersBase TrkParametersBase-* Tracking/TrkEvent (no_version_directory)
#             use TrkEventPrimitives TrkEventPrimitives-* Tracking/TrkEvent (no_version_directory)
#             use GeoPrimitives GeoPrimitives-* DetectorDescription (no_version_directory)
#             use EventPrimitives EventPrimitives-* Event (no_version_directory)
#         use TrkNeutralParameters TrkNeutralParameters-* Tracking/TrkEvent (no_version_directory)
#           use AtlasPolicy AtlasPolicy-*  (no_version_directory)
#           use TrkParametersBase TrkParametersBase-* Tracking/TrkEvent (no_version_directory)
#           use TrkSurfaces TrkSurfaces-* Tracking/TrkDetDescr (no_version_directory)
#         use TrkTrackLink TrkTrackLink-* Tracking/TrkEvent (no_version_directory)
#           use AtlasPolicy AtlasPolicy-*  (no_version_directory)
#           use TrkParameters TrkParameters-* Tracking/TrkEvent (no_version_directory)
#           use TrkNeutralParameters TrkNeutralParameters-* Tracking/TrkEvent (no_version_directory)
#         use GeoPrimitives GeoPrimitives-* DetectorDescription (no_version_directory)
#         use EventPrimitives EventPrimitives-* Event (no_version_directory)
#     use FourMom FourMom-* Event (no_version_directory)
#       use AtlasPolicy AtlasPolicy-*  (no_version_directory)
#       use AtlasCLHEP AtlasCLHEP-* External (no_version_directory)
#       use EventPrimitives EventPrimitives-* Event (no_version_directory)
#       use EventKernel EventKernel-* Event (no_version_directory)
#     use NavFourMom NavFourMom-* Event (no_version_directory)
#       use AtlasPolicy AtlasPolicy-*  (no_version_directory)
#       use AtlasCLHEP AtlasCLHEP-* External (no_version_directory)
#       use CLIDSvc CLIDSvc-* Control (no_version_directory)
#       use DataModel DataModel-* Control (no_version_directory)
#       use EventKernel EventKernel-* Event (no_version_directory)
#       use Navigation Navigation-* Control (no_version_directory)
#     use CaloDetDescr CaloDetDescr-* Calorimeter (no_version_directory)
#       use AtlasPolicy AtlasPolicy-*  (no_version_directory)
#       use AtlasBoost AtlasBoost-* External (no_version_directory)
#       use Identifier Identifier-* DetectorDescription (no_version_directory)
#       use CaloIdentifier CaloIdentifier-* Calorimeter (no_version_directory)
#       use GaudiInterface GaudiInterface-* External (no_version_directory)
#       use CLIDSvc CLIDSvc-* Control (no_version_directory)
#       use DataModel DataModel-* Control (no_version_directory)
#       use AthenaKernel AthenaKernel-* Control (no_version_directory)
#       use AthenaBaseComps AthenaBaseComps-* Control (no_version_directory)
#       use GeoModelInterfaces GeoModelInterfaces-* DetectorDescription/GeoModel (no_version_directory)
#         use AtlasPolicy AtlasPolicy-*  (no_version_directory)
#         use AthenaKernel AthenaKernel-* Control (no_version_directory)
#         use CLIDSvc CLIDSvc-* Control (no_version_directory)
#         use GaudiInterface GaudiInterface-* External (no_version_directory)
#       use LArReadoutGeometry LArReadoutGeometry-* LArCalorimeter/LArGeoModel (no_version_directory)
#         use AtlasPolicy AtlasPolicy-*  (no_version_directory)
#         use CLIDSvc CLIDSvc-* Control (no_version_directory)
#         use GeoModelKernel GeoModelKernel-* DetectorDescription/GeoModel (no_version_directory)
#         use Identifier Identifier-* DetectorDescription (no_version_directory)
#         use LArHV LArHV-* LArCalorimeter/LArGeoModel (no_version_directory)
#           use AtlasPolicy AtlasPolicy-*  (no_version_directory)
#           use GeoModelKernel GeoModelKernel-* DetectorDescription/GeoModel (no_version_directory)
#           use StoreGate StoreGate-* Control (no_version_directory)
#           use CLIDSvc CLIDSvc-* Control (no_version_directory)
#           use IOVSvc IOVSvc-* Control (no_version_directory)
#             use AtlasPolicy AtlasPolicy-*  (no_version_directory)
#             use SGTools SGTools-* Control (no_version_directory)
#             use AthenaKernel AthenaKernel-* Control (no_version_directory)
#             use AthenaBaseComps AthenaBaseComps-* Control (no_version_directory)
#             use AtlasBoost AtlasBoost-* External (no_version_directory)
#             use GaudiInterface GaudiInterface-* External (no_version_directory)
#         use GeoPrimitives GeoPrimitives-* DetectorDescription (no_version_directory)
#       use GeoPrimitives GeoPrimitives-* DetectorDescription (no_version_directory)
#       use CaloGeoHelpers CaloGeoHelpers-* Calorimeter (no_version_directory)
#     use CaloIdentifier CaloIdentifier-* Calorimeter (no_version_directory)
#     use CaloDetDescr CaloDetDescr-* Calorimeter (no_version_directory)
#     use CaloConditions CaloConditions-* Calorimeter (no_version_directory)
#       use AtlasPolicy AtlasPolicy-*  (no_version_directory)
#       use GaudiInterface GaudiInterface-* External (no_version_directory)
#       use CLIDSvc CLIDSvc-* Control (no_version_directory)
#       use CxxUtils CxxUtils-* Control (no_version_directory)
#       use Identifier Identifier-* DetectorDescription (no_version_directory)
#     use GeoPrimitives GeoPrimitives-* DetectorDescription (no_version_directory)
#     use CaloGeoHelpers CaloGeoHelpers-* Calorimeter (no_version_directory)
#   use xAODCaloEvent xAODCaloEvent-* Event/xAOD (no_version_directory)
#     use AtlasPolicy AtlasPolicy-*  (no_version_directory)
#     use AthContainers AthContainers-* Control (no_version_directory)
#     use AthLinks AthLinks-* Control (no_version_directory)
#     use CxxUtils CxxUtils-* Control (no_version_directory)
#     use GeoPrimitives GeoPrimitives-* DetectorDescription (no_version_directory)
#     use xAODBase xAODBase-* Event/xAOD (no_version_directory)
#       use AtlasPolicy AtlasPolicy-*  (no_version_directory)
#       use AtlasROOT AtlasROOT-* External (no_version_directory)
#       use SGTools SGTools-* Control (no_version_directory)
#       use AthContainers AthContainers-* Control (no_version_directory)
#     use xAODCore xAODCore-* Event/xAOD (no_version_directory)
#       use AtlasPolicy AtlasPolicy-*  (no_version_directory)
#       use AthenaKernel AthenaKernel-* Control (no_version_directory)
#       use SGTools SGTools-* Control (no_version_directory)
#       use AthLinks AthLinks-* Control (no_version_directory)
#       use AthContainersInterfaces AthContainersInterfaces-* Control (no_version_directory)
#       use AthContainers AthContainers-* Control (no_version_directory)
#       use AtlasROOT AtlasROOT-* External (no_version_directory)
#     use CaloGeoHelpers CaloGeoHelpers-* Calorimeter (no_version_directory)
#     use CaloEvent CaloEvent-* Calorimeter (no_version_directory)
# use CaloDetDescr CaloDetDescr-* Calorimeter (no_version_directory)
# use CaloEvent CaloEvent-* Calorimeter (no_version_directory)
# use CaloIdentifier CaloIdentifier-* Calorimeter (no_version_directory)
# use CaloUtils CaloUtils-* Calorimeter (no_version_directory)
#   use AtlasPolicy AtlasPolicy-*  (no_version_directory)
#   use GaudiInterface GaudiInterface-* External (no_version_directory)
#   use AthenaKernel AthenaKernel-* Control (no_version_directory)
#   use StoreGate StoreGate-* Control (no_version_directory)
#   use CaloInterface CaloInterface-* Calorimeter (no_version_directory)
#   use CaloEvent CaloEvent-* Calorimeter (no_version_directory)
#   use CaloDetDescr CaloDetDescr-* Calorimeter (no_version_directory)
#   use CaloIdentifier CaloIdentifier-* Calorimeter (no_version_directory)
#   use CaloConditions CaloConditions-* Calorimeter (no_version_directory)
#   use Navigation Navigation-* Control (no_version_directory)
#   use AthenaBaseComps AthenaBaseComps-* Control (no_version_directory)
#   use xAODCaloEvent xAODCaloEvent-* Event/xAOD (no_version_directory)
#   use CxxUtils CxxUtils-* Control (no_version_directory)
#   use CaloGeoHelpers CaloGeoHelpers-* Calorimeter (no_version_directory)
#   use FourMom FourMom-* Event (no_version_directory)
# use CaloConditions CaloConditions-* Calorimeter (no_version_directory)
# use CaloRec CaloRec-* Calorimeter (no_version_directory)
#   use AtlasPolicy AtlasPolicy-*  (no_version_directory)
#   use GaudiInterface GaudiInterface-* External (no_version_directory)
#   use CxxUtils CxxUtils-* Control (no_version_directory)
#   use StoreGate StoreGate-* Control (no_version_directory)
#   use AthenaKernel AthenaKernel-* Control (no_version_directory)
#   use AthenaBaseComps AthenaBaseComps-* Control (no_version_directory)
#   use CaloInterface CaloInterface-* Calorimeter (no_version_directory)
#   use CaloUtils CaloUtils-* Calorimeter (no_version_directory)
#   use CaloEvent CaloEvent-* Calorimeter (no_version_directory)
#   use CaloIdentifier CaloIdentifier-* Calorimeter (no_version_directory)
#   use Identifier Identifier-* DetectorDescription (no_version_directory)
#   use CaloConditions CaloConditions-* Calorimeter (no_version_directory)
#   use AthenaPoolUtilities AthenaPoolUtilities-* Database/AthenaPOOL (no_version_directory)
#     use AtlasPolicy AtlasPolicy-*  (no_version_directory)
#     use AtlasCORAL AtlasCORAL-* External (no_version_directory)
#       use ExternalPolicy ExternalPolicy-00-* External (no_version_directory)
#       use CORAL v* LCG_Interfaces (no_version_directory) (native_version=CORAL_2_4_5)
#         use LCG_Configuration v*  (no_version_directory)
#         use LCG_Settings v*  (no_version_directory)
#         use Boost v* LCG_Interfaces (no_version_directory) (native_version=1.55.0_python2.7)
#         use uuid v* LCG_Interfaces (no_auto_imports) (no_version_directory) (native_version=dummy)
#       use AtlasReflex AtlasReflex-00-* External (no_auto_imports) (no_version_directory)
#     use AthenaKernel AthenaKernel-* Control (no_version_directory)
#     use CLIDSvc CLIDSvc-* Control (no_version_directory)
#     use DataModel DataModel-* Control (no_version_directory)
#     use DBDataModel DBDataModel-* Database/AthenaPOOL (no_version_directory)
#       use AtlasPolicy AtlasPolicy-*  (no_version_directory)
#       use CLIDSvc CLIDSvc-* Control (no_version_directory)
#       use DataModel DataModel-* Control (no_version_directory)
#   use xAODCaloEvent xAODCaloEvent-* Event/xAOD (no_version_directory)
#   use AtlasCLHEP AtlasCLHEP-* External (no_version_directory)
#   use CaloDetDescr CaloDetDescr-* Calorimeter (no_version_directory)
#   use CaloGeoHelpers CaloGeoHelpers-* Calorimeter (no_version_directory)
#   use LArElecCalib LArElecCalib-* LArCalorimeter (no_version_directory)
#     use AtlasPolicy AtlasPolicy-*  (no_version_directory)
#     use GaudiInterface GaudiInterface-* External (no_version_directory)
#     use LArIdentifier LArIdentifier-* LArCalorimeter (no_version_directory)
#       use AtlasPolicy AtlasPolicy-*  (no_version_directory)
#       use CLIDSvc CLIDSvc-* Control (no_version_directory)
#       use Identifier Identifier-* DetectorDescription (no_version_directory)
#       use AtlasDetDescr AtlasDetDescr-* DetectorDescription (no_version_directory)
#       use IdDict IdDict-* DetectorDescription (no_version_directory)
#     use CaloIdentifier CaloIdentifier-* Calorimeter (no_version_directory)
#     use Identifier Identifier-* DetectorDescription (no_version_directory)
#     use CLIDSvc CLIDSvc-* Control (no_version_directory)
#     use AthenaKernel AthenaKernel-* Control (no_version_directory)
#     use AtlasEigen AtlasEigen-* External (no_version_directory)
# use LArIdentifier LArIdentifier-* LArCalorimeter (no_version_directory)
# use LArRawEvent LArRawEvent-* LArCalorimeter (no_version_directory)
#   use AtlasPolicy AtlasPolicy-*  (no_version_directory)
#   use AtlasCLHEP AtlasCLHEP-* External (no_version_directory)
#   use CaloIdentifier CaloIdentifier-* Calorimeter (no_version_directory)
#   use CLIDSvc CLIDSvc-* Control (no_version_directory)
#   use DataModel DataModel-* Control (no_version_directory)
#   use Identifier Identifier-* DetectorDescription (no_version_directory)
# use LArSimEvent LArSimEvent-* LArCalorimeter (no_version_directory)
#   use AtlasPolicy AtlasPolicy-*  (no_version_directory)
#   use CLIDSvc CLIDSvc-* Control (no_version_directory)
#   use AtlasCLHEP AtlasCLHEP-* External (no_version_directory)
#   use Identifier Identifier-* DetectorDescription (no_version_directory)
#   use HitManagement HitManagement-* Simulation (no_version_directory)
#     use EventInfo EventInfo-* Event (no_version_directory)
#       use AtlasPolicy AtlasPolicy-*  (no_version_directory)
#       use SGTools SGTools-* Control (no_version_directory)
#       use GaudiInterface GaudiInterface-* External (no_version_directory)
#     use AtlasPolicy AtlasPolicy-*  (no_version_directory)
#     use GaudiInterface GaudiInterface-* External (no_version_directory)
#     use AthenaKernel AthenaKernel-* Control (no_version_directory)
#     use AthContainers AthContainers-* Control (no_version_directory)
# use LArElecCalib LArElecCalib-* LArCalorimeter (no_version_directory)
# use LArRecConditions LArRecConditions-* LArCalorimeter (no_version_directory)
#   use AtlasPolicy AtlasPolicy-*  (no_version_directory)
#   use GaudiInterface GaudiInterface-* External (no_version_directory)
#   use AthenaKernel AthenaKernel-* Control (no_version_directory)
#   use Identifier Identifier-* DetectorDescription (no_version_directory)
#   use CaloIdentifier CaloIdentifier-* Calorimeter (no_version_directory)
# use AtlasHepMC AtlasHepMC-* External (no_version_directory) (native_version=2.06.09)
#   use ExternalPolicy ExternalPolicy-* External (no_version_directory)
#   use LCG_Configuration v*  (no_version_directory)
# use AtlasROOT AtlasROOT-* External (no_version_directory)
# use DataModel DataModel-* Control (no_version_directory)
# use AthenaPoolUtilities AthenaPoolUtilities-* Database/AthenaPOOL (no_version_directory)
# use xAODEventInfo xAODEventInfo-* Event/xAOD (no_version_directory)
#   use AtlasPolicy AtlasPolicy-*  (no_version_directory)
#   use AthContainers AthContainers-* Control (no_version_directory)
#   use AthLinks AthLinks-* Control (no_version_directory)
#   use xAODCore xAODCore-* Event/xAOD (no_version_directory)
# use GeoModelInterfaces GeoModelInterfaces-* DetectorDescription/GeoModel (no_version_directory)
# use GeneratorObjects GeneratorObjects-* Generators (no_version_directory)
#   use AtlasPolicy AtlasPolicy-*  (no_version_directory)
#   use AtlasHepMC AtlasHepMC-* External (no_version_directory) (native_version=2.06.09)
#   use GaudiInterface GaudiInterface-* External (no_version_directory)
#   use DataModel DataModel-* Control (no_version_directory)
#   use SGTools SGTools-* Control (no_version_directory)
#   use xAODTruth xAODTruth-* Event/xAOD (no_version_directory)
#     use AtlasPolicy AtlasPolicy-*  (no_version_directory)
#     use AthContainers AthContainers-* Control (no_version_directory)
#     use AthLinks AthLinks-* Control (no_version_directory)
#     use xAODBase xAODBase-* Event/xAOD (no_version_directory)
#     use xAODCore xAODCore-* Event/xAOD (no_version_directory)
#     use AtlasROOT AtlasROOT-* External (no_version_directory)
# use CaloTriggerTool CaloTriggerTool-* Calorimeter (no_version_directory)
#   use AtlasPolicy AtlasPolicy-*  (no_version_directory)
#   use GaudiInterface GaudiInterface-* External (no_version_directory)
#   use StoreGate StoreGate-* Control (no_version_directory)
#   use CLIDSvc CLIDSvc-* Control (no_version_directory)
#   use AthenaKernel AthenaKernel-* Control (no_version_directory)
#   use AthenaBaseComps AthenaBaseComps-* Control (no_version_directory)
#   use Identifier Identifier-* DetectorDescription (no_version_directory)
#   use CaloIdentifier CaloIdentifier-* Calorimeter (no_version_directory)
#   use TrigT1CaloCalibConditions TrigT1CaloCalibConditions-* Trigger/TrigT1 (no_version_directory)
#     use AtlasPolicy AtlasPolicy-*  (no_version_directory)
#     use GaudiInterface GaudiInterface-* External (no_version_directory)
#     use CLIDSvc CLIDSvc-* Control (no_version_directory)
#     use DataModel DataModel-* Control (no_version_directory)
#     use AtlasCORAL AtlasCORAL-* External (no_version_directory)
#     use AthenaPoolUtilities AthenaPoolUtilities-* Database/AthenaPOOL (no_version_directory)
#   use AtlasReflex AtlasReflex-* External (no_auto_imports) (no_version_directory)
# use LArRecEvent LArRecEvent-* LArCalorimeter (no_version_directory)
#   use AtlasPolicy AtlasPolicy-*  (no_version_directory)
#   use DataModel DataModel-* Control (no_version_directory)
#   use CaloEvent CaloEvent-* Calorimeter (no_version_directory)
#   use Identifier Identifier-* DetectorDescription (no_version_directory)
#   use CLIDSvc CLIDSvc-* Control (no_version_directory)
#   use CaloIdentifier CaloIdentifier-* Calorimeter (no_version_directory)
# use LArTools LArTools-* LArCalorimeter (no_version_directory)
#   use AtlasPolicy AtlasPolicy-*  (no_version_directory)
#   use GaudiInterface GaudiInterface-* External (no_version_directory)
#   use StoreGate StoreGate-* Control (no_version_directory)
#   use AthenaKernel AthenaKernel-* Control (no_version_directory)
#   use AthenaBaseComps AthenaBaseComps-* Control (no_version_directory)
#   use Identifier Identifier-* DetectorDescription (no_version_directory)
#   use LArIdentifier LArIdentifier-* LArCalorimeter (no_version_directory)
#   use CaloIdentifier CaloIdentifier-* Calorimeter (no_version_directory)
#   use LArElecCalib LArElecCalib-* LArCalorimeter (no_version_directory)
#   use AthenaBaseComps AthenaBaseComps-* Control (no_version_directory)
#   use AthenaPoolUtilities AthenaPoolUtilities-* Database/AthenaPOOL (no_version_directory)
#   use AtlasReflex AtlasReflex-* External (no_auto_imports) (no_version_directory)
# use TrigT1CaloCalibConditions TrigT1CaloCalibConditions-* Trigger/TrigT1 (no_version_directory)
# use xAODTrigL1Calo xAODTrigL1Calo-* Event/xAOD (no_version_directory)
#   use AtlasPolicy AtlasPolicy-*  (no_version_directory)
#   use AthContainers AthContainers-* Control (no_version_directory)
#   use AthLinks AthLinks-* Control (no_version_directory)
#   use CxxUtils CxxUtils-* Control (no_version_directory)
#   use xAODBase xAODBase-* Event/xAOD (no_version_directory)
#   use xAODCore xAODCore-* Event/xAOD (no_version_directory)
# use TrigT1CaloCondSvc TrigT1CaloCondSvc-* Trigger/TrigT1 (no_version_directory)
#   use AtlasPolicy AtlasPolicy-*  (no_version_directory)
#   use GaudiInterface GaudiInterface-* External (no_version_directory)
#   use StoreGate StoreGate-* Control (no_version_directory)
#   use AthenaKernel AthenaKernel-* Control (no_version_directory)
#   use SGTools SGTools-* Control (no_version_directory)
#   use AthenaBaseComps AthenaBaseComps-* Control (no_version_directory)
#   use AthenaPoolUtilities AthenaPoolUtilities-* Database/AthenaPOOL (no_version_directory)
#   use RegistrationServices RegistrationServices-* Database (no_version_directory)
#     use AtlasPolicy AtlasPolicy-*  (no_version_directory)
#     use GaudiInterface GaudiInterface-* External (no_version_directory)
#   use TrigT1CaloCalibConditions TrigT1CaloCalibConditions-* Trigger/TrigT1 (no_version_directory)
# use GaudiKernel v*  (no_auto_imports) (no_version_directory)
# use GaudiCoreSvc *  (no_auto_imports) (no_version_directory)
#   use GaudiKernel *  (no_version_directory)
#   use Boost * LCG_Interfaces (no_auto_imports) (no_version_directory) (native_version=1.55.0_python2.7)
#   use ROOT * LCG_Interfaces (no_auto_imports) (no_version_directory) (native_version=5.34.25)
# use CLIDComps * Control (no_auto_imports) (no_version_directory)
#   use AtlasPolicy AtlasPolicy-*  (no_version_directory)
#
# Selection :
use CMT v1r25p20140131 (/cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8)
use CodeCheck CodeCheck-01-02-03 Tools (/cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/AtlasCore/20.1.8)
use LCG_Platforms v1  (/cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/LCGCMT/LCGCMT_72a)
use AtlasCompilers AtlasCompilers-00-00-23 External (/cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/DetCommon/20.1.8)
use LCG_Configuration v1  (/cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/LCGCMT/LCGCMT_72a)
use LCG_Settings v1  (/cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/LCGCMT/LCGCMT_72a)
use CLHEP CLHEP-00-67-00-02 LCG_Interfaces (/cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/DetCommon/20.1.8)
use RELAX v1 LCG_Interfaces (/cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/LCGCMT/LCGCMT_72a) (no_auto_imports)
use uuid v1 LCG_Interfaces (/cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/LCGCMT/LCGCMT_72a)
use AtlasDoxygen AtlasDoxygen-00-04-10 Tools (/cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/DetCommon/20.1.8)
use AtlasCommonPolicy AtlasCommonPolicy-00-00-55  (/cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/DetCommon/20.1.8)
use xrootd v1 LCG_Interfaces (/cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/LCGCMT/LCGCMT_72a)
use GCCXML v1 LCG_Interfaces (/cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/LCGCMT/LCGCMT_72a) (no_auto_imports)
use libunwind v1 LCG_Interfaces (/cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/LCGCMT/LCGCMT_72a) (no_auto_imports)
use tcmalloc v1 LCG_Interfaces (/cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/LCGCMT/LCGCMT_72a) (no_auto_imports)
use Python v1 LCG_Interfaces (/cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/LCGCMT/LCGCMT_72a) (no_auto_imports)
use Boost Boost-00-71-00-01 LCG_Interfaces (/cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/DetCommon/20.1.8)
use CORAL v1 LCG_Interfaces (/cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/LCGCMT/LCGCMT_72a)
use ROOT v1 LCG_Interfaces (/cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/LCGCMT/LCGCMT_72a)
use Reflex v1 LCG_Interfaces (/cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/LCGCMT/LCGCMT_72a)
use GaudiPolicy GaudiPolicy-15-00-01  (/cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/GAUDI/v25r3p2-lcg72a)
use GaudiPluginService GaudiPluginService-01-02-00  (/cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/GAUDI/v25r3p2-lcg72a)
use GaudiKernel GaudiKernel-31-00-00  (/cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/GAUDI/v25r3p2-lcg72a)
use GaudiCoreSvc GaudiCoreSvc-03-01-00  (/cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/GAUDI/v25r3p2-lcg72a) (no_auto_imports)
use PlatformPolicy PlatformPolicy-00-00-20 External (/cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/AtlasCore/20.1.8)
use AtlasExternalArea AtlasExternalArea-00-00-25 External (/cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/AtlasCore/20.1.8)
use Mac105_Compat Mac105_Compat-00-00-01 External (/cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/AtlasCore/20.1.8)
use ExternalPolicy ExternalPolicy-00-01-71 External (/cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/AtlasCore/20.1.8)
use AtlasHepMC AtlasHepMC-00-00-20 External (/cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/AtlasEvent/20.1.8)
use AtlasCLHEP AtlasCLHEP-00-00-08 External (/cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/AtlasCore/20.1.8)
use AtlasPython AtlasPython-00-01-07 External (/cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/AtlasCore/20.1.8) (no_auto_imports)
use AtlasRELAX AtlasRELAX-00-01-00 External (/cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/AtlasCore/20.1.8) (no_auto_imports)
use AtlasReflex AtlasReflex-00-02-57 External (/cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/AtlasCore/20.1.8)
use AtlasCORAL AtlasCORAL-00-00-10 External (/cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/AtlasCore/20.1.8)
use AtlasROOT AtlasROOT-02-03-21 External (/cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/AtlasCore/20.1.8)
use GaudiInterface GaudiInterface-01-03-04 External (/cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/AtlasCore/20.1.8)
use CheckerGccPlugins CheckerGccPlugins-00-01-14 External (/cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/AtlasCore/20.1.8)
use AtlasCxxPolicy AtlasCxxPolicy-00-00-72  (/cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/AtlasCore/20.1.8)
use AtlasPolicy AtlasPolicy-01-08-34  (/cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/AtlasCore/20.1.8)
use CLIDComps CLIDComps-00-06-18 Control (/cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/AtlasCore/20.1.8) (no_auto_imports)
use RegistrationServices RegistrationServices-00-06-48 Database (/cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/AtlasCore/20.1.8)
use GeoModelKernel GeoModelKernel-00-00-81 DetectorDescription/GeoModel (/cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/AtlasCore/20.1.8)
use PyCmt PyCmt-00-00-40 Tools (/cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/AtlasCore/20.1.8) (no_auto_imports)
use AtlasEigen AtlasEigen-00-00-07 External (/cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/AtlasCore/20.1.8)
use EventPrimitives EventPrimitives-00-00-45 Event (/cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/AtlasConditions/20.1.8)
use Scripts Scripts-00-01-88 Tools (/cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/AtlasCore/20.1.8) (no_auto_imports)
use AtlasBoost AtlasBoost-00-00-09 External (/cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/AtlasCore/20.1.8)
use Identifier Identifier-00-09-32 DetectorDescription (/cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/AtlasCore/20.1.8)
use IdDict IdDict-00-08-19 DetectorDescription (/cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/AtlasCore/20.1.8)
use AthAllocators AthAllocators-00-01-06 Control (/cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/AtlasCore/20.1.8)
use CxxUtils CxxUtils-00-01-45 Control (/cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/AtlasCore/20.1.8)
use GeoPrimitives GeoPrimitives-00-00-33-03 DetectorDescription (/cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/AtlasConditions/20.1.8)
use TrkDetElementBase TrkDetElementBase-01-00-00 Tracking/TrkDetDescr (/cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/AtlasConditions/20.1.8)
use TrkEventPrimitives TrkEventPrimitives-01-00-12 Tracking/TrkEvent (/cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/AtlasConditions/20.1.8)
use TrkParametersBase TrkParametersBase-01-02-06 Tracking/TrkEvent (/cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/AtlasConditions/20.1.8)
use CaloGeoHelpers CaloGeoHelpers-00-00-06 Calorimeter (/cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/AtlasConditions/20.1.8)
use DataModelRoot DataModelRoot-00-00-20 Control (/cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/AtlasCore/20.1.8)
use AthenaKernel AthenaKernel-00-56-19 Control (/cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/AtlasCore/20.1.8)
use SGTools SGTools-00-24-09 Control (/cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/AtlasCore/20.1.8)
use EventInfo EventInfo-00-11-02-03 Event (/cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/AtlasCore/20.1.8)
use AthLinks AthLinks-00-02-19 Control (/cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/AtlasCore/20.1.8)
use CLIDSvc CLIDSvc-00-05-02 Control (/cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/AtlasCore/20.1.8)
use CaloConditions CaloConditions-00-01-67 Calorimeter (/cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/AtlasConditions/20.1.8)
use GeoModelInterfaces GeoModelInterfaces-00-00-05 DetectorDescription/GeoModel (/cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/AtlasCore/20.1.8)
use TrkDetDescrUtils TrkDetDescrUtils-01-03-01 Tracking/TrkDetDescr (/cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/AtlasConditions/20.1.8)
use AtlasDetDescr AtlasDetDescr-00-08-05 DetectorDescription (/cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/AtlasCore/20.1.8)
use LArIdentifier LArIdentifier-01-02-06 LArCalorimeter (/cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/AtlasConditions/20.1.8)
use CaloIdentifier CaloIdentifier-00-10-84 Calorimeter (/cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/AtlasConditions/20.1.8)
use LArRecConditions LArRecConditions-00-00-28 LArCalorimeter (/cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/AtlasConditions/20.1.8)
use LArElecCalib LArElecCalib-02-06-14 LArCalorimeter (/cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/AtlasConditions/20.1.8)
use AthContainersInterfaces AthContainersInterfaces-00-01-33 Control (/cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/AtlasCore/20.1.8)
use AthContainers AthContainers-00-02-45 Control (/cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/AtlasCore/20.1.8)
use HitManagement HitManagement-00-01-19 Simulation (/cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/AtlasEvent/20.1.8)
use LArSimEvent LArSimEvent-01-04-04 LArCalorimeter (/cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/AtlasEvent/20.1.8)
use xAODCore xAODCore-00-00-84 Event/xAOD (/cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/AtlasEvent/20.1.8)
use xAODEventInfo xAODEventInfo-00-00-22-01 Event/xAOD (/cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/AtlasEvent/20.1.8)
use xAODBase xAODBase-00-00-22 Event/xAOD (/cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/AtlasEvent/20.1.8)
use xAODTrigL1Calo xAODTrigL1Calo-00-00-57 Event/xAOD (/cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/AtlasEvent/20.1.8)
use xAODTruth xAODTruth-00-01-10 Event/xAOD (/cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/AtlasEvent/20.1.8)
use DataModel DataModel-00-23-71 Control (/cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/AtlasCore/20.1.8)
use GeneratorObjects GeneratorObjects-01-03-23 Generators (/cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/AtlasEvent/20.1.8)
use LArRawEvent LArRawEvent-01-07-21 LArCalorimeter (/cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/AtlasEvent/20.1.8)
use DBDataModel DBDataModel-00-08-02 Database/AthenaPOOL (/cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/AtlasCore/20.1.8)
use AthenaPoolUtilities AthenaPoolUtilities-00-05-06 Database/AthenaPOOL (/cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/AtlasCore/20.1.8)
use TrigT1CaloCalibConditions TrigT1CaloCalibConditions-00-03-26 Trigger/TrigT1 (/cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/AtlasConditions/20.1.8)
use TrkSurfaces TrkSurfaces-01-03-07 Tracking/TrkDetDescr (/cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/AtlasConditions/20.1.8)
use TrkNeutralParameters TrkNeutralParameters-01-00-05 Tracking/TrkEvent (/cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/AtlasConditions/20.1.8)
use TrkParameters TrkParameters-02-00-08 Tracking/TrkEvent (/cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/AtlasConditions/20.1.8)
use TrkTrackLink TrkTrackLink-01-00-02 Tracking/TrkEvent (/cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/AtlasEvent/20.1.8)
use VxVertex VxVertex-03-00-13 Tracking/TrkEvent (/cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/AtlasEvent/20.1.8)
use Navigation Navigation-00-08-25 Control (/cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/AtlasCore/20.1.8)
use EventKernel EventKernel-00-08-14 Event (/cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/AtlasEvent/20.1.8)
use NavFourMom NavFourMom-00-04-19 Event (/cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/AtlasEvent/20.1.8)
use FourMom FourMom-00-03-21 Event (/cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/AtlasEvent/20.1.8)
use StoreGate StoreGate-02-45-01-11 Control (/cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/AtlasCore/20.1.8)
use AthenaBaseComps AthenaBaseComps-00-07-02 Control (/cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/AtlasCore/20.1.8)
use TrigT1CaloCondSvc TrigT1CaloCondSvc-00-02-09 Trigger/TrigT1 (/cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/AtlasConditions/20.1.8)
use LArTools LArTools-00-08-17 LArCalorimeter (/cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/AtlasConditions/20.1.8)
use CaloTriggerTool CaloTriggerTool-00-03-40 Calorimeter (/cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/AtlasConditions/20.1.8)
use IOVSvc IOVSvc-00-07-33 Control (/cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/AtlasCore/20.1.8)
use LArHV LArHV-00-00-32 LArCalorimeter/LArGeoModel (/cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/AtlasConditions/20.1.8)
use LArReadoutGeometry LArReadoutGeometry-00-01-01 LArCalorimeter/LArGeoModel (/cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/AtlasConditions/20.1.8)
use CaloDetDescr CaloDetDescr-01-00-11 Calorimeter (/cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/AtlasConditions/20.1.8)
use CaloEvent CaloEvent-01-08-53 Calorimeter (/cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/AtlasEvent/20.1.8)
use LArRecEvent LArRecEvent-01-03-14 LArCalorimeter (/cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/AtlasEvent/20.1.8)
use xAODCaloEvent xAODCaloEvent-00-01-09 Event/xAOD (/cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/AtlasEvent/20.1.8)
use CaloInterface CaloInterface-01-00-10 Calorimeter (/cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/AtlasEvent/20.1.8)
use CaloUtils CaloUtils-01-00-49 Calorimeter (/cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/AtlasEvent/20.1.8)
use CaloRec CaloRec-03-00-37-04 Calorimeter (/cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/AtlasReconstruction/20.1.8)
use CMTUSERCONTEXT v0 (/cvmfs/atlas.cern.ch/repo/tools/slc6/cmt)
----------> tags
x86_64-slc6-gcc48-opt (from CMTCONFIG) package [LCG_Platforms PlatformPolicy] implies [target-x86_64 target-slc6 target-gcc48 target-opt Linux slc6 64 gcc-4.8 opt x86_64-slc6-gcc48]
ATLAS (from arguments) package [GaudiPolicy] implies [use-shared-dir no-pyzip] applied [ExternalPolicy]
CMTv1 (from CMTVERSION)
CMTr25 (from CMTVERSION)
CMTp20140131 (from CMTVERSION)
Linux (from uname) package [CMT LCG_Platforms AtlasCxxPolicy AtlasPolicy] implies [Unix host-linux cpp_native_dependencies]
STANDALONE (from CMTSITE)
CMTUSERCONTEXT_no_config (from PROJECT) excludes [CMTUSERCONTEXT_config]
CMTUSERCONTEXT_no_root (from PROJECT) excludes [CMTUSERCONTEXT_root]
CMTUSERCONTEXT_cleanup (from PROJECT) excludes [CMTUSERCONTEXT_no_cleanup]
CMTUSERCONTEXT_scripts (from PROJECT) excludes [CMTUSERCONTEXT_no_scripts]
CMTUSERCONTEXT_no_prototypes (from PROJECT) excludes [CMTUSERCONTEXT_prototypes]
CMTUSERCONTEXT_with_installarea (from PROJECT) excludes [CMTUSERCONTEXT_without_installarea]
CMTUSERCONTEXT_without_version_directory (from PROJECT) excludes [CMTUSERCONTEXT_with_version_directory]
boveia_no_config (from PROJECT) excludes [boveia_config]
boveia_no_root (from PROJECT) excludes [boveia_root]
boveia_cleanup (from PROJECT) excludes [boveia_no_cleanup]
boveia_scripts (from PROJECT) excludes [boveia_no_scripts]
boveia_no_prototypes (from PROJECT) excludes [boveia_prototypes]
boveia_with_installarea (from PROJECT) excludes [boveia_without_installarea]
boveia_without_version_directory (from PROJECT) excludes [boveia_with_version_directory]
boveia (from PROJECT)
AtlasProduction_no_config (from PROJECT) excludes [AtlasProduction_config]
AtlasProduction_no_root (from PROJECT) excludes [AtlasProduction_root]
AtlasProduction_cleanup (from PROJECT) excludes [AtlasProduction_no_cleanup]
AtlasProduction_scripts (from PROJECT) excludes [AtlasProduction_no_scripts]
AtlasProduction_no_prototypes (from PROJECT) excludes [AtlasProduction_prototypes]
AtlasProduction_with_installarea (from PROJECT) excludes [AtlasProduction_without_installarea]
AtlasProduction_without_version_directory (from PROJECT) excludes [AtlasProduction_with_version_directory]
AtlasOffline_no_config (from PROJECT) excludes [AtlasOffline_config]
AtlasOffline_no_root (from PROJECT) excludes [AtlasOffline_root]
AtlasOffline_cleanup (from PROJECT) excludes [AtlasOffline_no_cleanup]
AtlasOffline_scripts (from PROJECT) excludes [AtlasOffline_no_scripts]
AtlasOffline_no_prototypes (from PROJECT) excludes [AtlasOffline_prototypes]
AtlasOffline_with_installarea (from PROJECT) excludes [AtlasOffline_without_installarea]
AtlasOffline_without_version_directory (from PROJECT) excludes [AtlasOffline_with_version_directory]
AtlasAnalysis_no_config (from PROJECT) excludes [AtlasAnalysis_config]
AtlasAnalysis_no_root (from PROJECT) excludes [AtlasAnalysis_root]
AtlasAnalysis_cleanup (from PROJECT) excludes [AtlasAnalysis_no_cleanup]
AtlasAnalysis_scripts (from PROJECT) excludes [AtlasAnalysis_no_scripts]
AtlasAnalysis_no_prototypes (from PROJECT) excludes [AtlasAnalysis_prototypes]
AtlasAnalysis_with_installarea (from PROJECT) excludes [AtlasAnalysis_without_installarea]
AtlasAnalysis_without_version_directory (from PROJECT) excludes [AtlasAnalysis_with_version_directory]
AtlasTrigger_no_config (from PROJECT) excludes [AtlasTrigger_config]
AtlasTrigger_no_root (from PROJECT) excludes [AtlasTrigger_root]
AtlasTrigger_cleanup (from PROJECT) excludes [AtlasTrigger_no_cleanup]
AtlasTrigger_scripts (from PROJECT) excludes [AtlasTrigger_no_scripts]
AtlasTrigger_no_prototypes (from PROJECT) excludes [AtlasTrigger_prototypes]
AtlasTrigger_with_installarea (from PROJECT) excludes [AtlasTrigger_without_installarea]
AtlasTrigger_without_version_directory (from PROJECT) excludes [AtlasTrigger_with_version_directory]
AtlasReconstruction_no_config (from PROJECT) excludes [AtlasReconstruction_config]
AtlasReconstruction_no_root (from PROJECT) excludes [AtlasReconstruction_root]
AtlasReconstruction_cleanup (from PROJECT) excludes [AtlasReconstruction_no_cleanup]
AtlasReconstruction_scripts (from PROJECT) excludes [AtlasReconstruction_no_scripts]
AtlasReconstruction_no_prototypes (from PROJECT) excludes [AtlasReconstruction_prototypes]
AtlasReconstruction_with_installarea (from PROJECT) excludes [AtlasReconstruction_without_installarea]
AtlasReconstruction_without_version_directory (from PROJECT) excludes [AtlasReconstruction_with_version_directory]
AtlasEvent_no_config (from PROJECT) excludes [AtlasEvent_config]
AtlasEvent_no_root (from PROJECT) excludes [AtlasEvent_root]
AtlasEvent_cleanup (from PROJECT) excludes [AtlasEvent_no_cleanup]
AtlasEvent_scripts (from PROJECT) excludes [AtlasEvent_no_scripts]
AtlasEvent_no_prototypes (from PROJECT) excludes [AtlasEvent_prototypes]
AtlasEvent_with_installarea (from PROJECT) excludes [AtlasEvent_without_installarea]
AtlasEvent_without_version_directory (from PROJECT) excludes [AtlasEvent_with_version_directory]
AtlasConditions_no_config (from PROJECT) excludes [AtlasConditions_config]
AtlasConditions_no_root (from PROJECT) excludes [AtlasConditions_root]
AtlasConditions_cleanup (from PROJECT) excludes [AtlasConditions_no_cleanup]
AtlasConditions_scripts (from PROJECT) excludes [AtlasConditions_no_scripts]
AtlasConditions_no_prototypes (from PROJECT) excludes [AtlasConditions_prototypes]
AtlasConditions_with_installarea (from PROJECT) excludes [AtlasConditions_without_installarea]
AtlasConditions_without_version_directory (from PROJECT) excludes [AtlasConditions_with_version_directory]
AtlasCore_no_config (from PROJECT) excludes [AtlasCore_config]
AtlasCore_no_root (from PROJECT) excludes [AtlasCore_root]
AtlasCore_cleanup (from PROJECT) excludes [AtlasCore_no_cleanup]
AtlasCore_scripts (from PROJECT) excludes [AtlasCore_no_scripts]
AtlasCore_no_prototypes (from PROJECT) excludes [AtlasCore_prototypes]
AtlasCore_with_installarea (from PROJECT) excludes [AtlasCore_without_installarea]
AtlasCore_without_version_directory (from PROJECT) excludes [AtlasCore_with_version_directory]
DetCommon_no_config (from PROJECT) excludes [DetCommon_config]
DetCommon_no_root (from PROJECT) excludes [DetCommon_root]
DetCommon_cleanup (from PROJECT) excludes [DetCommon_no_cleanup]
DetCommon_scripts (from PROJECT) excludes [DetCommon_no_scripts]
DetCommon_prototypes (from PROJECT) excludes [DetCommon_no_prototypes]
DetCommon_with_installarea (from PROJECT) excludes [DetCommon_without_installarea]
DetCommon_without_version_directory (from PROJECT) excludes [DetCommon_with_version_directory]
tdaq-common_no_config (from PROJECT) excludes [tdaq-common_config]
tdaq-common_no_root (from PROJECT) excludes [tdaq-common_root]
tdaq-common_cleanup (from PROJECT) excludes [tdaq-common_no_cleanup]
tdaq-common_scripts (from PROJECT) excludes [tdaq-common_no_scripts]
tdaq-common_prototypes (from PROJECT) excludes [tdaq-common_no_prototypes]
tdaq-common_without_installarea (from PROJECT) excludes [tdaq-common_with_installarea]
tdaq-common_without_version_directory (from PROJECT) excludes [tdaq-common_with_version_directory]
LCGCMT_no_config (from PROJECT) excludes [LCGCMT_config]
LCGCMT_no_root (from PROJECT) excludes [LCGCMT_root]
LCGCMT_cleanup (from PROJECT) excludes [LCGCMT_no_cleanup]
LCGCMT_scripts (from PROJECT) excludes [LCGCMT_no_scripts]
LCGCMT_prototypes (from PROJECT) excludes [LCGCMT_no_prototypes]
LCGCMT_with_installarea (from PROJECT) excludes [LCGCMT_without_installarea]
LCGCMT_without_version_directory (from PROJECT) excludes [LCGCMT_with_version_directory]
GAUDI_no_config (from PROJECT) excludes [GAUDI_config]
GAUDI_root (from PROJECT) excludes [GAUDI_no_root]
GAUDI_cleanup (from PROJECT) excludes [GAUDI_no_cleanup]
GAUDI_scripts (from PROJECT) excludes [GAUDI_no_scripts]
GAUDI_prototypes (from PROJECT) excludes [GAUDI_no_prototypes]
GAUDI_with_installarea (from PROJECT) excludes [GAUDI_without_installarea]
GAUDI_without_version_directory (from PROJECT) excludes [GAUDI_with_version_directory]
dqm-common_no_config (from PROJECT) excludes [dqm-common_config]
dqm-common_no_root (from PROJECT) excludes [dqm-common_root]
dqm-common_cleanup (from PROJECT) excludes [dqm-common_no_cleanup]
dqm-common_scripts (from PROJECT) excludes [dqm-common_no_scripts]
dqm-common_prototypes (from PROJECT) excludes [dqm-common_no_prototypes]
dqm-common_without_installarea (from PROJECT) excludes [dqm-common_with_installarea]
dqm-common_without_version_directory (from PROJECT) excludes [dqm-common_with_version_directory]
AtlasSimulation_no_config (from PROJECT) excludes [AtlasSimulation_config]
AtlasSimulation_no_root (from PROJECT) excludes [AtlasSimulation_root]
AtlasSimulation_cleanup (from PROJECT) excludes [AtlasSimulation_no_cleanup]
AtlasSimulation_scripts (from PROJECT) excludes [AtlasSimulation_no_scripts]
AtlasSimulation_no_prototypes (from PROJECT) excludes [AtlasSimulation_prototypes]
AtlasSimulation_with_installarea (from PROJECT) excludes [AtlasSimulation_without_installarea]
AtlasSimulation_without_version_directory (from PROJECT) excludes [AtlasSimulation_with_version_directory]
x86_64 (from package CMT) package [LCG_Platforms] implies [host-x86_64] applied [CMT]
slc67 (from package CMT) package [LCG_Platforms PlatformPolicy] implies [host-slc6] applied [CMT]
gcc481 (from package CMT) package [LCG_Platforms] implies [host-gcc48] applied [CMT]
Unix (from package CMT) package [LCG_Platforms] implies [host-unix] excludes [WIN32 Win32]
c_native_dependencies (from package CMT) activated GaudiPolicy
cpp_native_dependencies (from package CMT) activated GaudiPolicy
/cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8:/cvmfs/atlas.cern.ch/repo/sw/tdaq/tdaqnotProject (from package ExternalPolicy) applied [ExternalPolicy]
target-unix (from package LCG_Settings) activated LCG_Platforms
target-x86_64 (from package LCG_Settings) activated LCG_Platforms
target-gcc48 (from package LCG_Settings) package [LCG_Platforms] implies [target-gcc4 target-lcg-compiler lcg-compiler target-c11] activated LCG_Platforms
host-x86_64 (from package LCG_Settings) activated LCG_Platforms
target-slc (from package LCG_Settings) package [LCG_Platforms] implies [target-linux] activated LCG_Platforms
target-gcc (from package LCG_Settings) activated LCG_Platforms
target-gcc4 (from package LCG_Settings) package [LCG_Platforms] implies [target-gcc] activated LCG_Platforms
target-lcg-compiler (from package LCG_Settings) activated LCG_Platforms
host-gcc4 (from package LCG_Platforms) package [LCG_Platforms] implies [host-gcc]
host-gcc48 (from package LCG_Platforms) package [LCG_Platforms] implies [host-gcc4]
host-gcc (from package LCG_Platforms)
host-linux (from package LCG_Platforms) package [LCG_Platforms] implies [host-unix]
host-unix (from package LCG_Platforms)
host-slc6 (from package LCG_Platforms) package [LCG_Platforms] implies [host-slc]
host-slc (from package LCG_Platforms) package [LCG_Platforms] implies [host-linux]
target-opt (from package LCG_Platforms)
target-slc6 (from package LCG_Platforms) package [LCG_Platforms] implies [target-slc]
target-linux (from package LCG_Platforms) package [LCG_Platforms] implies [target-unix]
lcg-compiler (from package LCG_Platforms)
target-c11 (from package LCG_Platforms)
ROOT_GE_5_15 (from package LCG_Configuration) applied [LCG_Configuration]
ROOT_GE_5_19 (from package LCG_Configuration) applied [LCG_Configuration]
use-shared-dir (from package GaudiPolicy)
do_genconf (from package GaudiPolicy) applied [AtlasPolicy] activated AtlasPolicy
no-pyzip (from package GaudiPolicy)
separate-debug (from package AtlasCommonPolicy) excludes [no-separate-debug] applied [AtlasCommonPolicy]
NICOS (from package AtlasCommonPolicy) package AtlasCommonPolicy excludes [NICOSrel_nightly] applied [AtlasCommonPolicy]
LCGCMT_INSTALLED (from package PlatformPolicy) applied [PlatformPolicy ExternalPolicy]
block-tdaqc (from package PlatformPolicy) applied [PlatformPolicy ExternalPolicy]
opt (from package PlatformPolicy) package [AtlasPolicy] implies [optimized]
gcc (from package PlatformPolicy)
64 (from package PlatformPolicy) package [PlatformPolicy] implies [target-64]
gcc-4.8 (from package PlatformPolicy) package [PlatformPolicy] implies [gcc48x gcc48 gcc]
gcc48x (from package PlatformPolicy)
gcc48 (from package PlatformPolicy)
slc6 (from package PlatformPolicy)
x86_64-slc6-gcc48 (from package PlatformPolicy)
target-64 (from package PlatformPolicy)
asNeeded (from package PlatformPolicy) applied [PlatformPolicy]
CheckerGccPlugins_project_AtlasCore (from package CheckerGccPlugins) applied [CheckerGccPlugins]
optimized (from package AtlasPolicy) package [AtlasPolicy] implies [opt]
HasAthenaRunTime (from package AtlasPolicy) applied [AtlasPolicy]
HAVE_GAUDI_PLUGINSVC (from package GaudiPluginService) applied [GaudiPluginService]
ROOTBasicLibs (from package AtlasROOT) applied [AtlasROOT]
ROOTCintexLibs (from package AtlasROOT) applied [xAODCore] activated xAODCore
ROOTMathLibs (from package AtlasROOT) applied [xAODBase] activated xAODBase
xAODCaloEvent_Calorimeter/CaloEvent_nothasPP (from package xAODCaloEvent) applied [xAODCaloEvent]
NEEDS_CORAL_RELATIONAL_ACCESS (from package CORAL) applied [AtlasCORAL] activated AtlasCORAL
NEEDS_CORAL_BASE (from package CORAL) applied [AthenaPoolUtilities] activated AthenaPoolUtilities
----------> CMTPATH
# Add path /cvmfs/atlas.cern.ch/repo/tools/slc6/cmt from CMTUSERCONTEXT
# Add path /afs/cern.ch/work/b/boveia/tlaflags-20.1.8.4 from initialization
# Add path /cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/AtlasProduction/20.1.8.4 from initialization
# Add path /cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/AtlasOffline/20.1.8 from ProjectPath
# Add path /cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/AtlasAnalysis/20.1.8 from ProjectPath
# Add path /cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/AtlasSimulation/20.1.8 from ProjectPath
# Add path /cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/AtlasTrigger/20.1.8 from ProjectPath
# Add path /cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/AtlasReconstruction/20.1.8 from ProjectPath
# Add path /cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/AtlasEvent/20.1.8 from ProjectPath
# Add path /cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/dqm-common/dqm-common-00-42-00 from ProjectPath
# Add path /cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/AtlasConditions/20.1.8 from ProjectPath
# Add path /cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/AtlasCore/20.1.8 from ProjectPath
# Add path /cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/DetCommon/20.1.8 from ProjectPath
# Add path /cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/tdaq-common/tdaq-common-01-33-00 from ProjectPath
# Add path /cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/GAUDI/v25r3p2-lcg72a from ProjectPath
# Add path /cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/LCGCMT/LCGCMT_72a from ProjectPath
