#!/bin/bash
#
# Copyright © 2012-2015 Sergio Arroutbi Braojos <sarroutbi@gmail.com>
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
# SUBURL="http://www.bikestocks.com/producto/Orbea-Grow-2"
# TRADEMARK=Orbea
# PRICE=249,00
# STORE=BikeStocks
# KIND=MTB

MAX_PRICE=2
OUTPUT_FILE=./output
URL_BASE="http://www.bikestocks.es"
NO_CAMEL_MIN=3

#### KEYS GENERATED
TRADEMARK_KEY="TRADEMARK"
SUBURL_KEY="SUBURL"
STORE_KEY="STORE"
PRICE_KEY="PRICE"
KIND_KEY="KIND"

. ./common_proc

#
# 1 - The sentence: THIS IS A SENTENCE => This Is A Sentence
# 2 - The min length: 4 => THIS IS A SENTENCE => This IS A Sentence
#
function camel()
{
  let counter=0;
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
    echo "${SUBURL_KEY}=\"$2\""
    echo "${TRADEMARK_KEY}=$3"
    echo "${PRICE_KEY}=$4"
    echo "${STORE_KEY}=$5"
    echo "${KIND_KEY}=$6"
    echo 
  fi
}

# Params:
# 1 - The URL of bike
# 2 - The file of the bike
function print_model()
{
  URL_SEARCH=$(echo "${1}"  | tr -d '"')
  FILE_SEARCH="${2}"
  #echo "======================================"
  #echo "======> URL:${URL_SEARCH} <========="
  #echo "======> FILE:${FILE_SEARCH} <========="
  MODEL=$(grep "${URL_SEARCH}" "${FILE_SEARCH}" | head -1 | sed -e 's/<[^>]*>//g')
  echo "${MODEL}"
  #echo "======================================"
}

# Params:
# 1 - The URL of bike
# 2 - The file of the bike
function print_price()
{
  URL_SEARCH=$(echo "${1}"  | tr -d '"')
  FILE_SEARCH="${2}"
  #echo "======================================"
  #echo "======> URL:${URL_SEARCH} <========="
  #echo "======> FILE:${FILE_SEARCH} <========="
  PRICE=$(grep "${URL_SEARCH}" "${FILE_SEARCH}" | awk -F "<a class=precio>" {'print $2'} | awk -F "</a>" {'print $1'} | tr -d '.' | tr -d '\n' | awk {'print $1'})
  echo "${PRICE}"
  #echo "======================================"
}

function clean_model()
{
    MODEL="${1}"
    echo "${MODEL}" | sed -e 's/[Bb]icicleta//g' | sed -e 's/[Tt]riciclo//g' | sed -e 's/Bici sin pedales//g' | tr "'" '"'
}

function dump_bike_from_urls()
{
  URLS="$1"
  FILE="$2"
  #echo "URLS:=>${URLS}<="
  echo "${URLS}" | while read URL;
  do
    TRADEMARK_MODEL=$(print_model "${URL}" "${FILE}" | sed -e s/"BICICLETA "//g)
    TRADEMARK_MODEL_CLEAN=$(clean_model "${TRADEMARK_MODEL}")
    TRADEMARK=$(echo ${TRADEMARK_MODEL_CLEAN} | awk {'print $1'})
    MODEL=$(echo ${TRADEMARK_MODEL_CLEAN} | awk {'for(i=2;i<=NF;++i){printf $i; if(i<NF){printf " "}}'} | tr -d '\r')
    PRICE=$(print_price "${URL}" "${FILE}")
    ### SOME URLs, that contain %, are not well parsed by awk. We insert an additional % char
    NOBASE_URL=$(echo ${URL} | tr -d '"' | sed s-%-%%-g)
    FINAL_URL="${URL_BASE}/${NOBASE_URL}"
    #echo "========================================================================"
    #echo "TRADEMARK_MODEL=${TRADEMARK_MODEL}"
    #echo "TRADEMARK=${TRADEMARK}"
    #echo "MODEL=${MODEL}"
    #echo "URL=${FINAL_URL}"
    #echo "PRICE=${PRICE}"
    #echo "FILE=${FILE}"
    #echo "========================================================================"
    TRADEMARK_CAMEL=$(camel "${TRADEMARK}" 0)
    MODEL_CAMEL=$(camel "${MODEL}" ${NO_CAMEL_MIN})
    dump_bike "${MODEL_CAMEL}" "${FINAL_URL}" "${TRADEMARK_CAMEL}" "${PRICE}" "${STORE}" "${TYPE}"
  done
}

function process_page()
{
  BASE_FILE="$1"
  STORE="$2"
  TYPE="$3"
  #echo "BASE_FILE=${BASE_FILE}"
  #echo "STORE=${STORE}"
  #echo "TYPE=${TYPE}"

  cat ${BASE_FILE} | sed -e 's/<h3/\n<h3/g' | sed -e 's@/h3>@/h3>\n@g' |\
grep '<h3>' | grep 'a href'|\
grep -vi Bolsa | grep -vi Casco | grep -vi Soporte | grep -vi Cubierta |\
grep -vi Elevador | grep -vi Rodillo | grep -v Transporte |\
while read HTML_LINE;
  do
    TRADEMARK_MODEL=$(echo ${HTML_LINE} | sed -e 's/<[^>]*>//g' | tr -d '\n' | tr -d '\r')
    TRADEMARK_MODEL_CLEAN=$(bubic_clean "${TRADEMARK_MODEL}")
    TRADEMARK=$(echo "${TRADEMARK_MODEL_CLEAN}" | awk {'print $1'})
    MODEL=$(echo ${TRADEMARK_MODEL_CLEAN} | awk {'for(i=2;i<=NF;++i){printf $i; if(i<NF){printf " "}}'})
    MODEL_CAMEL=$(bubic_camel "${MODEL}" ${NO_CAMEL_MIN})
    TRADEMARK_CAMEL=$(bubic_camel "${TRADEMARK}" ${NO_CAMEL_MIN})
    URL=$(echo "${HTML_LINE}" | awk -F "a href=" {'print $2'} | awk {'print $1'} | tr -d ' ')
    PRICE=$(cat "${BASE_FILE}" | grep ">$TRADEMARK_MODEL<" -A10 |\
grep '<span class="price"' | sed -e 's/<[^>]*>//g' |\
sed -e 's/^[ \t]*//g' | tr -d ' ' | egrep -E -o "[0-9]{2,5},{1}[0-9]{2}" | head -1)
    #echo "========================================================================"
    #echo "BASE_FILE=${BASE_FILE}"
    #echo "HTML_LINE=${HTML_LINE}"
    #echo "TRADEMARK_MODEL=${TRADEMARK_MODEL}"
    #echo "TRADEMARK_MODEL_CLEAN=${TRADEMARK_MODEL_CLEAN}"
    #echo "TRADEMARK_CAMEL=${TRADEMARK_CAMEL}"
    #echo "MODEL_CAMEL=${MODEL_CAMEL}"
    #echo "URL=${URL}"
    #echo "PRICE=${PRICE}"
    #echo "========================================================================"
    bubic_dump_bike "${MODEL_CAMEL}" "${URL}" "${TRADEMARK_CAMEL}" "${PRICE}" "${STORE}" "${TYPE}"
  done
}

function process_pages()
{
  IFILE="$1"
  INPAGES="$2"
  STORE="$3"
  TYPE="$4"
  #echo "**************************"
  #echo "BASE_FILE=$1"
  #echo "PAGES=$2"
  #echo "STORE=$3"
  #echo "TYPE=$4"
  #echo "**************************"

  if [ "${INPAGES}" = "" ];
  then
      process_page "${IFILE}" "${STORE}" "${TYPE}"
  else
    for page in ${INPAGES};
    do
      FILE="${IFILE}-${page}"
      process_page "${FILE}" "${STORE}" "${TYPE}"
    done
  fi
}

> ${OUTPUT_FILE}

MTB_26_BIKES_BASE="mtb-26"
MTB_26_BIKES_PAGES="$(seq 1 3)"
process_pages "${MTB_26_BIKES_BASE}" "${MTB_26_BIKES_PAGES}" "BikeStocks" "MTB" >> ${OUTPUT_FILE}

MTB_27_BIKES_BASE="mtb-27"
MTB_27_BIKES_PAGES="$(seq 1 9)"
process_pages "${MTB_27_BIKES_BASE}" "${MTB_27_BIKES_PAGES}" "BikeStocks" "MTB" >> ${OUTPUT_FILE}

MTB_29_BIKES_BASE="mtb-29"
MTB_29_BIKES_PAGES="$(seq 1 7)"
process_pages "${MTB_29_BIKES_BASE}" "${MTB_29_BIKES_PAGES}" "BikeStocks" "MTB-29" >> ${OUTPUT_FILE}

ROAD_TRIATLON_BIKES_BASE="road-triatlon"
ROAD_TRIATLON_BIKES_PAGES="$(seq 1 2)"

process_pages "${ROAD_TRIATLON_BIKES_BASE}" "${ROAD_TRIATLON_BIKES_PAGES}" "BikeStocks" "ROAD-TRIATLON" >> ${OUTPUT_FILE}

ROAD_BIKES_BASE="road"
ROAD_BIKES_PAGES="$(seq 1 6)"
process_pages "${ROAD_BIKES_BASE}" "${ROAD_BIKES_PAGES}" "BikeStocks" "ROAD" >> ${OUTPUT_FILE}

URBAN_ELECTRIC_BIKES_BASE="urban-electric"
URBAN_ELECTRIC_BIKES_PAGES="$(seq 1 3)"

process_pages "${URBAN_ELECTRIC_BIKES_BASE}" "${URBAN_ELECTRIC_BIKES_PAGES}" "BikeStocks" "URBAN-ELECTRIC" >> ${OUTPUT_FILE}

BMX_BIKES_BASE="bmx"
BMX_BIKES_PAGES="$(seq 1 2)"

process_pages "${BMX_BIKES_BASE}" "${BMX_BIKES_PAGES}" "BikeStocks" "BMX" >> ${OUTPUT_FILE}

URBAN_WALK_BIKES_BASE="urban-walk"
URBAN_WALK_BIKES_PAGES="$(seq 1 4)"

process_pages "${URBAN_WALK_BIKES_BASE}" "${URBAN_WALK_BIKES_PAGES}" "BikeStocks" "URBAN" >> ${OUTPUT_FILE}

URBAN_TREKKING_BIKES_BASE="urban-trekking"
URBAN_TREKKING_BIKES_PAGES="$(seq 1 3)"

process_pages "${URBAN_TREKKING_BIKES_BASE}" "${URBAN_TREKKING_BIKES_PAGES}" "BikeStocks" "URBAN-TREKKING" >> ${OUTPUT_FILE}

URBAN_FOLDING_BIKES_BASE="urban-folding"
URBAN_FOLDING_BIKES_PAGES="$(seq 1 3)"

process_pages "${URBAN_FOLDING_BIKES_BASE}" "${URBAN_FOLDING_BIKES_PAGES}" "BikeStocks" "URBAN-FOLDING" >> ${OUTPUT_FILE}

MTB_WOMAN_BIKES_BASE="mtb-woman"
MTB_WOMAN_BIKES_PAGES="$(seq 1 2)"

process_pages "${MTB_WOMAN_BIKES_BASE}" "${MTB_WOMAN_BIKES_PAGES}" "BikeStocks" "MTB-WOMAN" >> ${OUTPUT_FILE}

KIDS_BIKES_BASE="kids"
KIDS_BIKES_PAGES="$(seq 1 3)"

process_pages "${KIDS_BIKES_BASE}" "${KIDS_BIKES_PAGES}" "BikeStocks" "KIDS" >> ${OUTPUT_FILE}

