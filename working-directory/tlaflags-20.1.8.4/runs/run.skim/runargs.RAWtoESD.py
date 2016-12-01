# Run arguments file auto-generated on Thu Dec 17 13:37:27 2015 by:
# JobTransform: RAWtoESD
# Version: $Id: trfExe.py 697822 2015-10-01 11:38:06Z graemes $
# Import runArgs class
from PyJobTransforms.trfJobOptions import RunArguments
runArgs = RunArguments()
runArgs.trfSubstepName = 'RAWtoESD' 

runArgs.AMITag = 'f628'
runArgs.conditionsTag = 'CONDBR2-BLKPA-2015-14'
runArgs.preExec = ['DQMonFlags.doCTPMon=False;jobproperties.Beam.bunchSpacing.set_Value_and_Lock(25)']
runArgs.geometryVersion = 'ATLAS-R2-2015-03-01-00'

# Explicitly added to process all events in this step
runArgs.maxEvents = -1

# Input data
runArgs.inputBSFile = ['../r00278912_multiple_events.RAW.data']
runArgs.inputBSFileType = 'BS'
runArgs.inputBSFileNentries = 10

# Output data
runArgs.outputESDFile = 'esd.pool.root'
runArgs.outputESDFileType = 'ESD'

# Extra runargs

# Extra runtime runargs

# Literal runargs snippets
