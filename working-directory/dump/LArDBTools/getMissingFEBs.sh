#!/bin/bash
#Script to run the missing feb extractiong
lardbtoolsdir='/afs/cern.ch/user/l/larcalib/LArDBTools'

if [[ $# != 2 ]];
then
  echo "Expected a run number nad output file name"
  exit
fi

run=$1
ofile=$2

#check if athena env. is set
if ! which athena.py 2>/dev/null 
then
    echo "Setting up offline envirnoment from LArDBTools area..."
    export ATLAS_LOCAL_ROOT_BASE=/cvmfs/atlas.cern.ch/repo/ATLASLocalRootBase
    source /cvmfs/atlas.cern.ch/repo/ATLASLocalRootBase/user/atlasLocalSetup.sh
    source $AtlasSetup/scripts/asetup.sh --input  $lardbtoolsdir/asetupConfig
    source $GroupArea/../build/x86_64-slc6-gcc62-opt/setup.sh
    if ! which athena.py 2>/dev/null 
	then
	echo "Failed to get enviroment"
	exit -1
    fi
    #unset FRONTIER_SERVER
fi
$lardbtoolsdir/python/getMissingFebsForRun.py $run $ofile
