#!/bin/bash
#
# This script gets all the bicycles from
# Mammoth store !

OUTPUT_FILE=bicimania.txt
URL="www.mammoth.es"
URL_BASE=http://www.mammoth.es/catalogo/bicicletas?page=
EXCLUDE="-Rgif -Rpng -Rjpg -Rcss"
PAGE_BASE="bicicletas?page="
#EXCLUDE="-Ahtml"
#ONLY_DOMAIN="bicimania.com"
#HOST_ONLY="-D${ONLY_DOMAIN}"
ALL_BIKENAMES_FILE="./output.bikes"
ALL_URLS_FILE="./output.url"
ALL_BIKEURLS_FILE="./output"

pages="$(seq 1 13)"

test -f ${ALL_BIKEURLS_FILE}  && rm ${ALL_BIKEURLS_FILE}
test -f ${ALL_BIKENAMES_FILE} && rm ${ALL_BIKENAMES_FILE}
test -f ${ALL_BIKENAMES_FILE} && rm ${ALL_URLS_FILE}

function parseMammothBike()
{
  URL=$1
}

function getNLine()
{
  head -${1} $2 | tail -1
}

for page in ${pages};
do
  # NAME PARSING:
  cat ${PAGE_BASE}${page} | grep -i "field-content" | grep -i "a href" | sed 's/<a href=/\n/g' | awk -F ">" {'print $2'} | awk -F "<" {'print $1'} | while read NAME;
  do
    test -z "${NAME}" || echo "$NAME" 
  done | uniq >> ${ALL_BIKENAMES_FILE}
 
  # LINK 
  cat ${PAGE_BASE}${page} | grep -i "field-content" | grep -i "a href" | sed 's/<a href=/\n/g' | awk -F ">" {'print $1'} | grep -v " " | tr -d '"' | while read SUBURL;
  do
    echo ${SUBURL} | grep -v ^\< 2>&1 >/dev/null &&
      echo "SUBURL=\"${URL}${SUBURL}\""
  done | uniq >> ${ALL_URLS_FILE}
done

NUM_ENTRIES=$(cat ${ALL_BIKENAMES_FILE} | wc -l)
let counter=0
while [ ${counter} -ne ${NUM_ENTRIES} ];
do
  echo -n "[" 
  echo -n "$(getNLine ${counter} ${ALL_BIKENAMES_FILE})"
  echo "]" 
  getNLine ${counter} ${ALL_URLS_FILE}
  echo 
  let counter=${counter}+1
done >> ${ALL_BIKEURLS_FILE}

#rm ${ALL_BIKEURLS}
rm ${ALL_BIKENAMES_FILE}
rm ${ALL_URLS_FILE}
