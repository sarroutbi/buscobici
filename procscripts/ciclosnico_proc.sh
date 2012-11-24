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
NO_CAMEL_MIN=6
NO_CAMEL_TRADEMARK_MIN=0
OUTPUT_FILE=./output

#### KEYS GENERATED
TRADEMARK_KEY="TRADEMARK"
SUBURL_KEY="SUBURL"
STORE_KEY="STORE"
PRICE_KEY="PRICE"
KIND_KEY="KIND"

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
  # | sed -e 's!\'!\\\'!g')
  #  echo "======> MODEL:${1} <========="
  echo ${MODEL}
  #echo "======================================"
}

# Params:
# 1 - The FILE  of bike
# 2 - The MODEL of bike
function print_price()
{
  PRICE=$(grep "$2" "$1" -A${MAX_PRICE} | egrep -E -o '[0-9]{0,}.{0,}[0-9]{2,},{0,}[0-9]{0,}' | sed -e 's/<[^>]*>//g' | grep -v "[A-Za-z]" | tr -d '.' | tr -d ' ' | head -1)
  echo ${PRICE}
}

function print_url()
{
  model="$1"
  BASE_FILE="$2"
  echo "${model}" | grep '"' > /dev/null
  if [ $? -eq 0 ]; 
  then
    MODEL=$(echo "${model}" | sed -e 's-\"-\\\"-g')
    URL=$(grep "${MODEL}" "${BASE_FILE}" | grep "a href"  | awk -F "a href=" {'print $2'} | awk -F "class" {'print $1'} | awk -F "title" {'print $1'} | head -1 | tr -d '"' | sed -e 's/[ \t]$//g')
  else
    URL=$(grep "${model}" "${BASE_FILE}" | grep "a href"  | awk -F "a href=" {'print $2'} | awk -F "class" {'print $1'} | awk -F "title" {'print $1'} | head -1 | tr -d '"' | sed -e 's/[ \t]$//g')
  fi
  echo "${URL}"
}

function process_page_url()
{
  BASE_FILE="$1"
  STORE="$2"
  TYPE="$3"
  MODELS=$(cat "${BASE_FILE}" | grep "<h3>" | sed -e 's/^[ \t]//g' | sed -e 's/^[ \t]*//g' | grep product_link | sed -e 's/<[^>]*>//g' | sort | tr -d '\t' | uniq)
  echo "${MODELS}" | while read model;
  do
    MODEL_FILTER=$(filter_model "${model}")
    MODEL=$(echo "${MODEL_FILTER}" | awk {'for(i=2;i<=NF;++i){printf $i; if(i<NF){printf " "}}'} | tr -d '\r')
    TRADEMARK=$(echo "${MODEL_FILTER}" | awk {'print $1'})
    MODEL_CAMEL=$(camel "${MODEL}" ${NO_CAMEL_MIN})
    TRADEMARK_CAMEL=$(camel "${TRADEMARK}" ${NO_CAMEL_TRADEMARK_MIN})
    URL=$(print_url "${model}" "${BASE_FILE}")
    PRICE=$(print_price "${BASE_FILE}" "${model}")
    #echo "========================================================================"
    #echo "TRADEMARK=${TRADEMARK_CAMEL}"
    #echo "MODEL=>${MODEL_CAMEL}<="
    #echo "URL=${URL}"
    #echo "PRICE=${PRICE}"
    #echo "STORE=${STORE}"
    #echo "TYPE=${TYPE}"
    #echo "FILE=${BASE_FILE}"
    #echo "SEARCH_MODEL=>${model}<="
    #echo "========================================================================"
    dump_bike "${MODEL_CAMEL}" "${URL}" "${TRADEMARK_CAMEL}" "${PRICE}" "${STORE}" "${TYPE}"
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

ROAD_BIKES_BASE="category.php?id_category=31&p="
ROAD_BIKES_PAGES="$(seq 1)"

MTB_BIKES_BASE="category.php?id_category=32&p="
MTB_BIKES_PAGES="$(seq 1 5)"

URBAN_BIKES_BASE="category.php?id_category=33&p="
URBAN_BIKES_PAGES="$(seq 1)"

KIDS_BIKES_BASE="category.php?id_category=34&p="
KIDS_BIKES_PAGES="$(seq 1)"

BMX_BIKES_BASE="category.php?id_category=35&p="
BMX_BIKES_PAGES="$(seq 1)"

> ${OUTPUT_FILE}

process_pages "${ROAD_BIKES_BASE}" "${ROAD_BIKES_PAGES}" "Ciclos Nico" "ROAD"  >> ${OUTPUT_FILE}
process_pages "${MTB_BIKES_BASE}" "${MTB_BIKES_PAGES}" "Ciclos Nico" "MTB" >> ${OUTPUT_FILE}
process_pages "${URBAN_BIKES_BASE}" "${URBAN_BIKES_PAGES}" "Ciclos Nico" "URBAN"  >> ${OUTPUT_FILE}
process_pages "${BMX_BIKES_BASE}" "${BMX_BIKES_PAGES}" "Ciclos Nico" "BMX"  >> ${OUTPUT_FILE}
process_pages "${KIDS_BIKES_BASE}" "${KIDS_BIKES_PAGES}" "Ciclos Nico" "KIDS"  >> ${OUTPUT_FILE}

#process_pages "${ROAD_BIKES_BASE}" "${ROAD_BIKES_PAGES}" "Ciclos Nico" "ROAD"
#process_pages "${MTB_BIKES_BASE}" "${MTB_BIKES_PAGES}" "Ciclos Nico" "MTB"
#process_pages "${URBAN_BIKES_BASE}" "${URBAN_BIKES_PAGES}" "Ciclos Nico" "URBAN"
#process_pages "${BMX_BIKES_BASE}" "${BMX_BIKES_PAGES}" "Ciclos Nico" "BMX"
#process_pages "${KIDS_BIKES_BASE}" "${KIDS_BIKES_PAGES}" "Ciclos Nico" "KIDS"
