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
BASE_URL="http://www.mundoebikes.es"
NO_CAMEL_MIN=6
NO_CAMEL_TRADEMARK_MIN=0
MODEL_DOWN_SEARCH=10
MAX_PRICE_SEARCH=20
MAX_PRICE_SEARCH2=25
URL="www.mundoebikes.es"
ONLY_DOMAIN="mundoebikes.es"

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
  PRICE=$(grep "${MODEL}" "${FILE}" -A${MAX_PRICE_SEARCH} | grep "productPrice"| sed -e 's/<[^>]*>//g' | egrep -o -E "[0-9]{1,} {0,1}[0-9]{1,3}.{0,1}[0-9]{0,}" | head -1)
  PRICE_NO_SPACE=$(echo ${PRICE} | tr -d ' ' | tr '.' ',')
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
    echo "${MODEL}" | sed -e 's/[Tt]riciclo [Ii]nfantil//g' | sed -e 's/[Bb]icicleta [Ii]nfantil//g' | sed -e 's/[Bb]icicleta de [Tt]riathlon//g' | sed -e 's/[Bb]icicleta de [Cc]iudad//g' | sed -e 's/Bici sin pedales//g' | sed -e 's/[Bb]icicleta de [Mm]onta.a//g' | sed -e 's/[Bb]icicleta [Oo]utdoor//g' | sed -e 's/[Bb]icicleta [Tt]rekking//g' | sed -e 's/[Bb]icicleta BMX//g' | sed -e 's/[Bb]icicleta de [Pp]aseo//g' | sed -e 's/[Bb]icicleta [Uu]rbana [Ee]l.ctrica//g'   | sed -e 's/[Bb]icicleta [Uu]rbana [Pp]legable//g'  | sed -e 's/[Bb]icicleta [Uu]rbana//g' | sed -e 's/[Cc]uadro de [Cc]arretera//g' | sed -e 's/[Bb]icicleta de [Cc]arretera//g' | sed -e 's/[Bb]icicleta [Uu]rbana [Pp]legable//g' | sed -e 's/[Bb]icicleta [Ee]l.ctrica//g' | sed -e 's/[Bb]icicleta//g' | sed -e 's/[Tt]riciclo//g' | sed -e 's/[Cc]uadro//g'
}

function dump_bike_from_file()
{
  FILE="$1"
  STORE="$2"
  TYPE="$3"
  TRADEMARK_MODELS=$(cat "${FILE}" | grep "<a href" | grep "browse-product-title" | sed -e 's/<[^>]*>//g')
  echo "${TRADEMARK_MODELS}" | while read trademark_model;
  do 
    test -z "${trademark_model}" && continue;
    TRADEMARK_MODEL="${trademark_model}"
    TRADEMARK_MODEL_CLEAN=$(clean_model "${TRADEMARK_MODEL}")
    TRADEMARK=$(echo "${TRADEMARK_MODEL_CLEAN}" | awk {'print $1'})
    TRADEMARK_CAMEL=$(camel "${TRADEMARK}" ${NO_CAMEL_TRADEMARK_MIN})
    if [ "${TRADEMARK_CAMEL}" = "Solid" ];
    then
      TRADEMARK_CAMEL="Solid Bikes"
      MODEL=$(echo "${TRADEMARK_MODEL_CLEAN}" | awk {'for(i=3;i<=NF;++i){printf $i; if(i<NF){printf " "}}'} | tr -d '\r' | tr "'" '"')
    else 
      MODEL=$(echo "${TRADEMARK_MODEL_CLEAN}" | awk {'for(i=2;i<=NF;++i){printf $i; if(i<NF){printf " "}}'} | tr -d '\r' | tr "'" '"')
    fi
    MODEL_CAMEL=$(camel "${MODEL}" "${NO_CAMEL_MIN}")
    URL=$(grep "${trademark_model}" "${FILE}" | grep "<a href" | awk -F "a href=" {'print $2'} | awk {'print $1'} | head -1 | tr -d '"' | tr -d '\n' | tr -d '\r')
    FINAL_URL=$(echo "\"${BASE_URL}${URL}\"")
    PRICE=$(print_price "${FILE}" "${TRADEMARK_MODEL}")
    #echo "========================================================================"
    #echo "TRADEMARK_MODEL=${TRADEMARK_MODEL}"
    #echo "TRADEMARK_MODEL_CLEAN=${TRADEMARK_MODEL_CLEAN}"
    #echo "TRADEMARK=${TRADEMARK}"
    #echo "TRADEMARK_CAMEL=${TRADEMARK_CAMEL}"
    #echo "MODEL=${MODEL}"
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

BMX_BIKES_BASE="bicicletas-bmx-freestyle"
BMX_BIKES_PAGES=""

ROAD_BIKES_BASE="bicicletas-de-carretera?limit=20&limitstart="
ROAD_BIKES_PAGES="0 20 40"

ROAD_TRIATLON_BASE="bicicletas-triatlon-contrarreloj"
ROAD_TRIATLON_PAGES=""

URBAN_ELECTRIC_BIKES_BASE="bicicletas-electricas-deportivas?limit=20&limitstart="
URBAN_ELECTRIC_BIKES_PAGES="0 20"

URBAN_FOLDING_BIKES_BASE="${URL}/bicicletas-ciudad-paseo-urbanas-plegables?limit=20"
URBAN_FOLDING_BIKES_PAGES="0 20 40"

URBAN_EFOLDING_BIKES_BASE="bicicletas-electricas-plegables"
URBAN_EFOLDING_BIKES_PAGES=""

URBAN_EBIKES_BASE="bicicletas-electricas-urbanas?limit=20&limitstart="
URBAN_EBIKES_PAGES="0 20 40"

URBAN_FIXIE_BASE="bicicletas-fixed-and-single-speed"
URBAN_FIXIE_PAGES=""

URBAN_CRUISER_BASE="bicicletas-cruisers"
URBAN_CRUISER_PAGES=""

URBAN_TREKKING_BASE="bicicletas-trekking?limit=20&limitstart="
URBAN_TREKKING_PAGES="0 20 40"

URBAN_CITY_BASE="bicicletas-ciudad-paseo-urbanas?limit=20&limitstart="
URBAN_CITY_PAGES="0 20 40 60 80 100 120 140 160 180"

URBAN_RETRO_BASE="${URL}/bicicletas-clasicas-retro?limit=20&limitstart="
URBAN_RETRO_PAGES="0 20 40 60 80"

MTB29_BIKES_BASE="bicicletas-mtb-29r?limit=20&limitstart="
MTB29_BIKES_PAGES="0 20"

MTB_ALU_BIKES_BASE="bicicletas-mtb-aluminio?limit=20&limitstart="
MTB_ALU_BIKES_PAGES="0 20 40 60 80 100"

MTB_CAR_BIKES_BASE="bicicletas-mtb-carbono"
MTB_CAR_BIKES_PAGES=""

MTB_DOUBLE_BIKES_BASE="bicicletas-mtb-doble-susp?limit=20&limitstart="
MTB_DOUBLE_BIKES_PAGES=""

MTB_BIKES_BASE="bicicletas-mtb?limit=20&limitstart="
MTB_BIKES_PAGES="0 20 40 60 80 100 120 140 160 180"

KIDS_BIKES_BASE="bicicletas-infantiles?limit=20&limitstart="
KIDS_BIKES_PAGES="0 20 40 60 80 100 120"

KIDS_MTB_BIKES_BASE="bicicletas-mtb-junior?limit=20&limitstart="
KIDS_MTB_BIKES_PAGES="0 20 40 60"

process_pages "${BMX_BIKES_BASE}"            "${BMX_BIKES_PAGES}"            "MundoEbikes" "BMX"   >> ${OUTPUT_FILE}
process_pages "${ROAD_BIKES_BASE}"           "${ROAD_BIKES_PAGES}"           "MundoEbikes" "ROAD"  >> ${OUTPUT_FILE}
process_pages "${ROAD_TRIATLON_BASE}"        "${ROAD_TRIATLON_PAGES}"        "MundoEbikes" "ROAD"  >> ${OUTPUT_FILE}
process_pages "${URBAN_ELECTRIC_BIKES_BASE}" "${URBAN_ELECTRIC_BIKES_PAGES}" "MundoEbikes" "URBAN" >> ${OUTPUT_FILE}
process_pages "${URBAN_FOLDING_BIKES_BASE}"  "${URBAN_FOLDING_BIKES_PAGES}"  "MundoEbikes" "URBAN" >> ${OUTPUT_FILE}
process_pages "${URBAN_EFOLDING_BIKES_BASE}" "${URBAN_EFOLDING_BIKES_PAGES}" "MundoEbikes" "URBAN" >> ${OUTPUT_FILE}
process_pages "${URBAN_EBIKES_BASE}"         "${URBAN_EBIKES_PAGES}"         "MundoEbikes" "URBAN" >> ${OUTPUT_FILE}
process_pages "${URBAN_FIXIE_BASE}"          "${URBAN_FIXIE_PAGES}"          "MundoEbikes" "URBAN" >> ${OUTPUT_FILE}
process_pages "${URBAN_CRUISER_BASE}"        "${URBAN_CRUISER_PAGES}"        "MundoEbikes" "URBAN" >> ${OUTPUT_FILE}
process_pages "${URBAN_TREKKING_BASE}"       "${URBAN_TREKKING_PAGES=}"      "MundoEbikes" "URBAN" >> ${OUTPUT_FILE}
process_pages "${URBAN_CITY_BASE}"           "${URBAN_CITY_PAGES}"           "MundoEbikes" "URBAN" >> ${OUTPUT_FILE}
process_pages "${URBAN_RETRO_BASE}"          "${URBAN_RETRO_PAGES}"          "MundoEbikes" "URBAN" >> ${OUTPUT_FILE}
process_pages "${MTB29_BIKES_BASE}"          "${MTB29_BIKES_PAGES}"          "MundoEbikes" "MTB"   >> ${OUTPUT_FILE}
process_pages "${MTB_ALU_BIKES_BASE}"        "${MTB_ALU_BIKES_PAGES}"        "MundoEbikes" "MTB"   >> ${OUTPUT_FILE}
process_pages "${MTB_CAR_BIKES_BASE}"        "${MTB_CAR_BIKES_PAGES}"        "MundoEbikes" "MTB"   >> ${OUTPUT_FILE}
process_pages "${MTB_DOUBLE_BIKES_BASE}"     "${MTB_DOUBLE_BIKES_PAGES}"     "MundoEbikes" "MTB-DOUBLE" >> ${OUTPUT_FILE}
process_pages "${MTB_BIKES_BASE}"            "${MTB_BIKES_PAGES}"            "MundoEbikes" "MTB"   >> ${OUTPUT_FILE}
process_pages "${KIDS_BIKES_BASE}"           "${KIDS_BIKES_PAGES}"           "MundoEbikes" "KIDS"  >> ${OUTPUT_FILE}
process_pages "${KIDS_MTB_BIKES_BASE}"       "${KIDS_MTB_BIKES_PAGES}"       "MundoEbikes" "KIDS"  >> ${OUTPUT_FILE} 
