#!/bin/bash

for run in `cat list-2015-runnumbers.txt`
do
    python lumiInspector.py -r $run > ./bciddata/${run}.txt
done
