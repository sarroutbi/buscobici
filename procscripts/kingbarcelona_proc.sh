#!/bin/bash
#
# Copyright © 2012-2013 Sergio Arroutbi Braojos <sarroutbi@gmail.com>
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

MAX_PRICE=5
OUTPUT_FILE=./output
BASE_URL="http://www.kingbarcelona.com"
NO_CAMEL_MIN=6
NO_CAMEL_TRADEMARK_MIN=0
MODEL_DOWN_SEARCH=10
MAX_PRICE_SEARCH=1
MAX_PRICE_SEARCH2=1
URL="www.kingbarcelona.com"
ONLY_DOMAIN="kingbarcelona.com"

#### KEYS GENERATED
TRADEMARK_KEY="TRADEMARK"
SUBURL_KEY="SUBURL"
STORE_KEY="STORE"
PRICE_KEY="PRICE"
KIND_KEY="KIND"

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
  PRICE=$(grep "${MODEL}" "${FILE}" | grep 'Precio:' | awk -F ">Precio" {'print $2'} | awk -F "</span>" {'print $1'} | head -1 | egrep -E -o "[0-9]{1,2},{0,1}[0-9]{2,3}.{1}[0-9]{2}")
  PRICE_NO_SPACE=$(echo ${PRICE} | tr -d ',' | tr '.' ',' | tr -d ' ')
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

function clean_model()
{
    MODEL="${1}"
    MODEL_CLEAN=($bubic_clean "${MODEL}")
    echo "${MODEL_CLEAN}" | grep ^"Bici ni" 2>&1 >/dev/null
    if [ $? -eq 0 ];
    then
      echo "${MODEL_CLEAN}" | awk {'for(i=3;i<=NF;++i){printf $i; if(i<NF){printf " "}}'}
    else
      echo "${MODEL_CLEAN}" | grep ^"Bici KTM ni" 2>&1 >/dev/null
      if [ $? -eq 0 ];
      then
        echo "${MODEL_CLEAN}" | awk {'for(i=4;i<=NF;++i){printf $i; if(i<NF){printf " "}}'}
      else
        echo "${MODEL_CLEAN}"
      fi
    fi
}

function dump_bike_from_file()
{
  FILE="$1"
  STORE="$2"
  TYPE="$3"
  TRADEMARK_MODELS=$(cat "${FILE}" | grep '<td class="productListing-data">' | sed -e 's!&nbsp;!!g' | grep "a href=" | awk -F "</a>" {'print $1'} | sed -e 's/<[^>]*>//g')
  TRADEMARK_MODELS_HTML=$(cat "${FILE}" | grep '<td class="productListing-data">')
  echo "${TRADEMARK_MODELS}" | while read trademark_model;
  do 
    test -z "${trademark_model}" && continue;
    TRADEMARK_MODEL="${trademark_model}"
    TRADEMARK_MODEL_CLEAN=$(bubic_clean "${TRADEMARK_MODEL}")
    TRADEMARK=$(echo "${TRADEMARK_MODEL_CLEAN}" | awk {'print $1'})
    TRADEMARK_CAMEL=$(camel "${TRADEMARK}" ${NO_CAMEL_TRADEMARK_MIN})
    if [ "${TRADEMARK_CAMEL}" = "Solid" ];
    then
      TRADEMARK_CAMEL="Solid Bikes"
      MODEL=$(echo "${TRADEMARK_MODEL_CLEAN}" | awk {'for(i=3;i<=NF;++i){printf $i; if(i<NF){printf " "}}'} | tr -d '\r' | tr "'" '"')
    else 
      MODEL=$(echo "${TRADEMARK_MODEL_CLEAN}" | awk {'for(i=2;i<=NF;++i){printf $i; if(i<NF){printf " "}}'} | tr -d '\r' | tr "'" '"')
    fi
    MODEL_CAMEL=$(camel "${MODEL}" "${NO_CAMEL_MIN}")
    URL=$(grep "${trademark_model}" "${FILE}" | grep '<td class="productListing-data">' | grep "<a href" | awk -F "a href=" {'print $2'} | awk {'print $1'} | head -1 | tr -d '"')
    FINAL_URL=$(echo "\"${URL}\"")
    PRICE=$(print_price "${FILE}" "${TRADEMARK_MODEL}")
    #echo "========================================================================"
    #echo "FILE=${FILE}"
    #echo "TRADEMARK_MODEL=${TRADEMARK_MODEL}"
    #echo "TRADEMARK_MODEL_CLEAN=${TRADEMARK_MODEL_CLEAN}"
    #echo "TRADEMARK=${TRADEMARK}"
    #echo "TRADEMARK_CAMEL=${TRADEMARK_CAMEL}"
    #echo "MODEL=${MODEL}"
    #echo "URL=${FINAL_URL}"
    #echo "PRICE=${PRICE}"
    #echo "STORE=${STORE}"
    #echo "TYPE=${TYPE}"
    #echo "========================================================================"
    dump_bike "${MODEL_CAMEL}" "${FINAL_URL}" "${TRADEMARK_CAMEL}" "${PRICE}" "${STORE}" "${TYPE}"
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
      dump_bike_from_file "${BASE_FILE}-${page}" "${STORE}" "${TYPE}"
    done
  fi
}

> ${OUTPUT_FILE}

MTB_FIX_29_BIKES_BASE="mtb-fix-29"
MTB_FIX_29_BIKES_PAGES="$(seq 1 1)"

MTB_FIX_29_CARBON_BIKES_BASE="mtb-fix-29-carbon"
MTB_FIX_29_CARBON_BIKES_PAGES="$(seq 1 2)"

MTB_FIX_275_BIKES_BASE="mtb-fix-275"
MTB_FIX_275_BIKES_PAGES="$(seq 1 1)"

MTB_FIX_275_CARBON_BIKES_BASE="mtb-fix-275-carbon"
MTB_FIX_275_CARBON_BIKES_PAGES="$(seq 1 1)"

MTB_DOUBLE_29_BIKES_BASE="mtb-double-29"
MTB_DOUBLE_29_BIKES_PAGES="$(seq 1 1)"

MTB_DOUBLE_29_CARBON_BIKES_BASE="mtb-double-29-carbon"
MTB_DOUBLE_29_CARBON_BIKES_PAGES="$(seq 1 1)"

MTB_DOUBLE_275_BIKES_BASE="mtb-double-275"
MTB_DOUBLE_275_BIKES_PAGES="$(seq 1 1)"

MTB_DOUBLE_275_CARBON_BIKES_BASE="mtb-double-275-carbon"
MTB_DOUBLE_275_CARBON_BIKES_PAGES="$(seq 1 1)"

ROAD_BIKES_BASE="road"
ROAD_BIKES_PAGES="$(seq 1 2)"

ROAD_DISC_BIKES_BASE="road-disc"
ROAD_DISC_BIKES_PAGES="$(seq 1 1)"

ROAD_CICLOCROSS_BIKES_BASE="road-ciclocross"
ROAD_CICLOCROSS_BIKES_PAGES="$(seq 1 1)"

URBAN_ELECTRIC_BIKES_BASE="urban-electric"
URBAN_ELECTRIC_BIKES_PAGES="$(seq 1 1)"

URBAN_BIKES_BASE="urban"
URBAN_BIKES_PAGES="$(seq 1 1)"

URBAN_FOLDING_BIKES_BASE="urban-folding"
URBAN_FOLDING_BIKES_PAGES="$(seq 1 1)"

URBAN_FAT_BIKES_BASE="urban-fat"
URBAN_FAT_BIKES_PAGES="$(seq 1 1)"

KIDS_BIKES_BASE="kids"
KIDS_BIKES_PAGES="$(seq 1 1)"

KIDS_BTT_BIKES_BASE="kids-btt"
KIDS_BTT_BIKES_PAGES="$(seq 1 1)"

process_pages "${ROAD_BIKES_BASE}" "${ROAD_BIKES_PAGES}" "King Barcelona" "ROAD" >> ${OUTPUT_FILE}
process_pages "${MTB_FIX_29_BIKES_BASE}" "${MTB_FIX_29_BIKES_PAGES}" "King Barcelona" "MTB-FIX-29" >> ${OUTPUT_FILE}
process_pages "${MTB_FIX_29_CARBON_BIKES_BASE}" "${MTB_FIX_29_CARBON_BIKES_PAGES}" "King Barcelona" "MTB-FIX-29" >> ${OUTPUT_FILE}
process_pages "${MTB_FIX_275_BIKES_BASE}" "${MTB_FIX_275_BIKES_PAGES}" "King Barcelona" "MTB-FIX-275" >> ${OUTPUT_FILE}
process_pages "${MTB_FIX_275_CARBON_BIKES_BASE}" "${MTB_FIX_275_CARBON_BIKES_PAGES}" "King Barcelona" "MTB-FIX-275" >> ${OUTPUT_FILE}
process_pages "${MTB_DOUBLE_29_BIKES_BASE}" "${MTB_DOUBLE_29_BIKES_PAGES}" "King Barcelona" "MTB-DOUBLE-29" >> ${OUTPUT_FILE}
process_pages "${MTB_DOUBLE_29_CARBON_BIKES_BASE}" "${MTB_DOUBLE_29_CARBON_BIKES_PAGES}" "King Barcelona" "MTB-DOUBLE-29" >> ${OUTPUT_FILE}
process_pages "${MTB_DOUBLE_275_BIKES_BASE}" "${MTB_DOUBLE_275_BIKES_PAGES}" "King Barcelona" "MTB-DOUBLE-275" >> ${OUTPUT_FILE}
process_pages "${MTB_DOUBLE_275_CARBON_BIKES_BASE}" "${MTB_DOUBLE_275_CARBON_BIKES_PAGES}" "King Barcelona" "MTB-DOUBLE-275" >> ${OUTPUT_FILE}
process_pages "${ROAD_BIKES_BASE}" "${ROAD_BIKES_PAGES}" "King Barcelona" "ROAD" >> ${OUTPUT_FILE}
process_pages "${ROAD_DISC_BIKES_BASE}" "${ROAD_DISC_BIKES_PAGES}" "King Barcelona" "ROAD" >> ${OUTPUT_FILE}
process_pages "${ROAD_CICLOCROSS_BIKES_BASE}" "${ROAD_CICLOCROSS_BIKES_PAGES}" "King Barcelona" "ROAD-CICLOCROSS" >> ${OUTPUT_FILE}
process_pages "${URBAN_ELECTRIC_BIKES_BASE}" "${URBAN_ELECTRIC_BIKES_PAGES}" "King Barcelona" "URBAN-ELECTRIC" >> ${OUTPUT_FILE}
process_pages "${URBAN_BIKES_BASE}" "${URBAN_BIKES_PAGES}" "King Barcelona" "URBAN" >> ${OUTPUT_FILE}
process_pages "${URBAN_FOLDING_BIKES_BASE}" "${URBAN_FOLDING_BIKES_PAGES}" "King Barcelona" "URBAN-FOLDING" >> ${OUTPUT_FILE}
process_pages "${URBAN_FAT_BIKES_BASE}" "${URBAN_FAT_BIKES_PAGES}" "King Barcelona" "URBAN" >> ${OUTPUT_FILE}
process_pages "${KIDS_BIKES_BASE}" "${KIDS_BIKES_PAGES}" "King Barcelona" "KIDS" >> ${OUTPUT_FILE}
process_pages "${KIDS_BTT_BIKES_BASE}" "${KIDS_BTT_BIKES_PAGES}" "King Barcelona" "KIDS" >> ${OUTPUT_FILE}
