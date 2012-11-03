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
BASE_URL="http://www.calmera.es"
NO_CAMEL_MIN=6
NO_CAMEL_TRADEMARK_MIN=0
MAX_PRICE_SEARCH=35
URL="www.calmera.es"
ONLY_DOMAIN="calmera.es"
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
  STORE="$3"
  TYPE="$4"
  #echo "URLS:=>${URLS}<="
  echo "${URLS}" | while read URL;
  do
    TRADEMARK_MODEL=$(grep "${URL}" "${FILE}" -B10 | grep '<p class="tituloprod">' | sed -e 's/<[^>]*>//g' | tail -1 | tr -d '\r' | sed -e 's/^[ /t]//g')
    TRADEMARK=$(echo "${TRADEMARK_MODEL}" | awk {'print $1'})
    TRADEMARK_CAMEL=$(camel "${TRADEMARK}" ${NO_CAMEL_TRADEMARK_MIN})
    MODEL=$(echo "${TRADEMARK_MODEL}" | awk {'for(i=2;i<=NF;++i){printf $i; if(i<NF){printf " "}}'})
    MODEL_CAMEL=$(camel "${MODEL}" ${NO_CAMEL_MIN})
    PRICE=$(grep ${URL} ${FILE} -B10 | grep "precio.jpg" -A2 | sed -e 's/<[^>]*>//g' | egrep -o -E "[0-9]{1,}.{0,}[0-9]{1,},{0,}[0-9]{0,}"  | tr "." "," | tail -1)
    FINAL_URL=$(echo \""${BASE_URL}"/"${URL}"\")
    #echo "========================================================================"
    #echo "TRADEMARK_MODEL=${TRADEMARK_MODEL}"
    #echo "TRADEMARK=${TRADEMARK_CAMEL}"
    #echo "MODEL=${MODEL_CAMEL}="
    #echo "URL=${FINAL_URL}"
    #echo "PRICE=${PRICE}"
    #echo "STORE=${STORE}"
    #echo "TYPE=${TYPE}"
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
    URLS=$(cat "${BASE_FILE}" | grep '<a href="producto' | awk -F '<a href=' {'print $2'} | awk -F '"' {'print $1'})
    dump_bike_from_urls "${URLS}" "${BASE_FILE}" "${STORE}" "${TYPE}"
  else
    for page in ${PAGES};
    do 
      URLS=$(cat "${BASE_FILE}${page}" | grep '<a href="producto' | awk -F '<a href="' {'print $2'} | awk -F '"' {'print $1'})
      dump_bike_from_urls "${URLS}" "${BASE_FILE}${page}" "${STORE}" "${TYPE}"
    done
  fi
}

> ${OUTPUT_FILE}

MTB_BIKES_BASE="productos2.asp?id=25&p="
MTB_BIKES_PAGES="$(seq 1 5)"

MTB_DOUBLE_BASE="productos2.asp?id=1&p="
MTB_DOUBLE_PAGES="$(seq 1 1)"

MTB_29_BIKES_BASE="productos2.asp?id=60&p="
MTB_29_BIKES_PAGES="$(seq 1 3)"

MTB_FREERIDE_BIKES_BASE="productos2.asp?id=4"

ROAD_BIKES_BASE="productos2.asp?id=5&p="
ROAD_BIKES_PAGES="$(seq 1 3)"

ROAD_CARBON_BIKES_BASE="productos2.asp?id=6&p="
ROAD_CARBON_BIKES_PAGES="$(seq 1 10)"

ROAD_TRIATLON_BIKES_BASE="productos2.asp?id=7&p="
ROAD_TRIATLON_BIKES_PAGES="$(seq 1 10)"

URBAN_BIKES_BASE="productos2.asp?id=29&p="
URBAN_BIKES_PAGES="$(seq 1 10)"

TREKKING_BIKES_BASE="productos2.asp?id=27&p="
TREKKING_BIKES_PAGES="$(seq 1 5)"

FOLDING_BIKES_BASE="productos2.asp?id=13&p="
FOLDING_BIKES_PAGES="$(seq 1 5)"

ELECTRIC_BIKES_BASE="productos2.asp?id=57&p="

KIDS00_BIKES_BASE="productos2.asp?id=17"
KIDS01_BIKES_BASE="productos2.asp?id=18"
KIDS02_BIKES_BASE="productos2.asp?id=19"
KIDS03_BIKES_BASE="productos2.asp?id=20"
KIDS04_BIKES_BASE="productos2.asp?id=21"
KIDS05_BIKES_BASE="productos2.asp?id=30"

TRICYCLE_BIKES_BASE="productos2.asp?id=15"

BMX_BIKES_BASE="productos2.asp?id=22&p="
BMX_BIKES_PAGES="$(seq 1 3)"

BMX_FREESTYLE_BIKES_BASE="productos2.asp?id=31"

BMX_TRIAL_BIKES_BASE="productos2.asp?id=32"

process_pages "${MTB_BIKES_BASE}"           "${MTB_BIKES_PAGES}"           "Calmera" "MTB"    >> ${OUTPUT_FILE}
process_pages "${MTB_DOUBLE_BASE}"          "${MTB_DOUBLE_PAGES}" "Calmera" "MTB-DOUBLE"      >> ${OUTPUT_FILE}
process_pages "${MTB_29_BIKES_BASE}"        "${MTB_29_BIKES_PAGES}"        "Calmera" "MTB-29" >> ${OUTPUT_FILE}
process_pages "${MTB_FREERIDE_BIKES_BASE}"  "${MTB_FREERIDE_BIKES_PAGES}"  "Calmera" "MTB"    >> ${OUTPUT_FILE}
process_pages "${ROAD_BIKES_BASE}"          "${ROAD_BIKES_PAGES}"          "Calmera" "ROAD"   >> ${OUTPUT_FILE}
process_pages "${ROAD_CARBON_BIKES_BASE}"   "${ROAD_CARBON_BIKES_PAGES}"   "Calmera" "ROAD"   >> ${OUTPUT_FILE}
process_pages "${ROAD_TRIATLON_BIKES_BASE}" "${ROAD_TRIATLON_BIKES_PAGES}" "Calmera" "ROAD"   >> ${OUTPUT_FILE}
process_pages "${URBAN_BIKES_BASE}"         "${URBAN_BIKES_PAGES}"         "Calmera" "URBAN"  >> ${OUTPUT_FILE}
process_pages "${TREKKING_BIKES_BASE}"      "${TREKKING_BIKES_PAGES}"      "Calmera" "URBAN"  >> ${OUTPUT_FILE}
process_pages "${FOLDING_BIKES_BASE}"       "${FOLDING_BIKES_PAGES}"       "Calmera" "URBAN"  >> ${OUTPUT_FILE}
process_pages "${ELECTRIC_BIKES_BASE}"      "${ELECTRIC_BIKES_PAGES}"      "Calmera" "URBAN"  >> ${OUTPUT_FILE}
process_pages "${KIDS00_BIKES_BASE}"        "${KIDS00_BIKES_PAGES}"        "Calmera" "KIDS"   >> ${OUTPUT_FILE}
process_pages "${KIDS01_BIKES_BASE}"        "${KIDS01_BIKES_PAGES}"        "Calmera" "KIDS"   >> ${OUTPUT_FILE}
process_pages "${KIDS02_BIKES_BASE}"        "${KIDS02_BIKES_PAGES}"        "Calmera" "KIDS"   >> ${OUTPUT_FILE}
process_pages "${KIDS03_BIKES_BASE}"        "${KIDS03_BIKES_PAGES}"        "Calmera" "KIDS"   >> ${OUTPUT_FILE}
process_pages "${KIDS04_BIKES_BASE}"        "${KIDS04_BIKES_PAGES}"        "Calmera" "KIDS"   >> ${OUTPUT_FILE}
process_pages "${KIDS05_BIKES_BASE}"        "${KIDS05_BIKES_PAGES}"        "Calmera" "KIDS"   >> ${OUTPUT_FILE}
process_pages "${TRICYCLE_BIKES_BASE}"      "${TRICYCLE_BIKES_PAGES}"      "Calmera" "KIDS"   >> ${OUTPUT_FILE}
process_pages "${BMX_BIKES_BASE}"           "${BMX_BIKES_PAGES}"           "Calmera" "BMX"    >> ${OUTPUT_FILE}
process_pages "${BMX_FREESTYLE_BIKES_BASE}" "${BMX_FREESTYLE_BIKES_PAGES}" "Calmera" "BMX"    >> ${OUTPUT_FILE}
process_pages "${BMX_TRIAL_BIKES_BASE}"     "${BMX_TRIAL_BIKES_PAGES}"     "Calmera" "BMX"    >> ${OUTPUT_FILE} 

