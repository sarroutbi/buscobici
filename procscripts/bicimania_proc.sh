#!/bin/sh
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
  #if [[ "$1" != "" ]] && [[ "$2" != "" ]] && [[ "$3" != ""]]; 
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
  MODELS=$(wget -O - "$1" 2>&1 | grep "<title>" -A 3 | sed -e 's/<[^>]*>//g' | awk -F " - " {'print $NF'} | grep "[a-z,A-Z]*" | tr -d "\n")
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
  PRICES=$(wget "$1" -O - 2>&1 | grep "IVA" | grep '&euro' | grep -o "[0-9,\.]*[0-9],[0-9]*" | tr -d '.' | tail -1)
  for price in ${PRICES};
  do
    PRICE=${price} 
  done
  echo ${PRICE}
}

function process_pages()
{
  BASE_URL="$1"
  PAGES="$2"
  STORE="$3"
  TYPE="$4"
  if [ "${PAGES}" = "" ];
  then
    MODELS=$(cat "${BASE_URL}" | grep href | grep "productListing-data" | awk -F "<b>" {'print $2'} | awk -F "</b>" {'print $1'})
    echo "${MODELS}" | while read model;
    do
      MODEL=$(echo "${model}" | awk {'for(i=2;i<=NF;++i){printf $i; if(i<NF){printf " "}}'} | tr -d '\r')
      TRADEMARK=$(echo "${model}" | awk {'print $1'})
      URL=$(grep "${model}" "${BASE_URL}" | grep -o "<a href=[^>]*>" | sed -e 's/<a href=//g' | tr -d '>' | awk -F "?" {'print $1'} | head -1 | uniq)
      PRICE=$(print_price "${URL}")
      dump_bike "${MODEL}" "${URL}" "${TRADEMARK}" "${PRICE}" "${STORE}" "${TYPE}"
    done
  else
    for page in ${PAGES};
    do
      MODELS=$(cat "${BASE_URL}${page}" | grep href | grep "productListing-data" | awk -F "<b>" {'print $2'} | awk -F "</b>" {'print $1'})
      echo "${MODELS}" | while read model
      do
        MODEL=$(echo "${model}" | awk {'for(i=2;i<=NF;++i){printf $i; if(i<NF){printf " "}}'} | tr -d '\r')
        TRADEMARK=$(echo "${model}" | awk {'print $1'})
        URL=$(grep "${model}" "${BASE_URL}${page}" | grep -o "<a href=[^>]*>" | sed -e 's/<a href=//g' | tr -d '>' | awk -F "?" {'print $1'} | head -1 | uniq)
        PRICE=$(print_price $(echo "${URL}" | tr -d '"'))
        dump_bike "${MODEL}" "${URL}" "${TRADEMARK}" "${PRICE}" "${STORE}" "${TYPE}"
      done
    done 
  fi
}

function process_pages2()
{
  BASE_FILE="$1"
  PAGES="$2"
  STORE="$3"
  TYPE="$4"
  if [ "${PAGES}" = "" ];
  then
      URLS=$(cat ${BASE_FILE} | grep "productListing-data"| grep -o "<a href=[^>]*>" | sed -e 's/<a href=//g' | tr -d '>'| tr -d '"' | uniq)
      echo "${URLS}" | while read URL;
      do
        TRADEMARK_MODEL=$(print_model ${URL})
        TRADEMARK_MODEL=${TRADEMARK_MODEL}
        TRADEMARK=$(echo ${TRADEMARK_MODEL} | awk {'print $1'})
        MODEL=$(echo ${TRADEMARK_MODEL} | awk {'for(i=2;i<=NF;++i){printf $i; if(i<NF){printf " "}}'} | tr -d '\r')
        PRICE=$(print_price "${URL}")
        FINAL_URL=$(echo "${URL}" | awk -F "?" {'print $1'})
        ##echo "========================================================================"
        ##echo "TRADEMARK_MODEL=${TRADEMARK_MODEL}"
        ##echo "TRADEMARK=${TRADEMARK}"
        ##echo "MODEL=${MODEL}"
        ##echo "URL=${FINAL_URL}"
        ##echo "PRICE=${PRICE}"
        ##echo "========================================================================"
        dump_bike "${MODEL}" "${FINAL_URL}" "${TRADEMARK}" "${PRICE}" "${STORE}" "${TYPE}"
      done
  else
    for page in ${PAGES};
    do 
      URLS=$(cat ${BASE_FILE}${page} | grep "productListing-data"| grep -o "<a href=[^>]*>" | sed -e 's/<a href=//g' | tr -d '>'| tr -d '"' | uniq)
      echo "${URLS}" | while read URL;
      do
        TRADEMARK_MODEL=$(print_model ${URL})
        TRADEMARK=$(echo ${TRADEMARK_MODEL} | awk {'print $1'})
        MODEL=$(echo ${TRADEMARK_MODEL} | awk {'for(i=2;i<=NF;++i){printf $i; if(i<NF){printf " "}}'} | tr -d '\r')
        PRICE=$(print_price "${URL}")
        FINAL_URL=$(echo ${URL} | awk -F "?" {'print $1'})
        ##echo "========================================================================"
        ##echo "TRADEMARK_MODEL=${TRADEMARK_MODEL}"
        ##echo "TRADEMARK=${TRADEMARK}"
        ##echo "MODEL=${MODEL}"
        ##echo "URL=${FINAL_URL}"
        ##echo "PRICE=${PRICE}"
        ##echo "========================================================================"
        dump_bike "${MODEL}" "${FINAL_URL}" "${TRADEMARK}" "${PRICE}" "${STORE}" "${TYPE}"
      done
    done
  fi
}

FIX_BIKES_BASE="mtb-rigida-c-21_28.html?page="
FIX_BIKES_PAGES=$(seq 1 10)

DOUBLE_BIKES_BASE="doble-suspension-c-21_30.html?page="
DOUBLE_BIKES_PAGES=$(seq 1 10)

ROAD_BIKES_BASE="carretera-c-21_32.html?page="
ROAD_BIKES_PAGES=$(seq 1 10)

BMX_BIKES_BASE="bmx-y-freestyle-c-21_31.html"

CONFORT_BIKES_BASE="confort-c-21_107.html?page="
CONFORT_BIKES_PAGES=$(seq 1 3)

FOLDING_BIKES_BASE="plegables-c-21_133.html?page="
FOLDING_BIKES_PAGES=$(seq 1 3)

CHILDREN_BIKES_BASE="bicis-nino-c-21_98.html"

> ${OUTPUT_FILE}

######process_pages "${FIX_BIKES_BASE}" "${FIX_BIKES_PAGES}" "Bicimania" "MTB-FIX" >> ${OUTPUT_FILE}
######process_pages "${DOUBLE_BIKES_BASE}" "${DOUBLE_BIKES_PAGES}" "Bicimania" "MTB-Double" >> ${OUTPUT_FILE}
######process_pages "${ROAD_BIKES_BASE}" "${ROAD_BIKES_PAGES}" "Bicimania" "ROAD" >> ${OUTPUT_FILE}
######process_pages "${BMX_BIKES_BASE}" "" "Bicimania" "BMX" >> ${OUTPUT_FILE}
######process_pages "${CONFORT_BIKES_BASE}" "${CONFORT_BIKES_PAGES}" "Bicimania" "CONFORT" >> ${OUTPUT_FILE}
######process_pages "${FOLDING_BIKES_BASE}" "${FOLDING_BIKES_PAGES}" "Bicimania" "FOLDING" >> ${OUTPUT_FILE}
######process_pages "${CHILDREN_BIKES_BASE}" "" "Bicimania" "KIDS" >> ${OUTPUT_FILE}

process_pages2 "${FIX_BIKES_BASE}" "${FIX_BIKES_PAGES}" "Bicimania" "MTB-FIX" >> ${OUTPUT_FILE}
process_pages2 "${DOUBLE_BIKES_BASE}" "${DOUBLE_BIKES_PAGES}" "Bicimania" "MTB-Double" >> ${OUTPUT_FILE}
process_pages2 "${ROAD_BIKES_BASE}" "${ROAD_BIKES_PAGES}" "Bicimania" "ROAD"  >> ${OUTPUT_FILE}
process_pages2 "${BMX_BIKES_BASE}" "" "Bicimania" "BMX"  >> ${OUTPUT_FILE}
process_pages2 "${CONFORT_BIKES_BASE}" "${CONFORT_BIKES_PAGES}" "Bicimania" "CONFORT"  >> ${OUTPUT_FILE}
process_pages2 "${FOLDING_BIKES_BASE}" "${FOLDING_BIKES_PAGES}" "Bicimania" "FOLDING" >> ${OUTPUT_FILE}
process_pages2 "${CHILDREN_BIKES_BASE}" "" "Bicimania" "KIDS"  >> ${OUTPUT_FILE}
