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
OUTPUT_FILE=./output
#OUTPUT_FILE=/dev/stdout
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
  #if [[ "$1" != "" ]] && [[ "$2" != "" ]] && [[ "$3" != "" ]] \
  #    && [[ "$4" != "" ]] && [[ "$4" -gt 50 ]] && [[ "$5" != "" ]]  && [[ "$6" != "" ]];
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
  PRICE=$(echo "$1" | grep "${2}" | awk -F '<span class="price"' {'print $2'} | awk -F "/span>" {'print $1'} | awk -F ">" {'print $2'} | awk -F "<" {'print $1'})
  echo ${PRICE} | awk -F "€" {'print $1'} | tr -d " "
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

function process_pages()
{
  BASE_FILE="$1"
  PAGES="$2"
  STORE="$3"
  TYPE="$4"

  if [ "${PAGES}" = "" ];
  then
#    TRADEMARK_MODELS=$(cat ${BASE_FILE} | grep '<h3>' | awk -F '<h3>' {'print $2'} | awk -F '</h3>' {'print $1'} | sed -e 's/<[^>]*>//g')
    TRADEMARK_MODELS=$(cat ${BASE_FILE} | grep '<h3>' | awk -F '<h3>' {'for(i=2;i<NF;++i){printf $i"\n";}'})
    echo "${TRADEMARK_MODELS}" | while read line;
    do
      URL=$(echo ${line} | awk -F '</h3>' {'print $1'} | awk -F "<a href=" {'print $2'} | awk {'print $1'})
      TRADEMARK_MODEL=$(echo ${line} | awk -F '</h3>' {'print $1'} | sed -e 's/<[^>]*>//g' )
      TRADEMARK=$(echo ${TRADEMARK_MODEL} | awk {'print $1'})
      MODEL=$(echo "${TRADEMARK_MODEL}" | awk {'for(i=2;i<=NF;++i){printf $i; if(i<NF){printf " "}}'} | tr -d '\r')
      MODEL_CAMEL=$(camel "${MODEL}" ${NO_CAMEL_MIN})
      TRADEMARK_CAMEL=$(camel "${TRADEMARK}" ${NO_CAMEL_TRADEMARK_MIN})
      PRICE=$(print_price "${line}" ${TRADEMARK_MODEL})
      #echo "============================================================"
      #echo "LINE=${line}"
      #echo "TRADEMARK_MODEL=${TRADEMARK_MODEL}"
      #echo "TRADEMARK=${TRADEMARK}"
      #echo "TRADEMARK_CAMEL=${TRADEMARK_CAMEL}"
      #echo "MODEL=${MODEL}"
      #echo "MODEL_CAMEL=${MODEL_CAMEL}"
      #echo "PRICE=${PRICE}"
      #echo "URL=${URL}"
      #echo "STORE=${STORE}"
      #echo "TYPE=${TYPE}"
      #echo "============================================================"
      dump_bike "${MODEL_CAMEL}" "${URL}" "${TRADEMARK_CAMEL}" "${PRICE}" "${STORE}" "${TYPE}"
    done
  fi
}

> ${OUTPUT_FILE}

MTB_BIKES_ORBEA_26_MTB_BASE="8-orbea-rígidas-26" 
MTB_BIKES_CUBE_26_MTB_BASE="9-cube-rígida-26" 
MTB_BIKES_MMR_26_MTB_BASE="151-mmr-rígida-26" 
MTB_BIKES_ORBEA_29_MTB_BASE="11-orbea-rígida-29er" 
MTB_BIKES_CUBE_29_MTB_BASE="14-cube-rígida-29er" 
MTB_BIKES_MMR_29_MTB_BASE="152-mmr-rígida-29er"  
MTB_BIKES_ORBEA_DOUBLE_26_MTB_BASE="18-orbea-doble-susp-26" 
MTB_BIKES_CUBE_DOUBLE_26_MTB_BASE="19-cube-doble-susp-26" 
MTB_BIKES_ORBEA_DOUBLE_29_MTB_BASE="28-orbea-doble-susp-29er" 
MTB_BIKES_CUBE_DOUBLE_29_MTB_BASE="23-cube-doble-susp-29er" 
MTB_BIKES_ORBEA_ROAD_MTB_BASE="33-orbea-carretera" 
MTB_BIKES_CUBE_ROAD_MTB_BASE="32-cube-carretera" 
MTB_BIKES_ROAD_2012="63-bicis-carretera-2012" 
MTB_BIKES_ROAD_TRIATLON="142-triatlon" 
MTB_BIKES_KIDS="34-infantiles" 
MTB_BIKES_WOMAN="122-dama"                                   

process_pages "${MTB_BIKES_ORBEA_26_MTB_BASE}" "" "Bicicletas Pasaje" "MTB" >> ${OUTPUT_FILE} 
process_pages "${MTB_BIKES_CUBE_26_MTB_BASE}" "" "Bicicletas Pasaje" "MTB" >> ${OUTPUT_FILE}  
process_pages "${MTB_BIKES_MMR_26_MTB_BASE}" "" "Bicicletas Pasaje" "MTB" >> ${OUTPUT_FILE} 
process_pages "${MTB_BIKES_ORBEA_29_MTB_BASE}" "" "Bicicletas Pasaje" "MTB-29" >> ${OUTPUT_FILE} 
process_pages "${MTB_BIKES_CUBE_29_MTB_BASE}" "" "Bicicletas Pasaje" "MTB-29" >> ${OUTPUT_FILE} 
process_pages "${MTB_BIKES_MMR_29_MTB_BASE}" "" "Bicicletas Pasaje" "MTB-29" >> ${OUTPUT_FILE} 
process_pages "${MTB_BIKES_ORBEA_DOUBLE_26_MTB_BASE}" "" "Bicicletas Pasaje" "MTB-DOUBLE" >> ${OUTPUT_FILE} 
process_pages "${MTB_BIKES_CUBE_DOUBLE_26_MTB_BASE}" "" "Bicicletas Pasaje" "MTB-DOUBLE" >> ${OUTPUT_FILE} 
process_pages "${MTB_BIKES_ORBEA_DOUBLE_29_MTB_BASE}" "" "Bicicletas Pasaje" "MTB-DOUBLE" >> ${OUTPUT_FILE} 
process_pages "${MTB_BIKES_CUBE_DOUBLE_29_MTB_BASE}" "" "Bicicletas Pasaje" "MTB-DOUBLE" >> ${OUTPUT_FILE} 
process_pages "${MTB_BIKES_ORBEA_ROAD_MTB_BASE}" "" "Bicicletas Pasaje" "ROAD" >> ${OUTPUT_FILE} 
process_pages "${MTB_BIKES_CUBE_ROAD_MTB_BASE}" "" "Bicicletas Pasaje" "ROAD" >> ${OUTPUT_FILE} 
process_pages "${MTB_BIKES_ROAD_2012}" "" "Bicicletas Pasaje"  "ROAD" >> ${OUTPUT_FILE} 
process_pages "${MTB_BIKES_ROAD_TRIATLON}" "" "Bicicletas Pasaje" "ROAD" >> ${OUTPUT_FILE} 
process_pages "${MTB_BIKES_KIDS}" "" "Bicicletas Pasaje" "KIDS" >> ${OUTPUT_FILE} 
process_pages "${MTB_BIKES_WOMAN}" "" "Bicicletas Pasaje" "MTB-WOMAN" >> ${OUTPUT_FILE}