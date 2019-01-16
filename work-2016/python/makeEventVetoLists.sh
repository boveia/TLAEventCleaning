#!/bin/bash

LISTOFRUNNUMBERS=./list-run2-runnumbers.txt
EVENTVETOLISTDIR=./data/event-veto-info

################################################################

# set up some version of Athena
if [ "$SITEROOT" == "" ]; then
    # exact version doesn't matter?
    source /afs/cern.ch/atlas/software/dist/AtlasSetup/scripts/asetup.sh 21.0.20
fi

# make the output directory
mkdir -p ${EVENTVETOLISTDIR}
# look over the list of run numbers and do showEventVeto for each run
for runno in `cat ${LISTOFRUNNUMBERS}`
do
python showEventVeto-2018.py -r $runno -e $runno >& ${EVENTVETOLISTDIR}/event-veto-$runno.txt
done
