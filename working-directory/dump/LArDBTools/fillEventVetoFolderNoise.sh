#!/bin/bash
# to do: - change hardcoded tag to a dynamically found from COOL
#        - add more command line options
#        - find the reason of crash of executable at the end (after sqlite is created)

echo "Script to fill the EventVeto folder from noise burst and data corruption tree"

lardbtoolsdir=` echo $0 | grep -o ".*/" `
EvDir="${lardbtoolsdir}/EventVetoToCool"

if [[ $# != 1 ]] && [[ $# != 2 ]] && [[ $# != 3 ]]  && [[ $# != 4 ]] && [[ $# != 5 ]] && [[ $# != 6 ]] && [[ $# != 7 ]]
then
  echo "Expected a run number"
  echo "Optionaly the output file name, flag (0) to switch off noise and flag (0) to switch off processing of express_express stream, foldertag and switch to switchh off corruption"
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
  nflag=$3
else
  nflag=1 
fi

if [[ $# > 3 ]]
then
  esflag=$4
else
  esflag=1 
fi

if [[ $# > 4 ]]
then
  mainflag=$5
  if [[ $mainflag == 0 ]]
  then
     ccflag=1
  else
     ccflag=0
  fi
else
  mainflag=0 
  ccflag=1
fi

if [[ $# > 5 ]]
then
  foldertag=$6
else
  foldertag=`${lardbtoolsdir}/getCurrentFolderTag.sh COOLOFL_LAR/CONDBR2 /LAR/BadChannelsOfl/EventVeto`
  echo "Running for tag $foldertag"
fi

if [[ $# > 6 ]]
then
  corrflag=$7
else
  corrflag=1
fi
echo "Running EventVetoToCool " $run $sqlitename $mnbflag 

if [[ -f $qlitename ]]
then
  echo "file $sqlitename exists, please remove"
  exit
fi

if [[ $corrflag == 1 ]]
then
   # extract a miising feb info
   echo "Trying to extract MF info"
   /bin/rm -rf mf.txt
   (${lardbtoolsdir}/getMissingFEBs.sh $run mf.txt )
   if [[ $? != 0 ]]
   then
      echo "Something went wrong, with MF extraction"
      exit -1
   fi
   ls -l mf.txt
fi

source $EvDir/env_afs.sh

if [[ $corrflag == 1 ]]
then
#  $EvDir/EventVetoToCool -r $run -d "sqlite://;schema=${sqlitename};dbname=CONDBR2" -f /LAR/BadChannelsOfl/EventVeto  -b $foldertag -v 0 -z 1 -w 0.001 -l 0.001 -n $nflag -y 0 -o 1 -s $ccflag -e $esflag --fromMain $mainflag --fromNoiseBurst 0 --missingFEBsFile mf.txt 
  $EvDir/EventVetoToCool -r $run -d "sqlite://;schema=${sqlitename};dbname=CONDBR2" -f /LAR/BadChannelsOfl/EventVeto  -b $foldertag -v 1 -z 1 -w 0.001 -l 0.001 -n $nflag -y 0 -o 1 -s $ccflag -e $esflag --fromMain $mainflag --fromNoiseBurst 0 --missingFEBsFile mf.txt 
else 
#  $EvDir/EventVetoToCool -r $run -d "sqlite://;schema=${sqlitename};dbname=CONDBR2" -f /LAR/BadChannelsOfl/EventVeto  -b $foldertag -v 0 -z 1 -w 0.001 -l 0.001 -n $nflag -y 0 -o 1 -s $ccflag -e $esflag --fromMain $mainflag --fromNoiseBurst 0  
  $EvDir/EventVetoToCool -r $run -d "sqlite://;schema=${sqlitename};dbname=CONDBR2" -f /LAR/BadChannelsOfl/EventVeto  -b $foldertag -v 1 -z 1 -w 0.001 -l 0.001 -n $nflag -y 0 -o 1 -s $ccflag -e $esflag --fromMain $mainflag --fromNoiseBurst 0  
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
