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
# Parse results to common file with structure:
#
# [Grow 2]
# SUBURL="http://www.bicicletasgil.com/producto/Orbea-Grow-2"
# TRADEMARK=Orbea
# PRICE=249,00
# STORE=Biciletas Gil
# KIND=MTB-FIX

MAX_PRICE=2
OUTPUT_FILE=./output
#OUTPUT_FILE=/dev/stdout
BASE_URL="http://www.bikeos.com"
NO_CAMEL_MIN=6
NO_CAMEL_TRADEMARK_MIN=0
MAX_PRICE_SEARCH=35
URL="www.bikeos.com"
ONLY_DOMAIN="bikeos.com"
EXCLUDE="-Rgif -Rpng -Rjpg"

#### COMMON proc 
. ./common_proc

#### KEYS GENERATED
TRADEMARK_KEY="TRADEMARK"
SUBURL_KEY="SUBURL"
STORE_KEY="STORE"
PRICE_KEY="PRICE"
KIND_KEY="KIND"

# Params
# 1 - Model:     [MODEL]
# 2 - Url:       SUBURL="www.whatever.es"
# 3 - Trademark: TRADEMARK=Trek
# 4 - Price:     PRICE=100000,99
# 5 - Store:     STORE=Mammoth
# 6 - Kind:      KIND=MTB
function dump_bike()
{
  if [[ "$1" != "" ]];
  then
    echo "[$1]"
    echo "${SUBURL_KEY}=$2"
    echo "${TRADEMARK_KEY}=$3"
    echo "${PRICE_KEY}=$4"
    echo "${STORE_KEY}=$5"
    echo "${KIND_KEY}=$6"
    echo 
  fi
}

# Params:
# 1 - The URL of bike
function print_model()
{
  URL="$1"
  FILE="$2"
  #echo "================== MODEL ===================="
  grep "${URL}" "${FILE}" | sed -e 's/<[^>]*>//g'
  #echo "================== MODEL ===================="
}

# Params:
# 1 - The File of bike
# 2 - The model of bike
function print_price()
{
  FILE="$1"
  MODEL="$2"
  PRICE=$(grep "${MODEL}" "${FILE}" -A${MAX_PRICE_SEARCH} | grep -v "old-price" | grep -v "price-box" | grep "price" -A2 | sed -e 's/<[^>]*>//g' | egrep -o -E "[0-9]{1,}.{0,1}[0-9]{1,},{0,1}[0-9]{0,}" | tr -d '.' | tail -1)
  if [ "${PRICE}" = "" ];
  then
    let MAX_PRICE_SEARCH=${MAX_PRICE_SEARCH}+5
    PRICE=$(grep "${MODEL}" "${FILE}" -A${MAX_PRICE_SEARCH} | grep -v "old-price" | grep -v "price-box" | grep "price" -A2 | sed -e 's/<[^>]*>//g' | egrep -o -E "[0-9]{1,}.{0,1}[0-9]{1,},{0,1}[0-9]{0,}" | tr -d '.' | tail -1)
  fi
  if [ "${PRICE}" = "" ];
  then
    let MAX_PRICE_SEARCH=${MAX_PRICE_SEARCH}+10
    PRICE=$(grep "${MODEL}" "${FILE}" -A${MAX_PRICE_SEARCH} | grep -v "old-price" | grep -v "price-box" | grep "price" -A2 | sed -e 's/<[^>]*>//g' | egrep -o -E "[0-9]{1,}.{0,1}[0-9]{1,},{0,1}[0-9]{0,}" | tr -d '.' | tail -1)
  fi
  if [ "${PRICE}" = "" ];
  then
    ### Last effort, go for first one
    let MAX_PRICE_SEARCH=${MAX_PRICE_SEARCH}+90
    PRICE=$(grep "${MODEL}" "${FILE}" -A${MAX_PRICE_SEARCH} | grep -v "old-price" | grep -v "price-box" | grep "price" -A2 | sed -e 's/<[^>]*>//g' | egrep -o -E "[0-9]{1,}.{0,1}[0-9]{1,},{0,1}[0-9]{0,}" | tr -d '.' | head -1)
  fi
  PRICE_NO_SPACE=$(echo ${PRICE} | tr -d ' ')
  echo ${PRICE_NO_SPACE}
}

# Params
# 1 - The URL where to extract the file
function log_print_price2()
{
  echo "Printing price from URL:${1}"
  echo "Command: wget -o /dev/null ${1} -O - | grep '<span class=\"special-price\">' -A10 | sed -e 's/<[^>]*>//g' | egrep -o -E \"[0-9]{0,}.{0,}[0-9]{1,},{0,}[0-9]{0,}\" | head -1 | sed -e 's/[^0-9,\.,\,]*//g'"
  OUTPUT=$(wget ${1} -o /dev/null -O - | grep '<span class="special-price">' -A10 | sed -e 's/<[^>]*>//g' | egrep -o -E "[0-9]{0,}.{0,}[0-9]{1,},{0,}[0-9]{0,}" | head -1 | sed -e 's/[^0-9,\.,\,]*//g')
  OUTPUT2=$(wget -o /dev/null ${1} -O - | grep '<span class="special-price">' -A10 | sed -e 's/<[^>]*>//g' | egrep -o -E "[0-9]{0,}.{0,}[0-9]{1,},{0,}[0-9]{0,}" | head -1)
  OUTPUT3=$(wget -o /dev/null ${1} -O - | grep '<span class="special-price">' -A10 | sed -e 's/<[^>]*>//g' | egrep -o -E "[0-9]{0,}.{0,}[0-9]{1,},{0,}[0-9]{0,}")
  OUTPUT4=$(wget -o /dev/null ${1} -O - | grep '<span class="special-price">' -A10 | sed -e 's/<[^>]*>//g')
  echo "Output :=>${OUTPUT}<="
  #echo "Output2:=>${OUTPUT2}<="
  #echo "Output3:=>${OUTPUT3}<="
  #echo "Output4:=>${OUTPUT4}<="
}

# Params
# 1 - The URL where to extract the file
function print_price2()
{
  PRICE=$(wget -o /dev/null ${1} -O - | grep '<span class="special-price">' -A10 | sed -e 's/<[^>]*>//g' | egrep -o -E "[0-9]{0,}.{0,}[0-9]{1,},{0,}[0-9]{0,}" | head -1 | sed -e 's/[^0-9,\.,\,]*//g')
  echo ${PRICE}
}

function print_price3()
{
  FILE="$1"
  URL="$2"
  PRICE=$(grep "${URL}" "${FILE}" -A50 | grep price -A2 | grep '</span>' | egrep -o -E "[0-9]{0,}.{0,}[0-9]{2,},{0,}[0-9]{0,}" | tr -d ' ' | head -1 | tr -d '.')
  echo "${PRICE}"
}

# Params:
# 1 - The sentence
# 2 - The min size to camelize
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

function dump_bike_from_urls()
{
  URLS="$1"
  FILE="$2"
  #echo "URLS:=>${URLS}<="
  echo "${URLS}" | while read URL;
  do
    TRADEMARK_MODEL=$(print_model "${URL}" "${FILE}" | sed -e s/"+ Vale regalo [0-9]*"//g | sed -e s/"+ vale regalo [0-9]*"//g | sed -e s/"+Vale regalo [0-9]*"//g | sed -e 's/^[ \t]*//g' | sed -e 's/[ \t]*$//g')
    TRADEMARK_MODEL_CLEAN=$(bubic_clean "${TRADEMARK_MODEL}")
    TRADEMARK=$(echo ${TRADEMARK_MODEL_CLEAN} | awk {'print $1'})
    TRADEMARK_CAMEL=$(bubic_camel "${TRADEMARK}" 0)
#    MODEL=$(echo ${TRADEMARK_MODEL} | awk {'for(i=2;i<=NF;++i){printf $i; if(i<NF){printf " "}}'} | tr -d '\r' | sed -e 's/[ \t]*$//g' | sed 's/[^0-9,A-Z,a-z,-,\,\.,\(,\)]*$//g')
    MODEL=$(echo "${TRADEMARK_MODEL_CLEAN}" | awk {'for(i=2;i<=NF;++i){printf $i; if(i<NF){printf " "}}'})
    MODEL_CAMEL=$(bubic_camel "${MODEL}" ${NO_CAMEL_MIN})
    MODEL_CAMEL_CLEAN=$(bubic_clean "${MODEL_CAMEL}")
    PRICE=$(print_price "${FILE}" "${MODEL}")
    NOBASE_URL=$(echo ${URL} | awk -F "a href=" {'print $2'} | awk {'print $1'})
    FINAL_URL="${NOBASE_URL}"
    echo "${PRICE}" | grep "[0-9]" 2>&1 >/dev/null
    if [ $? -ne 0 ];
    then
      FINAL_URL_NO_QUOTED=$(echo ${FINAL_URL} | tr -d '"')
      # echo "No PRICE!, printing price from =>${FINAL_URL_NO_QUOTED}<="
      # log_print_price2 ${FINAL_URL_NO_QUOTED}
      PRICE=$(print_price2 ${FINAL_URL_NO_QUOTED} | tr -d '.')
    fi 
    echo "${PRICE}" | grep "[0-9]" 2>&1 >/dev/null
    if [ $? -ne 0 ];
    then
      PRICE=$(print_price3 "${FILE}" "${URL}")
    fi 
    #echo "========================================================================"
    #echo "TRADEMARK_MODEL=>${TRADEMARK_MODEL}<="
    #echo "TRADEMARK_MODEL_CLEAN=>${TRADEMARK_MODEL_CLEAN}<="
    #echo "TRADEMARK=${TRADEMARK_CAMEL}"
    #echo "MODEL=>${MODEL}<="
    #echo "MODEL_CAMEL=>${MODEL_CAMEL}<="
    #echo "MODEL_CAMEL_CLEAN=>${MODEL_CAMEL_CLEAN}<="
    #echo "URL=${FINAL_URL}"
    #echo "PRICE=${PRICE}"
    #echo "FILE=${FILE}"
    #echo "========================================================================"
    dump_bike "${MODEL_CAMEL_CLEAN}" "${FINAL_URL}" "${TRADEMARK_CAMEL}" "${PRICE}" "${STORE}" "${TYPE}"
  done
}

function process_pages()
{
  BASE_FILE="$1"
  PAGES="$2"
  STORE="$3"
  TYPE="$4"
  #echo "BASE_FILE=$1"
  #echo "PAGES=$2"
  #echo "STORE=$3"
  #echo "TYPE=$4"

  if [ "${PAGES}" = "" ];
  then
    URLS=$(cat "${BASE_FILE}" | grep h2)
    dump_bike_from_urls "${URLS}" 
  else
    for page in ${PAGES};
    do 
      URLS=$(cat "${BASE_FILE}${page}" | grep h2)
      dump_bike_from_urls "${URLS}" "${BASE_FILE}${page}"
    done
  fi
}

> ${OUTPUT_FILE}

ROAD_BIKES_BASE="bicicletas-carretera.html?p="
ROAD_BIKES_PAGES="$(seq 1 20)"

MTB_BIKES_BASE="bicicletas-mountain-bike.html?p="
MTB_BIKES_PAGES="$(seq 1 35)"

BMX_BIKES_BASE="bicicletas-bmx-trial-freeride.html?p="
BMX_BIKES_PAGES="$(seq 1 10)"

TREKKING_OUTLET_BIKES_BASE="bicicletas-trekking-liquidacion.html?p="
TREKKING_OUTLET_BIKES_PAGES="$(seq 1 5)"

TREKKING_2012_BIKES_BASE="bicicletas-trekking-2012.html?p="
TREKKING_2012_BIKES_PAGES="$(seq 1 5)"

TREKKING_2013_BIKES_BASE="bicicletas-trekking-2013.html?p="
TREKKING_2013_BIKES_PAGES="$(seq 1 10)"

TREKKING_2014_BIKES_BASE="bicicletas-trekking-2014.html?p="
TREKKING_2014_BIKES_PAGES="$(seq 1 10)"

FOLDING_BIKES_BASE="bicicletas-plegables.html?p="
FOLDING_BIKES_PAGES="$(seq 1 5)"

ELECTRIC_BIKES_BASE="bicicletas-electricas.html?p="
ELECTRIC_BIKES_PAGES="$(seq 1 20)"

KIDS_BIKES_BASE="bicicleta-infantil.html?p="
KIDS_BIKES_PAGES="$(seq 1 10)"

MTB_29_BIKES_BASE="bicicletas-29.html?p="
MTB_29_BIKES_PAGES="$(seq 1 10)"

process_pages "${MTB_BIKES_BASE}"  "${MTB_BIKES_PAGES}"  "BikeOS" "MTB" >> ${OUTPUT_FILE}
process_pages "${ROAD_BIKES_BASE}" "${ROAD_BIKES_PAGES}" "BikeOS" "ROAD" >> ${OUTPUT_FILE}
process_pages "${BMX_BIKES_BASE}"  "${BMX_BIKES_PAGES}"  "BikeOS" "BMX" >> ${OUTPUT_FILE}
process_pages "${TREKKING_OUTLET_BIKES_BASE}" "${TREKKING_OUTLET_BIKES_PAGES}" "BikeOS" "URBAN" >> ${OUTPUT_FILE}
process_pages "${TREKKING_2012_BIKES_BASE}" "${TREKKING_2012_BIKES_PAGES}" "BikeOS" "URBAN" >> ${OUTPUT_FILE}
process_pages "${TREKKING_2013_BIKES_BASE}" "${TREKKING_2013_BIKES_PAGES}" "BikeOS" "URBAN" >> ${OUTPUT_FILE}
process_pages "${TREKKING_2014_BIKES_BASE}" "${TREKKING_2014_BIKES_PAGES}" "BikeOS" "URBAN" >> ${OUTPUT_FILE}
process_pages "${FOLDING_BIKES_BASE}"  "${FOLDING_BIKES_PAGES}" "BikeOS" "URBAN" >> ${OUTPUT_FILE}
process_pages "${ELECTRIC_BIKES_BASE}" "${ELECTRIC_BIKES_PAGES}" "BikeOS" "URBAN" >> ${OUTPUT_FILE}
process_pages "${KIDS_BIKES_BASE}" "${KIDS_BIKES_PAGES}" "BikeOS" "KIDS" >> ${OUTPUT_FILE}
process_pages "${MTB_29_BIKES_BASE}" "${MTB_29_BIKES_PAGES}" "BikeOS" "MTB-29" >> ${OUTPUT_FILE}
