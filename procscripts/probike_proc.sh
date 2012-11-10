#!/bin/bash
#
# Parse results to common file with structure:
#
# [Grow 2]
# SUBURL="http://www.bicicletasgil.com/producto/Orbea-Grow-2"
# TRADEMARK=Orbea
# PRICE=249,00
# STORE=Biciletas Gil
# KIND=MTB-FIX

MAX_PRICE=15
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
  MODEL=$(echo "$1" | sed -e 's/[Bb]icicleta//g' | sed -e "s/'/\\\'/g")
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
  PRICE=$(grep "$2" "$1" -A${MAX_PRICE} | egrep -E -o '[0-9]{0,}.{0,}[0-9]{2,},{0,}[0-9]{0,}' | sed -e 's/<[^>]*>//g' | grep -v "[A-Za-z]" | tr -d '.')
  echo ${PRICE}
}

function print_url()
{
  model="$1"
  BASE_FILE="$2"
  echo "${model}" | grep '"'
  if [ $? -eq 0 ]; 
  then
    MODEL=$(echo "${model}" | sed -e 's-\"-\\\"-g')
    URL=$(grep "${MODEL}" "${BASE_FILE}" | grep -o "<a href=[^>]*>" | awk -F "title" {'print $1'} | tail -1 | tr -d '"' | awk -F '<a href=' {'print $2'} | tr -d ' ')
  else
    URL=$(grep "${model}" "${BASE_FILE}" | grep -o "<a href=[^>]*>" | awk -F "title" {'print $1'} | tail -1 | tr -d '"' | awk -F '<a href=' {'print $2'} | tr -d ' ')
  fi
  echo "${URL}"
}

function process_page_url()
{
  BASE_FILE="$1"
  STORE="$2"
  TYPE="$3"
  MODELS=$(cat "${BASE_FILE}" | grep "product-name" -A2 |  grep -v "path_listado" | sed -e 's/<[^>]*>//g' | grep [A-Z,a-z])
  echo "${MODELS}" | while read model;
  do
    MODEL_FILTER=$(filter_model "${model}")
    MODEL=$(echo "${MODEL_FILTER}" | awk {'for(i=2;i<=NF;++i){printf $i; if(i<NF){printf " "}}'} | tr -d '\r')
    MODEL_CAMEL=$(camel "${MODEL}" ${NO_CAMEL_MIN})
    TRADEMARK=$(echo "${MODEL_FILTER}" | awk {'print $1'})
    TRADEMARK_CAMEL=$(camel "${TRADEMARK}" ${NO_CAMEL_TRADEMARK_MIN})
    URL=$(print_url "${model}" "${BASE_FILE}")
    #URL=$(grep "${model}" "${BASE_FILE}" | grep -o "<a href=[^>]*>" | awk -F "title" {'print $1'} | tail -1 | tr -d '"' | awk -F '<a href=' {'print $2'} | tr -d ' ')
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

ROAD_BIKES_BASE="carretera.html?p="
ROAD_BIKES_PAGES="$(seq 1 3)"

BMX_BIKES_BASE="free-dh.html"

KIDS_BIKES_BASE="infantil.html"

MTB_BIKES_BASE="mtb.html?p="
MTB_BIKES_PAGES=$(seq 1 8)

URBAN_BIKES_BASE="urbana.html?p="
URBAN_BIKES_PAGES=$(seq 1 3)

> ${OUTPUT_FILE}

#process_pages "${MTB_BIKES_BASE}" "${MTB_BIKES_PAGES}" "Probike" "MTB" >> ${OUTPUT_FILE}
#process_pages "${ROAD_BIKES_BASE}" "${ROAD_BIKES_PAGES}" "Probike" "ROAD"  >> ${OUTPUT_FILE}
#process_pages "${URBAN_BIKES_BASE}" "${URBAN_BIKES_PAGES}" "Probike" "URBAN"  >> ${OUTPUT_FILE}
#process_pages "${BMX_BIKES_BASE}" "" "Probike" "BMX"  >> ${OUTPUT_FILE}
#process_pages "${KIDS_BIKES_BASE}" "" "Probike" "KIDS"  >> ${OUTPUT_FILE}

process_pages "${MTB_BIKES_BASE}" "${MTB_BIKES_PAGES}" "Probike" "MTB"
process_pages "${ROAD_BIKES_BASE}" "${ROAD_BIKES_PAGES}" "Probike" "ROAD"
process_pages "${URBAN_BIKES_BASE}" "${URBAN_BIKES_PAGES}" "Probike" "URBAN"
process_pages "${BMX_BIKES_BASE}" "" "Probike" "BMX"
process_pages "${KIDS_BIKES_BASE}" "" "Probike" "KIDS"
