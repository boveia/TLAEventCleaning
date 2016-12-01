# Run arguments file auto-generated on Fri Dec 18 13:51:51 2015 by:
# JobTransform: RAWtoESD
# Version: $Id: trfExe.py 697822 2015-10-01 11:38:06Z graemes $
# Import runArgs class
from PyJobTransforms.trfJobOptions import RunArguments
runArgs = RunArguments()
runArgs.trfSubstepName = 'RAWtoESD' 

runArgs.conditionsTag = 'CONDBR2-BLKPA-2015-14'
runArgs.autoConfiguration = ['everything']
runArgs.maxEvents = 10
runArgs.preExec = ['DQMonFlags.doCTPMon=False;jobproperties.Beam.bunchSpacing.set_Value_and_Lock(25)']
runArgs.geometryVersion = 'ATLAS-R2-2015-03-01-00'

# Input data
runArgs.inputBSFile = ['../data15_13TeV.00281385.calibration_DataScouting_05_Jets.merge.RAW.o10._lb0005._0001.1']
runArgs.inputBSFileType = 'BS'
runArgs.inputBSFileNentries = 11363

# Output data
runArgs.outputESDFile = 'esd.pool.root'
runArgs.outputESDFileType = 'ESD'

# Extra runargs

# Extra runtime runargs

# Literal runargs snippets
