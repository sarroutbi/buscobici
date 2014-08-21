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
BASE_URL="http://www.tomasdomingo.com"
NO_CAMEL_MIN=6
NO_CAMEL_TRADEMARK_MIN=0
MAX_PRICE_SEARCH=35
URL="www.tomasdomingo.com"
ONLY_DOMAIN="tomasdomingo.com"
EXCLUDE="-Rgif -Rpng -Rjpg"

#### KEYS GENERATED
TRADEMARK_KEY="TRADEMARK"
SUBURL_KEY="SUBURL"
STORE_KEY="STORE"
PRICE_KEY="PRICE"
KIND_KEY="KIND"

#### LOAD COMMON FUNCTIONS
. ./common_proc

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
  grep "${URL}" "${FILE}" | sed -e 's/<[^>]*>//g' | sed -e 's/[Bb]icicleta //g' \
| sed -e 's/[Cc]arretera //g' | sed -e 's/[Cc]iclocross //g' | sed -e 's/[Mm]onta.a //g' | sed -e 's/[Tt]rial //g' | sed -e 's/[Tt]rekking//g' | sed -e 's/[Tt]riatl.n//g' | sed -e 's/[Dd]escenso //g' | sed -e 's/[Dd]irt //g' | sed -e 's-dirt/freeride--g' | sed -e 's-dirt/street--g' | sed -e 's/[Dd]oble //g' | sed -e 's/[Ff]reeride //g' | sed -e 's/[Pp]aseo//g' | sed -e 's/[Pp]legable//g' | sed -e 's/[Ii]nfantil //g' | sed -e 's/[Ee]l.ctrica //g' | sed -e 's/[Mm]inibike//g' | sed -e 's/[Ss]uspensi.on //g' | sed -e 's/[Tt]riciclo //g' | sed -e 's/[Ss]tick//g' | sed -e 's/[Ss]uspensi.n //g' | sed -e 's/de //g' | sed -e 's/BTT //g' | sed -e 's/BMX //g' | sed -e 's/TRAIL //g' | sed -e 's/[Ss]ill.n //g' | sed -e 's/[Ee]l.ctrico //g' | sed -e 's/[Ss]ill.n //g' | sed -e 's/[Ss]oporte //g' | sed -e 's/[Cc]erradura + llaves//g' | sed -e 's/[Dd]isplay //g'
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
    let MAX_PRICE_SEARCH=${MAX_PRICE_SEARCH}+5
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
  STORE="$3"
  TYPE="$4"
  #echo "URLS:=>${URLS}<="
  echo "${URLS}" | while read URL;
  do
    TRADEMARK=$(grep ${URL} ${FILE} -B10 | grep Marca: | awk -F "Marca:" {'print $2'} | sed -e 's/<[^>]*>//g' | tr -d '\r')
    TRADEMARK_CAMEL=$(camel "${TRADEMARK}" ${NO_CAMEL_TRADEMARK_MIN})
    MODEL=$(grep ${URL} ${FILE} -B10 | grep Modelo: | awk -F "Modelo:" {'print $2'} | sed -e 's/<[^>]*>//g' | sed -e 's-^ --g' | tr -d '\r')
    MODEL_CAMEL=$(camel "${MODEL}" ${NO_CAMEL_MIN})
    PRICE=$(grep ${URL} ${FILE} -B10 | grep Precio | egrep -o -E "[0-9]{1,}.{0,}[0-9]{0,}"  | awk -F "&" {'print $1'} | tr "." "," | tail -1)
    FINAL_URL=$(echo \""${BASE_URL}"/"${URL}"\")
    #echo "========================================================================"
    #echo "TRADEMARK=${TRADEMARK_CAMEL}"
    #echo "MODEL=>${MODEL_CAMEL}<="
    #echo "URL=${FINAL_URL}"
    #echo "PRICE=${PRICE}"
    #echo "STORE=${STORE}"
    #echo "TYPE=${TYPE}"
    #echo "FILE=${FILE}"
    #echo "========================================================================"
    dump_bike "${MODEL_CAMEL}" "${FINAL_URL}" "${TRADEMARK_CAMEL}" "${PRICE}" "${STORE}" "${TYPE}"
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
    URLS=$(cat "${BASE_FILE}")
    dump_bike_from_urls "${URLS}" "${BASE_FILE}" "${STORE}" "${TYPE}"
  else
    for page in ${PAGES};
    do
      URLS=$(cat "${BASE_FILE}${page}" | grep -i "+ info" | awk -F "a href=" '{print $2}' | awk {'print $1'} | tr -d '"')
      dump_bike_from_urls "${URLS}" "${BASE_FILE}${page}" "${STORE}" "${TYPE}"
    done
  fi
}

function process_pages_raw()
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
    MODELS=$(cat "${BASE_FILE}"| grep 'span class="titol"')
    echo "${MODELS}" | while read MODEL_PRICE;
    do
      PRICE=$(echo "${MODEL_PRICE}" | awk -F '<span class="preu">' '{print $2}' | sed -e 's/<[^>]*>//g' | tr -d '€' | tr -d '.')
      MODEL=$(echo "${MODEL_PRICE}" | awk -F '<span class="preu">' '{print $1}' | sed -e 's/<[^>]*>//g' | tr "'" '"')
      URL=$(grep "${MODEL}" "${BASE_FILE}" -B5 | grep href | awk -F "<a href=" {'print $2'} | awk {'print $1'} | tr -d '"')
      FINAL_URL="\"${BASE_URL}/${URL}\""
      MODEL_CAMEL_UNCLEANED=$(camel "${MODEL}" ${NO_CAMEL_TRADEMARK_MIN})
      MODEL_CAMEL_CLEANED=$(bubic_clean "${MODEL_CAMEL_UNCLEANED}")
      MODEL_CAMEL=$(echo ${MODEL_CAMEL_CLEANED} | awk {'for(i=2;i<=NF;++i){printf $i; if(i<NF){printf " "}}'})
      #MODEL_CAMEL=${MODEL_CAMEL_UNCLEANED}
      TRADEMARK=$(echo ${MODEL_CAMEL_CLEANED} | awk {'print $1'})
      TRADEMARK_CAMEL=$(camel "${TRADEMARK}" ${NO_CAMEL_TRADEMARK_MIN})
      #echo "MODEL_PRICE:${MODEL_PRICE}"
      #echo "MODEL:${MODEL}"
      #echo "MODEL_CAMEL:${MODEL_CAMEL}"
      #echo "PRICE:${PRICE}"
      #echo "URL:${URL}"
      #echo "FINAL_URL:${FINAL_URL}"
      dump_bike "${MODEL_CAMEL}" "${FINAL_URL}" "${TRADEMARK_CAMEL}" "${PRICE}" "${STORE}" "${TYPE}"
    done
  fi
}

> ${OUTPUT_FILE}

ROAD_BIKES_BASE=road
ROAD_BIKES_PAGES=""

ROAD_WOMAN_BIKES_BASE=road-woman
ROAD_WOMAN_BIKES_PAGES=""

URBAN_CONFORT_BIKES_BASE=urban-confort
URBAN_CONFORT_BIKES_PAGES=""

URBAN_CONFORTM_BIKES_BASE=urban-confort-m
URBAN_CONFORTM_BIKES_PAGES=""

URBAN_CONFORT_HYBRID_BASE=urban-confort-hybrid
URBAN_CONFORT_HYBRID_PAGES=""

URBAN_FOLDING_BIKES_BASE=urban-folding
URBAN_FOLDING_BIKES_PAGES=""

MTB_DOUBLE_27_BIKES_BASE=mtb-double-27
MTB_DOUBLE_27_BIKES_PAGES=""

MTB_DOUBLE_29_BIKES_BASE=mtb-double-29
MTB_DOUBLE_29_BIKES_PAGES=""

MTB_FIX_26_BIKES_BASE=mtb-fix-26
MTB_FIX_26_BIKES_PAGES=""

MTB_FIX_27_BIKES_BASE=mtb-fix-27
MTB_FIX_27_BIKES_PAGES=""

MTB_FIX_29_BIKES_BASE=mtb-fix-29
MTB_FIX_29_BIKES_PAGES=""

MTB_FIX_26_WOMAN_BIKES_BASE=mtb-fix-woman-26
MTB_FIX_26_WOMAN_BIKES_PAGES=""

MTB_FIX_27_WOMAN_BIKES_BASE=mtb-fix-woman-27
MTB_FIX_27_WOMAN_BIKES_PAGES=""

MTB_FIX_29_WOMAN_BIKES_BASE=mtb-fix-woman-29
MTB_FIX_29_WOMAN_BIKES_PAGES=""

KIDS_BIKES_BASE=kids
KIDS_BIKES_PAGES=""

process_pages_raw "${ROAD_BIKES_BASE}" "${ROAD_BIKES_PAGES}" "TomasDomingo" "ROAD" >> ${OUTPUT_FILE}
process_pages_raw "${ROAD_WOMAN_BIKES_BASE}" "${ROAD_WOMAN_BIKES_PAGES}" "TomasDomingo" "ROAD-WOMAN" >> ${OUTPUT_FILE}
process_pages_raw "${URBAN_CONFORT_BIKES_BASE}" "${URBAN_CONFORT_BIKES_PAGES}" "TomasDomingo"   "URBAN" >> ${OUTPUT_FILE}
process_pages_raw "${URBAN_CONFORTM_BIKES_BASE}" "${URBAN_CONFORTM_BIKES_PAGES}" "TomasDomingo" "URBAN" >> ${OUTPUT_FILE}
process_pages_raw "${URBAN_CONFORT_HYBRID_BASE}" "${URBAN_CONFORT_HYBRID_PAGES}" "TomasDomingo" "URBAN" >> ${OUTPUT_FILE}
process_pages_raw "${URBAN_FOLDING_BIKES_BASE}" "${URBAN_FOLDING_BIKES_PAGES}" "TomasDomingo"   "URBAN"  >> ${OUTPUT_FILE}
process_pages_raw "${MTB_DOUBLE_27_BIKES_BASE}" "${MTB_DOUBLE_27_BIKES_PAGES}" "TomasDomingo"   "MTB-DOUBLE" >> ${OUTPUT_FILE}
process_pages_raw "${MTB_DOUBLE_29_BIKES_BASE}" "${MTB_DOUBLE_29_BIKES_PAGES}" "TomasDomingo"   "MTB-DOUBLE" >> ${OUTPUT_FILE}
process_pages_raw "${MTB_FIX_26_BIKES_BASE}" "${MTB_FIX_26_BIKES_PAGES}" "TomasDomingo"         "MTB-FIX" >> ${OUTPUT_FILE}
process_pages_raw "${MTB_FIX_27_BIKES_BASE}" "${MTB_FIX_27_BIKES_PAGES}" "TomasDomingo"         "MTB-FIX" >> ${OUTPUT_FILE}
process_pages_raw "${MTB_FIX_29_BIKES_BASE}" "${MTB_FIX_29_BIKES_PAGES}" "TomasDomingo"         "MTB-FIX" >> ${OUTPUT_FILE}
process_pages_raw "${MTB_FIX_26_WOMAN_BIKES_BASE}" "${MTB_FIX_26_WOMAN_BIKES_PAGES}" "TomasDomingo" "MTB-WOMAN" >> ${OUTPUT_FILE}
process_pages_raw "${MTB_FIX_27_WOMAN_BIKES_BASE}" "${MTB_FIX_27_WOMAN_BIKES_PAGES}" "TomasDomingo" "MTB-WOMAN" >> ${OUTPUT_FILE}
process_pages_raw "${MTB_FIX_29_WOMAN_BIKES_BASE}" "${MTB_FIX_29_WOMAN_BIKES_PAGES}" "TomasDomingo" "MTB-WOMAN" >> ${OUTPUT_FILE}
process_pages_raw "${KIDS_BIKES_BASE}" "${KIDS_BIKES_PAGES}" "TomasDomingo" "MTB-WOMAN" >> ${OUTPUT_FILE}
