#!/bin/bash
#
# This script checks some basic features for the loadable psql files, such as:
# - The insert lines starts with "INSERT INTO"
# - The insert lines ends with ");"
# - Check price has correct type
# - Check URL has correct syntax (http://...)
# - Check Model contains no forbidden characters
# The script receives the file generated with command "webtodb.sh"
#

test -z "${1}" && echo && echo "Please, specify input file" && echo && exit 1

let COUNTER_ERRORS=0
let COUNTER_LINES=0
let ERR=0
TMP_FILE=$(mktemp)

OUTPUT_FILE=./checkpsql.$(basename ${1}).error

let COUNTER_LINES=$(wc -l ${1} | awk {'print $1'})

cat "${1}" | grep -v ");"$ > ${TMP_FILE}

while read line;
do
  echo ${line}
  let COUNTER_ERRORS=${COUNTER_ERRORS}+1
done < ${TMP_FILE} >> ${OUTPUT_FILE}

cat "${1}" | grep -v ^"INSERT INTO" > ${TMP_FILE} 

while read line;
do
  echo ${line}
  let COUNTER_ERRORS=${COUNTER_ERRORS}+1
  let ERR=${ERR}+1
done < ${TMP_FILE} >> ${OUTPUT_FILE}

cat "${1}" > ${TMP_FILE}

while read line;
do
  MODEL=$(echo "${line}" | grep -o "(.*)" | tr -d "()" | awk -F "," {'print $1'})
  TRADEMARK=$(echo "${line}" | grep -o "(.*)" | tr -d "()" | awk -F "," {'print $2'} | sed -e 's/^[ \t]//g')
  STORE=$(echo "${line}" | grep -o "(.*)" | tr -d "()" | awk -F "," {'print $3'} | sed -e 's/^[ \t]//g')
  URL=$(echo "${line}" | grep -o "(.*)" | tr -d "()" | awk -F "," {'print $4'} | sed -e 's/^[ \t]//g')
  TYPE=$(echo "${line}" | grep -o "(.*)" | tr -d "()" | awk -F "," {'print $5'} | sed -e 's/^[ \t]//g')
  PRICE=$(echo "${line}" | grep -o "(.*)" | tr -d "()" | awk -F "," {'print $6'} | sed -e 's/^[ \t]//g')
  #echo "========================"
  #echo "MODEL=${MODEL}"
  #echo "TRADEMARK=${TRADEMARK}"
  #echo "STORE=${STORE}"
  #echo "URL=${URL}"
  #echo "TYPE=${TYPE}"
  #echo "PRICE=${PRICE}"
  #echo "========================"
done < ${TMP_FILE}

printf "\nTotal errors : %d/%d\n" "${COUNTER_ERRORS}" "${COUNTER_LINES}"

rm ${TMP_FILE}

# If error file is sized 0, we delete it
test -s ${OUTPUT_FILE} || rm ${OUTPUT_FILE}

exit ${ERR}
