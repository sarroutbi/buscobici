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
BASE_URL="http://www.bike-discount.de"
NO_CAMEL_MIN=6
NO_CAMEL_TRADEMARK_MIN=0
MAX_PRICE_SEARCH=35
URL="www.bike-discount.de"
ONLY_DOMAIN="bike-discount.de"
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
  cat "${BASE_FILE}" | grep "product-description" -A30 | tr -d '\n'| sed -e 's@<div class="product-description">@\n<div class="product-description">@g'| while read all_info;
  do
    # TRADEMARK PARSING
    TRADEMARK_MODEL_TAGGED=$(echo "${all_info}" | egrep -E -o "<h3><span class=\"manufacturer\">[-,A-Z,a-z,0-9,<,>,/,\.,\,,\`,\',\´,&,;,#, ]{0,}</h3>")
    TRADEMARK=$(echo "${TRADEMARK_MODEL_TAGGED}" | egrep -E -o "<span class=\"manufacturer\">[-,A-Z,a-z,0-9,<,>,/,\.,\,\`,\',\´,&,;,#, ]{0,}</span>" | sed -e 's@<[^>]*>@@g')
    MODEL=$(echo "${TRADEMARK_MODEL_TAGGED}" | egrep -E -o "</span>[-,A-Z,a-z,0-9,<,>,/,\.,\,,\`,\',\´,&,;,#, ]{0,}</h3>" | sed -e 's@<[^>]*>@@g')
    TRADEMARK_CAMEL=$(bubic_camel "${TRADEMARK}")
    MODEL_CAMEL=$(bubic_camel "${MODEL}")
    SUBURL=$(echo "${all_info}" | awk -F "href=" {'print $2'} | awk {'print $1'} | tr -d '"')
    FINAL_URL=$(echo "${BASE_URL}${SUBURL}")
    PRICE_TAGGED=$(grep "${SUBURL}" ${FILE} -A80 | grep price | egrep -E -o "<span class=\"price-value\">[0-9,.,\,-]{1,} &euro;</span>" | head -1)
    PRICE=$(echo "${PRICE_TAGGED}" | egrep -E -o "[0-9]{0,}\.{0,}[0-9]{3},{1}[0-9,-]{1,2}" | tr -d '.' | sed -e 's@-@00@g')
    if [ "{$PRICE}" == "" ];
    then
      PRICE_TAGGED=$(echo "${all_info}" | egrep -E -o "<span class=\"retail-value\">[0-9,.,\,-]{1,} &euro;</span>")
      PRICE=$(echo "${PRICE_TAGGED}" | egrep -E -o "[0-9]{0,}\.{0,}[0-9]{3},{1}[0-9,-]{1,2}" | tr -d '.' | sed -e 's@-@00@g')
    fi
    #echo "FILE:${BASE_FILE}"
    #echo "ALL INFO:=>${all_info}<="
    #echo "TRADEMARK MODEL_TAGGED:${TRADEMARK_MODEL_TAGGED}"
    #echo "TRADEMARK:${TRADEMARK}"
    #echo "MODEL:${MODEL}"
    #echo "SUBURL:${SUBURL}"
    #echo "URL:${FINAL_URL}"
    #echo "PRICE_TAGGED:=>${PRICE_TAGGED}<="
    #echo "PRICE:=>${PRICE}<="
    #echo "URL:=>${URL}<="
    #echo
    bubic_dump_bike "${MODEL_CAMEL}" "${FINAL_URL}" "${TRADEMARK_CAMEL}" "${PRICE}" "${STORE}" "${TYPE}"
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
      FILE="${1}-p${page}"
      process_file "${FILE}" "${STORE}" "${TYPE}"
    done
  fi
}

> ${OUTPUT_FILE}

#### ROAD ####
ROAD_BIKES_ALUM_BASE="road-alum"
ROAD_BIKES_ALUM_PAGES="$(seq 0 2)"

ROAD_BIKES_CARBON_BASE="road-carbon"
ROAD_BIKES_CARBON_PAGES="$(seq 0 3)"

ROAD_BIKES_WOMAN_BASE="road-woman"
ROAD_BIKES_WOMAN_PAGES="$(seq 0 1)"

ROAD_BIKES_TRIATLON_BASE="road-triatlon"
ROAD_BIKES_TRIATLON_PAGES="$(seq 0 1)"

ROAD_BIKES_CYCLOCROSS_BASE="road-cyclocross"
ROAD_BIKES_CYCLOCROSS_PAGES="$(seq 0 3)"

process_pages_raw "${ROAD_BIKES_ALUM_BASE}" "${ROAD_BIKES_ALUM_PAGES}" "BikeDiscount" "ROAD" >> ${OUTPUT_FILE}
process_pages_raw "${ROAD_BIKES_CARBON_BASE}" "${ROAD_BIKES_CARBON_PAGES}" "BikeDiscount" "ROAD" >> ${OUTPUT_FILE}
process_pages_raw "${ROAD_BIKES_WOMAN_BASE}" "${ROAD_BIKES_WOMAN_PAGES}" "BikeDiscount" "ROAD-WOMAN" >> ${OUTPUT_FILE}
process_pages_raw "${ROAD_BIKES_TRIATLON_BASE}" "${ROAD_BIKES_TRIATLON_PAGES}" "BikeDiscount" "ROAD-TRIATLON" >> ${OUTPUT_FILE}
process_pages_raw "${ROAD_BIKES_CYCLOCROSS_BASE}" "${ROAD_BIKES_CYCLOCROSS_PAGES}" "BikeDiscount" "ROAD" >> ${OUTPUT_FILE}

#### MTB ####
MTB_26_BIKES_BASE="mtbfix-26"
MTB_26_BIKES_PAGES="$(seq 0 5)"

MTB_275_BIKES_BASE="mtbfix-275"
MTB_275_BIKES_PAGES="$(seq 0 5)"

MTB_29_BIKES_BASE="mtbfix-29"
MTB_29_BIKES_PAGES="$(seq 0 5)"

MTB_WOMAN_BIKES_BASE="mtbfix-woman"
MTB_WOMAN_BIKES_PAGES="$(seq 0 5)"

MTB_DOUBLE_26_BIKES_BASE="mtb-double-26"
MTB_DOUBLE_26_BIKES_PAGES="$(seq 0 5)"

MTB_DOUBLE_275_BIKES_BASE="mtb-double-275"
MTB_DOUBLE_275_BIKES_PAGES="$(seq 0 5)"

MTB_DOUBLE_29_BIKES_BASE="mtb-double-29"
MTB_DOUBLE_29_BIKES_PAGES="$(seq 0 5)"

MTB_DOUBLE_WOMAN_BIKES_BASE="mtb-double-woman"
MTB_DOUBLE_WOMAN_BIKES_PAGES="$(seq 0 2)"

MTB_DOUBLE_FAT_BIKES_BASE="mtb-fat"
MTB_DOUBLE_FAT_BIKES_PAGES="$(seq 0 2)"

MTB_DOUBLE_DIRT_BIKES_BASE="mtb-double-dirt"
MTB_DOUBLE_DIRT_BIKES_PAGES="$(seq 0 2)"

MTB_ELECTRIC_BIKES_BASE="mtbfix-electric"
MTB_ELECTRIC_BIKES_PAGES="$(seq 0 1)"

MTB_DOUBLE_ELECTRIC_BIKES_BASE="mtb-double-electric"
MTB_DOUBLE_ELECTRIC_BIKES_PAGES="$(seq 0 1)"

process_pages_raw "${MTB_26_BIKES_BASE}" "${MTB_26_BIKES_PAGES}" "BikeDiscount" "MTB" >> ${OUTPUT_FILE}
process_pages_raw "${MTB_275_BIKES_BASE}" "${MTB_275_BIKES_PAGES}" "BikeDiscount" "MTB" >> ${OUTPUT_FILE}
process_pages_raw "${MTB_29_BIKES_BASE}" "${MTB_29_BIKES_PAGES}" "BikeDiscount" "MTB" >> ${OUTPUT_FILE}
process_pages_raw "${MTB_WOMAN_BIKES_BASE}" "${MTB_WOMAN_BIKES_PAGES}" "BikeDiscount" "MTB-WOMAN" >> ${OUTPUT_FILE}

process_pages_raw "${MTB_DOUBLE_26_BIKES_BASE}" "${MTB_DOUBLE_26_BIKES_PAGES}" "BikeDiscount" "MTB-DOUBLE" >> ${OUTPUT_FILE}
process_pages_raw "${MTB_DOUBLE_275_BIKES_BASE}" "${MTB_DOUBLE_275_BIKES_PAGES}" "BikeDiscount" "MTB-DOUBLE" >> ${OUTPUT_FILE}
process_pages_raw "${MTB_DOUBLE_29_BIKES_BASE}" "${MTB_DOUBLE_29_BIKES_PAGES}" "BikeDiscount" "MTB-DOUBLE" >> ${OUTPUT_FILE}
process_pages_raw "${MTB_DOUBLE_WOMAN_BIKES_BASE}" "${MTB_DOUBLE_WOMAN_BIKES_PAGES}" "BikeDiscount" "MTB-DOUBLE-WOMAN" >> ${OUTPUT_FILE}
process_pages_raw "${MTB_FAT_BIKES_BASE}" "${MTB_FAT_BIKES_PAGES}" "BikeDiscount" "MTB" >> ${OUTPUT_FILE}
process_pages_raw "${MTB_DOUBLE_DIRT_BIKES_BASE}" "${MTB_DOUBLE_DIRT_BIKES_PAGES}" "BikeDiscount" "MTB-DIRT" >> ${OUTPUT_FILE}
process_pages_raw "${MTB_ELECTRIC_BIKES_BASE}" "${MTB_ELECTRIC_BIKES_PAGES}" "BikeDiscount" "MTB-ELECTRIC" >> ${OUTPUT_FILE}
process_pages_raw "${MTB_DOUBLE_ELECTRIC_BIKES_BASE}" "${MTB_DOUBLE_ELECTRIC_BIKES_PAGES}" "BikeDiscount" "MTB-DOUBLE-ELECTRIC" >> ${OUTPUT_FILE}

#### URBAN ####
URBAN_TREKKING_BIKES_BASE="urban-trekking"
URBAN_TREKKING_BIKES_PAGES="$(seq 0 6)"

URBAN_TREKKING_WOMAN_BIKES_BASE="urban-trekking-woman"
URBAN_TREKKING_WOMAN_BIKES_PAGES="$(seq 0 6)"

URBAN_BIKES_BASE="urban"
URBAN_BIKES_PAGES="$(seq 0 1)"

URBAN_CRUISERS_BASE="urban-cruisers"
URBAN_CRUISERS_PAGES="$(seq 0 1)"

URBAN_FIXIE_BASE="urban-fixies"
URBAN_FIXIE_PAGES="$(seq 0 1)"

URBAN_FITNESS_BIKES_BASE="urban-fitness"
URBAN_FITNESS_BIKES_PAGES="$(seq 0 2)"

URBAN_FITNESS_WOMAN_BIKES_BASE="urban-fitness-woman"
URBAN_FITNESS_WOMAN_BIKES_PAGES="$(seq 0 1)"

URBAN_CROSSBIKES_BIKES_BASE="urban-crossbikes"
URBAN_CROSSBIKES_BIKES_PAGES="$(seq 0 3)"

URBAN_CROSSBIKES_WOMAN_BIKES_BASE="urban-crossbikes-woman"
URBAN_CROSSBIKES_WOMAN_BIKES_PAGES="$(seq 0 3)"

URBAN_ELECTRIC_BIKES_BASE="urban-electric"
URBAN_ELECTRIC_BIKES_PAGES="$(seq 0 3)"

URBAN_ELECTRIC_WOMAN_BIKES_BASE="urban-electric-woman"
URBAN_ELECTRIC_WOMAN_BIKES_PAGES="$(seq 0 3)"

process_pages_raw "${URBAN_TREKKING_BIKES_BASE}" "${URBAN_TREKKING_BIKES_PAGES}" "BikeDiscount" "URBAN" >> ${OUTPUT_FILE}
process_pages_raw "${URBAN_TREKKING_WOMAN_BIKES_BASE}" "${URBAN_TREKKING_WOMAN_BIKES_PAGES}" "BikeDiscount" "URBAN" >> ${OUTPUT_FILE}
process_pages_raw "${URBAN__BIKES_BASE}" "${URBAN__BIKES_PAGES}" "BikeDiscount" "URBAN" >> ${OUTPUT_FILE}
process_pages_raw "${URBAN_CRUISERS_BASE}" "${URBAN_CRUISERS_PAGES}" "BikeDiscount" "URBAN" >> ${OUTPUT_FILE}
process_pages_raw "${URBAN_FIXIE_BASE}" "${URBAN_FIXIE_PAGES}" "BikeDiscount" "URBAN-FIXIE" >> ${OUTPUT_FILE}
process_pages_raw "${URBAN_FITNESS_BIKES_BASE}" "${URBAN_FITNESS_BIKES_PAGES}" "BikeDiscount" "URBAN" >> ${OUTPUT_FILE}
process_pages_raw "${URBAN_FITNESS_WOMAN_BIKES_BASE}" "${URBAN_FITNESS_WOMAN_BIKES_PAGES}" "BikeDiscount" "URBAN-WOMAN" >> ${OUTPUT_FILE}
process_pages_raw "${URBAN_CROSSBIKES_BIKES_BASE}" "${URBAN_CROSSBIKES_BIKES_PAGES}" "BikeDiscount" "URBAN" >> ${OUTPUT_FILE}
process_pages_raw "${URBAN_CROSSBIKES_WOMAN_BIKES_BASE}" "${URBAN_CROSSBIKES_WOMAN_BIKES_PAGES}" "BikeDiscount" "URBAN-WOMAN" >> ${OUTPUT_FILE}
process_pages_raw "${URBAN_ELECTRIC_BIKES_BASE}" "${URBAN_ELECTRIC_BIKES_PAGES}" "BikeDiscount" "URBAN-ELECTRIC" >> ${OUTPUT_FILE}
process_pages_raw "${URBAN_ELECTRIC_WOMAN_BIKES_BASE}" "${URBAN_ELECTRIC_WOMAN_BIKES_PAGES}" "BikeDiscount" "URBAN-ELECTRIC" >> ${OUTPUT_FILE}

#### BMX ####
BMX_BIKES_BASE="bmx"
BMX_BIKES_PAGES="$(seq 0 2)"
process_pages_raw "${BMX_BIKES_BASE}" "${BMX_BIKES_PAGES}" "BikeDiscount" "BMX" >> ${OUTPUT_FILE}

#### KIDS ####
KIDS_BIKES_BASE="kids"
KIDS_BIKES_PAGES="$(seq 0 7)"
process_pages_raw "${KIDS_BIKES_BASE}" "${KIDS_BIKES_PAGES}" "BikeDiscount" "KIDS" >> ${OUTPUT_FILE}
