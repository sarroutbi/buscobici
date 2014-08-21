#!/bin/bash
#
# Copyright © 2014 Sergio Arroutbi Braojos <sarroutbi@gmail.com>
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
BASE_URL="http://www.labicicleta.net"
NO_CAMEL_MODEL_MIN=0
NO_CAMEL_TRADEMARK_MIN=0
MAX_PRICE_SEARCH=10
URL="www.labicicleta.net"
ONLY_DOMAIN="labicicleta.net"
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
  cat "${BASE_FILE}" | sed -e s@'<div class="product-top">'@'\n<div class="product-top">'@g | grep ^'<div class="product-top">' | while read line;
  do
    # MODEL LINE AND URL LIKE:
    # <h2><a href="/productos-bicicletas/bicicletas/mtb/cannondale-scalpel-29-3-14-detail.html" >CANNONDALE SCALPEL 29 3 '14</a></h2>
    TRADEMARK_MODEL=$(echo ${line} | awk -F '<h2>' {'print $2'} | awk -F '</h2>' {'print $1'} | sed -e 's@<[^>]*>@@g' | tr "'" '"' | tr "´" '"' | tr "\`" '"' | tr -d "\`" | tr -d "´" | sed -e 's@""@"@g')
    TRADEMARK_MODEL_CLEAN=$(bubic_clean "${TRADEMARK_MODEL}")
    TRADEMARK=$(echo ${TRADEMARK_MODEL_CLEAN} | awk {'print $1'})
    MODEL=$(echo ${TRADEMARK_MODEL_CLEAN} | awk {'for(i=2;i<=NF;++i){printf $i; if(i<NF){printf " "}}'})
    # Caad models are indeed Cannondale
    echo "${TRADEMARK}" | grep -i "Caad" > /dev/null
    if [ $? -eq 0 ];
    then
        TRADEMARK="Cannondale"
        MODEL=$(echo ${TRADEMARK_MODEL_CLEAN} | awk {'for(i=1;i<=NF;++i){printf $i; if(i<NF){printf " "}}'})
    fi
    # Supersix/Superx models are indeed Cannondale
    echo "${TRADEMARK}" | grep -i "Super" > /dev/null
    if [ $? -eq 0 ];
    then
        TRADEMARK="Cannondale"
        MODEL=$(echo ${TRADEMARK_MODEL_CLEAN} | awk {'for(i=1;i<=NF;++i){printf $i; if(i<NF){printf " "}}'})
    fi
    # Slice models are indeed Cannondale
    echo "${TRADEMARK}" | grep -i "Slice" > /dev/null
    if [ $? -eq 0 ];
    then
        TRADEMARK="Cannondale"
        MODEL=$(echo ${TRADEMARK_MODEL_CLEAN} | awk {'for(i=1;i<=NF;++i){printf $i; if(i<NF){printf " "}}'})
    fi
    # Trail models are indeed Cannondale
    echo "${TRADEMARK}" | grep -i ^"Trail" > /dev/null
    if [ $? -eq 0 ];
    then
        TRADEMARK="Cannondale"
        MODEL=$(echo ${TRADEMARK_MODEL_CLEAN} | awk {'for(i=1;i<=NF;++i){printf $i; if(i<NF){printf " "}}'})
    fi
    # Scalpel models are indeed Cannondale
    echo "${TRADEMARK}" | grep -i ^"Scalpel" > /dev/null
    if [ $? -eq 0 ];
    then
        TRADEMARK="Cannondale"
        MODEL=$(echo ${TRADEMARK_MODEL_CLEAN} | awk {'for(i=1;i<=NF;++i){printf $i; if(i<NF){printf " "}}'})
    fi
    # Sl is indeed Cannondale Trail Sl
    echo "${TRADEMARK}" | grep -i ^"Sl" > /dev/null
    if [ $? -eq 0 ];
    then
        TRADEMARK="Cannondale"
        MODEL="Trail $(echo ${TRADEMARK_MODEL_CLEAN} | awk {'for(i=1;i<=NF;++i){printf $i; if(i<NF){printf " "}}'})"
    fi
    # Sl is indeed Cannondale Trail Sl
    echo "${TRADEMARK}" | grep -i ^"29" > /dev/null
    if [ $? -eq 0 ];
    then
        TRADEMARK="Cannondale"
        MODEL="Trail $(echo ${TRADEMARK_MODEL_CLEAN} | awk {'for(i=1;i<=NF;++i){printf $i; if(i<NF){printf " "}}'})"
    fi
    # F29 models are indeed Cannondale
    echo "${TRADEMARK}" | grep -i ^"F29" > /dev/null
    if [ $? -eq 0 ];
    then
        TRADEMARK="Cannondale"
        MODEL="$(echo ${TRADEMARK_MODEL_CLEAN} | awk {'for(i=1;i<=NF;++i){printf $i; if(i<NF){printf " "}}'})"
    fi
    # Émonda models are indeed Trek
    echo "${TRADEMARK}" | grep -i ".monda" > /dev/null
    if [ $? -eq 0 ];
    then
        TRADEMARK="Trek"
        MODEL=$(echo ${TRADEMARK_MODEL_CLEAN} | awk {'for(i=1;i<=NF;++i){printf $i; if(i<NF){printf " "}}'})
    fi
    # Madone models are indeed Trek
    echo "${TRADEMARK}" | grep -i "Madone" > /dev/null
    if [ $? -eq 0 ];
    then
        TRADEMARK="Trek"
        MODEL=$(echo ${TRADEMARK_MODEL_CLEAN} | awk {'for(i=1;i<=NF;++i){printf $i; if(i<NF){printf " "}}'})
    fi
    # speed models are indeed Trek
    echo "${TRADEMARK}" | grep -i ^"speed" > /dev/null
    if [ $? -eq 0 ];
    then
        TRADEMARK="Trek"
        MODEL=$(echo ${TRADEMARK_MODEL_CLEAN} | awk {'for(i=1;i<=NF;++i){printf $i; if(i<NF){printf " "}}'})
    fi

    TRADEMARK_CAMEL=$(bubic_camel "${TRADEMARK}" ${NO_CAMEL_TRADEMARK_MIN})
    MODEL_CAMEL=$(bubic_camel "${MODEL}" ${NO_CAMEL_MODEL_MIN})
    SUBURL=$(echo ${line} | awk -F '<h2>' {'print $2'} | awk -F '</h2>' {'print $1'} | awk -F '<a href=' {'print $2'} | awk {'print $1'} | tr -d '"')
    URL="\"${BASE_URL}${SUBURL}\""
    # PRICE LIKE:
    # <span class="PricebasePriceWithTax" >6999,00 €</span>
    PRICE=$(echo ${line} | awk -F '<span class="PricebasePriceWithTax" >' {'print $2'} | awk -F '</span>' {'print $1'} | sed -e 's@<[^>]*>@@g' | tr -d ' ' | tr '.' ',' | egrep -E "[0-9]{2,5},[0-9]{0,2}" -o)
    #echo "LINE:=>${line}<="
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

#### MTB ####
MTB_BASE="mtb"
MTB_PAGES=""

process_pages_raw "${MTB_BASE}" "${MTB_PAGES}" "La Bicicleta" "MTB" >> ${OUTPUT_FILE}

#### ROAD ####
ROAD_BASE="road"
ROAD_PAGES=""

process_pages_raw "${ROAD_BASE}" "${ROAD_PAGES}" "La Bicicleta" "ROAD" >> ${OUTPUT_FILE}

#### BMX ####
BMX_BASE="bmx"
BMX_PAGES=""

process_pages_raw "${ROAD_BASE}" "${ROAD_PAGES}" "La Bicicleta" "ROAD" >> ${OUTPUT_FILE}

#### KIDS ####
KIDS_BASE="kids"
KIDS_PAGES=""

process_pages_raw "${KIDS_BASE}" "${KIDS_PAGES}" "La Bicicleta" "KIDS" >> ${OUTPUT_FILE}

#### URBAN ####
URBAN_BASE="urban"
URBAN_PAGES=""

process_pages_raw "${URBAN_BASE}" "${URBAN_PAGES}" "La Bicicleta" "URBAN" >> ${OUTPUT_FILE}

#### ROAD-TRIATHLON ####
ROAD_TRIATHLON_BASE="road-triathlon"
ROAD_TRIATHLON_PAGES=""

process_pages_raw "${ROAD_TRIATHLON_BASE}" "${ROAD_TRIATHLON_PAGES}" "La Bicicleta" "ROAD-TRIATHLON" >> ${OUTPUT_FILE}

#### ROAD_CICLOCROSS ####
ROAD_CICLOCROSS_BASE="road-ciclocross"
ROAD_CICLOCROSS_PAGES=""

process_pages_raw "${ROAD_CICLOCROSS_BASE}" "${ROAD_CICLOCROSS_PAGES}" "La Bicicleta" "ROAD-CICLOCROSS" >> ${OUTPUT_FILE}

#### URBAN-ELECTRIC ####
URBAN_ELECTRIC_BASE="urban-electric"
URBAN_ELECTRIC_PAGES=""

process_pages_raw "${URBAN_ELECTRIC_BASE}" "${URBAN_ELECTRIC_PAGES}" "La Bicicleta" "URBAN-ELECTRIC" >> ${OUTPUT_FILE}