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
  echo "[$1]"
  echo "${SUBURL_KEY}=$2"
  echo "${TRADEMARK_KEY}=$3"
  echo "${PRICE_KEY}=$4"
  echo "${STORE_KEY}=$5"
  echo "${KIND_KEY}=$6"
  echo 
}

function process_pages()
{
  BASE_URL="$1"
  PAGES="$2"
  TYPE="$3"
  if [ "${PAGES}" = "" ];
  then
    MODELS=$(cat "${BASE_URL}" | grep href | grep "productListing-data" | awk -F "<b>" {'print $2'} | awk -F "</b>" {'print $1'})

    for model in "${MODELS}";
    do
      MODEL=$(echo "${model}" | awk {'for(i=2;i<=NF;++i){printf $i; if(i<NF){printf " "}}'} | tr -d '\r')
      TRADEMARK=$(echo "${model}" | awk {'print $1'})
      dump_bike "${MODEL}" "" "${TRADEMARK}"
    done
  else
    for page in ${PAGES};
    do
      MODELS=$(cat "${BASE_URL}${page}" | grep href | grep "productListing-data" | awk -F "<b>" {'print $2'} | awk -F "</b>" {'print $1'})
      echo "${MODELS}" | while read model
      do
        MODEL=$(echo "${model}" | awk {'for(i=2;i<=NF;++i){printf $i; if(i<NF){printf " "}}'} | tr -d '\r')
        TRADEMARK=$(echo "${model}" | awk {'print $1'})
        dump_bike "${MODEL}" "" "${TRADEMARK}"
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

process_pages "${FIX_BIKES_BASE}" "${FIX_BIKES_PAGES}"
process_pages "${DOUBLE_BIKES_BASE}" "${DOUBLE_BIKES_PAGES}"
process_pages "${ROAD_BIKES_BASE}" "${ROAD_BIKES_PAGES}"
process_pages "${BMX_BIKES_BASE}" ""
process_pages "${CONFORT_BIKES_BASE}" "${CONFORT_BIKES_PAGES}"
process_pages "${FOLDING_BIKES_BASE}" "${FOLDING_BIKES_PAGES}"
process_pages "${CHILDREN_BIKES_BASE}" ""
