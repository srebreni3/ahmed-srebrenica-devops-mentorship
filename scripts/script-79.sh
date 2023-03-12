#!/bin/bash
#testing signal trapping
#
trap "echo ' Sorry! I have trapped Ctrl-C' " SIGINT
#
count=1
while [ $count -le 10 ]
do
    echo "Loop #$count"
    sleep 1
    count=$[ $count + 1 ]
done
#
echo "This is the end of the test script"
#