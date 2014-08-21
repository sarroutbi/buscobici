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
# This script receives:
#
# 1 - The configuration file containing the entries.
#     It must contain entries like:
#     ...
#     [7.6 FX WSD]
#     SUBURL="http://www.mammoth.es/producto/bicicletas/trek/76-fx-wsd"
#     TRADEMARK=Trek
#     PRICE=1099,00
#     STORE=Mammoth 
#     KIND=MTB
#
#     The script will attempt to get this entries, and insert them on 
#     the databases, in sentences like:
#
#     INSERT INTO bikes VALUES ('7.6 FX WSD', 'Trek', 'Mammoth', 'http://www.mammoth.es/producto/bicicletas/trek/76-fx-wsd', 'MTB', '1099.00');
#

########### GLOBAL CONFIG
G_DATABASE=bikesearch
G_TABLE=bikes
G_QUERY_STR="INSERT INTO bikes VALUES ('%s', '%s', '%s', '%s', '%s', '%s');"
G_SUBURL_KEY="SUBURL"
G_TRADEMARK_KEY="TRADEMARK"
G_PRICE_KEY="PRICE"
G_STORE_KEY="STORE"
G_TYPE_KEY="KIND"
G_MAX_SECTION=10

########### GLOBAL VARIABLES:
G_MODEL="-"
G_TRADEMARK="-"
G_STORE="-"
G_URL="-"
G_TYPE="-"
G_PRICE="0.00"
G_OUTPUT=$(mktemp)
G_OUTPUT_RAND=$(mktemp /tmp/tmp.rand.XXXXXXXX)
G_SEP="<=====>"
########### ADDITIONAL FUNCTIONS:

###########
# Function getSectionLength
# - Parse the file, gets the section
#   and returns the length of the section (including white lines)
#   Params:
#   1 : The file to parse
#   2 : The section to parse
function getSectionLength()
{ 
  let len=0
  let issection=1
  let onefound=0
  grep "${2}" "${1}" -A${G_MAX_SECTION} | while read line;
  do
   echo $line | grep "\[*\]" > /dev/null
   if [ $? -eq 0 ];
   then 
     echo "${line}" | grep "${2}" > /dev/null
     if [ $? -eq 0 ];
     then 
       if [ ${onefound} -eq 0 ]; 
       then
         let issection=1
         let onefound=1
       else
         let issection=0
       fi 
     else
       let issection=0
     fi
   elif [ $issection -eq 1 ];
   then
     let len=$len+1 
   else
     echo $len
     return 0
   fi
  done
}

###########
# Function parseSectionContent
# - Parse the file, gets the section specified
#   and inserts it to DataBase
#   Params:
#   1 : The file to parse
#   2 : The section to parse
#   3 : The length of the section
function parseSectionContent()
{
  G_MODEL="-"
  G_TRADEMARK="-"
  G_STORE="-"
  G_URL="-"
  G_TYPE="-"
  G_PRICE="0.00"
 
  test -z "${1}" && return 1 
  test -z "${2}" && return 1 
  test -z "${3}"
  if [ $? -eq 0 ];
  then
    LENGTH=${G_MAX_SECTION} 
  else 
    if [ ${3} -le 0 ];
    then
      LENGTH=${G_MAX_SECTION}
    else
      LENGTH=${3}
    fi
  fi

  grep "${2}" "${1}" -A${LENGTH} | grep "${2}" | head -1 2>&1 > /dev/null && G_MODEL="$(echo ${2} | tail -1 | tr -d "\[" | tr -d "\]" | tr -d '\\' | awk -F "${G_SEP}" {'print $1'})"
  grep "${2}" "${1}" -A${LENGTH} | grep ${G_TRADEMARK_KEY} 2>&1 >/dev/null && \
    G_TRADEMARK=$(grep "${2}" "${1}" -A${LENGTH} | grep ${G_TRADEMARK_KEY} | head -1 | awk -F "=" {'print $2'}); 
  grep "${2}" "${1}" -A${LENGTH} | grep ${G_STORE_KEY}       2>&1 > /dev/null && \
    G_STORE=$(grep "${2}" "${1}" -A${LENGTH} | grep "${G_STORE_KEY}" | head -1 | awk -F "=" {'print $2'});
  grep "${2}" "${1}" -A${LENGTH} | grep ${G_SUBURL_KEY}         2>&1 > /dev/null && \
    G_URL=$(grep "${2}" "${1}" -A${LENGTH} | grep "${G_SUBURL_KEY}" | head -1 | sed s-\"--g | awk -F "=" '{for(i=2;i<=NF;++i){printf $i; if(i<NF){printf "="}}}');
  grep "${2}" "${1}" -A${LENGTH} | grep ${G_TYPE_KEY}       2>&1 > /dev/null && \
    G_TYPE=$(grep "${2}" "${1}" -A${LENGTH} | grep "${G_TYPE_KEY}" | head -1 | awk -F "=" {'print $2'});
  grep "${2}" "${1}" -A${LENGTH} | grep ${G_PRICE_KEY}       2>&1 > /dev/null && \
    G_PRICE=$(grep "${2}" "${1}" -A${LENGTH} | grep "${G_PRICE_KEY}" | head -1 | awk -F "=" {'print $2'} | tr "," "." | grep -o "[0-9]*\.\{0,\},\{0,\}[0-9]*");

  #echo "============================"
  #echo "QUERY_STR is:${G_QUERY_STR}"
  #echo "MODEL     is:${G_MODEL}"
  #echo "TRADEMARK is:${G_TRADEMARK}"
  #echo "STORE     is:${G_STORE}"
  #echo "URL       is:${G_URL}"
  #echo "TYPE      is:${G_STORE}"
  #echo "PRICE     is:${G_PRICE}"
  #echo "============================"
  printf "${G_QUERY_STR}\n" "${G_MODEL}" "${G_TRADEMARK}" "${G_STORE}" "${G_URL}" "${G_TYPE}" "${G_PRICE}"
}

###########
# Function usage
function error()
{
  echo ""
  echo "$1:"  
  printNSpaces "${#1}"
  echo ": $2"
  echo ""
  exit $3
}

###########
# Function printNSpaces
function printNSpaces()
{
  let counter=0
  let nu=${1}
  while [ $counter -ne $nu ];
  do 
    echo -n " " 
    let counter=$counter+1 
  done 
}

###########
# Function usage
function usage()
{
  echo ""  
  echo "$0:"
  printNSpaces "${#0}"
  echo ": $0 \"file_to_parse\""  
  echo ""  
  exit 1
}

########### MAIN FUNCTIONS:
FILE=$1

test -z ${FILE} && usage $0
test -f ${FILE} || error $0 "Unable to open file $FILE" 1

# 0 - Include in each section a random number to avoid duplicated sections
RANDNUM=$(echo $((RANDOM * RANDOM)))
cat ${FILE} | while read line;
do
  echo ${line} | egrep -E "\\[*\\]" 1>/dev/null &&\
  echo "${line}" | sed -e "s@\[\([^]]*\)\]@\[\1${G_SEP}$((RANDOM))\]@g" ||\
  echo "${line}"
done > ${G_OUTPUT_RAND}

cat ${G_OUTPUT_RAND} | egrep -E "\\[*\\]" | while read line;
do
  length=$(getSectionLength ${G_OUTPUT_RAND} "$(echo ${line} | sed s-\\[-\\\\[-g | sed s-\\]-\\\\]-g)");
  parseSectionContent ${G_OUTPUT_RAND} "$(echo ${line} | sed s-\\[-\\\\[-g | sed s-\\]-\\\\]-g)" ${len} 
done > ${G_OUTPUT}

cat ${G_OUTPUT} | sort | uniq

rm ${G_OUTPUT}
rm ${G_OUTPUT_RAND}
