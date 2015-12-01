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

MAX_PRICE=10
NO_CAMEL_MIN=6
NO_CAMEL_TRADEMARK_MIN=0
OUTPUT_FILE=./output
#OUTPUT_FILE=/dev/stdout

. ./common_proc

#### KEYS GENERATED
TRADEMARK_KEY="TRADEMARK"
SUBURL_KEY="SUBURL"
STORE_KEY="STORE"
PRICE_KEY="PRICE"
KIND_KEY="KIND"

# Params:
# 1 - The URL of bike
function print_price()
{
  URL=$(echo $1 | tr -d '"')
  PRICE=$(wget -O - ${URL} -o /dev/null | grep IVA | egrep -E -o "[0-9]{0,1}[\ ]{0,1}[0-9]{3},{1}[0-9]{2}"| tr -d " ")
  echo ${PRICE} | awk {'print $1'}
}

# Params:
# 1 - The model
# 2 - The base file
function print_price_from_model()
{
  MODEL="$1"
  BASE_FILE="$2"
  PRICE=$(grep "${MODEL}" "${BASE_FILE}" -A${MAX_PRICE} | grep '<span class="price' | head -1 | sed -e 's-<[^>]*>--g' | egrep -E -o "[0-9]{0,2}.{0,1}[0-9]{3},{1}[0-9]{2}" | tr -d ' ')
  echo ${PRICE}
}

function print_url()
{
  model="$1"
  BASE_FILE="$2"
  URL_LINE=$(egrep -E -o "<[^>]*>${model}" ${BASE_FILE})
  URL=$(echo ${URL_LINE} | awk -F "href=" {'print $2'} | awk {'print $1'} | tr -d '"')
  echo "${URL}"
}

function process_page_file()
{
  BASE_FILE="$1"
  STORE="$2"
  TYPE="$3"
  MODEL_LINES=$(cat "${BASE_FILE}" | grep '<h3 class="title"' | sed -e 's-<[^>]*>--g')
  echo "${MODEL_LINES}" | while read model_line;
  do
    model=$(echo ${model_line} | awk -F "</h3>" {'print $1'} | sed -e 's-<[^>]*>--g' | egrep -E "[A-Z]{2,}"  | tr -d '\n' | tr -d '\r')
    MODEL_FILTER=$(bubic_clean "${model}")
    MODEL=$(echo "${MODEL_FILTER}" | awk {'for(i=2;i<=NF;++i){printf $i; if(i<NF){printf " "}}'} | tr -d '\r')
    TRADEMARK=$(echo "${MODEL_FILTER}" | awk {'print $1'})
    MODEL_CAMEL=$(bubic_camel "${MODEL}" ${NO_CAMEL_MIN})
    TRADEMARK_CAMEL=$(bubic_camel "${TRADEMARK}" ${NO_CAMEL_TRADEMARK_MIN})
    URL=$(print_url "${model}" "${BASE_FILE}")
    PRICE=$(print_price_from_model "${model}" "${BASE_FILE}")
    #echo "========================================================================"
    #echo "TRADEMARK=${TRADEMARK_CAMEL}"
    #echo "MODEL=>${MODEL_CAMEL}<="
    #echo "URL=${URL}"
    #echo "PRICE=${PRICE}"
    #echo "STORE=${STORE}"
    #echo "TYPE=${TYPE}"
    #echo "FILE=${BASE_FILE}"
    #echo "SEARCH_MODEL=>${model}<="
    #echo "========================================================================"
    bubic_dump_bike "${MODEL_CAMEL}" "${URL}" "${TRADEMARK_CAMEL}" "${PRICE}" "${STORE}" "${TYPE}"
  done
}

function process_pages()
{
  FILE="$1"
  PAGES="$2"
  STORE="$3"
  TYPE="$4"
  if [ "${PAGES}" = "" ];
  then
    process_page_file "${FILE}" "${STORE}" "${TYPE}"
  else
    for page in ${PAGES};
    do
      process_page_file "${FILE}-${page}" "${STORE}" "${TYPE}"
    done 
  fi
}

ROAD_BIKES_BASE="road"
ROAD_BIKES_PAGES="$(seq 1 7)"

MTB_BIKES_BASE="mtb-fix"
MTB_BIKES_PAGES="$(seq 1 14)"

MTB_DOUBLE_BIKES_BASE="mtb-double"
MTB_DOUBLE_BIKES_PAGES="$(seq 1 6)"

URBAN_BIKES_BASE="urban"
URBAN_BIKES_PAGES=""

KIDS_BIKES_BASE="kids"
KIDS_BIKES_PAGES="$(seq 1 5)"

BMX_BIKES_BASE="bmx"
BMX_BIKES_PAGES=""

> ${OUTPUT_FILE}

process_pages "${ROAD_BIKES_BASE}"  "${ROAD_BIKES_PAGES}"  "Ciclos Nico" "ROAD"  >> ${OUTPUT_FILE}
process_pages "${MTB_BIKES_BASE}"   "${MTB_BIKES_PAGES}"   "Ciclos Nico" "MTB" >> ${OUTPUT_FILE}
process_pages "${MTB_DOUBLE_BIKES_BASE}"  "${MTB_DOUBLE_BIKES_PAGES}"  "Ciclos Nico" "MTB-DOUBLE" >> ${OUTPUT_FILE}
process_pages "${URBAN_BIKES_BASE}" "${URBAN_BIKES_PAGES}" "Ciclos Nico" "URBAN"  >> ${OUTPUT_FILE}
process_pages "${KIDS_BIKES_BASE}"  "${KIDS_BIKES_PAGES}"  "Ciclos Nico" "KIDS"  >> ${OUTPUT_FILE}
#process_pages "${BMX_BIKES_BASE}"   "${BMX_BIKES_PAGES}"   "Ciclos Nico" "BMX"  >> ${OUTPUT_FILE}
