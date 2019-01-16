#!/bin/bash
# script to find the current and next folder level tag
# it needs to check the athena env., if not present create

if [[ $# != 1 ]]
then
   echo "Syntax is $0 run"
   exit
fi
 
lardbtoolsdir='/afs/cern.ch/user/l/larcalib/LArDBTools'
EvDir="${lardbtoolsdir}/python"

if ! which athena.py 2>/dev/null 
then
    #echo "Setting up offline envirnoment from AP area..."
    export ATLAS_LOCAL_ROOT_BASE=/cvmfs/atlas.cern.ch/repo/ATLASLocalRootBase
    source /cvmfs/atlas.cern.ch/repo/ATLASLocalRootBase/user/atlasLocalSetup.sh
    source $AtlasSetup/scripts/asetup.sh --input  $lardbtoolsdir/asetupConfig
    
    if ! which athena.py 2>&1 >/dev/null
        then
        echo "Failed to get athena.py"
        exit -1
    fi

fi 2>&1 >/dev/null

$EvDir/getReadyForPhysics.py $1 2>&1 | grep -v "Warning in"
