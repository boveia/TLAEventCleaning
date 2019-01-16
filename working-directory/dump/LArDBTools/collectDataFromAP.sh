#!/bin/bash
#Script to gather conditions data from many directories from the automatic processing

if [[ $# != 1 ]];
then
  echo "Expected a text file containing a list of directories as parameter"
  exit
fi

listOfDirFile=$1
shift


if [[ $sqlitedest == "" ]];
then
    sqlitedest=`/bin/pwd`
fi

echo "Destination:$sqlitedest"

#Hack for now: Omit OFC & Shape from the AP

AACEXTRAPARAMS="$AACEXTRAPARAMS -e /LAR/ElecCalibOfl/OFC/PhysWave/RTM -e /LAR/ElecCalibOfl/Shape/RTM"

if [[ $lardbtoolsdir == "" ]];
then
  lardbtoolsdir= `echo $0 | grep -o ".*/" `
  pyDir="${lardbtoolsdir}/python"  
fi

outputsqlite="${sqlitedest}/freshConstants_AP.db"
outputCat="freshConstants.xml"
if [[ $daemonDir == "" ]];
then
    daemonDir="/afs/cern.ch/user/l/larcalib/w0/data/WorkingDirectory/"
fi
copylog="AtlCoolCopy_AP.log"

if [ -f $outputsqlite ];
then
  echo "Output file $outputsqlite exists already. Please remove!"
  exit -1
fi

if [ -f $outputCat ];
then
  echo "Output file $outputCat exists already. Please remove!"
  exit -1
fi

echo "Script to collect data from a list of output directories of the automatic processing"
echo "Will take about 6 minutes for a complete calibration campaign"


if ! /bin/pwd | grep -q "^/afs/"
then
    echo "WARNING: Working directory is not on AFS!"
else
    free=`$pyDir/afsFree.py`
    freeMB=`expr $free / 1000`
    if [[ $free -le 150000 ]];
	then
	echo "WARNING: Only $freeMB MBytes free in run directory"
    else
	echo "Have $freeMB MBytes free space in run directory"
    fi
fi


if [ -f $copylog ];
then
    echo "$copylog exists, removing..."
    rm -f $copylog
fi
touch $copylog



echo "Check availablity of AtlCoolCopy.exe ...." 
if ! which AtlCoolCopy.exe 2>/dev/null 
then
    echo "Setting up offline envirnoment from AP area ..."
    source /afs/cern.ch/atlas/maxidisk/d20/Automation/AtlasProduction-20.1.0.2/env.sh
    if ! which AtlCoolCopy.exe 2>/dev/null 
	then
	echo "Failed to get AtlCoolCopy.exe"
	exit -1
    fi
fi
echo "Done."

echo "Additional AtlCoolCopy parameters: $AACEXTRAPARAMS"

num=0
numDir=0
poolSize=0

outputdb="sqlite://;schema=${outputsqlite};dbname=CONDBR2"

err=0

poolFileList=""
provSql=""

#Extract lines containing 3 number of at least 5 digits each separated by underscores
#for dir in `grep -o "[0-9]\{5,\}_[0-9]\{5,\}_[0-9]\{5,\}" $listOfDirFile`
#Same as above but require trailing characters (non white-space) 
for dir in `grep -o "[0-9]\{5,\}_[0-9]\{5,\}_[0-9]\{5,\}_[^[:space:]]*" $listOfDirFile`
do
  workDir=${daemonDir}/${dir}/poolFiles/
  if [ ! -d $workDir ];
  then
      echo "ERROR Can't find $workDir"
      continue
  fi
  echo -e "\nWorking on directory $dir ..."
  for dbf in `ls -1 ${workDir}myDB*.db`
  do 
    f=`echo ${dbf} | awk -F'/' '{print $NF}'`
    echo "Working on file $f"

    #localdest=$localdir/$f
    #cp $dbf $localdest
    inputdb="sqlite://;schema=${dbf};dbname=CONDBR2"
    num=`expr $num + 1`

    #echo "Copying COOL folders" 
    echo -e "\nCopy COOL folders from ${dbf}" >> $copylog
    (time AtlCoolCopy.exe $inputdb $outputdb -create $AACEXTRAPARAMS) >> $copylog 2>&1
    if [ $? -ne 0 ];  then
	echo "AtlCoolCopy reported an error. Pleaes check $copylog!"
	err=1
    fi
    provSql="$provSql $dir $dbf"
  done #end loop over sqlite files in one directory
  #poolFileList="$poolFileList "`/bin/ls -1 ${daemonDir}/${dir}*/poolFiles/*.pool.root`
  poolFileList="$poolFileList "`/bin/ls -1 ${daemonDir}/${dir}/poolFiles/*.pool.root`

  numDir=`expr $numDir + 1`

done #end loop over directories

#echo "Building provenance record from directory $dir"
#echo "Building provenance record from directory $dir" >> $copylog
#python ${pyDir}/MakeProvenanceDict.py freshConstants.provenance $provSql >> $copylog 2>&1
#if [[ $? != 0 ]];  then
#    echo "MakeProvenanceDict.py reported an error. Please check $copylog!"
#fi


if [[ $num == 0 ]]; then
    echo "No sqlite files found!"
    exit -1
fi

echo "Creating POOL file catalog ..."
echo -e "\nCreating POOL file catalog ..." >> $copylog
echo "${poolFileList}" >> $copylog
(time pool_insertFileToCatalog -u xmlcatalog_file:${outputCat} ${poolFileList}) >> $copylog 2>&1
if [[ $? != 0 ]];  then
    echo "pool_insertFileToCatalog reported an error. Please check $copylog!"
    err=1
fi


#echo -e "Purge duplicate IOVs" 
#echo -e "\nPurge duplicate IOVs"  >>  $copylog
#mv $outputsqlite ${outputsqlite}.tmp
#AtlCoolCopy.exe "sqlite://;schema=${outputsqlite}.tmp;dbname=COMP200" $outputdb -create -r 2147483647 >> $copylog
#if [[ $? != 0 ]];  then
#    echo "AtlCoolCopy reported an error. Pleaes check $copylog!"
#    err=1
#fi
#rm ${outputsqlite}.tmp

if [[ $sqlitedest != "" && $sqlitedest != `/bin/pwd` ]];
    then
    echo "Copy sqlite from $sqlitedest to ."
    cp ${outputsqlite} .
fi

# Summary information
echo "Merged $num sqlite files from $numDir directories"
echo "Total number of input pool files:"
grep -c "/afs/.*.pool.root" ${outputCat}
echo "Total size of input pool files (MBytes):"
ls -l `grep -o "/afs/.*.pool.root" ${outputCat}` | awk '{size = size + $5} END { print size/(1024*1024)}'


if [ $err == 0 ]; then
    echo "No error encountered."
    echo "Output files:" 
    echo "$outputsqlite: Sqlite files containing data for all detector parts"
    echo -e "$outputCat: Catalog files referencing all POOL files\n" 
    echo "Next step: Run prepareFiles.sh to merge POOL files into bigger units and prepare sqlite files for uploading"

else
    echo "At least one error occured. Please check log files!"
fi

