from IOVDbSvc.CondDB import conddb
conddb.addFolder('LAR_OFL',"/LAR/BadChannelsOfl")

from AthenaCommon.GlobalFlags import globalflags
globalflags.DataSource = 'data'  # or set this to 'geant4' if running on MC! ...
globalflags.DatabaseInstance = 'CONDBR2' # e.g. if you want run 2 data, set to COMP200 if you want run1. This is completely ignored in MC.

conddb.setGlobalTag("CONDBR2-BLKPA-2015-14")


svcMgr.EventSelector.RunNumber=281385 #set to the run you want
#svcMgr.EventSelector.InitialTimeStamp=4566 #set to the UTC timestamp you want COOL info for!


# AtlCoolConsole.py  "COOLOFL_LAR/CONDBR2"
# cd blah
# more EventVeto
# listtags EventVeto
# > Listing tags for folder /LAR/BadChannelsOfl/EventVeto
# > LARBadChannelsOflEventVeto-RUN2-UPD1-00 (locked) []
# > LARBadChannelsOflEventVeto-RUN2-UPD4-04 (locked) []
# > LARBadChannelsOflEventVeto-RUN2-empty (locked) []

>>> usetag LARBadChannelsOflEventVeto-RUN2-UPD4-04

>>> userunlumi 281385
>>> more EventVeto
>>> userunlumi 281385 5 281385 5

