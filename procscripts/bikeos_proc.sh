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

MAX_PRICE=2
OUTPUT_FILE=./output
BASE_URL="http://www.bikeos.com"
NO_CAMEL_MIN=6
NO_CAMEL_TRADEMARK_MIN=0
MAX_PRICE_SEARCH=35
URL="www.bikeos.com"
ONLY_DOMAIN="bikeos.com"
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

function dump_bike_from_urls()
{
  URLS="$1"
  FILE="$2"
  #echo "URLS:=>${URLS}<="
  echo "${URLS}" | while read URL;
  do
    TRADEMARK_MODEL=$(print_model "${URL}" "${FILE}" | sed -e s/"+ Vale regalo [0-9]*"//g | sed -e s/"+ vale regalo [0-9]*"//g | sed -e s/"+Vale regalo [0-9]*"//g | sed -e 's/^[ \t]*//g' | sed -e 's/[ \t]*$//g')
    TRADEMARK=$(echo ${TRADEMARK_MODEL} | awk {'print $1'})
    TRADEMARK_CAMEL=$(camel "${TRADEMARK}" 0)
#    MODEL=$(echo ${TRADEMARK_MODEL} | awk {'for(i=2;i<=NF;++i){printf $i; if(i<NF){printf " "}}'} | tr -d '\r' | sed -e 's/[ \t]*$//g' | sed 's/[^0-9,A-Z,a-z,-,\,\.,\(,\)]*$//g')
    ### echo "MODEL=echo \"${TRADEMARK_MODEL}\" | sed -e 's/${TRADEMARK}//g' | tr -d '\r' | sed -e 's/[ \t]*$//g' | sed 's/[^0-9,A-Z,a-z,-,\,\.,\(,\)]*$//g'"
    MODEL=$(echo "${TRADEMARK_MODEL}" | tr -d '\r' | sed -e 's/[ \t]*$//g' | sed 's/[^0-9,A-Z,a-z,-,\,\.,\(,\)]*$//g')
    MODEL_NO_TRADE=$(echo "${MODEL}" | awk -F "${TRADEMARK}" {'print $2'} | sed -e 's/^[ \t]*//g' | sed -e 's/[ \t]*$//g' | sed 's/[^0-9,A-Z,a-z,-,\,\.,\(,\)]*$//g')
    MODEL_CAMEL=$(camel "${MODEL_NO_TRADE}" ${NO_CAMEL_MIN})
    PRICE=$(print_price "${FILE}" "${MODEL}")
    NOBASE_URL=$(echo ${URL} | awk -F "a href=" {'print $2'} | awk {'print $1'})
    FINAL_URL="${NOBASE_URL}"
    #echo "========================================================================"
    #echo "TRADEMARK_MODEL=>${TRADEMARK_MODEL}<="
    #echo "TRADEMARK=${TRADEMARK}"
    #echo "MODEL=>${MODEL_NO_TRADE}<="
    #echo "URL=${FINAL_URL}"
    #echo "PRICE=${PRICE}"
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
  #echo "BASE_FILE=$1"
  #echo "PAGES=$2"
  #echo "STORE=$3"
  #echo "TYPE=$4"

  if [ "${PAGES}" = "" ];
  then
    URLS=$(cat "${BASE_FILE}" | grep h2)
    dump_bike_from_urls "${URLS}" 
  else
    for page in ${PAGES};
    do 
      URLS=$(cat "${BASE_FILE}${page}" | grep h2)
      dump_bike_from_urls "${URLS}" "${BASE_FILE}${page}"
    done
  fi
}

> ${OUTPUT_FILE}

ROAD_BIKES_BASE="carretera.html?p="
ROAD_BIKES_PAGES="$(seq 1 20)"

MTB_BIKES_BASE="mountain-bike.html?p="
MTB_BIKES_PAGES="$(seq 1 35)"

BMX_BIKES_BASE="bmx-trial-freeride.html?p="
BMX_BIKES_PAGES="$(seq 1 10)"

TREKKING_OUTLET_BIKES_BASE="trekking-liquidacion.html?p="
TREKKING_OUTLET_BIKES_PAGES="$(seq 1 5)"

TREKKING_2012_BIKES_BASE="trekking-2012.html?p="
TREKKING_2012_BIKES_PAGES="$(seq 1 5)"

TREKKING_2013_BIKES_BASE="trekking-2013.html?p="
TREKKING_2013_BIKES_PAGES="$(seq 1 10)"

FOLDING_BIKES_BASE="plegables.html?p="
FOLDING_BIKES_PAGES="$(seq 1 5)"

ELECTRIC_BIKES_BASE="electricas.html?p="
ELECTRIC_BIKES_PAGES="$(seq 1 20)"

KIDS_BIKES_BASE="infantil.html?p="
KIDS_BIKES_PAGES="$(seq 1 10)"

process_pages "${MTB_BIKES_BASE}"  "${MTB_BIKES_PAGES}"  "BikeOS" "MTB" >> ${OUTPUT_FILE}
process_pages "${ROAD_BIKES_BASE}" "${ROAD_BIKES_PAGES}" "BikeOS" "ROAD" >> ${OUTPUT_FILE}
process_pages "${BMX_BIKES_BASE}"  "${BMX_BIKES_PAGES}"  "BikeOS" "BMX" >> ${OUTPUT_FILE}
process_pages "${TREKKING_OUTLET_BIKES_BASE}" "${TREKKING_OUTLET_BIKES_PAGES}" "BikeOS" "URBAN" >> ${OUTPUT_FILE}
process_pages "${TREKKING_2012_BIKES_BASE}" "${TREKKING_2012_BIKES_PAGES}" "BikeOS" "URBAN" >> ${OUTPUT_FILE}
process_pages "${TREKKING_2013_BIKES_BASE}" "${TREKKING_2013_BIKES_PAGES}" "BikeOS" "URBAN" >> ${OUTPUT_FILE}
process_pages "${FOLDING_BIKES_BASE}"  "${FOLDING_BIKES_PAGES}" "BikeOS" "URBAN" >> ${OUTPUT_FILE}
process_pages "${ELECTRIC_BIKES_BASE}" "${ELECTRIC_BIKES_PAGES}" "BikeOS" "URBAN" >> ${OUTPUT_FILE}
process_pages "${KIDS_BIKES_BASE}" "${KIDS_BIKES_PAGES}" "BikeOS" "KIDS" >> ${OUTPUT_FILE}

# process_pages "${MTB_BIKES_BASE}"  "${MTB_BIKES_PAGES}"  "BikeOS" "MTB" 
# process_pages "${ROAD_BIKES_BASE}" "${ROAD_BIKES_PAGES}" "BikeOS" "ROAD" 
# process_pages "${BMX_BIKES_BASE}"  "${BMX_BIKES_PAGES}"  "BikeOS" "BMX" 
# process_pages "${TREKKING_OUTLET_BIKES_BASE}" "${TREKKING_OUTLET_BIKES_PAGES}" "BikeOS" "URBAN" 
# process_pages "${TREKKING_2012_BIKES_BASE}" "${TREKKING_2012_BIKES_PAGES}" "BikeOS" "URBAN" 
# process_pages "${TREKKING_2013_BIKES_BASE}" "${TREKKING_2013_BIKES_PAGES}" "BikeOS" "URBAN" 
# process_pages "${FOLDING_BIKES_BASE}"  "${FOLDING_BIKES_PAGES}" "BikeOS" "URBAN" 
# process_pages "${ELECTRIC_BIKES_BASE}" "${ELECTRIC_BIKES_PAGES}" "BikeOS" "URBAN" 
# process_pages "${KIDS_BIKES_BASE}" "${KIDS_BIKES_PAGES}" "BikeOS" "KIDS" 