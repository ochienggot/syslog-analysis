#!/bin/bash

# The first command-line argument is the input file otherwise a default filename 'syslog.txt' is used
if [ $# -eq 0 ]
then
    #echo "No args given"
    INPUT_FILE="syslog.txt"
else
    INPUT_FILE=$1
fi

awk -f script1.awk $INPUT_FILE | awk -f script2.awk | awk -f script3.awk
