#!/bin/bash
#
# Script to copy just the needed files to another directory (VCS normally):
# - .res xml files
# - .java files
function error()
{
  echo 
  echo "$1" 
  echo 
  exit $2
}

test -z ${1} && error "Please provide a target directory" 1

for file in $(find . -name "*.xml" -print);
do
  echo "cp $file ${1}/${file}"
done
echo -n "Sure? (y/n) :"
read char

if [ $char = "y" ];
then
  for file in $(find . -name "*.xml" -print);
  do
    cp $file ${1}/${file}
  done
else
  exit 0
fi
echo 

for file in $(find src -name "*.java" -print | grep -v 'R.java' );
do
  echo "cp $file ${1}/${file}"
done
echo -n "Sure? (y/n) :"
read char

if [ $char = "y" ];
then
  for file in $(find src -name "*.java" -print | grep -v 'R.java');
  do
    cp $file ${1}/${file}
  done
else
  exit 0
fi
