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
BASE_URL="http://www.karacol.es"
NO_CAMEL_MODEL_MIN=0
NO_CAMEL_TRADEMARK_MIN=0
MAX_PRICE_SEARCH=10
URL="www.karacol.es"
ONLY_DOMAIN="karacol.es"
EXCLUDE="-Rgif -Rpng -Rjpg"

#### KEYS GENERATED
TRADEMARK_KEY="TRADEMARK"
SUBURL_KEY="SUBURL"
STORE_KEY="STORE"
PRICE_KEY="PRICE"
KIND_KEY="KIND"

#### LOAD COMMON FUNCTIONS
. ./common_proc

function process_file()
{
  BASE_FILE="$1"
  STORE="$2"
  TYPE="$3"
  cat "${BASE_FILE}" | grep '<h3><a href' | grep 'class="name"' | while read HTML_LINE
  do
    TRADEMARK_MODEL=$(echo "${HTML_LINE}" | sed -e 's@<[^>]*>@@g')
    TRADEMARK_MODEL_CLEAN=$(bubic_clean "${TRADEMARK_MODEL}")
    TRADEMARK=$(echo ${TRADEMARK_MODEL_CLEAN} | awk {'print $1'})
    MODEL=$(echo ${TRADEMARK_MODEL_CLEAN} | awk {'for(i=2;i<=NF;++i){printf $i; if(i<NF){printf " "}}'})
    TRADEMARK_CAMEL=$(bubic_camel "${TRADEMARK}" ${NO_CAMEL_TRADEMARK_MIN})
    URL=$(echo ${HTML_LINE} | awk -F 'href=' {'print $2'} | awk {'print $1'})
    MODEL_CAMEL=$(bubic_camel "${MODEL}" ${NO_CAMEL_MODEL_MIN})
    PRICE=$(grep "${TRADEMARK_MODEL}" "${BASE_FILE}" -A${MAX_PRICE_SEARCH} | grep '<p class="price">' | sed -e 's@<@\n<@g' | egrep -E -o "[0-9]{0,2}.{0,1}[0-9]{2,3},{0,1}[0-9]{2}" | tr -d '.' | head -1)
    # Attempt to look for price with URL
    if [ "${PRICE}" = "" ];
    then
      PRICE=$(grep "${URL}" "${BASE_FILE}" -A${MAX_PRICE_SEARCH} | grep '<p class="price">' | sed -e 's@<[^>]*>@@g' | egrep -E -o "[0-9]{0,2}.{0,1}[0-9]{2,3},{0,1}[0-9]{2}" | tr -d '.');
    fi
    if [ "${PRICE}" = "" ];
    then
      URL_NO_DASH=$(echo "${URL}" | awk -F "´" {'print $1'})
      PRICE=$(grep "${URL_NO_DASH}" "${BASE_FILE}" -A${MAX_PRICE_SEARCH} | grep '<p class="price">' | sed -e 's@<[^>]*>@@g' | egrep -E -o "[0-9]{0,2}.{0,1}[0-9]{2,3},{0,1}[0-9]{2}" | tr -d '.');
    fi
    if [ "${PRICE}" = "" ];
    then
      URL_NO_DASH=$(echo "${URL}" | awk -F "´" {'print $1'})
      PRICE=$(grep "${URL_NO_DASH}" "${BASE_FILE}" -A${MAX_PRICE_SEARCH} | grep '<span class="xprecio' | sed -e 's@<[^>]*>@@g' | egrep -E -o "[0-9]{0,2}.{0,1}[0-9]{2,3},{0,1}[0-9]{2}" | tr -d '.' | tail -1);
    fi
    #echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
    #echo "LINE:${HTML_LINE}"
    #echo "TRADEMARK_MODEL:${TRADEMARK_MODEL}"
    #echo "TRADEMARK:=>${TRADEMARK}<="
    #echo "TRADEMARK_CAMEL:=>${TRADEMARK_CAMEL}<="
    #echo "MODEL:=>${MODEL}<="
    #echo "MODEL_CAMEL:=>${MODEL_CAMEL}<="
    #echo "URL:=>${URL}<="
    #echo "URL_NO_DASH:=>${URL_NO_DASH}<="
    #echo "PRICE:=>${PRICE}<="
    #echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
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

#### KIDS ####
KIDS_ROAD_BASE="kids-road"
KIDS_ROAD_PAGES="1"

process_pages_raw "${KIDS_ROAD_BASE}" "${KIDS_ROAD_PAGES}" "Karacol" "KIDS" >> ${OUTPUT_FILE}

#### KIDS ####
KIDS_MTB_BASE="kids-mtb"
KIDS_MTB_PAGES="$(seq 1 4)"

process_pages_raw "${KIDS_MTB_BASE}" "${KIDS_MTB_PAGES}" "Karacol" "KIDS" >> ${OUTPUT_FILE}

#### BMX ####
BMX_BASE="bmx"
BMX_PAGES="$(seq 1 3)"

process_pages_raw "${BMX_BASE}" "${BMX_PAGES}" "Karacol" "BMX" >> ${OUTPUT_FILE}

#### ROAD ####
ROAD_BASE="road"
ROAD_PAGES="$(seq 1 8)"

process_pages_raw "${ROAD_BASE}" "${ROAD_PAGES}" "Karacol" "ROAD" >> ${OUTPUT_FILE}

#### URBAN ####
URBAN_BASE="urban"
URBAN_PAGES="$(seq 1 6)"
process_pages_raw "${URBAN_BASE}" "${URBAN_PAGES}" "Karacol" "URBAN" >> ${OUTPUT_FILE}

#### MTB ####
MTB_BASE="mtb"
MTB_PAGES="$(seq 1 10)"
process_pages_raw "${MTB_BASE}" "${MTB_PAGES}" "Karacol" "MTB" >> ${OUTPUT_FILE}

#### MTB DOUBLE ####
MTB_DOUBLE_BASE="mtb-double"
MTB_DOUBLE_PAGES="$(seq 1 7)"
process_pages_raw "${MTB_DOUBLE_BASE}" "${MTB_DOUBLE_PAGES}" "Karacol" "MTB-DOUBLE" >> ${OUTPUT_FILE}

