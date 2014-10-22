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
  #echo "BASE_FILE=$1"
  #echo "STORE=$2"
  #echo "TYPE=$3"

  cat "${BASE_FILE}" | sed -e 's@<div class="product-container@\n<div class="product-container@g' | grep ^'<div class="product-container' | while read HTML_LINE
  do
    MODEL=$(echo "${HTML_LINE}" | awk -F '</a></h3>' {'print $1'} | sed -e 's@<[^>]*>@@g')
    MODEL_CLEAN=$(bubic_clean "${MODEL}")
    MODEL_CAMEL=$(bubic_camel "${MODEL_CLEAN}" ${NO_CAMEL_MODEL_MIN})
    TRADEMARK="Romet Bikes"
    URL=$(echo ${HTML_LINE} | awk -F 'href=' {'print $2'} | awk {'print $1'})
    PRICE=$(echo "${HTML_LINE}" | awk -F '<span class="price"' {'print $2'} | awk -F '</span><br />' {'print $1'} | egrep -E -o "[0-9]{0,2}[ ]{0,1}[0-9]{2,3},{0,1}[0-9]{2}" | tr -d ' ')
    #echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
    #echo "BASE FILE:${BASE_FILE}"
    #echo "LINE:${HTML_LINE}"
    #echo "TRADEMARK:=>${TRADEMARK}<="
    #echo "MODEL:=>${MODEL}<="
    #echo "MODEL_CAMEL:=>${MODEL_CAMEL}<="
    #echo "URL:=>${URL}<="
    #echo "PRICE:=>${PRICE}<="
    #echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
    bubic_dump_bike "${MODEL_CAMEL}" "${URL}" "${TRADEMARK}" "${PRICE}" "${STORE}" "${TYPE}"
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
KIDS_MTB_BASE="kids-mtb"
KIDS_MTB_PAGES="1"

process_pages_raw "${KIDS_MTB_BASE}" "${KIDS_MTB_PAGES}" "Romet Bikes" "KIDS" >> ${OUTPUT_FILE}

#### KIDS ####
KIDS_YOUNG_BASE="kids-young"
KIDS_YOUNG_PAGES="1"

process_pages_raw "${KIDS_YOUNG_BASE}" "${KIDS_YOUNG_PAGES}" "Romet Bikes" "KIDS" >> ${OUTPUT_FILE}

#### MTB ####
MTB_BASE="mtb"
MTB_PAGES="$(seq 1 5)"
process_pages_raw "${MTB_BASE}" "${MTB_PAGES}" "Romet Bikes" "MTB" >> ${OUTPUT_FILE}

#### URBAN ####
URBAN_BASE="urban"
URBAN_PAGES="$(seq 1 3)"
process_pages_raw "${URBAN_BASE}" "${URBAN_PAGES}" "Romet Bikes" "URBAN" >> ${OUTPUT_FILE}

#### TREKKING ####
TREKKING_BASE="trekking"
TREKKING_PAGES="$(seq 1 3)"
process_pages_raw "${TREKKING_BASE}" "${TREKKING_PAGES}" "Romet Bikes" "URBAN" >> ${OUTPUT_FILE}

#### ROAD ####
ROAD_BASE="road"
ROAD_PAGES="1"
process_pages_raw "${ROAD_BASE}" "${ROAD_PAGES}" "Romet Bikes" "URBAN" >> ${OUTPUT_FILE}
