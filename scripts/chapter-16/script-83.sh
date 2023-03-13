#!/bin/bash
#test running in the background 
#
count=1
while [ $count -le 10 ]
do
    sleep 1
    count=$[ $count +1 ]
done
#