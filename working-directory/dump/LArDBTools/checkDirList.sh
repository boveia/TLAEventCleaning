#!/bin/bash

daemonDir="/afs/cern.ch/user/l/larcalib/w0/data/WorkingDirectory/"

if [[ $# != 1 ]];
then
  echo "Expected a text file containing a list of directories as parameter"
  exit
fi

listOfDirFile=$1
shift

dlist=""

for dir in `grep -o "[0-9]\{5,\}_[0-9]\{5,\}_[0-9]\{5,\}\S\{1,\}" $listOfDirFile`
do
  workDir=${daemonDir}/${dir}/poolFiles/
  if [ ! -d $workDir ];
  then
      echo " $dir NOT FOUND"
  else
      echo $dlist | grep -q $dir
      if [ $? -eq 0 ];
	  then
	  echo " $dir DUPLICATE"
      else
	  dlist="$dlist $dir"
	  echo " $dir looks ok"
      fi
  fi
done

