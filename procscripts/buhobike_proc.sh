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

MTB_BIKES_BASE="rapida?op=188&_pagi_pg="
MTB_BIKES_PAGES=$(seq 1 35)

ROAD_BIKES_BASE="rapida?op=288&_pagi_pg="
ROAD_BIKES_PAGES=$(seq 1 25)

TREKKING_BIKES_BASE="rapida?op=388&_pagi_pg="
TREKKING_BIKES_PAGES=$(seq 1 15)

URBAN_BIKES_BASE="rapida?op=488&_pagi_pg="
URBAN_BIKES_PAGES=$(seq 1 15)

BMX_BIKES_BASE="rapida?op=588&_pagi_pg="
BMX_BIKES_PAGES=$(seq 1 3)

KIDS_BIKES_BASE="rapida?op=688&_pagi_pg="
KIDS_BIKES_PAGES=$(seq 1 8)

> ${OUTPUT_FILE}

process_pages "${MTB_BIKES_BASE}" "${MTB_BIKES_PAGES}" "BuhoBike" "MTB" >> ${OUTPUT_FILE}
process_pages "${ROAD_BIKES_BASE}" "${ROAD_BIKES_PAGES}" "BuhoBike" "ROAD"  >> ${OUTPUT_FILE}
process_pages "${TREKKING_BIKES_BASE}" "${TREKKING_BIKES_PAGES}" "BuhoBike" "URBAN-CONFORT-FOLDING"  >> ${OUTPUT_FILE}
process_pages "${URBAN_BIKES_BASE}" "${URBAN_BIKES_PAGES}" "BuhoBike" "URBAN-CONFORT-FOLDING"  >> ${OUTPUT_FILE}
process_pages "${BMX_BIKES_BASE}" "${BMX_BIKES_PAGES}" "BuhoBike" "BMX" >> ${OUTPUT_FILE}
process_pages "${KIDS_BIKES_BASE}" "${KIDS_BIKES_PAGES}" "BuhoBike" "KIDS"  >> ${OUTPUT_FILE}
