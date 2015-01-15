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

#### LOAD COMMON FUNCTIONS
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

function process_one_page()
{
  BASE_FILE="$1"
  STORE="$2"
  TYPE="$3"

  TRADEMARK_MODELS=$(cat ${BASE_FILE} | awk -F "<h3>" {'print $2'} | awk -F "</h3>" {'print $1'} | sed -e 's/<[^>]*>//g' | egrep -E ^[A-Z,a-z,0-9])
  echo "${TRADEMARK_MODELS}" | while read line;
  do
    PRICE=$(grep "${line}" "${BASE_FILE}" -A10 | awk -F '<span class="price">' {'print $2'} | awk -F '</span>' {'print $1'} | grep [0-9] | tr -d " " | tr -d "€" | head -1)
    URL=$(grep "${line}" "${BASE_FILE}" | sed -e 's/href=/\nhref=/g' | awk -F "href=" {'print $2'} | awk {'print $1'} | grep http | tail -1)
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
    bubic_dump_bike "${MODEL_CAMEL}" "${URL}" "${TRADEMARK_CAMEL}" "${PRICE}" "${STORE}" "${TYPE}"
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
      process_one_page "${THE_FILE}-${page}" "${STORE}" "${TYPE}"
    done
  fi
}

> ${OUTPUT_FILE}

MTB_BIKES_26_BASE="mtb-26"
MTB_BIKES_CUBE_26_BASE="mtb-26-cube"
MTB_BIKES_MMR_26_BASE="mtb-26-mmr"
MTB_BIKES_27_5_BASE="mtb-27-5"
MTB_BIKES_27_5_PAGES="$(seq 1 5)"
MTB_BIKES_29_BASE="mtb-29"
MTB_BIKES_29_PAGES="$(seq 1 6)"
MTB_BIKES_DOUBLE_26_BASE="mtb-double-26"
MTB_BIKES_DOUBLE_27_5_BASE="mtb-double-27-5"
MTB_BIKES_DOUBLE_27_5_PAGES="$(seq 1 3)"
MTB_BIKES_DOUBLE_29_BASE="mtb-double-29"
MTB_BIKES_DOUBLE_29_PAGES="$(seq 1 3)"
ROAD_BIKES_BASE="road"
ROAD_BIKES_PAGES="$(seq 1 4)"
ROAD_TRIATLON_BIKES_BASE="road-triatlon"
ROAD_2013_BIKES_BASE="road-2013"
KIDS_BIKES_BASE="kids"
KIDS_BIKES_PAGES="$(seq 1 3)"
WOMAN_BIKES_BASE="woman"
WOMAN_BIKES_PAGES="$(seq 1 3)"
URBAN_BIKES_BASE="urban"
URBAN_BIKES_PAGES="$(seq 1 3)"
URBAN_2013_BIKES_BASE="urban-2013"
URBAN_2013_BIKES_PAGES="$(seq 1 3)"

process_pages "${MTB_BIKES_26_BASE}" "${MTB_BIKES_26_PAGES}" "Bicicletas Pasaje" "MTB" >> ${OUTPUT_FILE}
process_pages "${MTB_BIKES_CUBE_26_BASE}" "${MTB_BIKES_CUBE_26_PAGES}" "Bicicletas Pasaje" "MTB" >> ${OUTPUT_FILE}
process_pages "${MTB_BIKES_MMR_26_BASE}" "${MTB_BIKES_MMR_26_PAGES}" "Bicicletas Pasaje" "MTB" >> ${OUTPUT_FILE}
process_pages "${MTB_BIKES_27_5_BASE}" "${MTB_BIKES_27_5_PAGES}" "Bicicletas Pasaje" "MTB" >> ${OUTPUT_FILE}
process_pages "${MTB_BIKES_29_BASE}" "${MTB_BIKES_29_PAGES}" "Bicicletas Pasaje" "MTB-29" >> ${OUTPUT_FILE}
process_pages "${MTB_BIKES_DOUBLE_26_BASE}" "${MTB_BIKES_DOUBLE_26_PAGES}" "Bicicletas Pasaje" "MTB-DOUBLE" >> ${OUTPUT_FILE}
process_pages "${MTB_BIKES_DOUBLE_27_5_BASE}" "${MTB_BIKES_DOUBLE_27_5_PAGES}" "Bicicletas Pasaje" "MTB-DOUBLE" >> ${OUTPUT_FILE}
process_pages "${MTB_BIKES_DOUBLE_29_BASE}" "${MTB_BIKES_DOUBLE_29_PAGES}" "Bicicletas Pasaje" "MTB-DOUBLE" >> ${OUTPUT_FILE}
process_pages "${ROAD_BIKES_BASE}" "${ROAD_BIKES_PAGES}" "Bicicletas Pasaje" "ROAD" >> ${OUTPUT_FILE}
process_pages "${ROAD_TRIATLON_BIKES_BASE}" "${ROAD_TRIATLON_BIKES_PAGES}" "Bicicletas Pasaje" "ROAD" >> ${OUTPUT_FILE}
process_pages "${ROAD_2013_BIKES_BASE}" "${ROAD_2013_BIKES_PAGES}" "Bicicletas Pasaje" "ROAD" >> ${OUTPUT_FILE}
process_pages "${KIDS_BIKES_BASE}"  "${KIDS_BIKES_PAGES}" "Bicicletas Pasaje" "KIDS" >> ${OUTPUT_FILE}
process_pages "${WOMAN_BIKES_BASE}" "${WOMAN_BIKES_PAGES}" "Bicicletas Pasaje" "MTB-WOMAN" >> ${OUTPUT_FILE}
process_pages "${URBAN_BIKES_BASE}" "${URBAN_BIKES_PAGES}" "Bicicletas Pasaje" "URBAN" >> ${OUTPUT_FILE}
process_pages "${URBAN_2013_BIKES_BASE}" "${URBAN_2013_BIKES_PAGES}" "Bicicletas Pasaje" "URBAN" >> ${OUTPUT_FILE}
