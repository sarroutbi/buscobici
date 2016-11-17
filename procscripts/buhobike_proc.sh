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
BASE_URL="http://www.buhobike.com"
NO_CAMEL_MIN=3

#### KEYS GENERATED
TRADEMARK_KEY="TRADEMARK"
SUBURL_KEY="SUBURL"
STORE_KEY="STORE"
PRICE_KEY="PRICE"
KIND_KEY="KIND"

# INCLUDE COMMON
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
  if [[ "$1" != "" ]];
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
function print_model()
{
  #echo "======================================"
  #  echo "======> URL:${1} <========="
  MODELS=$(wget -O - "$1" 2>&1 | grep "<title>" -A3 | sed -e 's/<[^>]*>//g' | grep "[A-Z,a-z,0-9]" | head -1 | awk -F " - " {'print $NF'} | tr -d "\n")
  echo "${MODELS}" | while read model;
  do
    MODEL="${model}"
    echo ${MODEL}
  done
  #echo "======================================"
}

# Params:
# 1 - The URL of bike
function print_price()
{
  PRICES=$(wget "$1" -O - 2>&1 | grep '&euro' | egrep -E -o "[0-9]{2,5}" | tr -d '.' | tail -1)
  for price in ${PRICES};
  do
    PRICE=${price} 
  done
  echo ${PRICE}
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

function process_file()
{
  BASE_FILE="$1"
  STORE="$2"
  TYPE="$3"
  cat ${BASE_FILE} | sed -e 's@<h5@\n<h5@g' | grep '<a class="product-name"' | while read bike;
  do
    # NOTE: each bike should be more or less like:
    # ORBEA<br>AQUA T23 2013<br><b>717 &euro;</b>
    MODEL=$(echo "${bike}" | awk -F "</h5>" {'print $1'} | sed -e 's/<[^>]*>//g')
    MODEL_CLEAN=$(bubic_clean "${MODEL}")
    TRADEMARK=$(echo "${bike}" | grep ">${MODEL}<" | awk -F '<p class="pro_list_manufacturer">' {'print $2'} | awk -F "</p>" {'print $1'}| sed -e 's@<[^>]*>@@g')
    TRADEMARK_CLEAN=${TRADEMARK}
    FINAL_URL=$(echo "${bike}" | awk -F 'href=' {'print $2'} | awk {'print $1'} | tr -d '"')
    PRICE=$(echo "${bike}" | awk -F '<span itemprop="price"' {'print "<span itemprop=\"price\"" $2'} | awk -F "</span>" {'print $1'} | sed -e 's/<[^>]*>//g' | egrep -E -o "[0-9]{0,2} {0,1}[0-9]{3},{1}[0-9]{0,2}" | tr -d ' ' | head -1)
    TRADEMARK_CAMEL=$(bubic_camel "${TRADEMARK_CLEAN}" 0)
    MODEL_CAMEL=$(bubic_camel "${MODEL_CLEAN}" ${NO_CAMEL_MIN})
    MODEL_CAMEL_DEF=$(echo "${MODEL_CAMEL}" | sed -e "s@${TRADEMARK_CAMEL}@@g")
    MODEL_CAMEL=$(bubic_camel "${MODEL_CAMEL_DEF}" ${NO_CAMEL_MIN})
    #echo "======================"
    #echo "FILE:=>${BASE_FILE}<="
    #echo "BIKE:=>${bike}<="
    #echo "MODEL:=>${MODEL}<="
    #echo "TRADEMARK:=>${TRADEMARK}<="
    #echo "TRADEMARK_CLEAN:=>${TRADEMARK_CLEAN}<="
    #echo "MODEL_CLEAN:=>${MODEL_CLEAN}<="
    #echo "TRADEMARK_CAMEL:=>${TRADEMARK_CAMEL}<="
    #echo "MODEL_CAMEL:=>${MODEL_CAMEL}<="
    #echo "MODEL_CAMEL_DEF:=>${MODEL_CAMEL_DEF}<="
    #echo "PRICE:=>${PRICE}<="
    #echo "URL:=>${FINAL_URL}<="
    #echo "======================"
    dump_bike "${MODEL_CAMEL}" "${FINAL_URL}" "${TRADEMARK_CAMEL}" "${PRICE}" "${STORE}" "${TYPE}"
  done
}


function process_pages()
{
  BASE_PROCESSED_FILE="$1"
  PAGES="$2"
  STORE="$3"
  TYPE="$4"
  if [ "${PAGES}" = "" ];
  then
    process_file "${BASE_PROCESSED_FILE}" "${STORE}" "${TYPE}"
  else
    for page in ${PAGES};
    do
      process_file "${BASE_PROCESSED_FILE}-${page}" "${STORE}" "${TYPE}"
    done
  fi
}

> ${OUTPUT_FILE}

MTB_BIKES_BASE="mtb"
MTB_BIKES_PAGES=$(seq 1 25)

ROAD_BIKES_BASE="road"
ROAD_BIKES_PAGES=$(seq 1 10)

URBAN_ELECTRIC_BIKES_BASE="urban-electric"
URBAN_ELECTRIC_BIKES_PAGES=$(seq 1 12)

URBAN_BIKES_BASE="urban"
URBAN_BIKES_PAGES=$(seq 1 7)

TREKKING_BIKES_BASE="trekking"
TREKKING_BIKES_PAGES=$(seq 1 4)

BMX_BIKES_BASE="bmx"
BMX_BIKES_PAGES=$(seq 1 2)

ROAD_CICLOCROSS_BIKES_BASE="road-ciclocross"
ROAD_CICLOCROSS_BIKES_PAGES=$(seq 1 2)

KIDS_BIKES_BASE="kids"
KIDS_BIKES_PAGES=$(seq 1 4)

process_pages "${MTB_BIKES_BASE}" "${MTB_BIKES_PAGES}" "BuhoBike" "MTB" >> ${OUTPUT_FILE}
process_pages "${ROAD_BIKES_BASE}" "${ROAD_BIKES_PAGES}" "BuhoBike" "ROAD"  >> ${OUTPUT_FILE}
process_pages "${URBAN_BIKES_BASE}" "${URBAN_BIKES_PAGES}" "BuhoBike" "URBAN"  >> ${OUTPUT_FILE}
process_pages "${URBAN_ELECTRIC_BIKES_BASE}" "${URBAN_ELECTRIC_BIKES_PAGES}" "BuhoBike" "URBAN-ELECTRIC"  >> ${OUTPUT_FILE}
process_pages "${TREKKING_BIKES_BASE}" "${TREKKING_BIKES_PAGES}" "BuhoBike" "URBAN-TREKKING"  >> ${OUTPUT_FILE}
process_pages "${BMX_BIKES_BASE}" "${BMX_BIKES_PAGES}" "BuhoBike" "BMX" >> ${OUTPUT_FILE}
process_pages "${ROAD_CICLOCROSS_BIKES_BASE}" "${ROAD_CICLOCROSS_BIKES_PAGES}" "BuhoBike" "ROAD-CICLOCROSS"  >> ${OUTPUT_FILE}
process_pages "${KIDS_BIKES_BASE}" "${KIDS_BIKES_PAGES}" "BuhoBike" "KIDS"  >> ${OUTPUT_FILE}
