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
URL_BASE="http://www.chainreactioncycles.com"
MAX_PRICE=50
NO_CAMEL_MIN=6
NO_CAMEL_TRADEMARK_MIN=0
OUTPUT_FILE=./output
#OUTPUT_FILE=/dev/stdout

TRADEMARK_KEY="TRADEMARK"
SUBURL_KEY="SUBURL"
STORE_KEY="STORE"
PRICE_KEY="PRICE"
KIND_KEY="KIND"

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
  MODEL_FILTER=$(echo "${MODEL}" | sed -e 's/[Bb]icicleta//g' | sed -e "s/'/\\\"/g")
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
  PRICE=$(grep "$2" "$1" -A${MAX_PRICE} | grep "Desde\|AHORA" -A1 | grep '€' | head -1 | sed -e 's/<[^>]*>//g' | tr '.' ',' | grep -o "[0-9,\.]*[0-9],[0-9]*")
  echo ${PRICE}
}

# Params:
# 1 - The URL of bike
# 2 - The MODEL of bike
function print_price2()
{
  PRICE=$(wget -o /dev/null -O - "$1" | grep "$2" -A${MAX_PRICE} | grep 'id="crc_product_rp"' | sed -e 's/<[^>]*>//g' | tr '.' ',' | grep -o "[0-9,\.]*[0-9],[0-9]*" | head -1)
  echo "${PRICE}"
}

# Params:
# 1 - The URL of bike
function print_price3()
{
  PRICE=$(wget -o /dev/null -O - "$1" | grep '<span class="pixel_separator" id="crc_product_rp">'| sed -e 's/<[^>]*>//g' | tr '.' ',' | egrep -o -E "[0-9]{2,5},{0,1}[0-9]{0,2}" | head -1)
  echo "${PRICE}"
}

function log_url()
{
  model="$1"
  BASE_FILE="$2"
  echo "Model:${model}"
  echo "${model}" | grep '"' > /dev/null
  if [ $? -eq 0 ]; 
  then
    echo "Here should go the link with quotes!!!"
    echo "grep is:"
    MODEL=$(echo "${model}" | sed -e 's-\"-\\\"-g')
    echo "grep \"${MODEL}\" \"${BASE_FILE}\" | grep \"href\"  | awk -F \"href=\" {'print $2'} | awk -F \"class\" {'print \$1'} | awk -F \"title\" {'print \$1'} | head -1 | tr -d '\"' | sed -e 's/[ \t]$//g' | awk {'print \$1'})"
    URL=$(grep "${MODEL}" "${BASE_FILE}" | grep "href"  | awk -F "href=" {'print $2'} | awk -F "class" {'print $1'} | awk -F "title" {'print $1'} | head -1 | tr -d '"' | sed -e 's/[ \t]$//g' | awk {'print $1'})
  else
    URL=$(grep "${model}" "${BASE_FILE}" | grep "href"  | awk -F "href=" {'print $2'} | awk -F "class" {'print $1'} | awk -F "title" {'print $1'} | head -1 | tr -d '"' | sed -e 's/[ \t]$//g' | awk {'print $1'})
  fi
  URL_COMPLETE="${URL_BASE}${URL}"
  echo "${URL_COMPLETE}"
}

function print_url()
{
  model="$1"
  BASE_FILE="$2"
  echo "${model}" | grep '"' > /dev/null
  if [ $? -eq 0 ]; 
  then
    MODEL=$(echo "${model}" | sed -e 's-\"-\\\"-g')
    URL=$(grep "${MODEL}" "${BASE_FILE}" | grep "href"  | awk -F "href=" {'print $2'} | awk -F "class" {'print $1'} | awk -F "title" {'print $1'} | head -1 | tr -d '"' | tr -d "'" | sed -e 's/[ \t]$//g' | awk {'print $1'})
  else
    URL=$(grep "${model}" "${BASE_FILE}" | grep "href"  | awk -F "href=" {'print $2'} | awk -F "class" {'print $1'} | awk -F "title" {'print $1'} | head -1 | tr -d '"' | tr -d "'" | sed -e 's/[ \t]$//g' | awk {'print $1'})
  fi
  URL_COMPLETE="${URL_BASE}${URL}"
  echo "${URL_COMPLETE}"
}

function process_page_url()
{
  BASE_FILE="$1"
  STORE="$2"
  TYPE="$3"
  #MODELS=$(cat "${BASE_FILE}" | grep '<li class="description">' -A2 | sed -e 's/<[^>]*>//g' | grep -v ^'--' | grep  ^[A-Z,a-z,0-9] | grep -v "Pedals" | grep -v "Helmet")
  MODELS=$(cat "${BASE_FILE}" | grep '<li class="description">' -A3 |  grep '</a>' | awk -F '</a>' {'print $1'} | grep -v "Pedals" | grep -v "Helmet" | grep -v "Casco" | grep -v "Pedales")
  echo "${MODELS}" | while read model;
  do
    MODEL_FILTER=$(bubic_clean "${model}")
    MODEL=$(echo "${MODEL_FILTER}" | awk {'for(i=2;i<=NF;++i){printf $i; if(i<NF){printf " "}}'} | tr -d '\r')
    MODEL_NO_FILTER=$(echo "${model}" | awk {'for(i=2;i<=NF;++i){printf $i; if(i<NF){printf " "}}'} | tr -d '\r')
    TRADEMARK=$(echo "${MODEL_FILTER}" | awk {'print $1'})
    TRADEMARK_SPECIAL=$(echo "${MODEL_FILTER}" | grep -i ^"De Rosa\|Vitus Bikes")
    if [ $? -eq 0 ]; 
    then
      MODEL=$(echo "${MODEL_FILTER}" | awk {'for(i=3;i<=NF;++i){printf $i; if(i<NF){printf " "}}'} | tr -d '\r')
      MODEL_CAMEL=$(camel "${MODEL}" ${NO_CAMEL_MIN})
      TRADEMARK=$(echo "${MODEL_FILTER}" | awk {'for(i=1;i<=2;++i){printf $i; if(i<NF){printf " "}}'} | tr -d '\r')
    else 
      MODEL=$(echo "${MODEL_FILTER}" | awk {'for(i=2;i<=NF;++i){printf $i; if(i<NF){printf " "}}'} | tr -d '\r')
      TRADEMARK=$(echo "${MODEL_FILTER}" | awk {'print $1'})
    fi
    MODEL_CAMEL=$(camel "${MODEL}" ${NO_CAMEL_MIN})
    TRADEMARK_CAMEL=$(camel "${TRADEMARK}" ${NO_CAMEL_TRADEMARK_MIN})

    #log_url "${MODEL_NO_FILTER}" "${BASE_FILE}"
    SUBURL=$(grep "${model}" "${BASE_FILE}" -B2 | grep 'a href' | awk -F "a href=" {'print $2'} \
             | awk {'print $1'} | tr -d '"' | head -1)
    URL="\"${URL_BASE}${SUBURL}\""
    PRICE=$(grep "${model}" "${BASE_FILE}" -A30 | egrep -o -E "[0-9]{1,5}\.{1}[0-9]{2}" | head -1 | tr '.' ',')

    # Avoid prices smaller than 100 euros, as many models (not only bikes) are being parsed
    test -z "${PRICE}" && PRICE=$(print_price2 "${URL}" "${MODEL}")
    PRICE_NO_DEC=$(echo ${PRICE} | awk -F "," {'print $1'})
    test -z ${PRICE_NO_DEC}
    if [ $? -ne 0 ];
    then
      if [ ${PRICE_NO_DEC} -lt 100 ]; then PRICE=; fi
    fi
    test -z "${PRICE}" && PRICE=$(print_price3 "${URL}")

    #echo "========================================================================"
    #echo "TRADEMARK_MODEL=${model}"
    #echo "TRADEMARK=${TRADEMARK_CAMEL}"
    #echo "MODEL=${MODEL}"
    #echo "MODEL_CAMEL=${MODEL_CAMEL}"
    #echo "URL=${URL}"
    #echo "PRICE=${PRICE}"
    #echo "STORE=${STORE}"
    #echo "TYPE=${TYPE}"
    #echo "FILE=${BASE_FILE}"
    #echo "SEARCH_MODEL=>${MODEL}<="
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

MTB_BIKES_BASE="rigidos?page="
MTB_BIKES_PAGES="$(seq 1 3)"

MTB_DOUBLE_BIKES_BASE="suspension-total?page="
MTB_DOUBLE_BIKES_PAGES="$(seq 1 3)"

ROAD_BIKES_BASE="bicis-de-carretera?page="
ROAD_BIKES_PAGES="$(seq 1 2)"

ROAD_TIME_BIKES_BASE="bicis-de-contra-reloj?page="
ROAD_TIME_BIKES_PAGES="1"

ELECTRIC_BIKES_BASE=""
ELECTRIC_BIKES_PAGES=""

FOLDING_BIKES_BASE=""
FOLDING_BIKES_PAGES=""

CRUISER_BIKES_BASE="bicis-cruiser?page="
CRUISER_BIKES_PAGES="1"

BMX_BIKES_BASE="bicis-bmx?page="
BMX_BIKES_PAGES="$(seq 1 3)"

KIDS_BIKES_BASE="bicis-infantiles?page="
KIDS_BIKES_PAGES="$(seq 1 2)"
 
URBAN_BIKES_BASE="bicis-urbanas?page="
URBAN_BIKES_PAGES="$(seq 1 3)"

URBAN_FOLDING_BIKES_BASE="bicis-plegables?page="
URBAN_FOLDING_BIKES_PAGES="$(seq 1 2)"

CICLOCROSS_BIKES_BASE="bicis-ciclocross?page="
CICLOCROSS_BIKES_PAGES="1"

> ${OUTPUT_FILE}

process_pages "${ROAD_BIKES_BASE}" "${ROAD_BIKES_PAGES}" "Chain Reaction" "ROAD"  >> ${OUTPUT_FILE}
process_pages "${MTB_BIKES_BASE}" "${MTB_BIKES_PAGES}" "Chain Reaction" "MTB-FIX" >> ${OUTPUT_FILE}
process_pages "${MTB_DOUBLE_BIKES_BASE}" "${MTB_DOUBLE_BIKES_PAGES}" "Chain Reaction" "MTB-DOUBLE" >> ${OUTPUT_FILE}
process_pages "${CRUISER_BIKES_BASE}" "${CRUISER_BIKES_PAGES}" "Chain Reaction" "URBAN" >> ${OUTPUT_FILE}
process_pages "${BMX_BIKES_BASE}" "${BMX_BIKES_PAGES}" "Chain Reaction" "BMX"  >> ${OUTPUT_FILE}
process_pages "${KIDS_BIKES_BASE}" "${KIDS_BIKES_PAGES}" "Chain Reaction" "KIDS"  >> ${OUTPUT_FILE}
process_pages "${URBAN_BIKES_BASE}" "${URBAN_BIKES_PAGES}" "Chain Reaction" "URBAN"  >> ${OUTPUT_FILE}
process_pages "${URBAN_FOLDING_BIKES_BASE}" "${URBAN_FOLDING_BIKES_PAGES}" "Chain Reaction" "URBAN-FOLDING"  >> ${OUTPUT_FILE}
process_pages "${BMX_BIKES_BASE}" "${BMX_BIKES_PAGES}" "Chain Reaction" "BMX"  >> ${OUTPUT_FILE}
process_pages "${CICLOCROSS_BIKES_BASE}" "${CICLOCROSS_BIKES_PAGES}" "Chain Reaction" "URBAN"  >> ${OUTPUT_FILE}

#process_pages "${ROAD_BIKES_BASE}" "${ROAD_BIKES_PAGES}" "Chain Reaction" "ROAD"  
#process_pages "${MTB_BIKES_BASE}" "${MTB_BIKES_PAGES}" "Chain Reaction" "MTB" 
#process_pages "${ELECTRIC_BIKES_BASE}" "${ELECTRIC_BIKES_PAGES}" "Chain Reaction" "URBAN"  
#process_pages "${FOLDING_BIKES_BASE}" "${FOLDING_BIKES_PAGES}" "Chain Reaction" "URBAN" 
#process_pages "${CRUISER_BIKES_BASE}" "${CRUISER_BIKES_PAGES}" "Chain Reaction" "URBAN" 
#process_pages "${BMX_BIKES_BASE}" "${BMX_BIKES_PAGES}" "Chain Reaction" "BMX"  
#process_pages "${KIDS_BIKES_BASE}" "${KIDS_BIKES_PAGES}" "Chain Reaction" "KIDS"  
#process_pages "${URBAN_BIKES_BASE}" "${URBAN_BIKES_PAGES}" "Chain Reaction" "URBAN"  
#process_pages "${BMX_BIKES_BASE}" "${BMX_BIKES_PAGES}" "Chain Reaction" "BMX"  
#process_pages "${CICLOCROSS_BIKES_BASE}" "${CICLOCROSS_BIKES_PAGES}" "Chain Reaction" "URBAN"  

