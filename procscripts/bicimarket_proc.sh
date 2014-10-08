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
BASE_URL="http://www.bicimarket.com"
NO_CAMEL_MIN=6
NO_CAMEL_TRADEMARK_MIN=0
MAX_PRICE_SEARCH=7
URL="www.bicimarket.com"
ONLY_DOMAIN="bicimarket.com"
EXCLUDE="-Rgif -Rpng -Rjpg"

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
# 1 - The File of bike
# 2 - The model of bike
function print_price()
{
  FILE="$1"
  MODEL="$2"
#  PRICE=$(grep "${MODEL}" "${FILE}" -A${MAX_PRICE_SEARCH} | egrep -E '<p>[0-9]{1,}' | head -1 |egrep "[0-9]{1,}.{0,1}" | sed -e 's/<[^>]*>//g' | tr -d '\r' | tr -d '.' | egrep -o "[0-9]{1,}.{0,1},{1,}[0-9]{0,}" | tr -d '\n')
  #PRICE=$(grep "${MODEL}" "${FILE}" -A${MAX_PRICE_SEARCH} | grep "<p>" | grep "</p>" | tr -d '\r')
  PRICE=$(grep "${MODEL}" "${FILE}" -A${MAX_PRICE_SEARCH} | grep '<span class="precio">' | tail -1 | sed -e 's/<[^>]*>//g' | tr -d '.')
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

function process_pages()
{
  BASE_FILE="$1"
  STORE="$2"
  TYPE="$3"
  #echo "catting:>${BASE_FILE}<"
  cat ${BASE_FILE} | grep "<h3><a href" | tr -d '\r' | sed -e 's/<[^>]*>//g' | sed -e 's/^[ \t]*//g' | uniq | while read model;
      do
        # NOTE: each bike should be more or less like:
        # ORBEA<br>AQUA T23 2013<br><b>717 &euro;</b>
        TRADEMARK=$(echo ${model} | awk {'print $1'})
        MODEL=$(echo ${model} | awk {'for(i=2;i<=NF;++i){printf $i; if(i<NF){printf " "}}'})
        URL=$(grep "${model}" "${BASE_FILE}" | awk -F '<h3><a href="' {'print $2'} | awk -F ">" {'print $1'} | tr -d "\r" | tr -d '"' | head -1)
        FINAL_URL=$(echo "${BASE_URL}${URL}")
        PRICE=$(print_price "${BASE_FILE}" "${MODEL}")
        TRADEMARK_CAMEL=$(camel "${TRADEMARK}" ${NO_CAMEL_TRADEMARK_MIN})
        MODEL_CAMEL=$(camel "${MODEL}" ${NO_CAMEL_MIN})
        #echo
        #echo "*****>${model}<*****"
        #echo "=========>TRADEMARK:${TRADEMARK_CAMEL}<==========="
        #echo "=========>MODEL:${MODEL_CAMEL}<==========="
        #echo "=========>URL:${FINAL_URL}<==========="
        #echo "=========>STORE:${STORE}<==========="
        #echo "=========>TYPE:${TYPE}<==========="
        #echo "=========>PRICE:${PRICE}<==========="
        #echo
        dump_bike "${MODEL_CAMEL}" "${FINAL_URL}" "${TRADEMARK_CAMEL}" "${PRICE}" "${STORE}" "${TYPE}"
     done
}

> ${OUTPUT_FILE}

MTB_29_BIKES_BASE="Bicicletas-29-pulgadas-c20380.html"
MTB_27_5_BIKES_BASE="Bicicletas-27-5-pulgadas-c20400.html"
ELECTRIC_BIKES_BASE="Bicicletas-Bicicleta-Electrica-c20130.html"
TRIAL_BIKES_BASE="Bicicletas-BikeTrial-c20131.html"
BMX_BIKES_BASE="Bicicletas-BMX-c20249.html"
ROAD_BIKES_BASE="Bicicletas-Carretera-c10020.html"
CICLOCROSS_BIKES_BASE="Bicicletas-Ciclocross-c20270.html"
MTB_XC_BIKES_BASE="Bicicletas-Cross-country-c1010.html"
CRUISERS_BIKES_BASE="Bicicletas-Cruisers-c20397.html"
DIRT_BIKES_BASE="Bicicletas-Dirt-c20303.html"
DOUBLE_FREERIDE_BIKES_BASE="Bicicletas-Doble-Freeride-DH-c20164.html"
MTB_DOUBLE_BIKES_BASE="Bicicletas-Doble-XC-Enduro-c20075.html"
FIXIE_BIKES_BASE="Bicicletas-Fixed-c20306.html"
HYBRID_BIKES_BASE="Bicicletas-Hibrida-c10050.html"
JUNIOR_BIKES_BASE="Bicicletas-Infantil-c20177.html"
LADY_BIKES_BASE="Bicicletas-Lady-c20253.html"
VELO_BIKES_BASE="Bicicletas-Pista-c20396.html"
FOLDING_BIKES_BASE="Bicicletas-Plegable-c10070.html"
TRIATLON_BIKES_BASE="Bicicletas-Triatlon-c20376.html"
URBAN_BIKES_BASE="Bicicletas-Urbanas-c10030.html"
MTB_26_ENDURO_BASE="Bicicletas-Enduro-AM-26-c20075.html"
MTB_27_ENDURO_BASE="Bicicletas-Enduro-AM-27-5-c20400.html"
MTB_29_ENDURO_BASE="Bicicletas-Enduro-AM-29-c20404.html"
MTB_XC_26_BASE="Bicicletas-MTB-XC-26-c1010.html"
MTB_XC_27_5_DOUBLE_BASE="Bicicletas-MTB-XC-Doble-27-5-c20405.html"
MTB_XC_29_DOUBLE_BASE="Bicicletas-MTB-XC-Doble-29-c20403.html"
MTB_XC_27_5_FIX_BASE="Bicicletas-MTB-XC-Rigida-27-5-c20402.html"
MTB_XC_29_FIX_BASE="Bicicletas-MTB-XC-Rigida-29-c20380.html"

#2014 review

function process_all_pages() {
    FILE="$1"
    PAGES="$2"
    STORE="$3"
    TYPE="$4"
    for page in ${PAGES};
    do
      process_pages "$1"-"$page" "$3" "$4"
    done
}


ROAD_2014_BIKES_BASE="road"
ROAD_2014_BIKES_PAGES="$(seq 1 4)"

ELECTRIC_2014_BIKES_BASE="electric"
ELECTRIC_2014_BIKES_PAGES="$(seq 1 2)"

URBAN_2014_BIKES_BASE="urban"
URBAN_2014_BIKES_PAGES="$(seq 1 2)"

ROAD_TRIATLON_2014_BIKES_BASE="road-triatlon"
ROAD_TRIATLON_2014_BIKES_PAGES="$(seq 1 2)"

ROAD_CICLOCROSS_2014_BIKES_BASE="road-ciclocross"
ROAD_CICLOCROSS_2014_BIKES_PAGES="$(seq 1 2)"

MTB_2014_BIKES_BASE="mtb"
MTB_2014_BIKES_PAGES="$(seq 1 2)"

MTB_27_5_2014_BIKES_BASE="mtb-27-5"
MTB_27_5_2014_BIKES_PAGES="$(seq 1 4)"

MTB_29_2014_BIKES_BASE="mtb-29"
MTB_29_2014_BIKES_PAGES="$(seq 1 5)"

KIDS_2014_BIKES_BASE="kids"
KIDS_2014_BIKES_PAGES="$(seq 1 3)"

BMX_2014_BIKES_BASE="bmx"
BMX_2014_BIKES_PAGES="$(seq 1 2)"

FOLDING_2014_BIKES_BASE="urban-folding"
FOLDING_2014_BIKES_PAGES="$(seq 1 2)"

process_all_pages "${ROAD_2014_BIKES_BASE}" "${ROAD_2014_BIKES_PAGES}" "Bicimarket" "ROAD" >> ${OUTPUT_FILE}
process_all_pages "${ELECTRIC_2014_BIKES_BASE}" "${ELECTRIC_2014_BIKES_PAGES}" "Bicimarket" "URBAN-ELECTRIC" >> ${OUTPUT_FILE}
process_all_pages "${URBAN_2014_BIKES_BASE}" "${URBAN_2014_BIKES_PAGES}" "Bicimarket" "URBAN" >> ${OUTPUT_FILE}
process_all_pages "${ROAD_TRIATLON_2014_BIKES_BASE}" "${ROAD_TRIATLON_2014_BIKES_PAGES}" "Bicimarket" "ROAD-TRIATLON" >> ${OUTPUT_FILE}
process_all_pages "${ELECTRIC_2014_BIKES_BASE}" "${ELECTRIC_2014_BIKES_PAGES}" "Bicimarket" "URBAN-ELECTRIC" >> ${OUTPUT_FILE}
process_all_pages "${MTB_2014_BIKES_BASE}" "${MTB_2014_BIKES_PAGES}" "Bicimarket" "MTB" >> ${OUTPUT_FILE}
process_all_pages "${MTB_27_5_2014_BIKES_BASE}" "${MTB_27_5_2014_BIKES_PAGES}" "Bicimarket" "MTB" >> ${OUTPUT_FILE}
process_all_pages "${MTB_29_2014_BIKES_BASE}" "${MTB_29_2014_BIKES_PAGES}" "Bicimarket" "MTB-29" >> ${OUTPUT_FILE}
process_all_pages "${KIDS_2014_BIKES_BASE}" "${KIDS_2014_BIKES_PAGES}" "Bicimarket" "KIDS" >> ${OUTPUT_FILE}
process_all_pages "${BMX_2014_BIKES_BASE}" "${BMX_2014_BIKES_PAGES}" "Bicimarket" "BMX" >> ${OUTPUT_FILE}
process_all_pages "${FOLDING_2014_BIKES_BASE}" "${FOLDING_2014_BIKES_PAGES}" "Bicimarket" "URBAN-FOLDING" >> ${OUTPUT_FILE}
