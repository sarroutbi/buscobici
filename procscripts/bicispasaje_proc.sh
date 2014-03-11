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

MAX_PRICE=2
OUTPUT_FILE=./output
#OUTPUT_FILE=/dev/stdout
BASE_URL="http://www.bicispasaje.es"
NO_CAMEL_MIN=6
NO_CAMEL_TRADEMARK_MIN=0
MAX_PRICE_SEARCH=35
URL="www.bicispasaje.es"
ONLY_DOMAIN="bicispasaje.es"

#### KEYS GENERATED
TRADEMARK_KEY="TRADEMARK"
SUBURL_KEY="SUBURL"
STORE_KEY="STORE"
PRICE_KEY="PRICE"
KIND_KEY="KIND"

# Params
# 1 - Model:     [MODEL]
# 2 - Url:       SUBURL="www.whatever.es"
# 3 - Trademark: TRADEMARK=Trek
# 4 - Price:     PRICE=100000,99
# 5 - Store:     STORE=Mammoth
# 6 - Kind:      KIND=MTB
function dump_bike()
{
  #if [[ "$1" != "" ]] && [[ "$2" != "" ]] && [[ "$3" != "" ]] \
  #    && [[ "$4" != "" ]] && [[ "$4" -gt 50 ]] && [[ "$5" != "" ]]  && [[ "$6" != "" ]];
  if [[ "$1" != "" ]];
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
# 1 - The File of bike
# 2 - The model of bike
function print_price()
{
  FILE="$1"
  MODEL="$2"
  PRICE=$(echo "$1" | grep "${2}" | awk -F '<span class="price"' {'print $2'} | awk -F "/span>" {'print $1'} | awk -F ">" {'print $2'} | awk -F "<" {'print $1'})
  echo ${PRICE} | awk -F "€" {'print $1'} | tr -d " "
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

function process_one_page()
{
  BASE_FILE="$1"
  STORE="$2"
  TYPE="$3"

  TRADEMARK_MODELS=$(cat ${BASE_FILE} | awk -F "<h3>" {'print $2'} | awk -F "</h3>" {'print $1'} | sed -e 's/<[^>]*>//g' | egrep -E ^[A-Z,a-z,0-9])
  echo "${TRADEMARK_MODELS}" | while read line;
  do
    PRICE=$(grep "${line}" "${BASE_FILE}" | awk -F '<span class="price">' {'print $2'} | awk -F '</span>' {'print $1'} | tr -d " " | tr -d "€" | tail -1)
    URL=$(grep "${line}" "${BASE_FILE}" | sed -e 's/href=/\nhref=/g' | awk -F "href=" {'print $2'} | awk {'print $1'} | tail -1)
    TRADEMARK_MODEL=$(echo ${line} | awk -F '</h3>' {'print $1'} | sed -e 's/<[^>]*>//g' )
    TRADEMARK=$(echo ${TRADEMARK_MODEL} | awk {'print $1'})
    MODEL=$(echo "${TRADEMARK_MODEL}" | awk {'for(i=2;i<=NF;++i){printf $i; if(i<NF){printf " "}}'} | tr -d '\r')
    MODEL_CAMEL=$(camel "${MODEL}" ${NO_CAMEL_MIN})
    TRADEMARK_CAMEL=$(camel "${TRADEMARK}" ${NO_CAMEL_TRADEMARK_MIN})
    #echo "============================================================"
    #echo "LINE=${line}"
    #echo "TRADEMARK_MODEL=${TRADEMARK_MODEL}"
    #echo "TRADEMARK=${TRADEMARK}"
    #echo "TRADEMARK_CAMEL=${TRADEMARK_CAMEL}"
    #echo "MODEL=${MODEL}"
    #echo "MODEL_CAMEL=${MODEL_CAMEL}"
    #echo "PRICE=${PRICE}"
    #echo "URL=${URL}"
    #echo "STORE=${STORE}"
    #echo "TYPE=${TYPE}"
    #echo "============================================================"
    dump_bike "${MODEL_CAMEL}" "${URL}" "${TRADEMARK_CAMEL}" "${PRICE}" "${STORE}" "${TYPE}"
  done
}

function process_pages()
{
  THE_FILE="$1"
  PAGES="$2"
  STORE="$3"
  TYPE="$4"
  if [ "${PAGES}" = "" ];
  then
    process_one_page "${THE_FILE}" "${STORE}" "${TYPE}"
  else
    for page in ${PAGES}
    do
      process_one_page "${THE_FILE}?p=${page}" "${STORE}" "${TYPE}"
    done
  fi
}

> ${OUTPUT_FILE}

MTB_BIKES_26_BASE="7-mtb-rigidas"
MTB_BIKES_27_5_BASE="158-mtb-rígida-275"
MTB_BIKES_27_5_PAGES="$(seq 1 3)"
MTB_BIKES_29_BASE="10-mtb-rígida-29er"
MTB_BIKES_29_PAGES="$(seq 1 3)"
MTB_BIKES_DOUBLE_26_BASE="17-doble-susp-26"
MTB_BIKES_DOUBLE_27_5_BASE="164-doble-susp-275-"
MTB_BIKES_DOUBLE_29_BASE="21-doble-susp-29er"
ROAD_BIKES_BASE="31-carretera"
ROAD_BIKES_PAGES="$(seq 1 4)"
ROAD_TRIATLON_BIKES_BASE="142-triatlón"
KIDS_BIKES_BASE="34-infantiles"
WOMAN_BIKES_BASE="122-dama"
URBAN_BIKES_BASE="153-trekking-ciudad"

process_pages "${MTB_BIKES_26_BASE}" "" "Bicicletas Pasaje" "MTB" >> ${OUTPUT_FILE}
process_pages "${MTB_BIKES_27_5_BASE}" "${MTB_BIKES_27_5_PAGES}" "Bicicletas Pasaje" "MTB" >> ${OUTPUT_FILE}
process_pages "${MTB_BIKES_29_BASE}" "${MTB_BIKES_29_PAGES}" "Bicicletas Pasaje" "MTB-29" >> ${OUTPUT_FILE}
process_pages "${MTB_BIKES_DOUBLE_26_BASE}" "" "Bicicletas Pasaje" "MTB-DOUBLE" >> ${OUTPUT_FILE}
process_pages "${MTB_BIKES_DOUBLE_27_5_BASE}" "" "Bicicletas Pasaje" >> ${OUTPUT_FILE}
process_pages "${MTB_BIKES_DOUBLE_29_BASE}" "" "Bicicletas Pasaje" "MTB-DOUBLE" >> ${OUTPUT_FILE}
process_pages "${ROAD_BIKES_BASE}" "${ROAD_BIKES_PAGES}" "" "Bicicletas Pasaje" "ROAD" >> ${OUTPUT_FILE}
process_pages "${ROAD_TRIATLON_BIKES_BASE}" "" "Bicicletas Pasaje" "ROAD" >> ${OUTPUT_FILE}
process_pages "${KIDS_BIKES_BASE}" "" "Bicicletas Pasaje" "KIDS" >> ${OUTPUT_FILE}
process_pages "${WOMAN_BIKES_BASE}" "" "Bicicletas Pasaje" "MTB-WOMAN" >> ${OUTPUT_FILE}
process_pages "${URBAN_BIKES_BASE}" "" "Bicicletas Pasaje" "URBAN" >> ${OUTPUT_FILE}