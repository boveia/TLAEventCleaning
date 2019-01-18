#!/bin/bash
ls -1 *.txt | awk -F'-' '{print $3}' | awk -F'\.' '{print $1}' | sort -n > runs-done.txt
grep -l 'Traceback' *.txt | awk -F'-' '{print $3}' | awk -F'\.' '{print $1}' | sort -n > runs-crashed.txt
grep -l 'terminate called' *.txt | awk -F'-' '{print $3}' | awk -F'\.' '{print $1}' | sort -n >> runs-crashed.txt
diff ../list-run2-runnumbers.txt runs-done.txt | grep '<' | awk '{print $2}' > runs-missing.txt
cat runs-crashed.txt >> runs-missing.txt
cat runs-missing.txt | sort -n | uniq


