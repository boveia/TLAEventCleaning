#!/bin/bash
# script to find the current and next folder level tag
# it needs to check the athena env., if not present create, and then use the getCurrentFolderTag.py from LArConditionsCommon

if [[ $# != 2 ]]
then
   echo "Syntax is $0 dbinstance folder"
   exit
fi
 
if ! which athena.py 2>/dev/null 
then
    #echo "Setting up offline envirnoment from AP area..."
    source /afs/cern.ch/atlas/maxidisk/d20/Automation/AtlasOffline-21.0.20/env.sh 2>&1 >/dev/null
    if ! which athena.py 2>&1 >/dev/null
        then
        echo "Failed to get athena.py"
        exit -1
    fi

fi 2>&1 >/dev/null

getCurrentFolderTag.py $1 $2 2>&1 | grep -v "Warning in" | grep -v currentGlobal | grep -v "Data source lookup"
