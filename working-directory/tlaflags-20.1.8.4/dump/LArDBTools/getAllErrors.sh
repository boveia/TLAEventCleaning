#!/bin/bash
#Script to gather conditions data from many directories from the automatic processing

if [[ $# != 1 ]];
then
  echo "Expected a text file containing a list of directories as parameter"
  exit
fi

listOfDirFile=$1
shift

if [[ $daemonDir == "" ]];
then
    daemonDir="/afs/cern.ch/user/l/larcalib/w0/data/WorkingDirectory/"
fi

#Same as above but require trailing characters (non white-space) 
for dir in `grep -o "[0-9]\{5,\}_[0-9]\{5,\}_[0-9]\{5,\}_[^[:space:]]*" $listOfDirFile`
do
  echo ""
  echo "Directory: $dir"
  workDir=${daemonDir}/${dir}/jobOptions/
  grep " ERROR " $workDir/*.log
done
