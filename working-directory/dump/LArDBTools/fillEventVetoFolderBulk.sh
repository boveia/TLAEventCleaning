#!/bin/bash
# to do: 
#        - add more command line options
#        - find the reason of crash of executable at the end (after sqlite is created)

echo "Script to fill the EventVeto folder from mini noise burst and data corruption tree"

lardbtoolsdir=` echo $0 | grep -o ".*/" `
EvDir="${lardbtoolsdir}/EventVetoToCool"

if [[ $# < 1 ]] || [[ $# > 5 ]]  
then
  echo "Expected a run number"
  echo "Optionaly the output file name, flag (0) to switch off MNB, flag (0) to switch off Noise, flag (0) to switch off data corruption"
  exit
fi

run=$1
if [[ $# > 1 ]]
then
  sqlitename=$2
else
  sqlitename=EventVeto${run}_Bulk.db 
fi
if [[ $# > 2 ]]
then
  mnbflag=$3
else
  mnbflag=1 
fi

if [[ $# > 3 ]]
then
  nflag=$4
else
  nflag=0 
fi

if [[ $# > 4 ]]
then
  corrflag=$5
else
  corrflag=0
fi


echo "Running EventVetoToCool " $run $sqlitename $mnbflag $nflag $corrflag

if [[ -f $qlitename ]]
then
  echo "file $sqlitename exists, please remove"
  exit
fi

if [[ $corrflag == 1 ]]
then
   # extract a miising feb info
   /bin/rm -rf mf.txt
   ${lardbtoolsdir}/getMissingFEBs.sh $run mf.txt  
fi

source $EvDir/env_afs.sh

if [[ $corrflag == 1 ]]
then
  $EvDir/EventVetoToCool -r $run -d "sqlite://;schema=${sqlitename};dbname=CONDBR2" -f /LAR/BadChannelsOfl/EventVeto  -b LARBadChannelsOflEventVeto-RUN2-Bulk-00 -v 0 -z 1 -w 0.001 -l 0.001 -n $nflag -y $mnbflag -x $corrflag -o 1 --fromMain 1 --fromNoiseBurst 0 -e 0 -s 0 --missingFEBsFile mf.txt --NoiseBurstCandidatebit 11
else
  $EvDir/EventVetoToCool -r $run -d "sqlite://;schema=${sqlitename};dbname=CONDBR2" -f /LAR/BadChannelsOfl/EventVeto  -b LARBadChannelsOflEventVeto-RUN2-Bulk-00 -v 0 -z 1 -w 0.001 -l 0.001 -n $nflag -y $mnbflag -x $corrflag -o 1 --fromMain 1 --fromNoiseBurst 0 -e 0 -s 0 --NoiseBurstCandidatebit 11
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
