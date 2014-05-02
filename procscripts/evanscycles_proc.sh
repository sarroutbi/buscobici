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
BASE_URL="http://www.evanscycles.com"
NO_CAMEL_MIN=6
NO_CAMEL_TRADEMARK_MIN=0
MAX_PRICE_SEARCH=35
URL="www.evanscycles.com"
ONLY_DOMAIN="evanscycles.com"
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
  cat "${BASE_FILE}" | grep '<h2 class="product_name">' | sed -e 's@<[^>]*>@@g' | while read model;
  do
    TRADEMARK=$(echo ${model} | awk {'print $1'} | tr -d '\n' | tr -d '\r')
    MODEL=$(echo ${model} | awk {'for(i=2;i<=NF;++i){printf $i; if(i<NF){printf " "}}'})
    if [ "${TRADEMARK}" = "De" ]; then
      TRADEMARK="De Rosa"
    MODEL=$(echo ${model} | awk {'for(i=3;i<=NF;++i){printf $i; if(i<NF){printf " "}}'})
    fi
    PRICE=$(grep "${model}" ${BASE_FILE} -A${MAX_PRICE_SEARCH} | grep 'class="one_product_price">' | sed -e 's@<[^>]*>@@g' | egrep -o -E "[0-9]{2,5}.{0,1}[0-9]{0,2}" | tr "." ",")
    if [ "${PRICE}" = "" ];
    then
        PRICE=$(grep "${model}" ${BASE_FILE} -A${MAX_PRICE_SEARCH} | grep 'class="product_price">' | sed -e 's@<[^>]*>@@g' | egrep -o -E "[0-9]{2,5}.{0,1}[0-9]{0,2}" | tr "." ",")
    fi
    SUBURL=$(grep "${model}" ${BASE_FILE} | grep '<h2 class="product_name">' | awk -F "<a href=" {'print $2'} | awk -F ">" {'print $1'} | tr -d '"' | tr -d '\n' | tr -d '\r')
    URL="\"${SUBURL}\""
    MODEL_CAMEL=$(bubic_camel "${MODEL}")
    TRADEMARK_CAMEL=$(bubic_camel "${TRADEMARK}")
    #echo "FILE:${BASE_FILE}"
    #echo "model:===>${model}<==="
    #echo "MODEL:=>${MODEL}<="
    #echo "TRADEMARK:=>${TRADEMARK}<="
    #echo "PRICE:=>${PRICE}<="
    #echo "OTHER_PRICE:=>${OTHER_PRICE}<="
    #echo "SUBURL:=>${SUBURL}<="
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
      FILE="${1}-${page}"
      process_file "${FILE}" "${STORE}" "${TYPE}"
    done
  fi
}

> ${OUTPUT_FILE}

#### ROAD ####
ROAD_BASE="road"
ROAD_PAGES="$(seq 0 15)"

process_pages_raw "${ROAD_BASE}" "${ROAD_PAGES}" "Evans Cycles" "ROAD" >> ${OUTPUT_FILE}

#### MTB ####
MTB_DOUBLE_BASE="mtb-double"
MTB_DOUBLE_PAGES="$(seq 0 8)"

process_pages_raw "${MTB_DOUBLE_BASE}" "${MTB_DOUBLE_PAGES}" "Evans Cycles" "ROAD" >> ${OUTPUT_FILE}

MTB_FIX_BASE="mtb-fix"
MTB_FIX_PAGES="$(seq 0 10)"

process_pages_raw "${MTB_FIX_BASE}" "${MTB_FIX_PAGES}" "Evans Cycles" "ROAD" >> ${OUTPUT_FILE}

MTB_FIX2_BASE="mtb-fix2"
MTB_FIX2_PAGES=

process_pages_raw "${MTB_FIX2_BASE}" "${MTB_FIX2_PAGES}"  "Evans Cycles" "ROAD" >> ${OUTPUT_FILE}

#### URBAN ####
HYBRID_BASE="hybrid"
HYBRID_PAGES="$(seq 0 15)"

process_pages_raw "${HYBRID_BASE}" "${HYBRID_PAGES}" "Evans Cycles" "URBAN" >> ${OUTPUT_FILE}

FOLDING_BASE="folding"
FOLDING_PAGES=""

process_pages_raw "${FOLDING_BASE}" "${FOLDING_PAGES}" "Evans Cycles" "URBAN" >> ${OUTPUT_FILE}

CYCLOCROSS_BASE="cross"
CYCLOCROSS_PAGES="$(seq 0 3)"

process_pages_raw "${CYCLOCROSS_BASE}" "${CYCLOCROSS_PAGES}" "Evans Cycles" "URBAN" >> ${OUTPUT_FILE}

FIXIE_BASE="fixie"
FIXIE_PAGES=""

process_pages_raw "${FIXIE_BASE}" "${FIXIE_PAGES}" "Evans Cycles" "URBAN" >> ${OUTPUT_FILE}

FIXIE_TRACK_BASE="fixie-track"
FIXIE_TRACK_PAGES=""

process_pages_raw "${FIXIE_TRACK_BASE}" "${FIXIE_TRACK_PAGES}" "Evans Cycles" "URBAN" >> ${OUTPUT_FILE}

TOURING_BASE="touring"
TOURING_PAGES=""

process_pages_raw "${TOURING_BASE}" "${TOURING_PAGES}" "Evans Cycles" "URBAN" >> ${OUTPUT_FILE}

#### BMX ####
BMX_BASE="bmx"
BMX_PAGES="$(seq 0 5)"

process_pages_raw "${BMX_BASE}" "${BMX_PAGES}" "Evans Cycles" "BMX" >> ${OUTPUT_FILE}

#### KIDS ####
KIDS_BASE="kids"
KIDS_PAGES="$(seq 0 7)"

process_pages_raw "${KIDS_BASE}" "${KIDS_PAGES}" "Evans Cycles" "KIDS" >> ${OUTPUT_FILE}
