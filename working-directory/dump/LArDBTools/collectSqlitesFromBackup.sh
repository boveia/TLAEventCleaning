#!/bin/bash
#Script to gather sqlite files from the backup area of the automatic processing and build 
#provenance dictionary. Primary purpose: Retroactivly register AMI metadata

if [[ $# != 1 ]];
then
  echo "Expected a text file containing a list of directories as parameter"
  exit
fi

listOfDirFile=$1
shift

backupdir="/castor/cern.ch/grid/atlas/caf/atlcal/perm/lar/ElecCalib/Auto"
pyDir="/afs/cern.ch/user/l/larcalib/LArDBTools/python"

export STAGE_SVCCLASS=atlcal

provSql=""

#Extract lines containing 3 number of at least 5 digits each separated by underscores
#for dir in `grep -o "[0-9]\{5,\}_[0-9]\{5,\}_[0-9]\{5,\}" $listOfDirFile`
#Same as above but require trailing characters (non white-space) 
for dir in `grep -o "[0-9]\{5,\}_[0-9]\{5,\}_[0-9]\{5,\}_[^[:space:]]*" $listOfDirFile`
do
  workDir=${backupdir}/${dir}/poolFiles
  if [ ! -d $dir ];
      then
      mkdir $dir
  fi
  for dbf in `nsls ${workDir}/ | grep "myDB.*db"`
  do 
    destination=$dir/$dbf
    if [ ! -e $destination ];
	then
	echo rfcp $workDir/$dbf $dir/$dbf
	rfcp $workDir/$dbf $dir/$dbf
    fi
    provSql="$provSql $dir ${dir}/$dbf"
  done
done
echo "Building provenance record..."
python ${pyDir}/MakeProvenanceDict.py freshConstants.provenance $provSql 

