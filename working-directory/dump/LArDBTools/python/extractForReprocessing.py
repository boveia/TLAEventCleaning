#import commands
from string import *

inputdb="COOLONL_LAR/COMP200"
outputdb="sqlite://;schema=reproc.db;dbname=COMP200"

takeRun=100000
newFromRun=88261
newToRun=92328

inputSuffix="-UPD3-00"
outputSuffix="-REPC-00" 

#TopLvlTag="COMCOND-ES1C-000-00"

listOfFolders=(
    "/LAR/ElecCalibOfl/Pedestals/Pedestal", 
    "/LAR/ElecCalibOfl/Ramps/RampLinea", # LARElecCalibRampsRampLinea-UPD1-00 LARElecCalibRampsRampLinea-UPD3-00
    "/LAR/ElecCalibOfl/MphysOverMcal/RTM",
    "/LAR/ElecCalibOfl/OFC/PhysWave/RTM/5samples3bins17phases",
    "/LAR/ElecCalibOfl/Shape/RTM/5samples3bins17phases",
    #"/LAR/ElecCalibOfl/HVScaleCorr"
    )


raus=open("extractFromDB.sh","w")


for folder in listOfFolders:

    if "TopLvlTag" in dir():
        inTag=TopLvlTag
    else:
        inTag=join(split(folder, '/'),'') + inputSuffix

    outTag=join(split(folder, '/'),'') + outputSuffix

    cmd="AtlCoolCopy.exe \"%s\" \"%s\" -f %s -t %s -ot %s -r %i -nrls %i 0 -nrlu %i 4294967295 -a -create" %\
         (inputdb, outputdb,folder,inTag,outTag,takeRun,newFromRun,newToRun)

    print cmd
    raus.write(cmd+"\n")

raus.close()
    
