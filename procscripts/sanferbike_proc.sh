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
# PROCESSING INFORMATION FOR SANFERBIKE STORE
#
# OUTPUT:
# [Hotwalk Ni�a 2011Specialized Hotwalk Ni�a 2011">Specialized Hotwalk Ni�a 2011">]
# SUBURL="http://bicimania.com/specialized-hotwalk-nina-2011-p-5739.html"
# TRADEMARK=Specialized
# PRICE=139,38
# STORE=Bicimania
# KIND=KIDS (Values valid:KIDS,MTB-*,URBAN-CONFORT-FOLDING,WOMEN,BMX,ROAD)

#### Some global configs
URL_BASE="http://www.sanferbike.com"
#OUTPUT_FILE="output"
OUTPUT_FILE=/dev/stdout
NO_CAMEL_MIN=6

#### The keys
KEY_URL="SUBURL"
KEY_TRADEMARK="TRADEMARK"
KEY_PRICE="PRICE"
KEY_STORE="STORE"
KEY_KIND="KIND"

#### The files to process
FILE_29="29.asp"
FILE_BMC="bmc.asp"
FILE_CANNONDALE="cannondale.asp"
FILE_WOMAN="ellas.asp"
FILE_GIANT="giant.asp"
FILE_LAPIERRE="lapierre.asp"
FILE_ORBEA="orbea.asp"
FILE_TRIATLON="triatlon.asp"

MAX_REV_SEARCH=10000
TRADEMARK_SEP="&nbsp;"
PRICE_KEY="Precio"
MAX_BIKES_PAGE=200
MAX_PRICE_DOWN=20

#
# 1 - The sentence: THIS IS A SENTENCE => This Is A Sentence
# 2 - The min length: 4 => THIS IS A SENTENCE => This IS A Sentence
#
function camel()
{
  let counter=0
  for word in ${1};
  do
    let counter=${counter}+1
  done
  let counter2=0
  for word in ${1};
  do
    let len=${#word}
    let counter2=${counter2}+1
    if [ ${len} -ge ${2} ]; then
      firstLetter=$(echo "${word:0:1}")
      rest=$(echo ${word:1} | tr "[A-Z]" "[a-z]") 
      if [ ${counter2} -lt ${counter} ];
      then
        echo -n "${firstLetter}${rest} "
      else
        echo -n "${firstLetter}${rest}"
      fi
    else
      if [ ${counter2} -lt ${counter} ];
      then
        echo -n "${word} "
      else
        echo -n "${word}"
      fi
    fi
  done
  echo
}

#
# 1 - The URL
#
function get_price()
{
  TMP_FILE=$(mktemp)
  TMP_FILE2=$(mktemp)
  URL=$(echo "${1}" | tr -d '"')
  wget "${URL}" -o ${TMP_FILE2} -O ${TMP_FILE} 2>&1 > /dev/null 
  cat ${TMP_FILE} | grep "${PRICE_KEY}" | awk -F "&nbsp;" {'print $2'} 
  rm ${TMP_FILE}
  rm ${TMP_FILE2}
}

#
# 1 - The file
# 2 - The model
#
function get_price_fm()
{
  PRICE=$(grep "${2}" "${1}" -A${MAX_PRICE_DOWN} | grep 'class="price"' | sed -e 's/<[^>]*>//g' | tr -d ' ' | sed -e 's/\t//g' | egrep -o -E "[0-9]{1,},{0,1}[0-9]{1,3}" | head -1)
  echo "${PRICE}"
}

#
# 1 - The model
# Prints the trademark
function get_trademark()
{
  TRADEMARK=$(echo "$1" | tr -d '"' | awk {'print $1'})
  echo "${TRADEMARK}"
}

#
# 1 - The file
# 2 - The model
# Prints the url
function get_url()
{
  SUBURL=$(grep "$2" "$1" -A10 | grep "a href" | head -1 | awk -F "a href=" {'print $2'} | awk -F " " {'print $1'}) 
  echo "${SUBURL}"
}

#
# 1 - Original type
# Prints valid type 
function translate_type()
{
  echo "${1}" | grep "Monta" 2>&1 > /dev/null
  if [ $? -eq 0 ];
  then
    echo "MTB"
    return 0
  fi
  echo "${1}" | grep "Carret" 2>&1 > /dev/null
  if [ $? -eq 0 ];
  then
    echo "ROAD"
    return 0
  fi
  echo "${1}" | grep "Infantil" 2>&1 > /dev/null
  if [ $? -eq 0 ];
  then
    echo "KIDS"
    return 0
  fi
  echo "${1}" | grep "Urbanas\|Híbridas" 2>&1 > /dev/null
  if [ $? -eq 0 ];
  then
    echo "URBAN-CONFORT-FOLDING"
    return 0
  fi
  echo ""
}

#
# 1 - URL of file
# 2 - The model
function get_type()
{
  TYPE=$(grep "$2" "$1" -B ${MAX_REV_SEARCH} | grep '<div class' | tail -1 | sed -e 's/<[^>]*>//g' | grep "Montaña\|Carretera\|Infantil\|Urbanas\|Híbridas\|" | tr -d ' ' | tr -d '\r' | tr -d '\n')
  TYPE_CONVERSED=$(translate_type "${TYPE}")
  translate_type "${TYPE}"
  #echo "${TYPE_CONVERSED}"
  #echo "${TYPE}"
}

# 
# 1 - URL of site 
# 2 - The Store
function process_file()
{
  cat "$1" | grep 'class="product_link"' | sed -e 's/<[^>]*>//g' | grep "[A-Z,a-z]" | tr -d '\r' | while read model;
  do
     TYPE=$3
     URL=$(get_url "$1" "${model}")
     TRADEMARK=$(get_trademark "${model}")
     PRICE=$(get_price_fm "${1}" "${model}")
     MODEL=$(echo "${model}" | awk -F "&nbsp;" {'print $2'})
     if [ "${MODEL}" = "" ];
     then
       MODEL=$(echo "${model}" | awk -F "&nbsp;&nbsp;" {'print $2'})
       if [ "${MODEL}" = "" ];
       then
         MODEL="${model}"
       fi
     fi
     TRADEMARK_CAMEL=$(camel "${TRADEMARK}" 0)
     MODEL_CAMEL=$(camel "${MODEL}" ${NO_CAMEL_MIN})
     if [ "${TYPE}" != "" ];
     then 
       echo "[${MODEL_CAMEL}]"
       echo "${KEY_URL}=${URL}"
       echo "${KEY_TRADEMARK}=${TRADEMARK_CAMEL}"
       echo "${KEY_PRICE}=${PRICE}"
       echo "${KEY_STORE}=${2}"
       echo "${KEY_KIND}=${3}"
       echo 
     fi
  done
} 

> ${OUTPUT_FILE}

process_file	"207-sport-maraton?n=${MAX_BIKES_PAGE}"                     "Sanferbike"  "MTB" >> ${OUTPUT_FILE}
process_file	"265-trail?n=${MAX_BIKES_PAGE}"                             "Sanferbike"  "MTB" >> ${OUTPUT_FILE}
process_file	"263-scalpel?n=${MAX_BIKES_PAGE}"                           "Sanferbike"  "MTB-DOUBLE">> ${OUTPUT_FILE}
process_file	"309-flash?n=${MAX_BIKES_PAGE}"                             "Sanferbike"  "MTB" >> ${OUTPUT_FILE}
process_file	"264-rz?n=${MAX_BIKES_PAGE}"                                "Sanferbike"  "MTB-DOUBLE" >> ${OUTPUT_FILE}
process_file	"266-b?n=${MAX_BIKES_PAGE}"                                 "Sanferbike"  "MTB" >> ${OUTPUT_FILE}
process_file	"208-all-enduro-cannondale?n=${MAX_BIKES_PAGE}"             "Sanferbike"  "MTB-DOUBLE" >> ${OUTPUT_FILE}
process_file	"209-over-mountain?n=${MAX_BIKES_PAGE}"                     "Sanferbike"  "MTB-29" >> ${OUTPUT_FILE}
process_file	"204-montana-mujer?n=${MAX_BIKES_PAGE}"                     "Sanferbike"  "MTB-WOMAN" >> ${OUTPUT_FILE}
process_file	"205-carretera?n=${MAX_BIKES_PAGE}"                         "Sanferbike"  "ROAD" >> ${OUTPUT_FILE}
process_file	"267-caad?n=${MAX_BIKES_PAGE}"                              "Sanferbike"  "ROAD" >> ${OUTPUT_FILE}
process_file	"269-shinapse?n=${MAX_BIKES_PAGE}"                          "Sanferbike"  "ROAD" >> ${OUTPUT_FILE}
process_file	"268-supersix?n=${MAX_BIKES_PAGE}"                          "Sanferbike"  "ROAD" >> ${OUTPUT_FILE}
process_file	"270-slice?n=${MAX_BIKES_PAGE}"                             "Sanferbike"  "ROAD" >> ${OUTPUT_FILE}
process_file	"310-superx?n=${MAX_BIKES_PAGE}"                            "Sanferbike"  >> ${OUTPUT_FILE}
process_file	"226-carretera-mujer-2013?n=${MAX_BIKES_PAGE}"              "Sanferbike"  >> ${OUTPUT_FILE}
process_file	"206-urbanas?n=${MAX_BIKES_PAGE}"                           "Sanferbike"  >> ${OUTPUT_FILE}
process_file	"163-bicicletas-lapierre-2013?n=${MAX_BIKES_PAGE}"          "Sanferbike"  >> ${OUTPUT_FILE}
process_file	"166-lap-montana-hombre?n=${MAX_BIKES_PAGE}"                "Sanferbike"  >> ${OUTPUT_FILE}
process_file	"171-x-country-maraton?n=${MAX_BIKES_PAGE}"                 "Sanferbike"  >> ${OUTPUT_FILE}
process_file	"278-raid?n=${MAX_BIKES_PAGE}"                              "Sanferbike"  >> ${OUTPUT_FILE}
process_file	"275-pro-race?n=${MAX_BIKES_PAGE}"                          "Sanferbike"  >> ${OUTPUT_FILE}
process_file	"276-x-control?n=${MAX_BIKES_PAGE}"                         "Sanferbike"  >> ${OUTPUT_FILE}
process_file	"279-xr?n=${MAX_BIKES_PAGE}"                                "Sanferbike"  >> ${OUTPUT_FILE}
process_file	"277-x-flow?n=${MAX_BIKES_PAGE}"                            "Sanferbike"  >> ${OUTPUT_FILE}
process_file	"274-bicicletas-29er?n=${MAX_BIKES_PAGE}"                   "Sanferbike"  >> ${OUTPUT_FILE}
process_file	"172-all-mountain-enduro?n=${MAX_BIKES_PAGE}"               "Sanferbike"  >> ${OUTPUT_FILE}
process_file	"280-zesty?n=${MAX_BIKES_PAGE}"                             "Sanferbike"  >> ${OUTPUT_FILE}
process_file	"43-bicicletas?n=${MAX_BIKES_PAGE}"                         "Sanferbike"  >> ${OUTPUT_FILE}
process_file	"323-bicis-montana-2011-en-oferta?n=${MAX_BIKES_PAGE}"      "Sanferbike"  >> ${OUTPUT_FILE}
process_file	"322-ofertas-2011-bicis-carretera?n=${MAX_BIKES_PAGE}"      "Sanferbike"  >> ${OUTPUT_FILE}
process_file	"318-ofertas-2012-bicis-montana?n=${MAX_BIKES_PAGE}"        "Sanferbike"  >> ${OUTPUT_FILE}
process_file	"319-carretera-road-ofertas-bicicletas?n=${MAX_BIKES_PAGE}" "Sanferbike"  >> ${OUTPUT_FILE}
process_file	"321-ofertas-2013-mtb?n=${MAX_BIKES_PAGE}"                  "Sanferbike"  >> ${OUTPUT_FILE}
process_file	"320-ofertas-2013-road?n=${MAX_BIKES_PAGE}"                 "Sanferbike"  >> ${OUTPUT_FILE}