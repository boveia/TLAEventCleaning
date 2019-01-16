#!/bin/bash
# to do: - change hardcoded tag to a dynamically found from COOL
#        - add more command line options

echo "Script to show the EventVeto folder content"

#lardbtoolsdir=` echo $0 | grep -o ".*/" `
# above doesnt work if invoked from another script from elsewhere
lardbtoolsdir='/afs/cern.ch/user/l/larcalib/LArDBTools'
EvDir="${lardbtoolsdir}/python"

if [[ $# != 1 ]] && [[ $# != 2 ]] && [[ $# != 3 ]]
then
  echo "Expected a run number"
  echo "Optionaly the tag and input sqlite file name"
  exit
fi

run=$1
if [[ $# > 1 ]]
then
  ftag=$2
else
  ftag=`${lardbtoolsdir}/getCurrentFolderTag.sh COOLOFL_LAR/CONDBR2 /LAR/BadChannelsOfl/EventVeto`
  echo "Running for tag $ftag"
fi

if [[ $# > 2 ]]
then
  sqlitename=$3
  dbname="sqlite://;schema=${sqlitename};dbname=CONDBR2"
else
  sqlitename=""
  dbname="COOLOFL_LAR/CONDBR2"
fi

echo "Running showEventVeto " $run $dbname $ftag 
echo "lardbtoolsdir: " $lardbtoolsdir

if [[ $sqlitename ]] && [ ! -f $qlitename ]
then
  echo "file $sqlitename doesn't exists"
  exit
fi

# check if some athena version is configured, if not configure
if ! which athena.py 2>/dev/null 
then
    echo "Setting up offline envirnoment from LArDBTools area..."
    export ATLAS_LOCAL_ROOT_BASE=/cvmfs/atlas.cern.ch/repo/ATLASLocalRootBase
    source /cvmfs/atlas.cern.ch/repo/ATLASLocalRootBase/user/atlasLocalSetup.sh
    source $AtlasSetup/scripts/asetup.sh --input  $lardbtoolsdir/asetupConfig
    if ! which athena.py 2>/dev/null 
	then
	echo "Failed to get enviroment"
	exit -1
    fi
fi

$EvDir/showEventVeto.py -r $run -t $ftag -d $dbname 

