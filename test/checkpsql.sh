#!/bin/bash
#
# This script checks some basic features for the loadable psql files, such as:
# - The insert lines starts with "INSERT INTO"
# - The insert lines ends with ");"
#
# The script receives the file generated with command "webtodb.sh"
#

OUTPUT_FILE=./checkpsql.txt
TMP_FILE=$(mktemp)
let COUNTER_ERRORS=0
let COUNTER_LINES=0

test -f ${OUTPUT_FILE} && rm ${OUTPUT_FILE}

test -z "${1}" && echo && echo "Please, specify input file" && echo && exit 1

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
done < ${TMP_FILE} >> ${OUTPUT_FILE}

printf "\nTotal errors : %d/%d\n\n" "${COUNTER_ERRORS}" "${COUNTER_LINES}"

rm ${TMP_FILE}