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
BASE_URL="http://www.bikester.es"
NO_CAMEL_MIN=6
NO_CAMEL_TRADEMARK_MIN=0
DOWN_SEARCH=20
PRICE_SEARCH=4
URL="www.probikeshop.es"
ONLY_DOMAIN="probikeshop.es"

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

function clean_model()
{
    MODEL="${1}"
    echo "${MODEL}" | sed -e 's/[Bb]icicleta//g' | sed -e 's/[Tt]riciclo//g' | sed -e 's/Bici sin pedales//g'
}

function dump_bike_from_file()
{
  FILE="$1"
  STORE="$2"
  TYPE="$3"
  TRADEMARK_MODELS=$(cat "${FILE}" | grep "<td class='product_thumb'>" -A${DOWN_SEARCH} | grep "<h3><a href")
  echo "${TRADEMARK_MODELS}" | while read trademark_model;
  do 
    #echo "===== TRADEMARK MODEL ====="
    #echo "=>${trademark_model}<="
    #echo "===== /TRADEMARK MODEL ====="
    test -z "${trademark_model}" && continue;
    TRADEMARK_MODEL=$(grep "${trademark_model}" "${FILE}" | grep "<h3><a href" | sed -e 's/<[^>]*>//g')
    TRADEMARK_MODEL_CLEAN=$(clean_model "${TRADEMARK_MODEL}")
    TRADEMARK=$(echo "${TRADEMARK_MODEL_CLEAN}" | awk {'print $1'})
    TRADEMARK_CAMEL=$(camel "${TRADEMARK}" ${NO_CAMEL_TRADEMARK_MIN})
    MODEL=$(echo "${TRADEMARK_MODEL_CLEAN}" | awk {'for(i=2;i<=NF;++i){printf $i; if(i<NF){printf " "}}'} | tr -d '\r' | tr "'" '"')
    MODEL_CAMEL=$(camel "${MODEL}" "${NO_CAMEL_MIN}")
    URL=$(grep "${trademark_model}" "${FILE}" | grep "<h3><a href" | awk -F "a href=" {'print $2'} | awk -F ">" {'print $1'} | tr -d '"')
    FINAL_URL=$(echo "\"${BASE_URL}${URL}\"")
    PRICE=$(grep "${trademark_model}" "${FILE}" -A${DOWN_SEARCH} | grep "product_price" -A${PRICE_SEARCH} | egrep -E "[0-9]{0,1}.{0,1}[0-9]{2,},{0,1}[0-9]{0,}" -o | head -1 | tr -d '.' | sed -e 's/^[ /t]*//g' | tr -d ' ' | tr -d '\r' | tr -d '\n' | tr -d '\302' | tr -d '\240')
    #echo "========================================================================"
    #echo "TRADEMARK_MODEL=${TRADEMARK_MODEL}"
    #echo "TRADEMARK_MODEL_CLEAN=${TRADEMARK_MODEL_CLEAN}"
    #echo "TRADEMARK=${TRADEMARK}"
    #echo "TRADEMARK_CAMEL=${TRADEMARK_CAMEL}"
    #echo "MODEL=${MODEL}="
    #echo "MODEL_CLEAN=${MODEL_CLEAN}="
    #echo "URL=${FINAL_URL}"
    #echo "PRICE=${PRICE}"
    #echo "STORE=${STORE}"
    #echo "TYPE=${TYPE}"
    #echo "FILE=${FILE}"
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
      dump_bike_from_file "${BASE_FILE}${page}" "${STORE}" "${TYPE}"
    done
  fi
}

> ${OUTPUT_FILE}

MTB_FIX_BIKES_BASE="${URL}/bicicletas/bicicletas-de-montana.html?page="
MTB_FIX_BIKES_PAGES="$(seq 0 5)"

MTB_DOUBLE_BIKES_BASE="${URL}/bicicletas/bicicletas-doble-suspension.html?page="
MTB_DOUBLE_BIKES_PAGES="$(seq 0 5)"

MTB_29_BIKES_BASE="${URL}/bicicletas/bicicletas-29-pulgadas.html?page="
MTB_29_BIKES_PAGES="$(seq 0 3)"

KIDS_BIKES_BASE="${URL}/bicicletas/bicicletas-para-ninos.html?page="
KIDS_BIKES_PAGES="$(seq 0 7)"

BTT_KIDS_BIKES_BASE="${URL}/bicicletas/bicicletas-juveniles-bicicletas-todo-terreno.html?page="
BTT_KIDS_BIKES_PAGES="$(seq 0 1)"

BMX_BIKES_BASE="${URL}/bicicletas/bmx.html?page="
BMX_BIKES_PAGES="$(seq 0 5)"

ROAD_BIKES_BASE="${URL}/bicicletas/bicicletas-de-carretera.html?page="
ROAD_BIKES_PAGES="$(seq 0 5)"

ROAD_CICLOCROSS_BIKES_BASE="${URL}/bicicletas/bicicletas-fitness-bicicletas-ciclocross.html"
ROAD_CICLOCROSS_BIKES_PAGES=""

URBAN_XC_BIKES_BASE="${URL}/bicicletas/bicicletas-xc-.html?page="
URBAN_XC_BIKES_PAGES="$(seq 0 3)"

URBAN_SINGLE_BIKES_BASE="${URL}/bicicletas/bicicletas-single-speed.html"
URBAN_SINGLE_BIKES_PAGES=""

URBAN_WALK_BIKES_BASE="${URL}/bicicletas/bicicleta-de-paseo.html?page="
URBAN_WALK_BIKES_PAGES="$(seq 0 2)"

URBAN_FOLDING_BIKES_BASE="${URL}/bicicletas/bicicletas-plegables-.html?page="
URBAN_FOLDING_BIKES_PAGES="$(seq 0 2)"

URBAN_RETRO_BIKES_BASE="${URL}/bicicletas/cruiser-retro.html"
URBAN_RETRO_BIKES_PAGES=""

URBAN_ELECT_BIKES_BASE="${URL}/bicicletas/bicicletas-electricas-pedelec.html?page="
URBAN_ELECT_BIKES_PAGES="$(seq 0 2)"

TREKKING_BIKES_BASE="${URL}/bicicletas/bicicletas-trekking.html?page="
TREKKING_BIKES_PAGES="$(seq 0 3)"

process_pages "${MTB_FIX_BIKES_BASE}"       "${MTB_FIX_BIKES_PAGES}"       "Bikester" "MTB"
process_pages "${MTB_DOUBLE_BIKES_BASE}"    "${MTB_DOUBLE_BIKES_PAGES}"    "Bikester" "MTB-DOUBLE"
process_pages "${MTB_29_BIKES_BASE}"        "${MTB_29_BIKES_PAGES}"        "Bikester" "MTB-29"
process_pages "${KIDS_BIKES_BASE}"          "${KIDS_BIKES_PAGES}"          "Bikester" "KIDS"
process_pages "${BTT_KIDS_BIKES_BASE}"      "${BTT_KIDS_BIKES_PAGES}"      "Bikester" "KIDS"
process_pages "${BMX_BIKES_BASE}"           "${BMX_BIKES_PAGES}"           "Bikester" "BMX"
process_pages "${ROAD_BIKES_BASE}"          "${ROAD_BIKES_PAGES}"          "Bikester" "ROAD"
process_pages "${ROAD_CICLOCROSS_BASE}"     "${ROAD_CICLOCROSS_PAGES}"     "Bikester" "ROAD" 
process_pages "${URBAN_XC_BIKES_BASE}"      "${URBAN_XC_BIKES_PAGES}"      "Bikester" "URBAN"
process_pages "${URBAN_SINGLE_BIKES_BASE}"  "${URBAN_SINGLE_BIKES_PAGES}"  "Bikester" "URBAN" 
process_pages "${URBAN_WALK_BIKES_BASE}"    "${URBAN_WALK_BIKES_PAGES}"    "Bikester" "URBAN"
process_pages "${URBAN_FOLDING_BIKES_BASE}" "${URBAN_FOLDING_BIKES_PAGES}" "Bikester" "URBAN"  
process_pages "${URBAN_RETRO_BIKES_BASE}"   "${URBAN_RETRO_BIKES_PAGES}"   "Bikester" "URBAN" 
process_pages "${URBAN_ELECT_BIKES_BASE}"   "${URBAN_ELECT_BIKES_PAGES}"   "Bikester" "URBAN" 
process_pages "${TREKKING_BIKES_BASE}"      "${TREKKING_BIKES_PAGES}"      "Bikester" "URBAN" 
