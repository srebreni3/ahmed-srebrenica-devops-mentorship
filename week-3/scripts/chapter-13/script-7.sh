#!/bin/bash

#using a variable to hold the list

list="Zenica Mostar Sarajevo Tuzla"
list=$list" Bihac"

for state in $list
do
    echo "Have you ever visited $state"
done