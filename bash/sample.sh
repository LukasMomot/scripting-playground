#!/usr/bin/env bash

# print used bash version
echo $BASH_VERSION
# define array of 5 numbers
numbers=(1 2 3 4 5)

# check if the array contains 3 using operator
if [[ " ${numbers[@]} " =~ " 3 " ]]; then
  echo "Array contains 3"
fi

#define a hashtable with example data
declare -A hashtable=( ["key1"]="value1" ["key2"]="value2" )

# access hashtable value using key
echo ${hashtable["key1"]}

# get files in current directory
files=$(ls -p | grep -v /)

# write files names to console
for file in $files
do
  echo $file
done
