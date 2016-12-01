#!/bin/bash
setupATLAS
#asetup 20.1.7.2,here
asetup 20.1.8.4,here

# cmt co -r LArCellRec-02-12-94-03 LArCalorimeter/LArCellRec
# cmt co -r TileRecUtils-00-09-47 TileCalorimeter/TileRecUtils

# svn+ssh://svn.cern.ch/reps/atlasoff
# r556334

# svn-modules
# git svn clone --stdlayout -r556334:HEAD svn+ssh://svn.cern.ch/reps/atlasoff/LArCalorimeter/LArCellRec
# git svn clone --stdlayout -r556334:HEAD svn+ssh://svn.cern.ch/reps/atlasoff/TileCalorimeter/TileRecUtils
