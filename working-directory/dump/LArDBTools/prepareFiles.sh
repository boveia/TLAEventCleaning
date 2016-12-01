#!/bin/bash

#Script to process merged sqlite and catalog from Automatic Processing

#Sqlite files in use:

#freshConstants_AP.db -> Collected output from the automatic processing

echo "Post-processing script to prepare LAr Electronic calibration upload"
echo "POOL-file merging, OFC/Shape computation, Conversion to COOL-inline for online DB" 

if [[ $sqlitedest == "" ]];
then
    sqlitedest=`/bin/pwd`
fi

if [[ $GlobalTag == "" ]];
then
    GlobalTag="LARCALIB-RUN2-00"
fi

echo "Destination:$sqlitedest"

if [[ $lardbtoolsdir == "" ]];
then
  lardbtoolsdir= `echo $0 | grep -o ".*/" `
  pyDir="${lardbtoolsdir}/python"  
fi

inputsqlite="${sqlitedest}/freshConstants_AP.db"
mergesqlite="${sqlitedest}/freshConstants_merging.db"
outputsqliteOFL="${sqlitedest}/freshConstants_ofl.db"
outputsqliteONL="${sqlitedest}/freshConstants_onl.db"


outputCat="freshConstants.xml"
copylog="AtlCoolCopy_merge.log"


if [ ! -f $inputsqlite ];
then
  echo "Did not find input sqlite file $inputsqlite"
  exit
fi


if [ ! -f $outputCat ];
then
  echo "Did not find catalog file $outputCat"
  exit
fi



if [ -f $outputsqliteONL ];
then
  echo "Output file $outputsqliteONL exists already. Please remove!"
  exit
fi


if [ -f $outputsqliteOFL ];
then
  echo "Output file $outputsqliteOFL exists already. Please remove!"
  exit
fi

if [ -f $mergesqlite ];
then
  echo "Output file  $mergesqlite exists already. Please remove!"
  exit
fi


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
echo "Check availablity of AtlCoolCopy.exe ...." 
if ! which AtlCoolCopy.exe 2>/dev/null 
then
    echo "Setting up offline envirnoment from AP area ..."
    /afs/cern.ch/atlas/maxidisk/d20/Automation/AtlasProduction-20.1.0.2/env.sh
    if ! which AtlCoolCopy.exe 2>/dev/null 
	then
	echo "Failed to get AtlCoolCopy.exe"
	exit -1
    fi
fi
echo "Done."


outputdbofl="sqlite://;schema=${outputsqliteOFL};dbname=CONDBR2"
outputdbonl="sqlite://;schema=${outputsqliteONL};dbname=CONDBR2"
mergedb="sqlite://;schema=${mergesqlite};dbname=CONDBR2"
err=0



echo "Running athena to merge POOL files (AutoCorr,DetCellParam, CaliPulseParams)"
echo -e "Running athena to merge POOL files (AutoCorr,DetCellParam, CaliPulseParams)" >> $copylog

#Internally the inputsqlite gets copied to mergesqlite
cat > merge.py << EOF
sqliteIn="${inputsqlite}"
sqliteOut="${mergesqlite}"
poolcat="$outputCat"
dbname="CONDBR2"
mergeFolders=["/LAR/ElecCalibOfl/AutoCorrs/AutoCorr",
              "/LAR/ElecCalibOfl/AutoCorrs/PhysicsAutoCorr",
              "/LAR/ElecCalibOfl/CaliPulseParams/RTM",
              "/LAR/ElecCalibOfl/DetCellParams/RTM",
              "/LAR/ElecCalibOfl/OFCBin/PhysWaveShifts"
              ]
fileName="LArConditionsCalib"

include("LArCalibProcessing/LArCalib_Merge.py")
EOF

athena.py merge.py > merge.log 2>&1
if [ $? -ne 0 ]; 
then
    echo "Athena reported an error. Please check merge.log!"
    echo "Aborting now."
    exit -1
elif grep -q ERROR merge.log 
then
    echo "ERROR occured during mering of POOL files. Please check merge.log!"
    echo "Aborting now."
    exit -1
else
    echo "First merging jobs finished."
fi

echo "Building a tag-hierarchy in  ${mergesqlite}, linking to $GlobalTag"
echo -e "Building a tag-hierarchy in  ${mergesqlite}, linking to $GlobalTag" >> $copylog
 
$pyDir/BuildTagHierarchy.py ${mergesqlite} $GlobalTag >> $copylog
# hack for new OFCBin:
$pyDir/BuildTagHierarchy.py bindiff_run2.db $GlobalTag >> $copylog
pool_insertFileToCatalog.py AdjustedOFCBin.pool.root --catalog="xmlcatalog_file:$outputCat"

echo "Creating temporary sqlite including the FCAL PhsyWave"
echo -e "Creating temporary sqlite including the FCAL PhsyWave" >> $copylog

cp $mergesqlite  ${mergesqlite}.tmp
#FIXME: Auto-detect the destination folder name
AtlCoolCopy.exe "COOLOFL_LAR/CONDBR2" "sqlite://;schema=${mergesqlite}.tmp;dbname=CONDBR2" -f /LAR/ElecCalibOfl/PhysWaves/FCALFromTB -t LARElecCalibOflPhysWavesFCALFromTB-calib-01 -of /LAR/ElecCalibOfl/PhysWaves/RTM -ot LARElecCalibOflPhysWavesRTM-RUN2-UPD3-00 -nochannel


echo "Running athena to compute OFCs and Shapes and apply residual shape correction" 
echo -e "Running athena to compute OFCs and Shapes and apply residual shape correction"  >> $copylog


cat > computeOFCShape.py <<EOF
 
InputAutoCorrSQLiteFile="${mergesqlite}.tmp"
InputAutoCorrPhysSQLiteFile="${mergesqlite}.tmp"
InputPhysWaveSQLiteFile="${mergesqlite}.tmp"

# hack for new OFCBin
InputDBConnectionPhysWaveShift="sqlite://;schema=bindiff_run2.db;dbname=CONDBR2"

OutputSQLiteFile="${mergesqlite}"
poolcat="$outputCat"

RunThreaded=False

include("LArCalibProcessing/LArCalib_OFC_Phys_Run2.py")
EOF

athena.py -s computeOFCShape.py > computeOFCShape.log 2>&1
if [ $? -ne 0 ]; 
then
    echo "Athena reported an error. Please check computeOFCShape.log!"
    echo "Aborting now."
    exit -1
#elif grep -q ERROR computeOFCShape.log 
#then
#    echo "ERROR occured during the OFC computation. Please check computeOFCShape.log!"
#    echo "Aborting now."
#    exit -1
else
    echo "OFC & Shape computation job finished"
fi

echo "Fix possibly wrong StoreGate keys in the folder description" 
echo -e "Fix possibly wrong StoreGate keys in the folder description" >> $copylog
$pyDir/fixSGKey.py ${mergesqlite} >> $copylog

echo $pyDir

echo -e "\nConvert to COOL-inline" 
echo -e "\nConvert to COOL-inline" >> $copylog

if [ ! -f OFCShapeFolderTag.py ];
then
    python $pyDir/../ChooseOFCShapeFlavor.py
fi

if [ ! -f OFCShapeFolderTag.py ];
then
    echo "ERROR, failed to get OFC and Shape flavor to be copied to the online database"
    echo -e "ERROR, failed to get OFC and Shape flavor to be copied to the online database" >> $copylog
fi

cat > ConvertToInline.py <<EOF
sqliteIn="${mergesqlite}"
sqliteOut="${outputsqliteONL}"
poolcat="$outputCat"
dbname="CONDBR2"
globalTag="LARCALIB-RUN2-00"
include("OFCShapeFolderTag.py")

inputFolders+=[("/LAR/ElecCalibOfl/Pedestals/Pedestal",""),
              ("/LAR/ElecCalibOfl/Ramps/RampLinea",""),
              ("/LAR/ElecCalibOfl/MphysOverMcal/RTM",""),
              #("/LAR/ElecCalibOfl/OFC/PhysWave/RTM/5samples1phase","LARElecCalibOflOFCPhysWaveRTM5samples1phase-RUN2-UPD3-00"),
              #("/LAR/ElecCalibOfl/Shape/RTM/5samples1phase","LARElecCalibOflShapeRTM5samples1phase-corr-RUN2-UPD3-00"),
             ]
include ("LArCalibProcessing/LArCalib_ToCoolInline.py")
EOF

athena.py ConvertToInline.py  > convertToInline.log 2>&1
if [ $? -ne 0 ]; 
then
    echo "Athena reported an error. Please check convertToInline.log!"
    echo "Aborting now."
    exit -1
elif grep -q ERROR convertToInline.log 
then
    # fix for unstable HEC channel in ramp
    if [[ `cat convertToInline.log | grep ERROR | grep "No valid Ramp found"`  =~ "gain 0" ]]
    then
     echo "Conversion to COOL inline finished"
    else
     echo "ERROR occured during conversion to COOL inline. Please check convertToInline.log!"
     echo "Aborting now."
     exit -1
    fi
else
    echo "Conversion to COOL inline finished"
fi

omitfolders="-e /LAR/ElecCalibOfl/Pedestals/Pedestal -e /LAR/ElecCalibOfl/Ramps/RampLinea -e /LAR/ElecCalibOfl/MphysOverMcal/RTM" 

echo -e "\nCreate sqlite file for offline database, omitting Pedestal, Ramp and MphysOverMcal"
echo -e "\nCreate sqlite file for offline database, omitting Pedestal, Ramp and MphysOverMcal" >> $copylog
echo AtlCoolCopy.exe $mergedb $outputdbofl -c $omitfolders >> $copylog
AtlCoolCopy.exe $mergedb $outputdbofl -c $omitfolders >> $copylog


#Set up tag relation in UPD3 sqlite file (for ease of access later on)
echo "Set up tag relation in  ${outputsqliteOFL3} (for ease of access later on)"
echo -e "\nSet up tag relation in  ${outputsqliteOFL3} (for ease of access later on)" >> $copylog
$pyDir/BuildTagHierarchy.py ${outputsqliteOFL} $GlobalTag >> $copylog


#exit 0

echo -e "\Set single-version folders to be UPD1"
echo -e "\nSet single-version folders to be UPD1" >> $copylog
# setting folders in singe-version file to upate mode 1
echo "Setting folders in $outputsqliteONL to update-mode 1"
${pyDir}/setOnlineMode.py $outputsqliteONL


dbNameforjobO=`echo ${outputsqliteONL} | awk -F'/' '{print $NF}'`

cat > CalibToNtuple.py << EOF
InputDB="sqlite://;schema=${dbNameforjobO};dbname=CONDBR2"
Objects=['PEDESTAL','RAMP','OFC','MPHYSOVERMCAL','SHAPE']
#OFCFolder='5samples1phase'
PoolCat='$outputCat'
RootFile='freshConstants.root'
DBTag="${GlobalTag}"
include("LArCalibTools/LArCommConditions2Ntuple.py")
svcMgr.IOVDbSvc.DBInstance=""
EOF

if [[ $sqlitedest != "" && $sqlitedest != `/bin/pwd` ]];
    then
    echo "Copy sqlite from $sqlitedest to ."
    cp ${outputsqliteOFL} .
    cp ${outputsqliteONL} .
    #cp ${outputsqliteOFL1} .
    #cp ${outputsqliteCompl} .
    #cp ${outputsqliteINL} .

    inputsqliteLocal=`echo ${inputsqlite}| awk -F'/' '{print $NF}'`
    mv ${inputsqlite} ${inputsqliteLocal}.done
fi

echo "Output files: "
echo "${outputsqliteONL}: All folders & tags needed at P1 and by Tier0 (merge with COOLONL_LAR/CONDBR2)"
echo "${outputsqliteOFL}: All folders & tags not used by default reconstruction (merge with COOLOFL_LAR/CONDBR2)"

#echo "${outputsqliteOFL1}: All folders & tags needed by the Tier0 (merge with COOLOFL_LAR/CONDBR2)"

echo "Next step: Run" 
echo "$pyDir/makeRegScript.py <dataset> $outputCat <sqlitefile>"
echo "Dataset is cond11_data.lar.COND or its successor"

if [ $err == 0 ]; then
    echo "No error encountered."
else
    echo "At least one error occured. Please check log files!"
    exit -1
fi
    
