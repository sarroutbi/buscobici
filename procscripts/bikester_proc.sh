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

#### LOAD COMMON FUNCTIONS
. ./common_proc

MAX_PRICE=2
#OUTPUT_FILE=/dev/stdout
OUTPUT_FILE=./output
BASE_URL="http://www.bikester.es"
NO_CAMEL_MIN=6
NO_CAMEL_TRADEMARK_MIN=0
MODEL_DOWN_SEARCH=10
MAX_PRICE_SEARCH=20
MAX_PRICE_SEARCH2=50
URL="www.bikester.es"
ONLY_DOMAIN="bikester.es"

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
# 1 - The File of bike
# 2 - The model of bike
function print_price()
{
  FILE="$1"
  MODEL="$2"
  PRICE=$(grep "${MODEL}" "${FILE}" -A${MAX_PRICE_SEARCH} | grep '<span class="productItemCurrentPriceText">' | sed -e 's/<[^>]*>//g' | egrep -o -E "[0-9]{0,1}.{0,1}[0-9]{1,3},{0,1}[0-9]{0,2} €" | tail -1)
  PRICE_NO_SPACE=$(echo ${PRICE} | tr -d ' ' | tr -d '.' | tr -d '€')
  echo ${PRICE_NO_SPACE}
}


# Params:
# 1 - The Url of the bike type
function get_type_with_url_type() {
 URL_TYPE="$1"
 TYPE="URBAN"
 echo "$1" | grep "bicicletas-de-montana.html" >/dev/null && TYPE="MTB"
 echo "$1" | grep "bicicletas-doble-suspension.html" >/dev/null && TYPE="MTB-DOUBLE"
 echo "$1" | grep "bicicletas-de-carretera.html" >/dev/null && TYPE="ROAD"
 echo "$1" | grep "bicicletas-juveniles-bicicletas-todo-terreno.html" >/dev/null && TYPE="KIDS"
 echo "$1" | grep "bicicletas-para-ninos.html" >/dev/null && TYPE="KIDS"
 echo "$1" | grep "monopatines-y-otros.html" >/dev/null && TYPE="KIDS"
 echo "$1" | grep "bmx.html" >/dev/null && TYPE="BMX"
 echo $TYPE
}

# Params:
# 1 - The Url of bike
function print_type_url()
{
  TYPE_URL=$(wget $1 -o /dev/null -O - | grep '<span class="icon-right-open-mini">' -A5 | grep href= | grep '/bicicletas/' | head -1 | awk -F 'href="' {'print $2'} | awk -F '"' {'print $1'})
  TYPE=$(get_type_with_url_type ${TYPE_URL})
  echo ${TYPE}
}

# Params:
# 1 - The Url of bike
function print_price_url()
{
  PRICE=$(wget $1 -o /dev/null -O - | grep priceInfo -A4 | egrep -E -o '[0-9]{0,1}\.{0,1}[0-9]{3},{0,1}[0-9]{0,2}' | tr -d '.')
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

function dump_bike_from_file()
{
  FILE="$1"
  STORE="$2"
  TYPE="$3"
  TRADEMARK_MODELS=$(cat "${FILE}" | grep '<div class="col-sm-12 productItemName">' -A10 | grep 'title=' | sed -e 's/^[ \t]*//g'  | grep ^title | awk -F 'title="' {'print $2'} | awk -F '"' {'print $1'})
  echo "${TRADEMARK_MODELS}" | while read trademark_model;
  do 
    test -z "${trademark_model}" && continue;
    TRADEMARK_MODEL="${trademark_model}"
    TRADEMARK_MODEL_CLEAN=$(bubic_clean "${TRADEMARK_MODEL}")
    TRADEMARK=$(echo "${TRADEMARK_MODEL_CLEAN}" | awk {'print $1'})
    TRADEMARK_CAMEL=$(bubic_camel "${TRADEMARK}" ${NO_CAMEL_TRADEMARK_MIN})
    if [ "${TRADEMARK_CAMEL}" = "Solid" ];
    then
      TRADEMARK_CAMEL="Solid Bikes"
      MODEL=$(echo "${TRADEMARK_MODEL_CLEAN}" | awk {'for(i=3;i<=NF;++i){printf $i; if(i<NF){printf " "}}'} | tr -d '\r' | tr "'" '"')
    elif [ "${TRADEMARK_CAMEL}" = "Fixie" ];
    then
      TRADEMARK_CAMEL="Fixie Inc."
      MODEL=$(echo "${TRADEMARK_MODEL_CLEAN}" | awk {'for(i=3;i<=NF;++i){printf $i; if(i<NF){printf " "}}'} | tr -d '\r' | tr "'" '"')
    elif [ "${TRADEMARK_CAMEL}" = "Stereo" ];
    then
      TRADEMARK_CAMEL="Stereo Bikes"
      MODEL=$(echo "${TRADEMARK_MODEL_CLEAN}" | awk {'for(i=3;i<=NF;++i){printf $i; if(i<NF){printf " "}}'} | tr -d '\r' | tr "'" '"')
    elif [ "${TRADEMARK_CAMEL}" = "Ns" ];
    then
      TRADEMARK_CAMEL="NS Bikes"
      MODEL=$(echo "${TRADEMARK_MODEL_CLEAN}" | awk {'for(i=3;i<=NF;++i){printf $i; if(i<NF){printf " "}}'} | tr -d '\r' | tr "'" '"')
    elif [ "${TRADEMARK_CAMEL}" = "Gt" ];
    then
      TRADEMARK_CAMEL="Gt Bicycles"
      MODEL=$(echo "${TRADEMARK_MODEL_CLEAN}" | awk {'for(i=3;i<=NF;++i){printf $i; if(i<NF){printf " "}}'} | tr -d '\r' | tr "'" '"')
    else 
      MODEL=$(echo "${TRADEMARK_MODEL_CLEAN}" | awk {'for(i=2;i<=NF;++i){printf $i; if(i<NF){printf " "}}'} | tr -d '\r' | tr "'" '"')
    fi
    MODEL_CAMEL=$(camel "${MODEL}" "${NO_CAMEL_MIN}")
    MODEL_CAMEL_CLEAN=$(bubic_clean "${MODEL_CAMEL}")
    URL=$(grep "${trademark_model}" "${FILE}" | grep "<a href" | awk -F "a href=" {'print $2'} | awk {'print $1'} | tr -d '"' | head -1)
    if [ "${URL}" = "" ];
    then
      URL=$(cat "${FILE}" | grep '<div class="productName">' -A10 | grep -i "${TRADEMARK_MODEL}" -B2 | grep 'a href=' | awk -F 'a href=' {'print $2'} | awk {'print $1'} | tr -d '"')
    fi
    FINAL_URL=$(echo "\"${URL}\"")
    PRICE=$(print_price "${FILE}" "${TRADEMARK_MODEL}")
    #echo "========================================================================"
    #echo "TRADEMARK_MODEL=${TRADEMARK_MODEL}"
    #echo "TRADEMARK_MODEL_CLEAN=${TRADEMARK_MODEL_CLEAN}"
    #echo "TRADEMARK=${TRADEMARK}"
    #echo "TRADEMARK_CAMEL=${TRADEMARK_CAMEL}"
    #echo "MODEL=${MODEL}"
    #echo "URL=${FINAL_URL}"
    #echo "PRICE=${PRICE}"
    #echo "STORE=${STORE}"
    #echo "TYPE=${TYPE}"
    #echo "FILE=${FILE}"
    #echo "========================================================================"
    bubic_dump_bike "${MODEL_CAMEL_CLEAN}" "${FINAL_URL}" "${TRADEMARK_CAMEL}" "${PRICE}" "${STORE}" "${TYPE}"
  done
}

function process_page_url()
{
  FILE=$1
  PAGES=$2
  STORE=$3
  cat $FILE | sed -e 's@<p@\n<p@g' | grep '<p class="l4">' -A3 | while read TRADEMARK_MODEL_URL;
  do
    TRADEMARK_MODEL=$(echo ${TRADEMARK_MODEL_URL} | sed -e 's/<[^>]*>//g' | sed -e 's@\&raquo;@@g')
    SUBURL=$(echo ${TRADEMARK_MODEL_URL} | awk -F 'href="' {'print $2'} | awk -F '"' {'print $1'})
    FINAL_URL_NO_DOT=${BASE_URL}/${SUBURL}
    FINAL_URL=\"${FINAL_URL_NO_DOT}\"
    TRADEMARK_MODEL_CLEAN=$(bubic_clean "${TRADEMARK_MODEL}")
    TRADEMARK=$(echo "${TRADEMARK_MODEL_CLEAN}" | awk {'print $1'})
    TRADEMARK_CAMEL=$(bubic_camel "${TRADEMARK}" ${NO_CAMEL_TRADEMARK_MIN})
    if [ "${TRADEMARK_CAMEL}" = "Solid" ];
    then
      TRADEMARK_CAMEL="Solid Bikes"
      MODEL=$(echo "${TRADEMARK_MODEL_CLEAN}" | awk {'for(i=3;i<=NF;++i){printf $i; if(i<NF){printf " "}}'} | tr -d '\r' | tr "'" '"')
    elif [ "${TRADEMARK_CAMEL}" = "Fixie" ];
    then
      TRADEMARK_CAMEL="Fixie Inc."
      MODEL=$(echo "${TRADEMARK_MODEL_CLEAN}" | awk {'for(i=3;i<=NF;++i){printf $i; if(i<NF){printf " "}}'} | tr -d '\r' | tr "'" '"')
    elif [ "${TRADEMARK_CAMEL}" = "Stereo" ];
    then
      TRADEMARK_CAMEL="Stereo Bikes"
      MODEL=$(echo "${TRADEMARK_MODEL_CLEAN}" | awk {'for(i=3;i<=NF;++i){printf $i; if(i<NF){printf " "}}'} | tr -d '\r' | tr "'" '"')
    elif [ "${TRADEMARK_CAMEL}" = "Ns" ];
    then
      TRADEMARK_CAMEL="NS Bikes"
      MODEL=$(echo "${TRADEMARK_MODEL_CLEAN}" | awk {'for(i=3;i<=NF;++i){printf $i; if(i<NF){printf " "}}'} | tr -d '\r' | tr "'" '"')
    elif [ "${TRADEMARK_CAMEL}" = "Gt" ];
    then
      TRADEMARK_CAMEL="Gt Bicycles"
      MODEL=$(echo "${TRADEMARK_MODEL_CLEAN}" | awk {'for(i=3;i<=NF;++i){printf $i; if(i<NF){printf " "}}'} | tr -d '\r' | tr "'" '"')
    else
      MODEL=$(echo "${TRADEMARK_MODEL_CLEAN}" | awk {'for(i=2;i<=NF;++i){printf $i; if(i<NF){printf " "}}'} | tr -d '\r' | tr "'" '"')
    fi
    MODEL_CAMEL=$(camel "${MODEL}" "${NO_CAMEL_MIN}")
    MODEL_CAMEL_CLEAN=$(bubic_clean "${MODEL_CAMEL}")
    PRICE=$(print_price_url ${FINAL_URL_NO_DOT})
    TYPE=$(print_type_url ${FINAL_URL_NO_DOT})
    #echo "========================================================================"
    #echo "TRADEMARK_MODEL_URL=${TRADEMARK_MODEL_URL}"
    #echo "TRADEMARK_MODEL=${TRADEMARK_MODEL}"
    #echo "TRADEMARK=${TRADEMARK}"
    #echo "TRADEMARK_CAMEL=${TRADEMARK_CAMEL}"
    #echo "MODEL_CAMEL=${MODEL_CAMEL}"
    #echo "FINAL_URL=${FINAL_URL}"
    #echo "PRICE=${PRICE}"
    #echo "TYPE=${TYPE}"
    #echo "========================================================================"
    bubic_dump_bike "${MODEL_CAMEL_CLEAN}" "${FINAL_URL}" "${TRADEMARK_CAMEL}" "${PRICE}" "${STORE}" "${TYPE}"
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

MTB_FIX_BIKES_BASE="bicicletas-de-montana.html?page="
MTB_FIX_BIKES_PAGES="$(seq 0 15)"

MTB_DOUBLE_BIKES_BASE="bicicletas-doble-suspension.html?page="
MTB_DOUBLE_BIKES_PAGES="$(seq 0 15)"

MTB_29_BIKES_BASE="bicicletas-29-pulgadas.html?page="
MTB_29_BIKES_PAGES="$(seq 0 3)"

KIDS_BIKES_BASE="bicicletas-para-ninos.html?page="
KIDS_BIKES_PAGES="$(seq 0 10)"

BTT_KIDS_BIKES_BASE="bicicletas-juveniles-bicicletas-todo-terreno.html?page="
BTT_KIDS_BIKES_PAGES="$(seq 0 1)"

BTT_JUNIOR_BIKES_BASE="bicicletas-junior.html?page="
BTT_JUNIOR_BIKES_PAGES="$(seq 0 3)"

BMX_BIKES_BASE="bmx.html?page="
BMX_BIKES_PAGES="$(seq 0 5)"

ROAD_BIKES_BASE="bicicletas-de-carretera.html?page="
ROAD_BIKES_PAGES="$(seq 0 10)"

ROAD_CICLOCROSS_BIKES_BASE="bicicletas-fitness-bicicletas-ciclocross.html"
ROAD_CICLOCROSS_BIKES_PAGES=""

URBAN_XC_BIKES_BASE="bicicletas-xc-.html?page="
URBAN_XC_BIKES_PAGES="$(seq 0 3)"

URBAN_SINGLE_BIKES_BASE="bicicletas-single-speed.html"
URBAN_SINGLE_BIKES_PAGES=""

URBAN_WALK_BIKES_BASE="bicicleta-de-paseo.html?page="
URBAN_WALK_BIKES_PAGES="$(seq 0 5)"

URBAN_FOLDING_BIKES_BASE="bicicletas-plegables-.html?page="
URBAN_FOLDING_BIKES_PAGES="$(seq 0 3)"

URBAN_FOLDING2_BIKES_BASE="bicicletas-plegables.html?page="
URBAN_FOLDING2_BIKES_PAGES="$(seq 0 3)"

URBAN_RETRO_BIKES_BASE="cruiser.html?page="
URBAN_RETRO_BIKES_PAGES="$(seq 0 2)"

URBAN_ELECT_BIKES_BASE="bicicletas-electricas-pedelec.html?page="
URBAN_ELECT_BIKES_PAGES="$(seq 0 5)"

URBAN_ELECT2_BIKES_BASE="bicicletas-electricas.html?page="
URBAN_ELECT2_BIKES_PAGES="$(seq 0 5)"

URBAN_RAW_BIKES_BASE="bicicletas-urbanas.html?page="
URBAN_RAW_BIKES_PAGES="$(seq 0 2)"

URBAN_TREKKING_BIKES_BASE="bicicletas-trekking.html?page="
URBAN_TREKKING_BIKES_PAGES="$(seq 0 5)"

URBAN_HYBRID_BIKES_BASE="bicicletas-hibridas.html?page="
URBAN_HYBRID_BIKES_PAGES="$(seq 0 5)"

MAP_BIKES_BASE="mapa-del-sitio-bicicletas.html"
MAP_BIKES_PAGES=""

process_page_url "${MAP_BIKES_BASE}" "${MAP_BIKES_PAGES}" "Bikester" ""  >> ${OUTPUT_FILE}
