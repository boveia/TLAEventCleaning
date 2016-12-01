#!/bin/bash

echo "Script to prepare LAr Electronic Calibration Database upload"
echo "The process consists of three steps:" 
echo "1. Step: Collect the sqlite and POOL files produced by the  Automatic Processing"
echo "2. Step: Merge POOL files into bigger unit and prepare sqlite files for uploading"
echo -e "3. Step: Create driver scripts to upload POOL files to the ConditionsDDM\n"

lardbtoolsdir=` echo $0 | grep -o ".*/" `

#lardbtoolsdir="/home/wlampl/LArDBToolsDev/"


pyDir="${lardbtoolsdir}/python"
if [[ $# != 1 ]];
then
  echo "Expected a text file containing a list of directories as parameter"
  exit
fi

listOfDirFile=$1
shift


echo "Check availablity of AtlCoolCopy.exe ...." 
if ! which AtlCoolCopy.exe 2>/dev/null 
then
    echo "Setting up offline envirnoment from AP area..."
    source /afs/cern.ch/atlas/maxidisk/d20/Automation/AtlasProduction-20.1.0.2/env.sh
    if ! which AtlCoolCopy.exe 2>/dev/null 
	then
	echo "Failed to get AtlCoolCopy.exe"
	exit -1
    fi
fi
echo "Done."

#echo $CMTPATH

#Ask user which version of OFCs and Shapes should be used:

if [ -f OFCShapeFolderTag.py ];
then 
    echo "Using existing OFCShapeFolderTag.py file:"
    cat OFCShapeFolderTag.py 
    sleep 2
else
    python $pyDir/ChooseOFCShapeFlavor.py
    if [ $? -ne 0 ];  then
	exit -1;
    fi
fi


if [[ $sqlitedest == "" ]];
then
    echo "No local directory for temporary sqlite files defined."
    loctempdir=`mktemp -d`
    if [[ $? != 0 ]];  then
	echo "Failed to created temporary directory!"
	exit -1
    fi
    sqlitedest="${loctempdir}/"
    echo "Will use $sqlitedest"
fi


echo -e "\nNow at step 1: Collect the sqlite and POOL files produced by the  Automatic Processing\n"
source $lardbtoolsdir/collectDataFromAP.sh $listOfDirFile
if [ $? -ne 0 ];  then
    echo "collectDataFromAP.sh failed."
    exit -1
else
    echo "collectDataFromAP.sh successful" 
fi


echo -e "\nNow at step 2: Merge POOL files into bigger units and prepare sqlite files for uploading\n"
source $lardbtoolsdir/prepareFiles.sh
if [ $? -ne 0 ];  then
    echo "prepareFiles.sh failed."
    exit -1
else
    echo "prepareFiles.sh successful"
fi


echo -e "\nNow at step 3: Create driver scripts to upload POOL files to the ConditionsDDM\n"
python $lardbtoolsdir/python/makeRegScript.py condR2_data.lar.COND $outputCat $outputsqliteOFL
if [ $? -ne 0 ];  then
    echo "makeRegScript.py failed."
    exit -1
else
    echo "makeRegScript.py successful"
fi
