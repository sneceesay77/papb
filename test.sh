#!/bin/bash

test=( "Sarah/Lisa" "/Sheriffo/Alfu" )

if [ "$1" == "test" ]
then
for i in "${test[@]}"
do

IFS='/' read -ra NAMES <<< "$i"    #Convert string to array

echo "${NAMES[1]}"
done
fi
