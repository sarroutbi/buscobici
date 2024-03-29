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
BASE_URL="http://www.ciclohobby.es"
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

function process_file()
{
  BASE_FILE="$1"
  STORE="$2"
  TYPE="$3"
  cat "${BASE_FILE}" | sed -e 's@<a class="product-name"@\n<a class="product-name"@g' | grep '<a class="product-name"' | while read line;
  do
    TRADEMARK_MODEL=$(echo "${line}" | awk -F '</a>' '{print $1}' | sed -e 's@<[^>]*>@@g'\
| sed -e 's@\.\.\.@@g' | grep [A-Z,a-z] | head -1 | sed -e 's@^[ \t]*@@g'\
| grep -vi "Biela"\ | grep -vi "Cambio"\ | grep -vi "Caja"\
| grep -vi "Culot"\ | grep -vi "Cuentakil.metros"\
| grep -vi "L.quido"\ | grep -vi "Sellador"\
| grep -vi "Cubierta" | grep -vi "Electroestimulador"\
| grep -vi "Casco" | grep -vi "Chaleco"\
| grep -vi "Chaqueta" | grep -vi "Chubasquero" \
| grep -vi "Cuadro" | grep -vi "Desviador"\
| grep -vi "Guante" | grep -vi "Horquilla"\
| grep -vi "Juego" | grep -vi "Maneta"\
| grep -vi "Maillot"\ | grep -vi "Sensor"\
| grep -vi "Mallas" | grep -vi "Paraviento"\
| grep -vi "Pulsometro" | grep -vi "Rueda"\
| grep -vi "Plataforma" | grep -vi "Zapatillas")
    TRADEMARK_MODEL_CAMEL=$(bubic_camel "${TRADEMARK_MODEL}" ${NO_CAMEL_TRADEMARK_MIN} | sed -e 's@Qer@Quer@g')
    TRADEMARK_MODEL_CLEAN=$(bubic_clean "${TRADEMARK_MODEL_CAMEL}")
    TRADEMARK=$(echo ${TRADEMARK_MODEL_CLEAN} | awk {'print $1'})
    MODEL=$(echo ${TRADEMARK_MODEL_CLEAN} | awk {'for(i=2;i<=NF;++i){printf $i; if(i<NF){printf " "}}'})
    URL=$(echo ${line} | awk -F 'href=' {'print $2'} | awk {'print $1'})
    MODEL_CAMEL=$(bubic_camel "${MODEL}" ${NO_CAMEL_MODEL_MIN})
    PRICE=$(grep "${TRADEMARK_MODEL}" "${BASE_FILE}" -A5 | sed -e 's@<@\n<@g' | grep "${TRADEMARK_MODEL}" -A10 | grep '<span class="price' | egrep -E -o "[0-9]{0,2} {1,2}[0-9]{3},{1}[0-9]{2} | tr -d ' ' | head")
    PRICE_NO_DASH=$(echo "${PRICE}" | tr -d ' ')
    #echo "##############################################################"
    #echo "LINE:${line}"
    #echo "TRADEMARK_MODEL:${TRADEMARK_MODEL}"
    #echo "TRADEMARK_MODEL_CLEAN:${TRADEMARK_MODEL_CLEAN}"
    #echo "TRADEMARK:=>${TRADEMARK}<="
    #echo "MODEL:=>${MODEL}<="
    #echo "URL:=>${URL}<="
    #echo "PRICE:=>${PRICE}<="
    #echo "PRICE_NO_DASH:=>${PRICE_NO_DASH}<="
    #echo "##############################################################"
    bubic_dump_bike "${MODEL}" "${URL}" "${TRADEMARK}" "${PRICE_NO_DASH}" "${STORE}" "${TYPE}"
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
ROAD_PAGES="$(seq 1 9)"

process_pages_raw "${ROAD_BASE}" "${ROAD_PAGES}" "CicloHobby" "ROAD" >> ${OUTPUT_FILE}

#### ROAD_TRIATLON ####
ROAD_TRIATLON_BASE="road-triatlon"
ROAD_TRIATLON_PAGES="$(seq 1 1)"

process_pages_raw "${ROAD_TRIATLON_BASE}" "${ROAD_TRIATLON_PAGES}" "CicloHobby" "ROAD_TRIATLON" >> ${OUTPUT_FILE}

#### MTB ####
MTB_BASE="mtb"
MTB_PAGES="$(seq 1 10)"
process_pages_raw "${MTB_BASE}" "${MTB_PAGES}" "CicloHobby" "MTB" >> ${OUTPUT_FILE}

#### ROAD CICLOCROSS ####
ROAD_CICLOCROSS_BASE="road-ciclocross"
ROAD_CICLOCROSS_PAGES=""
process_pages_raw "${ROAD_CICLOCROSS_BASE}" "${ROAD_CICLOCROSS_PAGES}" "CicloHobby" "ROAD-CICLOCROSS" >> ${OUTPUT_FILE}

#### URBAN ####
URBAN_BASE="urban"
URBAN_PAGES="1"
process_pages_raw "${URBAN_BASE}" "${URBAN_PAGES}" "CicloHobby" "URBAN" >> ${OUTPUT_FILE}

#### URBAN HYBRID ####
URBAN_HYBRID_BASE="urban-hybrid"
URBAN_HYBRID_PAGES="1"

process_pages_raw "${URBAN_HYBRID_BASE}" "${URBAN_HYBRID_PAGES}" "CicloHobby" "URBAN" >> ${OUTPUT_FILE}

#### URBAN FITNESS ####
URBAN_FITNESS_BASE="urban-fitness"
URBAN_FITNESS_PAGES="$(seq 1 3)"

process_pages_raw "${URBAN_FITNESS_BASE}" "${URBAN_FITNESS_PAGES}" "CicloHobby" "URBAN" >> ${OUTPUT_FILE}

#### URBAN ELECTRIC ####
URBAN_ELECTRIC_BASE="urban-electric"
URBAN_ELECTRIC_PAGES="$(seq 1 2)"

process_pages_raw "${URBAN_ELECTRIC_BASE}" "${URBAN_ELECTRIC_PAGES}" "CicloHobby" "URBAN-ELECTRIC" >> ${OUTPUT_FILE}

#### KIDS ####
KIDS_BASE="kids"
KIDS_PAGES="$(seq 1 4)"

process_pages_raw "${KIDS_BASE}" "${KIDS_PAGES}" "CicloHobby" "KIDS" >> ${OUTPUT_FILE}

#### BMX ####
BMX_BASE="bmx"
BMX_PAGES="1"

process_pages_raw "${BMX_BASE}" "${BMX_PAGES}" "CicloHobby" "BMX" >> ${OUTPUT_FILE}

#### BMX_DUAL ####
BMX_DUAL_BASE="bmx-dual"
BMX_DUAL_PAGES="1"

process_pages_raw "${BMX_DUAL_BASE}" "${BMX_DUAL_PAGES}" "CicloHobby" "BMX" >> ${OUTPUT_FILE}



