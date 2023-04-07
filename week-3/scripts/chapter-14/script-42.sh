#!/bin/bash

#testing parameters 
#
if [ $# -ne 2 ]
then 
    echo 
    echo Usage: script-42.sh a b 
    echo 
else 
    total=$[ $1 + $2 ]
    echo 
    echo The total is $total
    echo
fi
#