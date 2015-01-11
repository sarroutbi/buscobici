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
#
URL_BASE="http://www.biciescapa.com"
MAX_PRICE=15
NO_CAMEL_MODEL_MIN=0
NO_CAMEL_TRADEMARK_MIN=0
OUTPUT_FILE=./output
#OUTPUT_FILE=/dev/stdout

#### KEYS GENERATED
TRADEMARK_KEY="TRADEMARK"
SUBURL_KEY="SUBURL"
STORE_KEY="STORE"
PRICE_KEY="PRICE"
KIND_KEY="KIND"

### INCLUDE COMMON PROC
. ./common_proc

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

# Params
# 1 - Model:     [MODEL]
# 2 - Url:       SUBURL="www.whatever.es"
# 3 - Trademark: TRADEMARK=Trek
# 4 - Price:     PRICE=100000,99
# 5 - Store:     STORE=Mammoth
# 6 - Kind:      KIND=MTB
function dump_bike()
{
  # Line to print entries with some error:
  #if [[ "$1" = "" ]] || [[ "$2" = "" ]] || [[ "$3" = "" ]] \
  #    || [[ "$4" = "" ]]  || [[ "$5" = "" ]]  || [[ "$6" = "" ]];

  if [[ "$1" != "" ]] && [[ "$2" != "" ]] && [[ "$3" != "" ]] \
      && [[ "$4" != "" ]]  && [[ "$5" != "" ]]  && [[ "$6" != "" ]];
  then
    echo "[$1]"
    echo "${SUBURL_KEY}=\"$2\""
    echo "${TRADEMARK_KEY}=$3"
    echo "${PRICE_KEY}=$4"
    echo "${STORE_KEY}=$5"
    echo "${KIND_KEY}=$6"
    echo 
  fi
}

# Params:
# 1 - The URL of bike
function filter_model()
{
  #echo "======================================"
  # MODEL=$(echo "$1" | sed -e 's/[Bb]icicleta//g' | tr "'" '"')
  MODEL=$(echo "$1" | sed -e 's/[Bb]icicleta//g' | sed -e "s/''/\\\"/g")
  MODEL_FILTER=$(echo "${MODEL}" | sed -e 's/[Bb]icicleta//g' | sed -e "s/'/\\\"/g" | sed -e 's/\.\.\.//g')
  # | sed -e 's!\'!\\\'!g')
  #  echo "======> MODEL:${1} <========="
  echo ${MODEL_FILTER}
  #echo "======================================"
}

# Params:
# 1 - The FILE  of bike
# 2 - The MODEL of bike
function print_price()
{
  PRICE=$(grep "$2" "$1" -A${MAX_PRICE} | egrep -E "[0-9]{0,}\.{0,}[0-9]{1,}[0-9]{1,},[0-9]{1,}" | tr -d '.' | tr -d '\r' | tr -d '\n' | sed -e 's/<[^>]*>//g' | awk {'print $1'})
  echo ${PRICE}
}

function print_url()
{
  model="$1"
  BASE_FILE="$2"
  echo "${model}" | grep '"' > /dev/null
  URL=$(grep "${model}" "${BASE_FILE}" | grep '<h3>' | awk -F "href=" {'print $2'} | awk {'print $1'} | head -1 | tr -d '"' | sed -e 's/[ \t]$//g' | sed -e 's/Comprar//g')
  URL_COMPLETE="${URL}"
  echo "${URL_COMPLETE}"
}

function print_trademark_url()
{
  wget -o /dev/null -O - "$1" | grep '<title>' | sed -e 's/<[^>]*>//g' | awk {'print $1'} | grep -v "a href" | sed -e 's/Comprar//g'
}

function print_price_url()
{  
  wget -o /dev/null -O - "$1" | grep our_price_display | sed -e 's/<[^>]*>//g' | tr -d "." | sed -e 's/^[ \t]//g' | egrep -E  "[0-9]{0,}\.{0,}[0-9]{1,}[0-9]{1,},[0-9]{1,}" -o
}

function process_page_url()
{
  BASE_FILE="$1"
  STORE="$2"
  TYPE="$3"
  cat "${BASE_FILE}" | egrep -E '<h3>' | grep '<a href=' | tr -d '\r' | while read model_url_line;
  do
    TRADEMARK_MODEL=$(echo "${model_url_line}" | sed -e 's/<[^>]*>//g')
    URL=$(echo "${model_url_line}" | awk -F '<a href=' {'print $2'} | awk {'print $1'})
    URL_NO_QUOTES=$(echo ${URL} | tr -d '"')
    TRADEMARK=$(echo ${TRADEMARK_MODEL} | awk {'print $1'})
    TRADEMARK_CLEAN=$(bubic_clean "${TRADEMARK}")
    TRADEMARK_CAMEL=$(bubic_camel "${TRADEMARK_CLEAN}" ${NO_CAMEL_TRADEMARK_MIN})
    MODEL=$(echo ${TRADEMARK_MODEL} | awk {'for(i=2;i<=NF;++i){printf $i; if(i<NF){printf " "}}'})
    MODEL_CLEAN=$(bubic_clean "${MODEL}")
    MODEL_CAMEL=$(bubic_camel "${MODEL_CLEAN}" ${NO_CAMEL_MODEL_MIN})
    PRICE=$(print_price_url ${URL_NO_QUOTES})
    #echo "========================================================================"
    #echo "LINE=${model_url_line}"
    #echo "TRADEMARK=${TRADEMARK_CAMEL}"
    #echo "MODEL=${MODEL_CAMEL}"
    #echo "URL=${URL}"
    #echo "PRICE=${PRICE}"
    #echo "STORE=${STORE}"
    #echo "TYPE=${TYPE}"
    #echo "FILE=${BASE_FILE}"
    #echo "========================================================================"
    bubic_dump_bike "${MODEL_CAMEL}" "${URL}" "${TRADEMARK_CAMEL}" "${PRICE}" "${STORE}" "${TYPE}"
  done
}

function process_pages()
{
  BASE_URL="$1"
  PAGES="$2"
  STORE="$3"
  TYPE="$4"
  if [ "${PAGES}" = "" ];
  then
    process_page_url "${BASE_URL}" "${STORE}" "${TYPE}"
  else
    for page in ${PAGES};
    do
      process_page_url "${BASE_URL}${page}" "${STORE}" "${TYPE}"
    done 
  fi
}

MTB_FIX_BIKES_BASE="12-bicicletas-rigidas?p="
MTB_FIX_BIKES_PAGES="$(seq 1 13)"

MTB_DOUBLE_BIKES_BASE="14-doble-suspensio?p="
MTB_DOUBLE_BIKES_PAGES="$(seq 1 10)"

MTB_DOWN_BIKES_BASE="13-descenso"
MTB_DOWN_BIKES_PAGES=""

MTB_ELECTRIC_BIKES_BASE="55932276-btt-electricas?p"
MTB_ELECTRIC_BIKES_PAGES="$(seq 1 3)"

ROAD_BIKES_BASE="8-carretera?p="
ROAD_BIKES_PAGES="$(seq 1 8)"

BMX_BIKES_BASE="9-bmx-freestyle"
BMX_BIKES_PAGES=""

URBAN_BIKES_BASE="10-bicicletas-paseo-electricas?p="
URBAN_BIKES_PAGES="$(seq 1 8)"

FOLDING_BIKES_BASE="11-plegables?p="
FOLDING_BIKES_PAGES="$(seq 1 2)"

KIDS_BIKES_BASE="61-junior?p="
KIDS_BIKES_PAGES="$(seq 1 5)"

> ${OUTPUT_FILE}

process_pages "${MTB_FIX_BIKES_BASE}"    "${MTB_FIX_BIKES_PAGES}"    "Bici Escapa" "MTB-FIX"      >> ${OUTPUT_FILE}
process_pages "${MTB_DOUBLE_BIKES_BASE}" "${MTB_DOUBLE_BIKES_PAGES}" "Bici Escapa" "MTB-DOUBLE" >> ${OUTPUT_FILE}
process_pages "${MTB_DOWN_BIKES_BASE}"   "${MTB_DOWN_BIKES_PAGES}"   "Bici Escapa" "MTB-DOUBLE" >> ${OUTPUT_FILE}
process_pages "${MTB_29_BIKES_BASE}"     "${MTB_29_BIKES_PAGES}"     "Bici Escapa" "MTB-29" >> ${OUTPUT_FILE}
process_pages "${MTB_ELECTRIC_BIKES_BASE}" "${MTB_ELECTRIC_BIKES_PAGES}"   "Bici Escapa" "MTB-ELECTRIC" >> ${OUTPUT_FILE}
process_pages "${ROAD_BIKES_BASE}"       "${ROAD_BIKES_PAGES}"       "Bici Escapa" "ROAD" >> ${OUTPUT_FILE}
process_pages "${BMX_BIKES_BASE}"        "${BMX_BIKES_PAGES}"        "Bici Escapa" "BMX" >> ${OUTPUT_FILE}
process_pages "${URBAN_BIKES_BASE}"      "${URBAN_BIKES_PAGES}"      "Bici Escapa" "URBAN" >> ${OUTPUT_FILE}
process_pages "${FOLDING_BIKES_BASE}"    "${FOLDING_BIKES_PAGES}"    "Bici Escapa" "URBAN-FOLDING" >> ${OUTPUT_FILE}
process_pages "${KIDS_BIKES_BASE}"       "${KIDS_BIKES_PAGES}"       "Bici Escapa" "KIDS" >> ${OUTPUT_FILE}
