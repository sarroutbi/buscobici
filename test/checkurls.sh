#!/bin/bash
#
# 
# GLOBAL CONFIGURATION VALUES:
GLOBAL_URL="http://localhost/bikesearch"
SEARCH_PHP="search.php"
ERROR_LOG_FILE="./errorurl.txt"
let COUNTER_URL=0
let ERROR_COUNTER=0
TMP_FILE=$(mktemp)

> ${ERROR_LOG_FILE}

function urltest()
{
  URL="$1"
  wget "${URL}" -O - -o /dev/null 2>&1 > /dev/null
  return $?
}

# Parse input
# TO BE DONE
wget --post-data "search=\*" "${GLOBAL_URL}/${SEARCH_PHP}" -o /dev/null 2>&1 > /dev/null

#cat ${SEARCH_PHP} | egrep -E -o '<a href="[^>]*>' | sed -e 's/<a href="//g' | sed -e 's/">//g' | while read URL;
#do 
#  let COUNTER_URL=${COUNTER_URL}+1 
#done

cat ${SEARCH_PHP} | egrep -E -o '<a href="[^>]*>' | sed -e 's/<a href="//g' | sed -e 's/">//g' >> ${TMP_FILE}
while read URL;
do 
  let COUNTER_URL=${COUNTER_URL}+1 
done < ${TMP_FILE} 

let counter=0;

cat ${SEARCH_PHP} | egrep -E -o '<a href="[^>]*>' | sed -e 's/<a href="//g' | sed -e 's/">//g' | while read URL;
do
  printf "%s/%s (%s errors)\r" "${counter}" "${COUNTER_URL}" "${ERROR_COUNTER}"
  urltest "${URL}";
  if [ $? -ne 0 ]; 
  then
    echo "URL=>${URL}<= not accessible" >> ${ERROR_LOG_FILE};
    let ERROR_COUNTER=${ERROR_COUNTER}+1;
  fi 
  let counter=${counter}+1
done

rm "${SEARCH_PHP}"
rm "${TMP_FILE}"
