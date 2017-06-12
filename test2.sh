#!/bin/bash

john=21
jessie=10

if [[ "$john" == "21" && "$jessie" == "9" ]]
 then
   echo "John is $john and Jessie is $jessie"
elif [[ $john == "21" && $jessie == "10" ]]
then
   echo "John is $john and Jessie is $jessie"
fi
