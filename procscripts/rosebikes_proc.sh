#!/bin/bash
#
# Copyright © 2012-2014 Sergio Arroutbi Braojos <sarroutbi@gmail.com>
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
BASE_URL="http://www.rosebikes.es"
NO_CAMEL_MODEL_MIN=0
NO_CAMEL_TRADEMARK_MIN=0
MAX_PRICE_SEARCH=10
URL="www.rosebikes.es"
ONLY_DOMAIN="mhw-bike.es"
EXCLUDE="-Rgif -Rpng -Rjpg"

#### KEYS GENERATED
TRADEMARK_KEY="TRADEMARK"
SUBURL_KEY="SUBURL"
STORE_KEY="STORE"
PRICE_KEY="PRICE"
KIND_KEY="KIND"

#### LOAD COMMON FUNCTIONS
. ./common_proc

function print_price_with_url()
{
  URL=$(echo "${1}" | tr -d '"')
  wget "${URL}" -O - 2>/dev/null | grep 'div id="product_price"' | sed -e 's/<[^>]*>//g' | egrep -E -o "[0-9]{0,2}.{0,1}[0-9]{2,3},{0,1}[0-9]{0,2}" | tr -d '.' | tr -d " " | tr -d ' '
}

function process_file()
{
  BASE_FILE="$1"
  STORE="$2"
  TYPE="$3"
  cat "${BASE_FILE}" | grep 'class="products-details-content-title-title"' -A3 | sed -e 's/<[^>]*>//g' | grep [A-Z,a-z] | while read line;
  do
    TRADEMARK_MODEL=$(echo ${line})
    TRADEMARK_MODEL_CLEAN=$(bubic_clean "${TRADEMARK_MODEL}")
    TRADEMARK=$(echo ${TRADEMARK_MODEL_CLEAN} | awk {'print $1'})
    MODEL=$(echo ${TRADEMARK_MODEL_CLEAN} | awk {'for(i=2;i<=NF;++i){printf $i; if(i<NF){printf " "}}'} | tr -d '\n' | tr -d '\r')
    TRADEMARK_CAMEL=$(bubic_camel "${TRADEMARK}" ${NO_CAMEL_TRADEMARK_MIN})
    MODEL_CAMEL=$(bubic_camel "${MODEL}" ${NO_CAMEL_MODEL_MIN})
    MODEL_GREP=$(echo "${MODEL}" | tr '"' '.' | tr ',' '.' | tr "'" "." | sed -e 's/\.\.\.//g' | sed -e 's/ $//g')
    SUBURL=$(grep -i "${MODEL_GREP}" "${BASE_FILE}" -B5 | grep 'a href' | awk -F '<a href=' {'print $2'} | awk {'print $1'} | tail -1 | tr -d '"' | tr -d '\n' | tr -d '\r' | tr -d '>')
    URL="\"${BASE_URL}${SUBURL}\""
    PRICE=$(print_price_with_url "${URL}" | tr -d ' ' | egrep -E -o "[0-9]{2,5},{0,1}[0-9]{0,2}")
    #echo "LINE:${line}"
    #echo "TRADEMARK_MODEL:${TRADEMARK_MODEL}"
    #echo "TRADEMARK:=>${TRADEMARK}<="
    #echo "TRADEMARK_CAMEL:=>${TRADEMARK_CAMEL}<="
    #echo "MODEL:=>${MODEL}<="
    #echo "MODEL_GREP:=>${MODEL_GREP}<="
    #echo "MODEL_CAMEL:=>${MODEL_CAMEL}<="
    #echo "SUBURL:=>${SUBURL}<="
    #echo "URL:=>${URL}<="
    #echo "PRICE:=>${PRICE}<="
    #echo
    bubic_dump_bike "${MODEL_CAMEL}" "${URL}" "${TRADEMARK_CAMEL}" "${PRICE}" "${STORE}" "${TYPE}"
  done
}

function process_pages_raw()
{
  BASE_FILE="$1"
  PAGES="$2"
  STORE="$3"
  TYPE="$4"

  if [ "${PAGES}" = "" ];
  then
    FILE=${1}
    process_file "${BASE_FILE}" "${STORE}" "${TYPE}"
  else
    for page in ${PAGES};
    do
      FILE="${1}-${page}"
      process_file "${FILE}" "${STORE}" "${TYPE}"
    done
  fi
}

> ${OUTPUT_FILE}

#### ROAD ####
ROAD_BASE="road"
ROAD_PAGES="$(seq 1 3)"

process_pages_raw "${ROAD_BASE}" "${ROAD_PAGES}" "RoseBikes" "ROAD" >> ${OUTPUT_FILE}

#### MTB ####
MTB_BASE="mtb"
MTB_PAGES="$(seq 1 2)"

process_pages_raw "${MTB_BASE}" "${MTB_PAGES}" "RoseBikes" "MTB" >> ${OUTPUT_FILE}

#### FITNESS ####
FITNESS_BASE="fitness"
FITNESS_PAGES="$(seq 1 2)"

process_pages_raw "${FITNESS_BASE}" "${FITNESS_PAGES}" "RoseBikes" "URBAN-FITNESS" >> ${OUTPUT_FILE}

#### URBAN ####
URBAN_BASE="urban"
URBAN_PAGES="$(seq 1 2)"

process_pages_raw "${URBAN_BASE}" "${URBAN_PAGES}" "RoseBikes" "URBAN" >> ${OUTPUT_FILE}
