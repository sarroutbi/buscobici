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
BASE_URL="http://www.calmera.es"
NO_CAMEL_MIN=3
NO_CAMEL_TRADEMARK_MIN=0
MAX_PRICE_SEARCH=35
URL="www.calmera.es"
ONLY_DOMAIN="calmera.es"
EXCLUDE="-Rgif -Rpng -Rjpg"

. ./common_proc

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
  PRICE=$(grep "${MODEL}" "${FILE}" -A${MAX_PRICE_SEARCH} | grep -v "old-price" | grep -v "price-box" | grep "price" -A2 | sed -e 's/<[^>]*>//g' | egrep -o -E "[0-9]{1,}.{0,1}[0-9]{1,},{0,1}[0-9]{0,}" | tr -d '.' | tail -1)
  if [ "${PRICE}" = "" ];
  then
    let MAX_PRICE_SEARCH=${MAX_PRICE_SEARCH}+5
    PRICE=$(grep "${MODEL}" "${FILE}" -A${MAX_PRICE_SEARCH} | grep -v "old-price" | grep -v "price-box" | grep "price" -A2 | sed -e 's/<[^>]*>//g' | egrep -o -E "[0-9]{1,}.{0,1}[0-9]{1,},{0,1}[0-9]{0,}" | tr -d '.' | tail -1)
  fi
  if [ "${PRICE}" = "" ];
  then
    let MAX_PRICE_SEARCH=${MAX_PRICE_SEARCH}+5
    PRICE=$(grep "${MODEL}" "${FILE}" -A${MAX_PRICE_SEARCH} | grep -v "old-price" | grep -v "price-box" | grep "price" -A2 | sed -e 's/<[^>]*>//g' | egrep -o -E "[0-9]{1,}.{0,1}[0-9]{1,},{0,1}[0-9]{0,}" | tr -d '.' | tail -1)
  fi
  if [ "${PRICE}" = "" ];
  then
    ### Last effort, go for first one
    let MAX_PRICE_SEARCH=${MAX_PRICE_SEARCH}+90
    PRICE=$(grep "${MODEL}" "${FILE}" -A${MAX_PRICE_SEARCH} | grep -v "old-price" | grep -v "price-box" | grep "price" -A2 | sed -e 's/<[^>]*>//g' | egrep -o -E "[0-9]{1,}.{0,1}[0-9]{1,},{0,1}[0-9]{0,}" | tr -d '.' | head -1)
  fi
  PRICE_NO_SPACE=$(echo ${PRICE} | tr -d ' ')
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
  cat "${1}" | grep '<a class="product-name"' -A2 | sed -e 's@<[^>]*>@@g' | egrep -e [A-Z,a-z] | sed -e 's@^[ ,\t]*@@g' | while read model;
  do
      CLEAN_MODEL=$(bubic_clean "${model}" | tr -d '\r')
      CAMEL_MODEL=$(bubic_camel "${CLEAN_MODEL}" ${NO_CAMEL_MIN})
      TRADEMARK=$(echo "${CAMEL_MODEL}" | awk {'print $1'})
      FINAL_MODEL=$(echo "${CAMEL_MODEL}" | awk {'for(i=2;i<=NF;++i){printf $i; if(i<NF){printf " "}}'})
      URL=$(grep "${model}" "${FILE}" -B1 | awk -F 'href=' {'print $2'} | awk {'print $1'} | egrep -E "[a-z]" | head -1)
      PRICE=$(grep "${model}" "${FILE}" -C10 | grep '<span class="price' -A2 | egrep -E -o '[0-9]{0,2} {0,1}[0-9]{3},[0-9]{0,2}' | tr -d ' ')
      # COMMENT THIS:
      #echo "FILE=${FILE}"
      #echo "MODEL=${FINAL_MODEL}"
      #echo "URL=${URL}"
      #echo "PRICE=${PRICE}"
      #echo "STORE=${STORE}"
      #echo "TYPE=${TYPE}"
      # end COMMENT
      bubic_dump_bike "${FINAL_MODEL}" "${URL}" "${TRADEMARK}" "${PRICE}" "${STORE}" "${TYPE}"

  done
}

function dump_bike_from_urls()
{
  URLS="$1"
  FILE="$2"
  STORE="$3"
  TYPE="$4"
  #echo "URLS:=>${URLS}<="
  echo "${URLS}" | while read URL;
  do
    TRADEMARK_MODEL=$(grep "${URL}" "${FILE}" -B10 | grep '<p class="tituloprod">' | sed -e 's/<[^>]*>//g' | tail -1 | tr -d '\r' | sed -e 's/^[ /t]//g')
    TRADEMARK=$(echo "${TRADEMARK_MODEL}" | awk {'print $1'})
    TRADEMARK_CAMEL=$(camel "${TRADEMARK}" ${NO_CAMEL_TRADEMARK_MIN})
    MODEL=$(echo "${TRADEMARK_MODEL}" | awk {'for(i=2;i<=NF;++i){printf $i; if(i<NF){printf " "}}'})
    MODEL_CAMEL=$(camel "${MODEL}" ${NO_CAMEL_MIN})
    PRICE=$(grep ${URL} ${FILE} -B10 | grep "precio.jpg" -A2 | sed -e 's/<[^>]*>//g' | egrep -o -E "[0-9]{1,}.{0,}[0-9]{1,},{0,}[0-9]{0,}"  | tr "." "," | tail -1)
    FINAL_URL=$(echo \""${BASE_URL}"/"${URL}"\")
    #echo "========================================================================"
    #echo "TRADEMARK_MODEL=${TRADEMARK_MODEL}"
    #echo "TRADEMARK=${TRADEMARK_CAMEL}"
    #echo "MODEL=${MODEL_CAMEL}="
    #echo "URL=${FINAL_URL}"
    #echo "PRICE=${PRICE}"
    #echo "STORE=${STORE}"
    #echo "TYPE=${TYPE}"
    #echo "FILE=${FILE}"
    #echo "========================================================================"
    dump_bike "${MODEL_CAMEL}" "${FINAL_URL}" "${TRADEMARK_CAMEL}" "${PRICE}" "${STORE}" "${TYPE}"
  done
}

function process_pages_old()
{
  BASE_FILE="$1"
  PAGES="$2"
  STORE="$3"
  TYPE="$4"
  #echo "BASE_FILE=$1"
  #echo "PAGES=$2"
  #echo "STORE=$3"
  #echo "TYPE=$4"

  if [ "${PAGES}" = "" ];
  then
    URLS=$(cat "${BASE_FILE}" | grep '<a href="producto' | awk -F '<a href="' {'print $2'} | awk -F '"' {'print $1'})
    dump_bike_from_urls "${URLS}" "${BASE_FILE}" "${STORE}" "${TYPE}"
  else
    for page in ${PAGES};
    do
      URLS=$(cat "${BASE_FILE}${page}" | grep '<a href="producto' | awk -F '<a href="' {'print $2'} | awk -F '"' {'print $1'})
      dump_bike_from_urls "${URLS}" "${BASE_FILE}${page}" "${STORE}" "${TYPE}"
    done
  fi
}

function process_pages()
{
  BASE_FILE="$1"
  PAGES="$2"
  STORE="$3"
  TYPE="$4"
  #echo "BASE_FILE=$1"
  #echo "PAGES=$2"
  #echo "STORE=$3"
  #echo "TYPE=$4"

  if [ "${PAGES}" = "" ];
  then
    dump_bike_from_file "${BASE_FILE}" "${STORE}" "${TYPE}"
  else
    for page in ${PAGES};
    do
      dump_bike_from_file "${BASE_FILE}${page}" "${STORE}" "${TYPE}"
    done
  fi
}

> ${OUTPUT_FILE}

MTB_BIKES_BASE="18-montana?p="
MTB_BIKES_PAGES="$(seq 1 16)"

MTB_DOUBLE_BASE="27-doble-suspension?p="
MTB_DOUBLE_PAGES="$(seq 1 9)"

ROAD_BIKES_BASE="17-carretera?p="
ROAD_BIKES_PAGES="$(seq 1 16)"

ROAD_CARBON_BIKES_BASE="24-carbono?p="
ROAD_CARBON_BIKES_PAGES="$(seq 1 10)"

ROAD_TRIATLON_BIKES_BASE="25-triathlon?p="
ROAD_TRIATLON_BIKES_PAGES="$(seq 1 3)"

ROAD_CICLOCROSS_BIKES_BASE="132-ciclocross-y-cicloturismo?p="
ROAD_CICLOCROSS_BIKES_PAGES="$(seq 1 3)"

ROAD_FIXIES_BIKES_BASE="133-fixies?p="
ROAD_FIXIES_BIKES_PAGES="$(seq 1 2)"

URBAN_BIKES_BASE="19-urbanas-y-mixtastrekking?p="
URBAN_BIKES_PAGES="$(seq 1 13)"

KIDS_BIKES_BASE="20-infantiles?p="
KIDS_BIKES_PAGES="$(seq 1 7)"

TRICYCLE_BIKES_BASE="21-triciclos-y-tandems?p="
TRICYCLE_BIKES_PAGES="$(seq 1 3)"

BMX_BIKES_BASE="22-bmxfreestyletrial?p="
BMX_BIKES_PAGES="$(seq 1 2)"

process_pages "${MTB_BIKES_BASE}"             "${MTB_BIKES_PAGES}"             "Calmera" "MTB"    >> ${OUTPUT_FILE}
process_pages "${MTB_DOUBLE_BASE}"            "${MTB_DOUBLE_PAGES}"            "Calmera" "MTB-DOUBLE" >> ${OUTPUT_FILE}
process_pages "${ROAD_BIKES_BASE}"            "${ROAD_BIKES_PAGES}"            "Calmera" "ROAD"   >> ${OUTPUT_FILE}
process_pages "${ROAD_CARBON_BIKES_BASE}"     "${ROAD_CARBON_BIKES_PAGES}"     "Calmera" "ROAD"   >> ${OUTPUT_FILE}
process_pages "${ROAD_TRIATLON_BIKES_BASE}"   "${ROAD_TRIATLON_BIKES_PAGES}"   "Calmera" "ROAD"   >> ${OUTPUT_FILE}
process_pages "${ROAD_CICLOCROSS_BIKES_BASE}" "${ROAD_CICLOCROSS_BIKES_PAGES}" "Calmera" "ROAD-CICLOCROSS" >> ${OUTPUT_FILE}
process_pages "${ROAD_FIXIES_BIKES_BASE}"     "${ROAD_FIXIES_BIKES_PAGES}"     "Calmera" "URBAN-FIXIE" >> ${OUTPUT_FILE}
process_pages "${URBAN_BIKES_BASE}"           "${URBAN_BIKES_PAGES}"           "Calmera" "URBAN"  >> ${OUTPUT_FILE}
process_pages "${KIDS_BIKES_BASE}"            "${KIDS_BIKES_PAGES}"            "Calmera" "KIDS"   >> ${OUTPUT_FILE}
process_pages "${TRICYCLE_BIKES_BASE}"        "${TRICYCLE_BIKES_PAGES}"        "Calmera" "KIDS"   >> ${OUTPUT_FILE}
process_pages "${BMX_BIKES_BASE}"             "${BMX_BIKES_PAGES}"             "Calmera" "BMX"    >> ${OUTPUT_FILE}
