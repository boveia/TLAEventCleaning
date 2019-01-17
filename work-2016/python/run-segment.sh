#!/bin/bash

LISTOFRUNNUMBERS=./list-run2-runnumbers.txt
EVENTVETOLISTDIR=./data/event-veto-info-run2-4-10
WORKDIR=`pwd`
BATCHDIR=$WORKDIR/batch

SEGMENT=$(expr $1)
BEGINLINE=$(expr $(expr 130 \* ${SEGMENT}) + 1)
ENDLINE=$(expr ${BEGINLINE} + 129)

echo Segment $SEGMENT

ls -1 $BATCHDIR/job_*.sh | sed -n "${BEGINLINE},${ENDLINE}p" > $BATCHDIR/segment_$SEGMENT.sh
