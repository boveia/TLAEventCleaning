#!/bin/bash

echo "jobs to rerun: "
ls -1 *.txt | awk -F'-' '{print $3 "_" $5}' | awk -F'\.' '{print $1}' | sort -n > runseg-done.txt
grep -l 'Traceback' *.txt | awk -F'-' '{print $3}' | awk -F'\.' '{print $1}' | sort -n > runs-crashed.txt
grep -l 'terminate called' *.txt | awk -F'-' '{print $3}' | awk -F'\.' '{print $1}' | sort -n >> runs-crashed.txt
grep -L 'Lumi loss due t' *.txt | awk -F'-' '{print $3 "_" $5}' | awk -F'\.' '{print $1}' | sort -n >> runs-crashed.txt
diff ../list-run2-runseg-C.txt runseg-done.txt | grep '<' | awk '{print $2}' > runs-missing.txt
cat runs-crashed.txt >> runs-missing.txt
#cat runs-missing.txt | sort -n | uniq
cat runs-missing.txt | sort -n | uniq | awk -F'_' '{print "/afs/cern.ch/user/b/boveia/work/run2-tla/work-2016/python/batch-C/job_" $1 "_" $2 ".sh"}'

