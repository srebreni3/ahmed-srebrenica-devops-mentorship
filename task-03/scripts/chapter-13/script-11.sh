#!/bin/bash

#iterating through multiple directories

for file in /home/centos/ahmed-srebrenica-week-3
do 
    if [ -d "$file" ]
    then 
        echo "$file is a direcotory"
    elif [ -f "$file" ]
    then 
        echo "$file is a file"
    else 
        echo "$file doesn't exist"
    fi
done