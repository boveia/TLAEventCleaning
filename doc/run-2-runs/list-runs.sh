#!/bin/bash

cat *.txt | sed 's/^data1[5678]_[0-9]*TeV\.\([0-9]*\)\..*/\1/g' | sort -n | uniq > runs.txt
