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
BASE_URL="http://www.bicispasaje.es"
NO_CAMEL_MIN=6
NO_CAMEL_TRADEMARK_MIN=0
MAX_PRICE_SEARCH=35
URL="www.bicispasaje.es"
ONLY_DOMAIN="bicispasaje.es"

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

function dump_bike_from_url()
{
    URL="$1"
    SUBURL="$2"
    FILE="$3"
    STORE="$4"
    TYPE="$5"
    #FINAL_URL="${URL_BASE}/${SUBURL}/${URL}"

    PRICE=$(grep ${URL} ${FILE} -B10 | grep "precio.jpg" -A2 | sed -e 's/<[^>]*>//g' | egrep -o -E "[0-9]{1,}.{0,}[0-9]{1,},{0,}[0-9]{0,}"  | tr "." "," | tail -1)
    FINAL_URL=$(echo \""${BASE_URL}"/"${SUBURL}"/"${URL}"\")
    FINAL_URL_NO_DOT=$(echo "${FINAL_URL}" | tr -d '"')
    PRICE=$(wget -O - -o /dev/null ${FINAL_URL_NO_DOT} | grep -i precioactual -B2 | sed -e 's/<[^>]*>//g' | egrep -o -E "[0-9]{1,}.{0,1}[0-9]{0,},{1}[0-9]{0,}" | tail -1 )
    TRADEMARK_MODEL=$(wget -O - -o /dev/null ${FINAL_URL_NO_DOT} | grep "${PRICE}" -B2 | grep textoproducto | head -1 | sed -e 's/<[^>]*>//g')
    TRADEMARK=$(echo ${TRADEMARK_MODEL} | awk {'print $1'})
    TRADEMARK_CAMEL=$(camel "${TRADEMARK}" ${NO_CAMEL_TRADEMARK_MIN})
    MODEL=$(echo "${TRADEMARK_MODEL}" | awk {'for(i=2;i<=NF;++i){printf $i; if(i<NF){printf " "}}'} | sed -e 's/\.$//g')
    MODEL_CAMEL=$(camel "${MODEL}" ${NO_CAMEL_MIN})
    PRICE_NO_DOT=$(echo ${PRICE} | tr -d '.')
    # echo "========================================================================"
    # echo "TRADEMARK_MODEL=${TRADEMARK_MODEL}"
    # echo "TRADEMARK=${TRADEMARK_CAMEL}"
    # echo "MODEL=${MODEL_CAMEL}"
    # echo "URL=${FINAL_URL}"
    # echo "PRICE=${PRICE_NO_DOT}"
    # echo "STORE=${STORE}"
    # echo "TYPE=${TYPE}"
    # echo "FILE=${FILE}"
    # echo "========================================================================"
    dump_bike "${MODEL_CAMEL}" "${FINAL_URL}" "${TRADEMARK_CAMEL}" "${PRICE_NO_DOT}" "${STORE}" "${TYPE}"
}

function dump_bike_from_urls()
{
  URLS="$1"
  SUBURL="$2"
  FILE="$3"
  STORE="$4"
  TYPE="$5"
  # echo "URLS:=>${URLS}<="
  echo "${URLS}" | while read URL;
  do
    dump_bike_from_url "${URL}" "${SUBURL}" "${FILE}" "${STORE}" "${TYPE}"
  done
}

function process_pages()
{
  BASE_FILE="$1"
  PAGES="$2"
  SUBURL="$3"
  STORE="$4"
  TYPE="$5"

  if [ "${PAGES}" = "" ];
  then
    URLS=$(cat "${BASE_FILE}" | grep "a href"  | grep img | grep "a href" | grep -v 'a href="\.\.' | awk -F "a href=" {'print $2'} | awk -F ">" {'print $1'} | grep -v facebook | tr -d '"')
    dump_bike_from_urls "${URLS}" "${SUBURL}" "${BASE_FILE}" "${STORE}" "${TYPE}"
  else
    for page in ${PAGES};
    do 
      URLS=$(cat "${BASE_FILE}${page}" |grep "a href"  | grep img | grep "a href" | grep -v 'a href="\.\.' | awk -F "a href=" {'print $2'} | awk -F ">" {'print $1'} | grep -v facebook | tr -d '"')
      dump_bike_from_urls "${URLS}" "${SUBURL}" "${BASE_FILE}${page}" "${STORE}" "${TYPE}"
    done
  fi
}

> ${OUTPUT_FILE}

MTB_BIKES_ORBEA_26_MTB_BASE="orbea-mtb-26.html"
MTB_BIKES_CUBE_26_MTB_BASE="cube_mtb.html"
MTB_BIKES_ORBEA_29_MTB_BASE="orbea-mtb-29.html"
MTB_BIKES_CUBE_29_MTB_BASE="cube_mtb_29_er.html"
MTB_BIKES_ORBEA_DOUBLE_26_MTB_BASE="orbea-doble-suspension-2013.html"
MTB_BIKES_CUBE_DOUBLE_26_MTB_BASE="cube-doble-suspension-26.html"
MTB_BIKES_ORBEA_DOUBLE_29_MTB_BASE="orbea-doble-suspension-29er.html"
MTB_BIKES_CUBE_DOUBLE_29_MTB_BASE="cube-doble-suspension-29er.html"
MTB_BIKES_ORBEA_ROAD_MTB_BASE="orbea-carretera.html"
MTB_BIKES_CUBE_ROAD_MTB_BASE="cube-carretera.html"
MTB_BIKES_CUBE_2012_MTB_BASE="cube-liquidacion-2012.html"
MTB_BIKES_LAPIERRE_2012_MTB_BASE="mtb-lapierre.html"
MTB_BIKES_ORBEA_2012_MTB_BASE="liquidacion-2012-orbea.html"

process_pages "${MTB_BIKES_ORBEA_26_MTB_BASE}" ""        "orbea-2013" "Bicicletas Pasaje" "MTB" >> ${OUTPUT_FILE} 
process_pages "${MTB_BIKES_CUBE_26_MTB_BASE}" ""         "cube-2013"  "Bicicletas Pasaje" "MTB" >> ${OUTPUT_FILE}
process_pages "${MTB_BIKES_ORBEA_29_MTB_BASE}" ""        "orbea-2013" "Bicicletas Pasaje" "MTB" >> ${OUTPUT_FILE}
process_pages "${MTB_BIKES_CUBE_29_MTB_BASE}" ""         "cube-2013"  "Bicicletas Pasaje" "MTB" >> ${OUTPUT_FILE}
process_pages "${MTB_BIKES_ORBEA_DOUBLE_26_MTB_BASE}" "" "orbea-2013" "Bicicletas Pasaje" "MTB" >> ${OUTPUT_FILE}
process_pages "${MTB_BIKES_CUBE_DOUBLE_26_MTB_BASE}"  "" "cube-2013"  "Bicicletas Pasaje" "MTB" >> ${OUTPUT_FILE}
process_pages "${MTB_BIKES_ORBEA_DOUBLE_29_MTB_BASE}" "" "orbea-2013" "Bicicletas Pasaje" "MTB" >> ${OUTPUT_FILE}
process_pages "${MTB_BIKES_CUBE_DOUBLE_29_MTB_BASE}" ""  "cube-2013"  "Bicicletas Pasaje" "MTB" >> ${OUTPUT_FILE}
process_pages "${MTB_BIKES_ORBEA_ROAD_MTB_BASE}" ""      "orbea-2013" "Bicicletas Pasaje" "ROAD">> ${OUTPUT_FILE}
process_pages "${MTB_BIKES_CUBE_ROAD_MTB_BASE}" ""       "cube-2013"  "Bicicletas Pasaje" "ROAD">> ${OUTPUT_FILE}
process_pages "${MTB_BIKES_CUBE_2012_MTB_BASE}" ""       "cube-2012"  "Bicicletas Pasaje" "MTB" >> ${OUTPUT_FILE}
process_pages "${MTB_BIKES_LAPIERRE_2012_MTB_BASE}" "" "lapierre-2012" "Bicicletas Pasaje" "MTB">> ${OUTPUT_FILE}
process_pages "${MTB_BIKES_ORBEA_2012_MTB_BASE}" ""      "orbea-2012" "Bicicletas Pasaje" "MTB" >> ${OUTPUT_FILE} 