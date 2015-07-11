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
#OUTPUT_FILE=/dev/stdout
BASE_URL="http://www.ventabicicletas.es"
NO_CAMEL_MODEL_MIN=0
NO_CAMEL_TRADEMARK_MIN=0
MAX_PRICE_SEARCH=10
URL="www.mhw-bike.es"
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

function print_price_url()
{
  PRICE=$(wget -o /dev/null -O - $1 | grep our_price_display | sed -e 's@<[^>]*>@@g' | egrep -E "[0-9]{0,2},{0,1}[0-9]{2,3}.[0-9]{0,2}" -o | tr -d ',' | tr '.' ',')
  echo ${PRICE}
}

function process_file()
{
  BASE_FILE="$1"
  STORE="$2"
  TYPE="$3"
  cat "${BASE_FILE}" | sed -e 's@<a class="product-name"@\n<a class="product-name"@g' | sed -e 's@</a></h5>@</a></h5>\n@g' | grep ^'<a class' | sed -e 's@<[^>]*>@@g' | grep -v ^Bicicletas | egrep -E "[A-Z,a-z]" | while read line;
  do
    TRADEMARK_MODEL="${line}"
    TRADEMARK_MODEL_CLEAN=$(bubic_clean "${TRADEMARK_MODEL}")
    TRADEMARK=$(echo ${TRADEMARK_MODEL_CLEAN} | awk {'print $1'})
    MODEL=$(echo ${TRADEMARK_MODEL_CLEAN} | awk {'for(i=2;i<=NF;++i){printf $i; if(i<NF){printf " "}}'})
    TRADEMARK_CAMEL=$(bubic_camel "${TRADEMARK}" ${NO_CAMEL_TRADEMARK_MIN} | sed -e 's@Qer@Quer@g')
    MODEL_CAMEL=$(bubic_camel "${MODEL}" ${NO_CAMEL_MODEL_MIN})
    URL="\"$(cat ${BASE_FILE} | sed -e 's@<a class="product-name"@\n<a class="product-name"@g' | sed -e 's@</a></h5>@</a></h5>\n@g' | grep ^'<a class' | grep "${line}" | awk -F 'href="' {'print $2'} | awk -F '"' {'print $1'} | egrep -e "[A-Z,a-z]" | head -1)\""
    PRICE=$(cat "${BASE_FILE}" | sed -e 's@<a class="product-name"@\n<a class="product-name"@g' | sed -e 's@</a></h5>@</a></h5>\n@g' | grep 'product-desc' | grep "${line}" -A1 | sed -e 's@<span itemprop="price"@\n<span itemprop="price"@g' | sed -e 's@</span>@</span>\n@g' | grep ^'<span itemprop="price"' | tail -1 | sed -e 's@<[^>]*>@@g' | egrep -E "[0-9]{0,2},{0,1}[0-9]{2,3}.[0-9]{0,2}" -o | head -1 | tr -d ',' | tr '.' ',')
    #echo "=>LINE:${line}<="
    #echo "BASE_FILE:${BASE_FILE}"
    #echo "TRADEMARK_MODEL:${TRADEMARK_MODEL}"
    #echo "TRADEMARK:=>${TRADEMARK}<="
    #echo "TRADEMARK_CAMEL:=>${TRADEMARK_CAMEL}<="
    #echo "MODEL:=>${MODEL}<="
    #echo "MODEL_CAMEL:=>${MODEL_CAMEL}<="
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

process_pages_raw "${ROAD_BASE}" "${ROAD_PAGES}" "ToniBike" "ROAD" >> ${OUTPUT_FILE}

#### BMX ####
BMX_BASE="bmx"
BMX_PAGES=""

process_pages_raw "${BMX_BASE}" "${BMX_PAGES}" "ToniBike" "BMX" >> ${OUTPUT_FILE}

#### ROAD CICLOCROSS ####
ROAD_CICLOCROSS_BASE="road-ciclocross"
ROAD_CICLOCROSS_PAGES=""

process_pages_raw "${ROAD_CICLOCROSS_BASE}" "${ROAD_CICLOCROSS_PAGES}" "ToniBike" "ROAD" >> ${OUTPUT_FILE}

#### MTB ELECTRIC ####
MTB_ELECTRIC_BASE="mtb-electric"
MTB_ELECTRIC_PAGES=""

process_pages_raw "${MTB_ELECTRIC_BASE}" "${MTB_ELECTRIC_PAGES}" "ToniBike" "MTB-ELECTRIC" >> ${OUTPUT_FILE}

#### MTB DOUBLE ####
MTB_DOUBLE_BASE="mtb-double"
MTB_DOUBLE_PAGES=""

process_pages_raw "${MTB_DOUBLE_BASE}" "${MTB_DOUBLE_PAGES}" "ToniBike" "MTB-DOUBLE" >> ${OUTPUT_FILE}

#### KIDS ####
KIDS_BASE="kids"
KIDS_PAGES="$(seq 1 3)"

process_pages_raw "${KIDS_BASE}" "${KIDS_PAGES}" "ToniBike" "KIDS" >> ${OUTPUT_FILE}

#### MTB ####
MTB_BASE="mtb"
MTB_PAGES="$(seq 1 7)"

process_pages_raw "${MTB_BASE}" "${MTB_PAGES}" "ToniBike" "MTB" >> ${OUTPUT_FILE}

#### ROAD WOMAN ####
ROAD_WOMAN_BASE="road-woman"
ROAD_WOMAN_PAGES=""

process_pages_raw "${ROAD_WOMAN_BASE}" "${ROAD_WOMAN_PAGES}" "ToniBike" "ROAD-WOMAN" >> ${OUTPUT_FILE}

#### MTB WOMAN ####
MTB_WOMAN_BASE="mtb-woman"
MTB_WOMAN_PAGES=""

process_pages_raw "${MTB_WOMAN_BASE}" "${MTB_WOMAN_PAGES}" "ToniBike" "MTB-WOMAN" >> ${OUTPUT_FILE}

#### URBAN WOMAN ####
URBAN_WOMAN_BASE="urban-woman"
URBAN_WOMAN_PAGES=""

process_pages_raw "${URBAN_WOMAN_BASE}" "${URBAN_WOMAN_PAGES}" "ToniBike" "URBAN-WOMAN" >> ${OUTPUT_FILE}

#### ROAD_TRIATLON ####
ROAD_TRIATLON_BASE="road-triatlon"
ROAD_TRIATLON_PAGES=""

process_pages_raw "${ROAD_TRIATLON_BASE}" "${ROAD_TRIATLON_PAGES}" "ToniBike" "ROAD-TRIATLON" >> ${OUTPUT_FILE}
