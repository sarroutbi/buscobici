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
BASE_URL="http://www.mhw-bike.es"
NO_CAMEL_MIN=6
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

function process_file()
{
  BASE_FILE="$1"
  STORE="$2"
  TYPE="$3"
  
  #echo "============================="
  #echo "BASE_FILE=${BASE_FILE}"
  #echo "STORE="${STORE}"
  #echo "TYPE="${TYPE}"
  #echo "============================="

  cat "${BASE_FILE}" | grep '<div class="product--rating-container">' -A10 | grep -v euro | sed -e 's@<[^>]*>@@g' | grep "[A-Z,a-z]" | while read TRADEMARK_MODEL;
  do
    TRADEMARK=$(echo ${TRADEMARK_MODEL} | awk {'print $1'} | tr -d '\n' | tr -d '\r' | tr "'" '"')
    MODEL=$(echo ${TRADEMARK_MODEL} | awk {'for(i=2;i<=NF;++i){printf $i; if(i<NF){printf " "}}'} | tr "'" '"')
    SUBURL=$(grep "${TRADEMARK_MODEL}" ${FILE} -C3 | grep 'a href' | awk -F '<a href=' {'print $2'} | awk {'print $1'} | tr -d '"' | head -1)
    PRICE=$(grep "${SUBURL}" ${BASE_FILE} -A20 | grep euro | egrep -E "[0-9]{0,2}[.]{0,1}[0-9]{2,3},[0-9]{0,2}" -o | tr -d '.')
    URL="\"${SUBURL}\""
    MODEL_CAMEL=$(bubic_camel "${MODEL}")
    TRADEMARK_CAMEL=$(bubic_camel "${TRADEMARK}")
    #echo "============================="
    #echo "FILE:${BASE_FILE}"
    #echo "model:===>${model}<==="
    #echo "MODEL:=>${MODEL}<="
    #echo "TRADEMARK:=>${TRADEMARK}<="
    #echo "PRICE:=>${PRICE}<="
    #echo "SUBURL:=>${SUBURL}<="
    #echo "URL:=>${URL}<="
    #echo "============================="
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

#### MTB DOUBLE 29 ####
MTB_DOUBLE_29_BASE="mtb-double-29"
MTB_DOUBLE_29_PAGES="1"

process_pages_raw "${MTB_DOUBLE_29_BASE}" "${MTB_DOUBLE_29_PAGES}" "MHW Bike" "MTB-DOUBLE-29" >> ${OUTPUT_FILE}

#### MTB RIGID ####
MTB_RIGID_BASE="mtb-rigid"
MTB_RIGID_PAGES="$(seq 1 3)"

process_pages_raw "${MTB_RIGID_BASE}" "${MTB_RIGID_PAGES}" "MHW Bike" "MTB" >> ${OUTPUT_FILE}

#### MTB DOUBLE ####
MTB_DOUBLE_BASE="mtb-double"
MTB_DOUBLE_PAGES="$(seq 1 4)"

process_pages_raw "${MTB_DOUBLE_BASE}" "${MTB_DOUBLE_PAGES}" "MHW Bike" "MTB-DOUBLE" >> ${OUTPUT_FILE}

#### MTB RIGID 29 ####
MTB_RIGID_29_BASE="mtb-29"
MTB_RIGID_29_PAGES="$(seq 1 4)"

process_pages_raw "${MTB_RIGID_29_BASE}" "${MTB_RIGID_29_PAGES}" "MHW Bike" "MTB-29" >> ${OUTPUT_FILE}

#### MTB DOUBLE 29 (round 2) ####
MTB_DOUBLE2_29_BASE="mtb-double2-29"
MTB_DOUBLE2_29_PAGES="$(seq 1 3)"

process_pages_raw "${MTB_DOUBLE2_29_BASE}" "${MTB_DOUBLE2_29_PAGES}" "MHW Bike" "MTB-DOUBLE" >> ${OUTPUT_FILE}

#### DIRT/BMX ####
DIRT_BMX_BASE="dirt-bmx"
DIRT_BMX_PAGES="1"

process_pages_raw "${DIRT_BMX_BASE}" "${DIRT_BMX_PAGES}" "MHW Bike" "BMX" >> ${OUTPUT_FILE}

#### MTB WOMAN ####
MTB_WOMAN_BASE="mtb-woman"
MTB_WOMAN_PAGES="$(seq 1 3)"

process_pages_raw "${MTB_WOMAN_BASE}" "${MTB_WOMAN_PAGES}" "MHW Bike" "MTB-WOMAN" >> ${OUTPUT_FILE}

#### MTB-DOUBLE WOMAN ####
MTB_WOMAN_DOUBLE_BASE="mtb-woman-double"
MTB_WOMAN_DOUBLE_PAGES="$(seq 1 2)"

process_pages_raw "${MTB_WOMAN_DOUBLE_BASE}" "${MTB_WOMAN_DOUBLE_PAGES}" "MHW Bike" "MTB-WOMAN" >> ${OUTPUT_FILE}

#### URBAN CROSS ####
URBAN_CROSS_BASE="urban-cross"
URBAN_CROSS_PAGES="$(seq 1 4)"

process_pages_raw "${URBAN_CROSS_BASE}" "${URBAN_CROSS_PAGES}" "MHW Bike" "URBAN" >> ${OUTPUT_FILE}

#### URBAN WALK ####
URBAN_WALK_BASE="urban-walk"
URBAN_WALK_PAGES="$(seq 1 5)"

process_pages_raw "${URBAN_WALK_BASE}" "${URBAN_WALK_PAGES}" "MHW Bike" "URBAN" >> ${OUTPUT_FILE}

#### URBAN FITNESS ####
URBAN_FITNESS_BASE="urban-fitness"
URBAN_FITNESS_PAGES="$(seq 1 5)"

process_pages_raw "${URBAN_FITNESS_BASE}" "${URBAN_FITNESS_PAGES}" "MHW Bike" "URBAN" >> ${OUTPUT_FILE}

#### ROAD ####
ROAD_BASE="road"
ROAD_PAGES="$(seq 1 5)"

process_pages_raw "${ROAD_BASE}" "${ROAD_PAGES}" "MHW Bike" "ROAD" >> ${OUTPUT_FILE}

#### ROAD_WOMAN ####
ROAD_WOMAN_BASE="road-woman"
ROAD_WOMAN_PAGES="1"

process_pages_raw "${ROAD_WOMAN_BASE}" "${ROAD_WOMAN_PAGES}" "MHW Bike" "ROAD-WOMAN" >> ${OUTPUT_FILE}

#### ROAD_TRIATLON ####
ROAD_TRIATLON_BASE="road-triatlon"
ROAD_TRIATLON_PAGES="1"

process_pages_raw "${ROAD_TRIATLON_BASE}" "${ROAD_TRIATLON_PAGES}" "MHW Bike" "ROAD-TRIATLON" >> ${OUTPUT_FILE}

#### ROAD_CICLOCROSS ####
ROAD_CICLOCROSS_BASE="road-ciclocross"
ROAD_CICLOCROSS_PAGES="1"

process_pages_raw "${ROAD_CICLOCROSS_BASE}" "${ROAD_CICLOCROSS_PAGES}" "MHW Bike" "ROAD-CICLOCROSS" >> ${OUTPUT_FILE}

#### KIDS ####
KIDS_BASE="kids"
KIDS_PAGES="$(seq 1 4)"

process_pages_raw "${KIDS_BASE}" "${KIDS_PAGES}" "MHW Bike" "KIDS" >> ${OUTPUT_FILE}
