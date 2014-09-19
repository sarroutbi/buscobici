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
#OUTPUT_FILE=/dev/stdout
OUTPUT_FILE=./output
BASE_URL="http://www.mundoebikes.es"
NO_CAMEL_MIN=6
NO_CAMEL_TRADEMARK_MIN=0
MODEL_DOWN_SEARCH=10
MAX_PRICE_SEARCH=20
MAX_PRICE_SEARCH2=25
URL="www.mundoebikes.es"
ONLY_DOMAIN="mundoebikes.es"

#### KEYS GENERATED
TRADEMARK_KEY="TRADEMARK"
SUBURL_KEY="SUBURL"
STORE_KEY="STORE"
PRICE_KEY="PRICE"
KIND_KEY="KIND"

#### LOAD COMMON COMPONENTS
. ./common_proc

# Params
# 1 - Model:     [MODEL]
# 2 - Url:       SUBURL="www.whatever.es"
# 3 - Trademark: TRADEMARK=Trek
# 4 - Price:     PRICE=100000,99
# 5 - Store:     STORE=Mammoth
# 6 - Kind:      KIND=MTB
function dump_bike()
{
  if [[ "$1" != "" ]] && [[ "$2" != "" ]] && [[ "$3" != "" ]] \
      && [[ "$4" != "" ]]  && [[ "$5" != "" ]]  && [[ "$6" != "" ]];
  then
    echo "[$1]"
    echo "${SUBURL_KEY}=$2"
    echo "${TRADEMARK_KEY}=$3"
    echo "${PRICE_KEY}=$4"
    echo "${STORE_KEY}=$5"
    echo "${KIND_KEY}=$6"
    echo 
  fi
}

# Params:
# 1 - The URL of bike
function print_model()
{
  URL="$1"
  FILE="$2"
  #echo "================== MODEL ===================="
  grep "${URL}" "${FILE}" | sed -e 's/<[^>]*>//g' | sed -e 's/[Bb]icicleta //g' \
| sed -e 's/[Cc]arretera //g' | sed -e 's/[Cc]iclocross //g' | sed -e 's/[Mm]onta.a //g' | sed -e 's/[Tt]rial //g' | sed -e 's/[Tt]rekking//g' | sed -e 's/[Tt]riatl.n//g' | sed -e 's/[Dd]escenso //g' | sed -e 's/[Dd]irt //g' | sed -e 's-dirt/freeride--g' | sed -e 's-dirt/street--g' | sed -e 's/[Dd]oble //g' | sed -e 's/[Ff]reeride //g' | sed -e 's/[Pp]aseo//g' | sed -e 's/[Pp]legable//g' | sed -e 's/[Ii]nfantil //g' | sed -e 's/[Ee]l.ctrica //g' | sed -e 's/[Mm]inibike//g' | sed -e 's/[Ss]uspensi.on //g' | sed -e 's/[Tt]riciclo //g' | sed -e 's/[Ss]tick//g' | sed -e 's/[Ss]uspensi.n //g' | sed -e 's/de //g' | sed -e 's/BTT //g' | sed -e 's/BMX //g' | sed -e 's/TRAIL //g' | sed -e 's/[Ss]ill.n //g' | sed -e 's/[Ee]l.ctrico //g' | sed -e 's/[Ss]ill.n //g' | sed -e 's/[Ss]oporte //g' | sed -e 's/[Cc]erradura + llaves//g' | sed -e 's/[Dd]isplay //g'
  #echo "================== MODEL ===================="
}

# Params:
# 1 - The File of bike
# 2 - The model of bike
function print_price()
{
  FILE="$1"
  MODEL="$2"
  PRICE=$(grep "${MODEL}" "${FILE}" -A${MAX_PRICE_SEARCH} | grep "productPrice"| sed -e 's/<[^>]*>//g' | egrep -o -E "[0-9]{1,} {0,1}[0-9]{1,3}.{0,1}[0-9]{0,}" | head -1)
  PRICE_NO_SPACE=$(echo ${PRICE} | tr -d ' ' | tr '.' ',')
  echo ${PRICE_NO_SPACE}
}

# Params:
# 1 - The sentence
# 2 - The min size to camelize
function camel()
{
  let counter=0
  for word in ${1};
  do
    let counter=${counter}+1
  done
  let counter2=0
  for word in ${1};
  do
    let len=${#word}
    let counter2=${counter2}+1
    if [ ${len} -ge ${2} ]; then
      firstLetter=$(echo "${word:0:1}")
      rest=$(echo ${word:1} | tr "[A-Z]" "[a-z]") 
      if [ ${counter2} -lt ${counter} ];
      then
        echo -n "${firstLetter}${rest} "
      else
        echo -n "${firstLetter}${rest}"
      fi
    else
      if [ ${counter2} -lt ${counter} ];
      then
        echo -n "${word} "
      else
        echo -n "${word}"
      fi
    fi
  done
  echo
}

function dump_bike_from_file()
{
  FILE="$1"
  STORE="$2"
  TYPE="$3"
#  cat "${FILE}" | sed -e 's@<div class="product-meta">@\n<div class="product-meta">@g' | grep ^'<div class="product-meta">' | sed -e 's@<div class="image ">@\n<div class="image ">@g' | grep ^'<div class="product-meta"' | while read line;
  cat "${FILE}" | sed -e 's@<div class="product-image-container">@\n<div class="product-image-container">@g' | sed -e 's@<div class="left-block">@\n<div class="left-block">@g' | grep ^'<div class="product-image-container">' | while read line;
  do 
    TRADEMARK_MODEL=$(echo ${line} | awk -F 'title=' {'print $2'} | awk -F '"' {'print $2'} | tr -d '"' | sed -e 's/^[ ]*//g')
    TRADEMARK_MODEL_CLEAN=$(bubic_clean "${TRADEMARK_MODEL}" | sed -e 's/^[ ]*//g')
    TRADEMARK=$(echo ${TRADEMARK_MODEL_CLEAN} | awk {'print $1'})
    TRADEMARK_CAMEL=$(bubic_camel "${TRADEMARK}" ${NO_CAMEL_TRADEMARK_MIN} | sed -e 's/Q.er/Quer/g')
    MODEL=$(echo "${TRADEMARK_MODEL_CLEAN}" | awk {'for(i=2;i<=NF;i++){printf $i; if(i<NF) {printf " "}}'} | sed -e 's@\.\.\.@@g')
    MODEL_CAMEL=$(bubic_camel "${MODEL}" ${NO_CAMEL_MODEL_MIN})
    URL=$(echo ${line} | awk -F "href=" {'print $2'} | awk {'print $1'})
    PRICE=$(echo ${line} | awk -F 'class="price product-price">' {'print $2'} | awk -F "</span>" {'print $1'} | egrep -E "[0-9]{1,2}[ ]{0,1}[0-9]{2,5},[0-9]{0,2}" -o | tr -d ' ')
    #echo "========================================================================"
    #echo "FILE:${FILE}"
    #echo "LINE:${line}"
    #echo "TRADEMARK_MODEL=${TRADEMARK_MODEL}"
    #echo "TRADEMARK_MODEL_CLEAN=${TRADEMARK_MODEL_CLEAN}"
    #echo "TRADEMARK=${TRADEMARK}"
    #echo "TRADEMARK_CAMEL=${TRADEMARK_CAMEL}"
    #echo "MODEL=${MODEL}"
    #echo "MODEL_CAMEL=${MODEL_CAMEL}"
    #echo "URL=${URL}"
    #echo "PRICE=${PRICE}"
    #echo "STORE=${STORE}"
    #echo "TYPE=${TYPE}"
    #echo "========================================================================"
    dump_bike "${MODEL_CAMEL}" "${URL}" "${TRADEMARK_CAMEL}" "${PRICE}" "${STORE}" "${TYPE}"
  done
}

function process_pages()
{
  BASE_FILE="$1"
  PAGES="$2"
  STORE="$3"
  TYPE="$4"

  if [ "${PAGES}" = "" ];
  then
    dump_bike_from_file "${BASE_FILE}" "${STORE}" "${TYPE}"
  else
    for page in ${PAGES};
    do 
      #echo "dump_bike_from_file ${BASE_FILE}-${page} ${STORE} ${TYPE}"
      dump_bike_from_file "${BASE_FILE}-${page}" "${STORE}" "${TYPE}"
    done
  fi
}

> ${OUTPUT_FILE}

### BMX ###
BMX_BIKES_BASE="bmx"
BMX_BIKES_PAGES="$(seq 1 2)"

### ROAD ###
ROAD_BIKES_BASE="road"
ROAD_BIKES_PAGES="$(seq 1 4)"

ROAD_TRIATLON_BASE="road-triatlon"
ROAD_TRIATLON_PAGES="$(seq 1 2)"

### URBAN ###
URBAN_RETRO_BASE="urban-retro"
URBAN_RETRO_PAGES="$(seq 1 8)"

URBAN_CITY_BASE="urban-city"
URBAN_CITY_PAGES="$(seq 1 8)"

URBAN_CRUISER_BASE="urban-cruiser"
URBAN_CRUISER_PAGES="$(seq 1 5)"

URBAN_FOLDING_BIKES_BASE="urban-folding"
URBAN_FOLDING_BIKES_PAGES="$(seq 1 3)"

URBAN_FIXIE_BASE="urban-fixie"
URBAN_FIXIE_PAGES="$(seq 1 2)"

URBAN_ELECTRIC_BIKES_BASE="urban-electric"
URBAN_ELECTRIC_BIKES_PAGES="$(seq 1 3)"

URBAN_EFOLDING_BIKES_BASE="urban-folding-electric"
URBAN_EFOLDING_BIKES_PAGES="$(seq 1 2)"

URBAN_TREKKING_BASE="urban-trekking"
URBAN_TREKKING_PAGES="$(seq 1 2)"

URBAN_WORK_BASE="urban-work"
URBAN_WORK_PAGES="$(seq 1 2)"

### MTB ###
MTB_BIKES_BASE="mtb"
MTB_BIKES_PAGES="$(seq 1 15)"

MTB_ELECTRIC_BIKES_BASE="mtb-electric"
MTB_ELECTRIC_BIKES_PAGES="$(seq 1 2)"

### KIDS ###
KIDS_BIKES_BASE="kids"
KIDS_BIKES_PAGES="$(seq 1 6)"

KIDS_MTB_BIKES_BASE="kids-mtb"
KIDS_MTB_BIKES_PAGES="$(seq 1 5)"

### BMX ###
process_pages "${BMX_BIKES_BASE}" "${BMX_BIKES_PAGES}" "MundoEbikes" "BMX" >> ${OUTPUT_FILE}

### ROAD ###
process_pages "${ROAD_BIKES_BASE}" "${ROAD_BIKES_PAGES}" "MundoEbikes" "ROAD" >> ${OUTPUT_FILE}
process_pages "${ROAD_TRIATLON_BASE}" "${ROAD_TRIATLON_PAGES}" "MundoEbikes" "ROAD" >> ${OUTPUT_FILE}

### URBAN ###
process_pages "${URBAN_RETRO_BASE}" "${URBAN_RETRO_PAGES}" "MundoEbikes" "URBAN" >> ${OUTPUT_FILE}
process_pages "${URBAN_CITY_BASE}" "${URBAN_CITY_PAGES}" "MundoEbikes" "URBAN" >> ${OUTPUT_FILE}
process_pages "${URBAN_CRUISER_BASE}" "${URBAN_CRUISER_PAGES}" "MundoEbikes" "URBAN" >> ${OUTPUT_FILE}

process_pages "${URBAN_FOLDING_BIKES_BASE}" "${URBAN_FOLDING_BIKES_PAGES}" "MundoEbikes" "URBAN-FOLDING" >> ${OUTPUT_FILE}
process_pages "${URBAN_FIXIE_BASE}" "${URBAN_FIXIE_PAGES}" "MundoEbikes" "URBAN-FIXIE" >> ${OUTPUT_FILE}
process_pages "${URBAN_ELECTRIC_BIKES_BASE}" "${URBAN_ELECTRIC_BIKES_PAGES}" "MundoEbikes" "URBAN-ELECTRIC" >> ${OUTPUT_FILE}
process_pages "${URBAN_EFOLDING_BIKES_BASE}" "${URBAN_EFOLDING_BIKES_PAGES}" "MundoEbikes" "URBAN-FOLDING-ELECTRIC" >> ${OUTPUT_FILE}
process_pages "${URBAN_TREKKING_BASE}" "${URBAN_TREKKING_PAGES}" "MundoEbikes" "URBAN" >> ${OUTPUT_FILE}
process_pages "${URBAN_WORK_BASE}" "${URBAN_WORK_PAGES}" "MundoEbikes" "URBAN" >> ${OUTPUT_FILE}

### MTB ###
process_pages "${MTB_BIKES_BASE}" "${MTB_BIKES_PAGES}" "MundoEbikes" "MTB" >> ${OUTPUT_FILE}
process_pages "${MTB_ELECTRIC_BIKES_BASE}" "${MTB_ELECTRIC_BIKES_PAGES}" "MundoEbikes" "MTB-ELECTRIC" >> ${OUTPUT_FILE}

### KIDS ###
process_pages "${KIDS_BIKES_BASE}" "${KIDS_BIKES_PAGES}" "MundoEbikes" "KIDS" >> ${OUTPUT_FILE}
process_pages "${KIDS_MTB_BIKES_BASE}" "${KIDS_MTB_BIKES_PAGES}" "MundoEbikes" "KIDS-MTB" >> ${OUTPUT_FILE}
