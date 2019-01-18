#!/bin/bash

LISTOFRUNNUMBERS=./list-run2-runnumbers-C.txt
EVENTVETOLISTDIR=./data/event-veto-info-run2-4-10-C
WORKDIR=`pwd`
BATCHDIR=$WORKDIR/batch-C

################################################################

# set up some version of Athena
if [ "$SITEROOT" == "" ]; then
    # exact version doesn't matter?
    source /afs/cern.ch/atlas/software/dist/AtlasSetup/scripts/asetup.sh 21.0.20
fi

# make the batch directory
mkdir -p ${BATCHDIR}

# make the output directory
mkdir -p ${EVENTVETOLISTDIR}

# look over the list of run numbers and do showEventVeto for each run
for runno in `cat ${LISTOFRUNNUMBERS}`
do
    for ijob in `echo 0 1 2 3 4 5 6 7 8 9`
    do
        BATCHNAME="${BATCHDIR}/job_${runno}_${ijob}.sh"
        echo "#!/bin/bash" > $BATCHNAME
        echo "cd $WORKDIR" >> $BATCHNAME
        # echo "export AtlasSetup=/afs/cern.ch/atlas/software/dist/AtlasSetup" >> $BATCHNAME
        # echo "alias asetup='source $AtlasSetup/scripts/asetup.sh'" >> $BATCHNAME
        echo "source /afs/cern.ch/atlas/software/dist/AtlasSetup/scripts/asetup.sh 21.0.20" >> $BATCHNAME
        echo "python showEventVeto-2018-split.py -r $runno -e $runno -i $ijob -n 10 >& ${EVENTVETOLISTDIR}/event-veto-$runno-split-$ijob.txt" >> $BATCHNAME
        chmod u+x $BATCHNAME
        echo $BATCHNAME
    done
    #bsub -q 1nh $BATCHNAME
done
