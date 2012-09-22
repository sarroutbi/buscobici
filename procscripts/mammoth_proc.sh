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

pages="$(seq 1 13)"

for page in ${pages};
do
  # NAME PARSING:
  cat ${PAGE_BASE}${page} | grep -i "field-content" | grep -i "a href" | sed 's/<a href=/\n/g' | awk -F ">" {'print $2'} | awk -F "<" {'print $1'} | while read NAME;
  do
    test -z "${NAME}" || echo "NAME=>$NAME<=" 
  done | uniq > ${ALL_BIKENAMES_FILE}
 
  # LINK 
  cat ${PAGE_BASE}${page} | grep -i "field-content" | grep -i "a href" | sed 's/<a href=/\n/g' | awk -F ">" {'print $1'} | grep -v " " | while read SUBURL;
  do
    echo ${SUBURL} | grep -v ^\< 2>&1 >/dev/null &&
      echo "SUBURL=>$SUBURL<="
  done | uniq > ${ALL_URLS_FILE}
done

#rm ${ALL_BIKENAMES_FILE}
#rm ${ALL_URLS_FILE}
