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
# SUBURL="http://www.bicicletasgil.com/producto/Orbea-Grow-2"
# TRADEMARK=Orbea
# PRICE=249,00
# STORE=Biciletas Gil
# KIND=MTB-FIX

MAX_PRICE=2
OUTPUT_FILE=./output
MAX_TRIES=10
MAX_TIMEOUT=5

#### KEYS GENERATED
TRADEMARK_KEY="TRADEMARK"
SUBURL_KEY="SUBURL"
STORE_KEY="STORE"
PRICE_KEY="PRICE"
KIND_KEY="KIND"

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
  #if [[ "$1" != "" ]] && [[ "$2" != "" ]] && [[ "$3" != ""]]; 
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
function print_model()
{
  #echo "======================================"
  #  echo "======> URL:${1} <========="
  MODELS=$(wget --tries=${MAX_TRIES} --timeout=${MAX_TIMEOUT} -O - "$1" 2>&1 | grep "<title>" -A3 | sed -e 's/<[^>]*>//g' | grep "[A-Z,a-z,0-9]" | head -1 | awk -F " - " {'print $NF'} | tr -d "\n" | sed s-" [Nn]i.a "-" Niña "-g | sed s-" [Nn]i.o "-" Niño "-g)
  echo "${MODELS}" | while read model;
  do
    MODEL="${model}"
    echo ${MODEL}
  done
  #echo "======================================"
}

# Params:
# 1 - The URL of bike
function print_price()
{
  PRICE=$(wget --tries=${MAX_TRIES} --timeout=${MAX_TIMEOUT} "$1" -O - 2>&1 | grep -i "$2" -A25 | grep IVA | grep -o "[0-9,\.]*[0-9],[0-9]*" | tr -d '.' | tail -1)
  echo ${PRICE}
}

function process_pages()
{
  BASE_URL="$1"
  PAGES="$2"
  STORE="$3"
  TYPE="$4"
  if [ "${PAGES}" = "" ];
  then
    MODELS=$(cat "${BASE_URL}" | grep href | grep "productListing-data" | awk -F "<b>" {'print $2'} | awk -F "</b>" {'print $1'})
    echo "${MODELS}" | while read model;
    do
      #echo "============>${MODEL}<==========="
      MODEL=$(echo "${model}" | awk {'for(i=2;i<=NF;++i){printf $i; if(i<NF){printf " "}}'} | tr -d '\r')
      TRADEMARK=$(echo "${model}" | awk {'print $1'})
      URL=$(grep "${model}" "${BASE_URL}" | grep -o "<a href=[^>]*>" | sed -e 's/<a href=//g' | tr -d '>' | awk -F "?" {'print $1'} | head -1 | uniq)
      PRICE=$(print_price "${URL}")
      dump_bike "${MODEL}" "${URL}" "${TRADEMARK}" "${PRICE}" "${STORE}" "${TYPE}"
    done
  else
    for page in ${PAGES};
    do
      MODELS=$(cat "${BASE_URL}${page}" | grep href | grep "productListing-data" | awk -F "<b>" {'print $2'} | awk -F "</b>" {'print $1'})
      echo "${MODELS}" | while read model
      do
        MODEL=$(echo "${model}" | awk {'for(i=2;i<=NF;++i){printf $i; if(i<NF){printf " "}}'} | tr -d '\r')
        TRADEMARK=$(echo "${model}" | awk {'print $1'})
        URL=$(grep "${model}" "${BASE_URL}${page}" | grep -o "<a href=[^>]*>" | sed -e 's/<a href=//g' | tr -d '>' | awk -F "?" {'print $1'} | head -1 | uniq)
        PRICE=$(print_price2 "${MODEL}")
        dump_bike "${MODEL}" "${URL}" "${TRADEMARK}" "${PRICE}" "${STORE}" "${TYPE}"
      done
    done 
  fi
}

function process_pages2()
{
  BASE_FILE="$1"
  PAGES="$2"
  STORE="$3"
  TYPE="$4"
  if [ "${PAGES}" = "" ];
  then
      LINES=$(cat ${BASE_FILE} | sed -e 's@<a class="product-name"@\n<a class="product-name"@g' | sed -e 's@</div>@</div>\n@g' | grep ^'<a class')
      echo "${LINES}" | while read line;
      do
        TRADEMARK_MODEL=$(echo "${line}" | awk -F "</h5>" {'print $1'} | sed -e 's@<[^>]*>@@g')
        TRADEMARK=$(echo ${TRADEMARK_MODEL} | awk {'print $1'})
        TRADEMARK_CAMEL=$(bubic_camel "${TRADEMARK}")
        MODEL=$(echo ${TRADEMARK_MODEL} | awk {'for(i=2;i<=NF;++i){printf $i; if(i<NF){printf " "}}'} | tr -d '\r')
        MODEL_CAMEL=$(bubic_camel "${MODEL}")
        PRICE=$(echo "${line}" | egrep -E -o "[0-9]{0,1} {0,1}[0-9]{2,3},{1}[0-9]{2}" | tr -d ' ')
        FINAL_URL=$(echo "${line}" | awk -F "href=" {'print $2'} | awk {'print $1'} | tr -d '"')
        #echo "========================"
        #echo "LINE:$line"
        #echo "TRADEMARK:$TRADEMARK"
        #echo "MODEL:$MODEL"
        #echo "URL:$FINAL_URL"
        #echo "PRICE:$PRICE"
        #echo "========================"
        dump_bike "${MODEL_CAMEL}" "${FINAL_URL}" "${TRADEMARK_CAMEL}" "${PRICE}" "${STORE}" "${TYPE}"
      done
  else
    for page in ${PAGES};
    do 
      LINES=$(cat ${BASE_FILE}${page} | sed -e 's@<a class="product-name"@\n<a class="product-name"@g' | sed -e 's@</div>@</div>\n@g' | grep ^'<a class')
      echo "${LINES}" | while read line;
      do
        TRADEMARK_MODEL=$(echo "${line}" | awk -F "</h5>" {'print $1'} | sed -e 's@<[^>]*>@@g')
        TRADEMARK=$(echo ${TRADEMARK_MODEL} | awk {'print $1'})
        TRADEMARK_CAMEL=$(bubic_camel "${TRADEMARK}")
        MODEL=$(echo ${TRADEMARK_MODEL} | awk {'for(i=2;i<=NF;++i){printf $i; if(i<NF){printf " "}}'} | tr -d '\r')
        MODEL_CAMEL=$(bubic_camel "${MODEL}")
        PRICE=$(echo "${line}" | egrep -E -o "[0-9]{0,1} {0,1}[0-9]{2,3},{1}[0-9]{2}" | tr -d ' ')
        FINAL_URL=$(echo "${line}" | awk -F "href=" {'print $2'} | awk {'print $1'} | tr -d '"')
        #echo "========================"
        #echo "LINE:$line"
        #echo "TRADEMARK:$TRADEMARK"
        #echo "MODEL:$MODEL"
        #echo "URL:$FINAL_URL"
        #echo "PRICE:$PRICE"
        #echo "========================"
        dump_bike "${MODEL_CAMEL}" "${FINAL_URL}" "${TRADEMARK_CAMEL}" "${PRICE}" "${STORE}" "${TYPE}"
      done
    done
  fi
}

FIX_BIKES_BASE="4-montana-rigidas?p="
FIX_BIKES_PAGES=$(seq 1 5)

DOUBLE_BIKES_BASE="169-montana-doble-suspension-todas?p="
DOUBLE_BIKES_PAGES=$(seq 1 5)

MTB_WOMAN_BIKES_BASE="170-montana-de-mujer?p="
MTB_WOMAN_BIKES_PAGES=$(seq 1 3)

ROAD_BIKES_BASE="26-carretera?p="
ROAD_BIKES_PAGES=$(seq 1 6)

BMX_BIKES_BASE="11-bmx-campillo"

CHILDREN_BIKES_BASE="16-ninos?p="
CHILDREN_BIKES_PAGES=$(seq 1 3)

URBAN_BIKES_BASE="7-urbanas?p="
URBAN_BIKES_PAGES=$(seq 1 4)

URBAN_ELECTRIC_BIKES_BASE="23-urbanas"
URBAN_ELECTRIC_BIKES_PAGES=""

MTB_ELECTRIC_BIKES_BASE="38-montana"
MTB_ELECTRIC_BIKES_PAGES=""

> ${OUTPUT_FILE}

process_pages2 "${FIX_BIKES_BASE}" "${FIX_BIKES_PAGES}" "Bicimania" "MTB-FIX" >> ${OUTPUT_FILE}
process_pages2 "${DOUBLE_BIKES_BASE}" "${DOUBLE_BIKES_PAGES}" "Bicimania" "MTB-DOUBLE" >> ${OUTPUT_FILE}
process_pages2 "${ROAD_BIKES_BASE}" "${ROAD_BIKES_PAGES}" "Bicimania" "ROAD"  >> ${OUTPUT_FILE}
process_pages2 "${BMX_BIKES_BASE}" "" "Bicimania" "BMX"  >> ${OUTPUT_FILE}
process_pages2 "${CHILDREN_BIKES_BASE}" "${CHILDREN_BIKES_PAGES}" "Bicimania" "KIDS"  >> ${OUTPUT_FILE}
process_pages2 "${URBAN_BIKES_BASE}" "${URBAN_BIKES_PAGES}" "Bicimania" "URBAN"  >> ${OUTPUT_FILE}
process_pages2 "${URBAN_ELECTRIC_BIKES_BASE}" "${URBAN_ELECTRIC_BIKES_PAGES}" "Bicimania" "URBAN-ELECTRIC" >> ${OUTPUT_FILE}
process_pages2 "${MTB_ELECTRIC_BIKES_BASE}" "${MTB_ELECTRIC_BIKES_PAGES}" "Bicimania" "MTB-ELECTRIC" >> ${OUTPUT_FILE}
