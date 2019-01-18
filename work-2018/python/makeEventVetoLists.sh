#!/bin/bash

LISTOFRUNNUMBERS=./list-run2-runnumbers.txt
EVENTVETOLISTDIR=./data/event-veto-info-run2-4-10
WORKDIR=`pwd`
BATCHDIR=$WORKDIR/batch

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
    BATCHNAME="${BATCHDIR}/job_${runno}.sh"
    echo "#!/bin/bash" > $BATCHNAME
    echo "cd $WORKDIR" >> $BATCHNAME
    # echo "export AtlasSetup=/afs/cern.ch/atlas/software/dist/AtlasSetup" >> $BATCHNAME
    # echo "alias asetup='source $AtlasSetup/scripts/asetup.sh'" >> $BATCHNAME
    echo "source /afs/cern.ch/atlas/software/dist/AtlasSetup/scripts/asetup.sh 21.0.20" >> $BATCHNAME
    echo "python showEventVeto-2018.py -r $runno -e $runno >& ${EVENTVETOLISTDIR}/event-veto-$runno.txt" >> $BATCHNAME
    chmod u+x $BATCHNAME
    echo $BATCHNAME
    #bsub -q 1nh $BATCHNAME
done
