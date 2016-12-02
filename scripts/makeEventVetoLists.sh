#!/bin/bash

LISTOFRUNNUMBERS=./list-2016-runnumbers.txt
EVENTVETOLISTDIR=./data/event-veto-info

################################################################

# set up some version of Athena
if [ "$SITEROOT" == "" ]; then
    # exact version doesn't matter
    source /afs/cern.ch/atlas/software/dist/AtlasSetup/scripts/asetup.sh 20.7.5.2
fi

export PYTHONPATH=.:${PYTHONPATH}

# make the output directory
mkdir -p ${EVENTVETOLISTDIR}
# look over the list of run numbers and do showEventVeto for each run
for runno in `cat ${LISTOFRUNNUMBERS}`
do
python showEventVeto.py -r $runno -e $runno >& ${EVENTVETOLISTDIR}/event-veto-$runno.txt
done
