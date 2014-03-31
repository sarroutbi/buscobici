#!/bin/bash
#
# Copyright © 2012-2013 Sergio Arroutbi Braojos <sarroutbi@gmail.com>
# 
# Permission to use, copy, modify, and/or distribute this software 
# for any purpose with or without fee is hereby granted, provided that 
# the above copyright notice and this permission notice appear in all copies.
# 
# THE SOFTWARE IS PROVIDED “AS IS” AND THE AUTHOR DISCLAIMS ALL WARRANTIES 
# WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY 
# AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, 
# INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM 
# LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, 
# NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE 
# OR PERFORMANCE OF THIS SOFTWARE.
#
# 
# GLOBAL CONFIGURATION VALUES:
GLOBAL_URL="http://www.buscobici.com/bikesearch"
SEARCH_PHP="search.php"
ERROR_LOG_FILE="./errorurl.txt"
let COUNTER_URL=0
let ERROR_COUNTER=0
TMP_FILE=$(mktemp)

BASEDIR=$(dirname $0)
cd ${BASEDIR}

> "${ERROR_LOG_FILE}"
> "${TMP_FILE}"
rm -f "${SEARCH_PHP}"

function urltest()
{
  URL="$1"
  wget "${URL}" -O - -o /dev/null 2>&1 > /dev/null
  return $?
}

# Parse input
# TO BE DONE
wget --post-data "search=\*&entryPerPage=10000" "${GLOBAL_URL}/${SEARCH_PHP}" -o /dev/null 2>&1 > /dev/null

#cat ${SEARCH_PHP} | egrep -E -o '<a href="[^>]*>' | sed -e 's/<a href="//g' | sed -e 's/">//g' | while read URL;
#do 
#  let COUNTER_URL=${COUNTER_URL}+1 
#done

cat ${SEARCH_PHP} | grep -v '<li>' | egrep -E -o '<a href="[^>]*>' | sed -e 's/<a href="//g' | sed -e 's/">//g' >> ${TMP_FILE}

while read URL;
do 
  let COUNTER_URL=${COUNTER_URL}+1 
done < ${TMP_FILE} 

let counter=0;

cat ${SEARCH_PHP} | grep -v '<li>' | egrep -E -o '<a href="[^>]*>' | sed -e 's/<a href="//g' | awk -F "target" {'print $1'} | sed -e 's/">//g' | tr -d '"' | while read URL;
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
