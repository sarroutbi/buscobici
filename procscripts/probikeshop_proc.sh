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
BASE_URL="http://www.probikeshop.es"
NO_CAMEL_MIN=1
NO_CAMEL_TRADEMARK_MIN=0
DOWN_SEARCH=100
PRICE_SEARCH=2
URL="www.probikeshop.es"
ONLY_DOMAIN="probikeshop.es"

#### LOAD COMMON FUNCTIONS
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
  grep "${URL}" "${FILE}" | sed -e 's/<[^>]*>//g' | sed -e 's/[Cc]uatriciclo//g' | sed -e 's/[Bb]icicleta //g' \
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

function clean_model()
{
    MODEL="${1}"
    echo "${MODEL}" | sed -e 's/[Bb]icicleta de [Cc]iclocross//g' | sed -e 's/[Bb]icicleta de [Cc]arrera//g' | sed -e 's/[Bb]icicleta [Nn]i.[oa] con ruedines//g' | sed -e 's/[Cc]uatriciclo//g' | sed -e 's/[Bb]icicleta//g' | sed -e 's/[Tt]riciclo //g' | sed -e 's/Bici sin pedales//g' | sed -e 's/[Bb]icicleta//g' | sed -e 's/[Mm]ountain [Bb]ike//g' | sed -e 's/[Bb]icicleta de [Nn]i.[oa]//g' | sed -e 's/[Bb][Mm][Xx] Completa//g' | sed -e 's/[Bb][Mm][Xx]//g' | sed -e 's/Ni.[o,a]//g' | sed -e 's/[Bb]icicleeta//g' | sed -e 's/Bici//g' | sed -e 's/Bikes//g'
}

function dump_bike_from_file()
{
  FILE="$1"
  STORE="$2"
  TYPE="$3"
  TRADEMARK_MODELS=$(cat "${FILE}" | grep -A2 '<span class="product_title"' | sed -e 's/<[^>]*>//g' | egrep -E '[A-Z,a-z]')
  echo "${TRADEMARK_MODELS}" | while read trademark_model;
  do
    test -z "${trademark_model}" && continue;
    TRADEMARK_MODEL="${trademark_model}"
    TRADEMARK_MODEL_CLEAN=$(bubic_clean "${TRADEMARK_MODEL}")
    TRADEMARK=$(echo "${TRADEMARK_MODEL_CLEAN}" | awk {'print $1'})
    TRADEMARK_CAMEL=$(bubic_camel "${TRADEMARK}" ${NO_CAMEL_TRADEMARK_MIN})
    MODEL=$(echo "${TRADEMARK_MODEL_CLEAN}" | awk {'for(i=2;i<=NF;++i){printf $i; if(i<NF){printf " "}}'} | tr -d '\r' | tr "'" '"')
    MODEL_CAMEL=$(bubic_camel "${MODEL}" "${NO_CAMEL_MIN}")
    URL=$(grep "${trademark_model}" "${FILE}" -B10 | grep "<a class=\"product_link\" href" | awk -F "href=" {'print $2'} | awk -F ">" {'print $1'} | tr -d '"' | tr -d ' ')
    FINAL_URL=$(echo "\"${BASE_URL}${URL}\"")
#    PRICE=$(grep "${trademark_model}" "${FILE}" -A${DOWN_SEARCH} | grep '<span class="title"' -A${PRICE_SEARCH} | egrep -E "[0-9]{0,1}.{0,1}[0-9]{2,},{0,1}[0-9]{0,}" -o | head -1 | tr -d '.' | sed -e 's/^[ /t]*//g' | tr -d ' ' | tr -d '\r' | tr -d '\n' | tr -d '\302' | tr -d '\240')
    PRICE=$(grep "${trademark_model}" "${FILE}" -A${DOWN_SEARCH} | grep '<span class="product_price"' -A${PRICE_SEARCH} | sed -e 's/<[^>]*>//g' | egrep -E "[0-9]{0,1}.{0,1}[0-9]{2,},{0,1}[0-9]{0,}" | head -1 | sed -e 's/^[ /t]*//g' | tr -d ' ' | tr -d '\r' | tr -d '\n' | tr -d '\302' | tr -d '\240' | tr -d '.' | sed -e 's/^[ /t]*//g' | egrep -E "[0-9]{2,},{0,1}[0-9]{0,}" -o)
    #echo "========================================================================"
    #echo "FILE=${FILE}"
    #echo "TRADEMARK_MODEL=${TRADEMARK_MODEL}"
    #echo "TRADEMARK_MODEL_CLEAN=${TRADEMARK_MODEL_CLEAN}"
    #echo "TRADEMARK=${TRADEMARK}"
    #echo "TRADEMARK_CAMEL=${TRADEMARK_CAMEL}"
    #echo "MODEL=${MODEL}="
    #echo "MODEL_CAMEL=${MODEL_CAMEL}="
    #echo "URL=${FINAL_URL}"
    #echo "PRICE=${PRICE}"
    #echo "STORE=${STORE}"
    #echo "TYPE=${TYPE}"
    #echo "FILE=${FILE}"
    #echo "========================================================================"
    bubic_dump_bike "${MODEL_CAMEL}" "${FINAL_URL}" "${TRADEMARK_CAMEL}" "${PRICE}" "${STORE}" "${TYPE}"
  done
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

MTB_BIKES_BASE="bicicletas-c517.html?page="
MTB_BIKES_PAGES="$(seq 1 5)"

URBAN_BIKES_BASE="ciudad-bicicletas-urbanas-c3656.html"

MTB_WOMAN_BASE="bicicletas-c640.html"

ROAD_BIKES_BASE="bicicletas-c616.html?page="
ROAD_BIKES_PAGES="$(seq 1 3)"

BMX_BIKES_BASE="bicicletas-bmx-c673.html?page="
BMX_BIKES_PAGES="$(seq 1 10)"

KIDS00_BIKES_BASE="bicicletas-ninos-bicis-ninos-de-12-a-18-c739.html"
KIDS01_BIKES_BASE="bicicletas-ninos-c692.html"
KIDS01B_BIKES_BASE="bicis-de-aprendizaje-patinetes-c698.html"
KIDS02_BIKES_BASE="bicis-de-aprendizaje-sin-pedales-c693.html?page="
KIDS02_BIKES_PAGES="$(seq 1 3)"
KIDS03_BIKES_BASE="bicis-de-aprendizaje-cuatriciclos-c696.html"
KIDS04_BIKES_BASE="bicis-de-aprendizaje-triciclos-c697.html"
KIDS05_BIKES_BASE="bicicletas-ninos-bmx-ninos-c3489.html"
KIDS06_BIKES_BASE="bicicletas-ninos-bicis-ninos-de-12-a-14-c739.html"
KIDS07_BIKES_BASE="bicicletas-ninos-bicis-ninos-de-16-a-18-c3490.html"
KIDS08_BIKES_BASE="bicicletas-ninos-bicis-ninos-de-20-c757.html"
KIDS09_BIKES_BASE="bicicletas-ninos-bicis-ninos-de-24-c3491.html"

process_pages "${URBAN_BIKES_BASE}"  "${URBAN_BIKES_PAGES}"  "ProbikeShop" "URBAN"     >> ${OUTPUT_FILE}
process_pages "${MTB_BIKES_BASE}"    "${MTB_BIKES_PAGES}"    "ProbikeShop" "MTB"       >> ${OUTPUT_FILE}
process_pages "${MTB_WOMAN_BASE}"    "${MTB_WOMAN_PAGES}"    "ProbikeShop" "MTB-WOMAN" >> ${OUTPUT_FILE}
process_pages "${ROAD_BIKES_BASE}"   "${ROAD_BIKES_PAGES}"   "ProbikeShop" "ROAD"      >> ${OUTPUT_FILE}
process_pages "${BMX_BIKES_BASE}"    "${BMX_BIKES_PAGES}"    "ProbikeShop" "BMX"       >> ${OUTPUT_FILE}
process_pages "${KIDS00_BIKES_BASE}" "${KIDS00_BIKES_PAGES}" "ProbikeShop" "KIDS"      >> ${OUTPUT_FILE}
process_pages "${KIDS01_BIKES_BASE}" "${KIDS01_BIKES_PAGES}" "ProbikeShop" "KIDS"      >> ${OUTPUT_FILE}
process_pages "${KIDS01B_BIKES_BASE}" "${KIDS01B_BIKES_PAGES}" "ProbikeShop" "KIDS"      >> ${OUTPUT_FILE}
process_pages "${KIDS02_BIKES_BASE}" "${KIDS02_BIKES_PAGES}" "ProbikeShop" "KIDS"      >> ${OUTPUT_FILE}
process_pages "${KIDS03_BIKES_BASE}" "${KIDS03_BIKES_PAGES}" "ProbikeShop" "KIDS"      >> ${OUTPUT_FILE}
process_pages "${KIDS04_BIKES_BASE}" "${KIDS04_BIKES_PAGES}" "ProbikeShop" "KIDS"      >> ${OUTPUT_FILE}
process_pages "${KIDS05_BIKES_BASE}" "${KIDS05_BIKES_PAGES}" "ProbikeShop" "KIDS"      >> ${OUTPUT_FILE}
process_pages "${KIDS06_BIKES_BASE}" "${KIDS06_BIKES_PAGES}" "ProbikeShop" "KIDS"      >> ${OUTPUT_FILE}
process_pages "${KIDS07_BIKES_BASE}" "${KIDS07_BIKES_PAGES}" "ProbikeShop" "KIDS"      >> ${OUTPUT_FILE}
process_pages "${KIDS08_BIKES_BASE}" "${KIDS08_BIKES_PAGES}" "ProbikeShop" "KIDS"      >> ${OUTPUT_FILE}
process_pages "${KIDS09_BIKES_BASE}" "${KIDS09_BIKES_PAGES}" "ProbikeShop" "KIDS"      >> ${OUTPUT_FILE}

#process_pages "${MTB_BIKES_BASE}"    "${MTB_BIKES_PAGES}"    "ProbikeShop" "MTB"
#process_pages "${MTB_WOMAN_BASE}"    "${MTB_WOMAN_PAGES}"    "ProbikeShop" "MTB-WOMAN"
#process_pages "${ROAD_BIKES_BASE}"   "${ROAD_BIKES_PAGES}"   "ProbikeShop" "ROAD"
#process_pages "${BMX_BIKES_BASE}"    "${BMX_BIKES_PAGES}"    "ProbikeShop" "BMX"
#process_pages "${KIDS00_BIKES_BASE}" "${KIDS00_BIKES_PAGES}" "ProbikeShop" "KIDS"
#process_pages "${KIDS01_BIKES_BASE}" "${KIDS01_BIKES_PAGES}" "ProbikeShop" "KIDS"
#process_pages "${KIDS02_BIKES_BASE}" "${KIDS02_BIKES_PAGES}" "ProbikeShop" "KIDS"
#process_pages "${KIDS03_BIKES_BASE}" "${KIDS03_BIKES_PAGES}" "ProbikeShop" "KIDS"
#process_pages "${KIDS04_BIKES_BASE}" "${KIDS04_BIKES_PAGES}" "ProbikeShop" "KIDS"


