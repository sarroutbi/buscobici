#!/bin/sh
#
# Parse results to common file with structure:
#
# [Grow 2]
# SUBURL="http://www.bikestocks.com/producto/Orbea-Grow-2"
# TRADEMARK=Orbea
# PRICE=249,00
# STORE=BikeStocks
# KIND=MTB

MAX_PRICE=2
OUTPUT_FILE=./output
URL_BASE="http://www.bikestocks.es/b2c"

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
# 2 - The file of the bike
function print_model()
{
  URL_SEARCH=$(echo "${1}"  | tr -d '"')
  FILE_SEARCH="${2}"
  #echo "======================================"
  #echo "======> URL:${URL_SEARCH} <========="
  #echo "======> FILE:${FILE_SEARCH} <========="
  MODEL=$(grep "${URL_SEARCH}" "${FILE_SEARCH}" | head -1 | sed -e 's/<[^>]*>//g')
  echo "${MODEL}"
  #echo "======================================"
}

# Params:
# 1 - The URL of bike
# 2 - The file of the bike
function print_price()
{
  URL_SEARCH=$(echo "${1}"  | tr -d '"')
  FILE_SEARCH="${2}"
  #echo "======================================"
  #echo "======> URL:${URL_SEARCH} <========="
  #echo "======> FILE:${FILE_SEARCH} <========="
  PRICE=$(grep "${URL_SEARCH}" "${FILE_SEARCH}" | awk -F "<a class=precio>" {'print $2'} | awk -F "</a>" {'print $1'} | tr -d '.' | tr -d '\n' | awk {'print $1'})
  echo "${PRICE}"
  #echo "======================================"
}

function dump_bike_from_urls()
{
  URLS="$1"
  FILE="$2"
  #echo "URLS:=>${URLS}<="
  echo "${URLS}" | while read URL;
  do
    TRADEMARK_MODEL=$(print_model "${URL}" "${FILE}" | sed -e s/"BICICLETA "//g)
    TRADEMARK=$(echo ${TRADEMARK_MODEL} | awk {'print $1'})
    MODEL=$(echo ${TRADEMARK_MODEL} | awk {'for(i=2;i<=NF;++i){printf $i; if(i<NF){printf " "}}'} | tr -d '\r')
    PRICE=$(print_price "${URL}" "${FILE}")
    ### SOME URLs, that contain %, are not well parsed by awk. We insert an additional % char
    NOBASE_URL=$(echo ${URL} | tr -d '"' | sed s-%-%%-g)
    FINAL_URL="${URL_BASE}/${NOBASE_URL}"
    #echo "========================================================================"
    #echo "TRADEMARK_MODEL=${TRADEMARK_MODEL}"
    #echo "TRADEMARK=${TRADEMARK}"
    #echo "MODEL=${MODEL}"
    #echo "URL=${FINAL_URL}"
    #echo "PRICE=${PRICE}"
    #echo "FILE=${FILE}"
    #echo "========================================================================"
    dump_bike "${MODEL}" "${FINAL_URL}" "${TRADEMARK}" "${PRICE}" "${STORE}" "${TYPE}"
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
      #cat "${BASE_FILE}" | grep "tituloProdNombreListado"| grep -o "href=[^>]*>" | awk -F "href=" {'print $2'} | sed s/>//g
      URLS=$(cat "${BASE_FILE}" | grep "tituloProdNombreListado"| grep -o "href=[^>]*> | awk -F "href=" {'print $2'} | sed s/>//g")
      dump_bike_from_urls "${URLS}" 
  else
    for page in ${PAGES};
    do 
      URLS=$(cat "${BASE_FILE}${page}" | grep "tituloProdNombreListado"| grep -o "href=[^>]*>" | awk -F "href=" {'print $2'} | tr -d '>' | tr "'" '"')
      dump_bike_from_urls "${URLS}" "${BASE_FILE}${page}"
    done
  fi
}

MTB_2013_BIKES_BASE="index.php?page=pp_productos.php&md=1&tbusq=1&codf=499&pagact="
MTB_2013_BIKES_PAGES=$(seq 1 20)

MTB_2012_BIKES_BASE="index.php?page=pp_productos.php&md=1&tbusq=1&codf=338&pagact="
MTB_2012_BIKES_PAGES=$(seq 1 13)

ROAD_2012_BIKES_BASE="index.php?page=pp_productos.php&md=1&tbusq=1&codf=196&pagact="
ROAD_2012_BIKES_PAGES=$(seq 1 10)

ROAD_2013_BIKES_BASE="index.php?page=pp_productos.php&md=1&tbusq=1&codf=533&pagact="
ROAD_2013_BIKES_PAGES=$(seq 1 15)

TREKKING_2012_BIKES_BASE="index.php?page=pp_productos.php&md=1&tbusq=1&codf=370&pagact="
TREKKING_2012_BIKES_PAGES=$(seq 1 2)

TREKKING_2013_BIKES_BASE="index.php?page=pp_productos.php&md=1&tbusq=1&codf=476&pagact="
TREKKING_2013_BIKES_PAGES=$(seq 1 3)

URBAN_2012_BIKES_BASE="index.php?page=pp_productos.php&md=1&tbusq=1&codf=368&pagact="
URBAN_2012_BIKES_PAGES=$(seq 1 10)

URBAN_2013_BIKES_BASE="index.php?page=pp_productos.php&md=1&tbusq=1&codf=155&pagact="
URBAN_2013_BIKES_PAGES=$(seq 1 5)

FOLDING_BIKES_BASE="index.php?page=pp_productos.php&md=1&tbusq=1&codf=158&pagact="
FOLDING_BIKES_PAGES=$(seq 1 5)

ELECTRIC_BIKES_BASE="index.php?page=pp_productos.php&md=1&tbusq=1&codf=71&pagact="
ELECTRIC_BIKES_PAGES=$(seq 1 5)

BMX_2012_BIKES_BASE="index.php?page=pp_productos.php&md=1&tbusq=1&codf=281&pagact="
BMX_2012_BIKES_PAGES=$(seq 1 5)

BMX_2013_BIKES_BASE="index.php?page=pp_productos.php&md=1&tbusq=1&codf=541&pagact="
BMX_2013_BIKES_PAGES=$(seq 1 5)

JUNIOR_BIKES_BASE="index.php?page=pp_productos.php&md=1&tbusq=1&codf=352&pagact="
JUNIOR_BIKES_PAGES=$(seq 1 5)

TRIATLON_BIKES_BASE="index.php?page=pp_productos.php&md=1&tbusq=1&codf=415&pagact="
TRIATLON_BIKES_PAGES=$(seq 1 5)

MTB_DOUBLE_OUTLET_BIKES_BASE="index.php?page=pp_productos.php&tbusq=1&ref=Bicis-doble-suspension&md=1"
MTB_FIX_OUTLET_BIKES_BASE="index.php?page=pp_productos.php&tbusq=1&ref=Bicis-rigidas&md=1"

> ${OUTPUT_FILE}

process_pages "${MTB_2013_BIKES_BASE}"  "${MTB_2013_BIKES_PAGES}"  "BikeStocks" "MTB" >> ${OUTPUT_FILE}
process_pages "${MTB_2012_BIKES_BASE}"  "${MTB_2012_BIKES_PAGES}"  "BikeStocks" "MTB" >> ${OUTPUT_FILE}
process_pages "${ROAD_2012_BIKES_BASE}" "${ROAD_2012_BIKES_PAGES}" "BikeStocks" "ROAD" >> ${OUTPUT_FILE}
process_pages "${ROAD_2013_BIKES_BASE}" "${ROAD_2013_BIKES_PAGES}" "BikeStocks" "ROAD" >> ${OUTPUT_FILE}
process_pages "${TREKKING_2012_BIKES_BASE}" "${TREKKING_2012_BIKES_PAGES}" "BikeStocks" "URBAN" >> ${OUTPUT_FILE}
process_pages "${TREKKING_2013_BIKES_BASE}" "${TREKKING_2013_BIKES_PAGES}" "BikeStocks" "URBAN" >> ${OUTPUT_FILE}
process_pages "${URBAN_2012_BIKES_BASE}" "${URBAN_2012_BIKES_PAGES}" "BikeStocks" "URBAN" >> ${OUTPUT_FILE}
process_pages "${URBAN_2013_BIKES_BASE}" "${URBAN_2013_BIKES_PAGES}" "BikeStocks" "URBAN" >> ${OUTPUT_FILE}
process_pages "${FOLDING_BIKES_BASE}" "${FOLDING_BIKES_PAGES}" "BikeStocks" "URBAN" >> ${OUTPUT_FILE}
process_pages "${ELECTRIC_BIKES_BASE}" "${ELECTRIC_BIKES_PAGES}" "BikeStocks" "URBAN" >> ${OUTPUT_FILE}
process_pages "${BMX_2012_BIKES_BASE}" "${BMX_2012_BIKES_PAGES}" "BikeStocks" "BMX" >> ${OUTPUT_FILE}
process_pages "${BMX_2013_BIKES_BASE}" "${BMX_2013_BIKES_PAGES}" "BikeStocks" "BMX" >> ${OUTPUT_FILE}
process_pages "${JUNIOR_BIKES_BASE}" "${JUNIOR_BIKES_PAGES}" "BikeStocks" "KIDS" >> ${OUTPUT_FILE}
process_pages "${TRIATLON_BIKES_BASE}" "${TRIATLON_BIKES_PAGES}" "BikeStocks" "ROAD" >> ${OUTPUT_FILE}
process_pages "${MTB_DOUBLE_OUTLET_BIKES_BASE}" "${MTB_DOUBLE_OUTLET_BIKES_PAGES}" "BikeStocks" "MTB" >> ${OUTPUT_FILE}
process_pages "${MTB_FIX_OUTLET_BIKES_BASE}" "${MTB_FIX_OUTLET_BIKES_PAGES}" "BikeStocks" "MTB" >> ${OUTPUT_FILE}