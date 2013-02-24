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
BASE_URL="http://www.csbike.es"
NO_CAMEL_MIN=6
NO_CAMEL_TRADEMARK_MIN=0
MODEL_DOWN_SEARCH=10
MAX_PRICE_SEARCH=20
MAX_PRICE_SEARCH2=25
URL_BASE="http://www.csbike.es"
ONLY_DOMAIN="csbike.es"

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
    MODEL_CLEAN=$(echo "${MODEL}" | sed -e 's/[Bb]ici [Ff]reeride//g' |sed -e 's/Bici KTM [Bb][Mm][Xx]/KTM/g' | sed -e 's/Bici ni*os//g' | sed -e 's/[Bb]ici [Nn]ios//g' |sed -e 's/[Bb]ici [Dd][Hh]//g' | sed -e 's/[Bb]ici [Nn]i?os//g' | sed -e 's/[Bb]ici de [Tt]riathlon//g' | sed -e 's/[Bb]ici [Bb][Mm][Xx]//g' | sed -e 's/[Bb]ici [Mm]tb//g' | sed -e 's/[Bb]ici [Nn]i.os//g' | sed -e 's/[Bb]ici electrica//g' | sed -e 's/[Bb]ici de [Cc]iclismo//g'  | sed -e 's/[Bb]ici de [Cc]iudad//g' | sed -e 's/[Bb]icicleta de [Tt]riathlon//g' | sed -e 's/[Bb]icicleta de [Cc]iudad//g' | sed -e 's/Bici sin pedales//g' | sed -e 's/[Bb]icicleta de [Mm]onta.a//g' | sed -e 's/[Bb]icicleta [Oo]utdoor//g' | sed -e 's/[Bb]icicleta [Tt]rekking//g' | sed -e 's/[Bb]icicleta BMX//g' | sed -e 's/[Bb]icicleta de [Pp]aseo//g' | sed -e 's/[Bb]icicleta [Uu]rbana [Ee]l.ctrica//g'   | sed -e 's/[Bb]icicleta [Uu]rbana [Pp]legable//g'  | sed -e 's/[Bb]icicleta [Uu]rbana//g' | sed -e 's/[Cc]uadro de [Cc]arretera//g' | sed -e 's/[Bb]icicleta de [Cc]arretera//g' | sed -e 's/[Bb]icicleta [Uu]rbana [Pp]legable//g' | sed -e 's/[Bb]icicleta [Ee]l.ctrica//g' | sed -e 's/[Bb]icicleta//g' | sed -e 's/[Tt]riciclo//g' | sed -e 's/[Cc]uadro//g' | sed -e 's/[Pp]atinete//g' | sed -e 's/Bici KTM ni.os//g')
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

function dump_bike_from_file()
{
  FILE="$1"
  STORE="$2"
  TYPE="$3"
  TRADEMARK_MODELS=$(cat "${FILE}" | grep 'class="nombre"' | awk -F "<br" {'print $1'} | sed -e 's/<[^>]*>//g' | sed -e 's/+ [0-9][0-9]€//g' | sed -e 's/+ [0-9][0-9][0-9]€//g' | sed -e 's/+\.\.\.//g')
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
    URL=$(grep "${trademark_model}" "${FILE}" | grep 'class="nombre"' | awk -F "<a href=" {'print $2'} | awk {'print $1'} | tr -d '"' | head -1)
    FINAL_URL=$(echo "\"${URL_BASE}${URL}\"")
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

BH_BIKES_BASE="bh_bikes_"
BH_BIKES_PAGES="$(seq 1 6)"

CUBE_BIKES_BASE="cube_bikes_"
CUBE_BIKES_PAGES="$(seq 1 3)"

GT_BIKES_BASE="gt_bikes_"
GT_BIKES_PAGES="$(seq 1 4)"

STEVENS_BIKES_BASE="stevens_bikes_"
STEVENS_BIKES_PAGES="$(seq 1 4)"

OTHER_BIKES_BASE="other_bikes_" 
OTHER_BIKES_PAGES="$(seq 1 2)"

process_pages "${BH_BIKES_BASE}"      "${BH_BIKES_PAGES}"       "CSBike" "MTB" >> ${OUTPUT_FILE}
process_pages "${CUBE_BIKES_BASE}"    "${CUBE_BIKES_PAGES}"     "CSBike" "MTB" >> ${OUTPUT_FILE}
process_pages "${GT_BIKES_BASE}"      "${GT_BIKES_PAGES}"       "CSBike" "MTB" >> ${OUTPUT_FILE}
process_pages "${STEVENS_BIKES_BASE}" "${STEVENS_BIKES_PAGES}"  "CSBike" "MTB" >> ${OUTPUT_FILE}
process_pages "${OTHER_BIKES_BASE}"   "${OTHER_BIKES_PAGES}"    "CSBike" "MTB" >> ${OUTPUT_FILE}