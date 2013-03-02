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

MAX_PRICE=2
#OUTPUT_FILE=/dev/stdout
OUTPUT_FILE=./output
URL_BASE="http://www.labicitienda.com"
NO_CAMEL_MIN=6
NO_CAMEL_TRADEMARK_MIN=0
MODEL_DOWN_SEARCH=10
MAX_PRICE_SEARCH=20
MAX_PRICE_SEARCH2=25
ONLY_DOMAIN="labicitienda.com"
MAX_TRIES=10
MAX_TIMEOUT=10
COOKIE_FILE=labicitiendacookies.txt

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
  if [[ "$1" != "" ]] && [[ "$2" != "" ]] && [[ "$3" != "" ]] \
      && [[ "$4" != "" ]]  && [[ "$5" != "" ]]  && [[ "$6" != "" ]];
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
  PRICE2=$(grep "${MODEL}" "${FILE}" | grep 'class="nombre"' | awk -F "<br />" {'print $2'} | awk -F "</a>" {'print $1'})
  PRICE=$(grep "${MODEL}" "${FILE}" | grep 'class="nombre"' | awk -F '<span class="descuento">' {'print $1'} | egrep -o -E "[0-9]{1,},{0,1}[0-9]{1,3}.[0-9]{0,}" | tail -1)
  PRICE_NO_SPACE=$(echo ${PRICE} | tr -d ',' | tr '.' ',' | tr -d "\n" | tr -d '\n')
  #echo "================"
  #echo "FILE:${FILE}"
  #echo "MODEL:${MODEL}"
  #echo "PRICE2:${PRICE2}"
  #echo "PRICE:${PRICE}"
  #echo "================"

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

function clean_model()
{
    MODEL="${1}"
    MODEL_CLEAN=$(echo "${MODEL}" | sed -e 's/BICICLETA INFANTIL//g' | sed -e 's/CARRETERA//g' | sed -e 's/MOUNTAIN BIKE//g' | sed -e 's/MONTAIN BIKE//g' | sed -e 's/[Bb]ici [Ff]reeride//g' |sed -e 's/Bici KTM [Bb][Mm][Xx]/KTM/g' | sed -e 's/Bici ni*os//g' | sed -e 's/[Bb]ici [Nn]ios//g' |sed -e 's/[Bb]ici [Dd][Hh]//g' | sed -e 's/[Bb]ici [Nn]i?os//g' | sed -e 's/[Bb]ici de [Tt]riathlon//g' | sed -e 's/[Bb]ici [Bb][Mm][Xx]//g' | sed -e 's/[Bb]ici [Mm]tb//g' | sed -e 's/[Bb]ici [Nn]i.os//g' | sed -e 's/[Bb]ici electrica//g' | sed -e 's/[Bb]ici de [Cc]iclismo//g'  | sed -e 's/[Bb]ici de [Cc]iudad//g' | sed -e 's/[Bb]icicleta de [Tt]riathlon//g' | sed -e 's/[Bb]icicleta de [Cc]iudad//g' | sed -e 's/Bici sin pedales//g' | sed -e 's/[Bb]icicleta de [Mm]onta.a//g' | sed -e 's/[Bb]icicleta [Oo]utdoor//g' | sed -e 's/[Bb]icicleta [Tt]rekking//g' | sed -e 's/[Bb]icicleta BMX//g' | sed -e 's/[Bb]icicleta de [Pp]aseo//g' | sed -e 's/[Bb]icicleta [Uu]rbana [Ee]l.ctrica//g'   | sed -e 's/[Bb]icicleta [Uu]rbana [Pp]legable//g'  | sed -e 's/[Bb]icicleta [Uu]rbana//g' | sed -e 's/[Cc]uadro de [Cc]arretera//g' | sed -e 's/[Bb]icicleta de [Cc]arretera//g' | sed -e 's/[Bb]icicleta [Uu]rbana [Pp]legable//g' | sed -e 's/[Bb]icicleta [Ee]l.ctrica//g' | sed -e 's/[Bb]icicleta//g' | sed -e 's/[Tt]riciclo [Ii]nfantil//g' | sed -e 's/[Tt]riciclo//g' | sed -e 's/[Cc]uadro//g' | sed -e 's/[Pp]atinete//g' | sed -e 's/Bici KTM ni.os//g' | sed -e 's/BICICLETA//g' | sed -e 's/INFANTIL//g' | sed -e 's/BICYCLES//g' | sed -e 's/PLEGABLE//g' | sed -e 's/JUNIOR//g' | sed -e 's/PASEO//g' | sed -e 's/PSEO//g' | sed -e 's/URBANA//g')

    echo "${MODEL_CLEAN}" | grep ^"Bici ni" 2>&1 >/dev/null
    if [ $? -eq 0 ];
    then
      echo "${MODEL_CLEAN}" | awk {'for(i=3;i<=NF;++i){printf $i; if(i<NF){printf " "}}'}
    else
      echo "${MODEL_CLEAN}" | grep ^"Bici KTM ni" 2>&1 >/dev/null
      if [ $? -eq 0 ];
      then
        echo "${MODEL_CLEAN}" | awk {'for(i=4;i<=NF;++i){printf $i; if(i<NF){printf " "}}'}
      else
        echo "${MODEL_CLEAN}"
      fi
    fi
}

function dump_info_from_url()
{
    URL=$(echo $1 | tr -d '"')
    PRICE=$(wget -o /dev/null -O - "$URL" | grep "pageHeading" | egrep -o -E "[0-9]{1,},{0,1}[0-9]{1,3}.[0-9]{0,}" | tr -d ',')
    TRADEMARK_MODEL=$(wget -o /dev/null --load-cookies=${COOKIE_FILE} --tries=${MAX_TRIES} --timeout=${MAX_TIMEOUT} "$URL" -O -| grep "pageHeading" | grep BICICLETA | sed -e 's/<[^>]*>//g' | sed -e 's/[ \t]$//g')
    TRADEMARK_MODEL_CLEAN=$(clean_model "${TRADEMARK_MODEL}")
    TRADEMARK=$(echo "${TRADEMARK_MODEL_CLEAN}" | awk {'print $1'})
    MODEL=$(echo "${TRADEMARK_MODEL_CLEAN}" | awk {'for(i=2;i<=NF;++i){printf $i; if(i<NF){printf " "}}'})
    TRADEMARK_CAMEL=$(camel "${TRADEMARK}" "${NO_CAMEL_TRADEMARK_MIN}")
    MODEL_CAMEL=$(camel "${MODEL}" "${NO_CAMEL_MIN}")
    FINAL_URL=$(echo \"$URL\")
    #echo "========================================================================"
    #echo "TRADEMARK_MODEL=${TRADEMARK_MODEL}"
    #echo "TRADEMARK_MODEL_CLEAN=${TRADEMARK_MODEL_CLEAN}"
    #echo "TRADEMARK_CAMEL=${TRADEMARK_CAMEL}"
    #echo "MODEL=${MODEL_CAMEL}"
    #echo "URL=${FINAL_URL}"
    #echo "PRICE=${PRICE}"
    #echo "STORE=${STORE}"
    #echo "TYPE=${TYPE}"
    #echo "FILE=${FILE}"
    #echo "========================================================================"
    dump_bike "${MODEL_CAMEL}" "${FINAL_URL}" "${TRADEMARK_CAMEL}" "${PRICE}" "${STORE}" "${TYPE}"
}

function dump_bike_from_file()
{
  FILE="$1"
  STORE="$2"
  TYPE="$3"
  URLS=$(cat "${FILE}" | grep 'class="productListing-data"' | grep -v "buy_now" | awk -F "<a href=" {'print $2'} | awk -F '&osCsid=' {'print $1'} | sort | uniq)
  echo "${URLS}" | while read url;
  do 
    dump_info_from_url "${url}"
  done
}

function process_pages()
{
  BASE_FILE="$1"
  PAGES="$2"
  STORE="$3"
  TYPE="$4"

  if [ "${PAGES}" = "" ];
  then
    dump_bike_from_file "${BASE_FILE}" "${STORE}" "${TYPE}"
  else
    for page in ${PAGES};
    do 
      dump_bike_from_file "${BASE_FILE}${page}" "${STORE}" "${TYPE}"
    done
  fi
}

> ${OUTPUT_FILE}

MTB_BIKES_BASE="index.php?cPath=30_112&sort=2a&page="
MTB_BIKES_PAGES="$(seq 1 10)"

MTB_WOMAN_BIKES_BASE="index.php?cPath=30_145"
MTB_WOMAN_BIKES_PAGES=""

MTB_DOUBLE_BIKES_BASE="index.php?cPath=30_252&page="
MTB_DOUBLE_BIKES_PAGES="$(seq 1 5)"

MTB_DOUBLE_WOMAN_BIKES_BASE="index.php?cPath=30_291"
MTB_DOUBLE_WOMAN_BIKES_PAGES=""

ROAD_BIKES_BASE="index.php?cPath=30_113&sort=2a&page="
ROAD_BIKES_PAGES="$(seq 1 5)"

ROAD_TRIATLON_BIKES_BASE="index.php?cPath=30_139"
ROAD_TRIATLON_BIKES_PAGES=""

DIRT_BIKES_BASE="product_info.php?cPath=30_287&products_id=1761"
DIRT_BIKES_PAGES=""

BMX_FREE_BIKES_BASE="index.php?cPath=30_254"
BMX_FREE_BIKES_PAGES=""

URBAN_HYBRID_BIKES_BASE="index.php?cPath=30_293"
URBAN_HYBRID_BIKES_PAGES=""

KIDS_BIKES_BASE="index.php?cPath=30_115&sort=2a&page="
KIDS_BIKES_PAGES="$(seq 1 3)"

KIDS_JUNIOR_BIKES_BASE="index.php?cPath=30_117"
KIDS_JUNIOR_BIKES_PAGES=""

URBAN_FOLDING_BIKES_BASE="index.php?cPath=30_118"
URBAN_FOLDING_BIKES_PAGES=""

URBAN_BIKES_BASE="index.php?cPath=30_114&sort=2a&page="
URBAN_BIKES_PAGES="$(seq 1 3)"

URBAN_WOMAN_BIKES_BASE="index.php?cPath=30_253"
URBAN_WOMAN_BIKES_PAGES=""

process_pages "${MTB_BIKES_BASE}"              "${MTB_BIKES_PAGES}"              "LaBiciTienda" "MTB" >> ${OUTPUT_FILE}
process_pages "${MTB_WOMAN_BIKES_BASE}"        "${MTB_WOMAN_BIKES_PAGES}"        "LaBiciTienda" "MTB-WOMAN" >> ${OUTPUT_FILE}
process_pages "${MTB_DOUBLE_BIKES_BASE}"       "${MTB_DOUBLE_BIKES_PAGES}"       "LaBiciTienda" "MTB-DOUBLE" >> ${OUTPUT_FILE}
process_pages "${MTB_DOUBLE_WOMAN_BIKES_BASE}" "${MTB_DOUBLE_WOMAN_BIKES_PAGES}" "LaBiciTienda" "MTB-WOMAN" >> ${OUTPUT_FILE}
process_pages "${ROAD_BIKES_BASE}"             "${ROAD_BIKES_PAGES}"             "LaBiciTienda" "ROAD" >> ${OUTPUT_FILE}
process_pages "${ROAD_TRIATHLON_BIKES_BASE}"   "${ROAD_TRIATHLON_BIKES_PAGES}"   "LaBiciTienda" "ROAD" >> ${OUTPUT_FILE}
process_pages "${DIRT_BIKES_BASE}"             "${DIRT_BIKES_PAGES}"             "LaBiciTienda" "BMX" >> ${OUTPUT_FILE}
process_pages "${BMX_FREE_BIKES_BASE}"         "${BMX_FREE_BIKES_PAGES}"         "LaBiciTienda" "BMX" >> ${OUTPUT_FILE}
process_pages "${URBAN_HYBRID_BIKES_BASE}"     "${URBAN_HYBRID_BIKES_PAGES}"     "LaBiciTienda" "URBAN" >> ${OUTPUT_FILE}
process_pages "${KIDS_BIKES_BASE}"             "${KIDS_BIKES_PAGES}"             "LaBiciTienda" "KIDS" >> ${OUTPUT_FILE}
process_pages "${KIDS_JUNIOR_BIKES_BASE}"      "${KIDS_JUNIOR_BIKES_PAGES}"      "LaBiciTienda" "KIDS" >> ${OUTPUT_FILE}
process_pages "${URBAN_FOLDING_BIKES_BASE}"    "${URBAN_FOLDING_BIKES_PAGES}"    "LaBiciTienda" "URBAN" >> ${OUTPUT_FILE}
process_pages "${URBAN_BIKES_BASE}"            "${URBAN_BIKES_PAGES}"            "LaBiciTienda" "URBAN" >> ${OUTPUT_FILE}
