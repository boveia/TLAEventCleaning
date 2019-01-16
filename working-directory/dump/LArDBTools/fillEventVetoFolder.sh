#!/bin/bash
# to do: 
#        - add more command line options
#        - find the reason of crash of executable at the end (after sqlite is created)

echo "Script to fill the EventVeto folder from mini noise burst and noise tree"
echo "Not checking data corruption"

lardbtoolsdir=` echo $0 | grep -o ".*/" `
EvDir="${lardbtoolsdir}/EventVetoToCool"

if [[ $# != 1 ]] && [[ $# != 2 ]] && [[ $# != 3 ]]  && [[ $# != 4 ]] && [[ $# != 5 ]] && [[ $# != 6 ]] && [[ $# != 7 ]]
then
  echo "Expected a run number"
  echo "Optionaly the output file name, flag (0) to switch off MNB, flag (0) to switch off processing of express_express stream and flag (0) to switch off processing of LarNoiseBurst and flag (0) to switch off data corruption and flag (0) to switch off noise"
  exit
fi

run=$1
if [[ $# > 1 ]]
then
  sqlitename=$2
else
  sqlitename=EventVeto${run}.db 
fi
if [[ $# > 2 ]]
then
  mnbflag=$3
else
  mnbflag=1 
fi

if [[ $# > 3 ]]
then
  esflag=$4
else
  esflag=1 
fi

if [[ $# > 4 ]]
then
  nbflag=$5
else
  nbflag=1 
fi

if [[ $# > 5 ]]
then
  corrflag=$6
else
  corrflag=1 
fi

if [[ $# > 6 ]]
then
  noiseflag=$7
else
  noiseflag=1 
fi

echo "Running EventVetoToCool " $run $sqlitename $mnbflag $esflag $nbflag $corrflag $noiseflag

if [[ -f $qlitename ]]
then
  echo "file $sqlitename exists, please remove"
  exit
fi

currtag=`${lardbtoolsdir}/getCurrentFolderTag.sh COOLOFL_LAR/CONDBR2 /LAR/BadChannelsOfl/EventVeto`
echo "Running for tag $currtag"

if [[ $corrflag == 1 ]]
then
   # extract a miising feb info
   /bin/rm -rf mf.txt
   ${lardbtoolsdir}/getMissingFEBs.sh $run mf.txt  
fi

source $EvDir/env_afs.sh

if [[ $corrflag == 1 ]]
then
  $EvDir/EventVetoToCool -r $run -d "sqlite://;schema=${sqlitename};dbname=CONDBR2" -f /LAR/BadChannelsOfl/EventVeto  -b $currtag -v 1 -z 1 -w 0.001 -l 0.001 -n $nbflag -x $corrflag -y $mnbflag -o 1  -e $esflag --fromNoiseBurst $noiseflag --missingFEBsFile mf.txt --NoiseBurstCandidatebit 11
else
  $EvDir/EventVetoToCool -r $run -d "sqlite://;schema=${sqlitename};dbname=CONDBR2" -f /LAR/BadChannelsOfl/EventVeto  -b $currtag -v 1 -z 1 -w 0.001 -l 0.001 -n $nbflag -x $corrflag -y $mnbflag -o 1 -e $esflag --fromNoiseBurst $noiseflag --NoiseBurstCandidatebit 11
fi

if [[ $? != 0 ]]
then
  echo "Something went wrong, please check output"
  exit -1
else
  if [[ -f $qlitename ]]
  then
     echo "${sqlitename} was created, check it with showEventVeto.sh and if everything fine, upload with:"
     echo "/afs/cern.ch/user/a/atlcond/utils/AtlCoolMerge.py $sqlitename CONDBR2 ATLAS_COOLWRITE ATLAS_COOLOFL_LAR_W <password>"
  exit 0
  fi
fi
