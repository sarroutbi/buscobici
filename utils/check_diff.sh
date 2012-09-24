#!/bin/bash
# 
# This script receives:
# 1 - The config file result of parsing a web
# 2 - The psql file
# and compares its entries to check for inconsistencies
 
TMP_FILE=$(mktemp)
counter=0
cat $1 | grep "\[*\]" > ${TMP_FILE}
let counter=$(cat ${TMP_FILE} | wc -l)
let counter2=$(wc -l $2 | awk {'print $1'})
compare=${counter}
[ ${counter2} -ge ${compare} ]  && let compare=${counter2}

echo "COMPARING:${compare} lines"
let counter=0
while [ ${counter} -ne ${compare} ];
do
  line1=$(head -${counter} ${TMP_FILE} | tail -1)
  line2=$(head -${counter} $2 | tail -1 | awk -F "(" {'print $2'} | awk -F "," {'print $1'})
  echo "${line1}<=>${line2}"
  let counter=$counter+1
done
> ${TMP_FILE}
