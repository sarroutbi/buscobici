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
BASE_URL="http://www.bikingpoint.es"
NO_CAMEL_MIN=6
NO_CAMEL_TRADEMARK_MIN=0
MAX_PRICE_SEARCH=35
URL="www.bikingpoint.es"
ONLY_DOMAIN="bikingpoint.es"
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
  cat "${BASE_FILE}" | grep '<h2 class="product-name product-name-height">' | tr -d '\r' | while read model;
  do
    MODEL_TRADEMARK=$(echo ${model} | sed -e 's/<[^>]*>//g')
    MODEL_TRADEMARK_CLEAN=$(bubic_clean "${MODEL_TRADEMARK}" | sed -e 's/^ //g')
    TRADEMARK=$(echo ${MODEL_TRADEMARK_CLEAN} | awk {'print $1'})
    MODEL=$(echo ${MODEL_TRADEMARK_CLEAN} | awk {'for(i=2;i<=NF;++i){printf $i; if(i<NF){printf " "}}'})
    SUBURL=$(echo ${model} | awk -F "<a href=" {'print $2'} | awk {'print $1'} | tr -d '"' | tr -d '\n' | tr -d '\r')
    URL="\"${SUBURL}\""
    MODEL_CAMEL=$(bubic_camel "${MODEL}")
    TRADEMARK_CAMEL=$(bubic_camel "${TRADEMARK}")
    PRICE=$(grep "${MODEL_TRADEMARK}" "${BASE_FILE}" -C20 | grep '€' | sed -e 's/^ //g' | tr -d '€' | tr -d '.' | tr -d ' ' | sed -e 's/<[^>]*>//g' | tail -1 | egrep -E -o "[0-9]{2,5},[0-9]{0,2}")
    #echo "FILE:${BASE_FILE}"
    #echo "model:===>${model}<==="
    #echo "MODEL_TRADEMARK:=>${MODEL_TRADEMARK}<="
    #echo "MODEL_TRADEMARK_CLEAN:=>${MODEL_TRADEMARK_CLEAN}<="
    #echo "MODEL:=>${MODEL}<="
    #echo "TRADEMARK:=>${TRADEMARK}<="
    #echo "PRICE:=>${PRICE}<="
    #echo "URL:=>${URL}<="
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
      FILE="${1}?p=${page}"
      process_file "${FILE}" "${STORE}" "${TYPE}"
    done
  fi
}

> ${OUTPUT_FILE}

#### ROAD ####
ROAD_BIKES_BASE="road"
ROAD_BIKES_PAGES="$(seq 0 3)"

process_pages_raw "${ROAD_BIKES_BASE}" "${ROAD_BIKES_PAGES}" "Biking Point" "ROAD" >> ${OUTPUT_FILE}

#### MTB ####
MTB_DOUBLE_BIKES_BASE="mtb-double"
MTB_DOUBLE_BIKES_PAGES="$(seq 0 3)"
MTB_FIX_BIKES_BASE="mtb-fix"
MTB_FIX_BIKES_PAGES="$(seq 0 7)"
MTB_FREERIDE_BIKES_BASE="mtb-freeride"
MTB_FREERIDE_BIKES_PAGES="$(seq 0 1)"

process_pages_raw "${MTB_DOUBLE_BIKES_BASE}" "${MTB_DOUBLE_BIKES_PAGES}" "Biking Point" "MTB-DOUBLE" >> ${OUTPUT_FILE}
process_pages_raw "${MTB_FREERIDE_BIKES_BASE}" "${MTB_FREERIDE_BIKES_PAGES}" "Biking Point" "MTB-DOUBLE" >> ${OUTPUT_FILE}
process_pages_raw "${MTB_FIX_BIKES_BASE}" "${MTB_FIX_BIKES_PAGES}" "Biking Point" "MTB-FIX" >> ${OUTPUT_FILE}

#### URBAN ####
URBAN_ELECTRIC_BIKES_BASE="urban-electric"
URBAN_ELECTRIC_BIKES_PAGES="$(seq 0 1)"

URBAN_TREKKING_BIKES_BASE="urban-trekking"
URBAN_TREKKING_BIKES_PAGES="$(seq 0 2)"

URBAN_FOLDING_BIKES_BASE="urban-folding"
URBAN_FOLDING_BIKES_PAGES="$(seq 0 2)"

process_pages_raw "${URBAN_ELECTRIC_BIKES_BASE}" "${URBAN_ELECTRIC_BIKES_PAGES}" "Biking Point" "URBAN-ELECTRIC" >> ${OUTPUT_FILE}
process_pages_raw "${URBAN_TREKKING_BIKES_BASE}" "${URBAN_TREKKING_BIKES_PAGES}" "Biking Point" "URBAN-TREKKING" >> ${OUTPUT_FILE}
process_pages_raw "${URBAN_FOLDING_BIKES_BASE}" "${URBAN_FOLDING_BIKES_PAGES}" "Biking Point" "URBAN-FOLDING" >> ${OUTPUT_FILE}

#### BMX ####
BMX_BIKES_BASE="bmx"
BMX_BIKES_PAGES="$(seq 0 1)"

process_pages_raw "${BMX_BIKES_BASE}" "${BMX_BIKES_PAGES}" "Biking Point" "BMX" >> ${OUTPUT_FILE}

#### KIDS ####
KIDS_BIKES_BASE="kids"
KIDS_BIKES_PAGES="$(seq 0 3)"

process_pages_raw "${KIDS_BIKES_BASE}" "${KIDS_BIKES_PAGES}" "Biking Point" "KIDS" >> ${OUTPUT_FILE}
