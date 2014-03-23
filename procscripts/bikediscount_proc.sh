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
#OUTPUT_FILE=./output
OUTPUT_FILE=/dev/stdout
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
  cat "${BASE_FILE}" | grep 'class="product-box"' | while read model;
  do
    TRADEMARK=$(echo ${model} | awk -F 'span class="manufacturer ' {'print $2'} | awk -F '</span>' {'print $1'} | awk -F ">" {'print $2'})
    MODEL=$(echo ${model} | awk -F 'span class="manufacturer ' {'print $2'} | awk -F '</span>' {'print $2'} | awk -F ">" {'print $2'})
    PRICE=$(grep "<span>${MODEL}</span>" "${BASE_FILE}" -A50 | awk -F 'class="figure-awards"' {'print $2'} | sed -e 's/<[^>]*>//g' | awk -F ">" {'print $2'} | grep [0-9] | tr -d "€" | tr -d " " | head -1 | sed -e 's@-@00@g' | tr -d '.')
    SUBURL=$(echo ${model} | awk -F "<a href=" {'print $2'} | awk {'print $1'} | tr -d '"')
    URL="\"${BASE_URL}${SUBURL}\""
    MODEL_CAMEL=$(bubic_camel "${MODEL}")
    TRADEMARK_CAMEL=$(bubic_camel "${TRADEMARK}")
    #echo "FILE:${BASE_FILE}"
    #echo "model:===>${model}<==="
    #echo "MODEL:=>${MODEL}<="
    #echo "TRADEMARK:=>${TRADEMARK}<="
    #echo "PRICE:=>${PRICE}<="
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
      FILE="${1}-p${page}"
      process_file "${FILE}" "${STORE}" "${TYPE}"
    done
  fi
}

> ${OUTPUT_FILE}

ROAD_BIKES_ALUM_BASE="road-alum"
ROAD_BIKES_ALUM_PAGES="$(seq 0 5)"

ROAD_BIKES_CARBON_BASE="road-carbon"
ROAD_BIKES_CARBON_PAGES="$(seq 0 5)"

ROAD_BIKES_WOMAN_BASE="road-woman"
ROAD_BIKES_WOMAN_PAGES="$(seq 0 5)"

ROAD_BIKES_TRIATLON_BASE="road-triatlon"
ROAD_BIKES_TRIATLON_PAGES="$(seq 0 5)"

ROAD_BIKES_CYCLOCROSS_BASE="road-cyclocross"
ROAD_BIKES_CYCLOCROSS_PAGES="$(seq 0 5)"

process_pages_raw "${ROAD_BIKES_ALUM_BASE}" "${ROAD_BIKES_ALUM_PAGES}" "BikeDiscount" "ROAD" >> ${OUTPUT_FILE}
