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
MAX_PRICE=50
NO_CAMEL_MIN=6
NO_CAMEL_TRADEMARK_MIN=0
OUTPUT_FILE=./output
#OUTPUT_FILE=/dev/stdout

#### KEYS GENERATED
TRADEMARK_KEY="TRADEMARK"
SUBURL_KEY="SUBURL"
STORE_KEY="STORE"
PRICE_KEY="PRICE"
KIND_KEY="KIND"

#### LOAD COMMON FUNCTIONS
. ./common_proc

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

# Params
# 1 - Model:     [MODEL]
# 2 - Url:       SUBURL="www.whatever.es"
# 3 - Trademark: TRADEMARK=Trek
# 4 - Price:     PRICE=100000,99
# 5 - Store:     STORE=Mammoth
# 6 - Kind:      KIND=MTB
function dump_bike()
{
  # Line to print entries with some error:
  #if [[ "$1" = "" ]] || [[ "$2" = "" ]] || [[ "$3" = "" ]] \
  #    || [[ "$4" = "" ]]  || [[ "$5" = "" ]]  || [[ "$6" = "" ]];

  if [[ "$1" != "" ]] && [[ "$2" != "" ]] && [[ "$3" != "" ]] \
      && [[ "$4" != "" ]]  && [[ "$5" != "" ]]  && [[ "$6" != "" ]];
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
# 1 - The FILE  of bike
# 2 - The MODEL of bike
function print_price()
{
  PRICE="$(grep -A${MAX_PRICE} "$2" "$1" | grep '<span class="bem-product-price__unit--grid"' | head -1 | sed -e 's/<[^>]*>//g' | egrep -o -E "[0-9]{0,2}.{0,1}[0-9]{2,3},{1}[0-9]{2}" | tr -d '.' | sed -e 's/^[ \t]*//g')"
  echo "${PRICE}"
}

function print_url()
{
  model="$1"
  BASE_FILE="$2"
  URL=$(grep "${model}" "${BASE_FILE}" | grep '<a class="bem-product-thumb__name--grid"'| awk -F "href=" {'print $2'} | awk {'print $1'} | head -1)
  echo "${URL}" | tr -d '"'
}

function process_page_file()
{
  VALID_FILE=1
  FILE_BASE="$1"
  STORE="$2"
  TYPE="$3"
  test -f "${FILE_BASE}" || VALID_FILE=0
  if [ ${VALID_FILE} -eq 1 ];
  then
    #echo "========================================================================"
    #echo "BASE_FILE=${FILE_BASE}"
    #echo "STORE=${STORE}"
    #echo "TYPE=${TYPE}"
    #echo "========================================================================"
    MODELS="$(cat ${FILE_BASE} | grep '<a class="bem-product-thumb__name--grid"' | sed -e 's/<[^>]*>//g')"
    
    echo "${MODELS}" | tr -d '\r' | while read model;
    do
      TRADEMARK_MODEL="$(echo ${model} | tr -d '\r' | tr -d '\n')"
      TRADEMARK_MODEL_CLEAN=$(bubic_clean "${TRADEMARK_MODEL}")
      TRADEMARK="$(echo "${TRADEMARK_MODEL_CLEAN}" | awk {'print $1'} | tr -d '\n' | tr -d '\r')"
      MODEL_CLEAN=$(echo "${TRADEMARK_MODEL_CLEAN}" | awk {'for(i=2;i<=NF;i++){printf $i; if(i<NF){printf " "}}'} | sed -e 's/^- //g')
      if [ "${TRADEMARK}" = "De" ];
      then
	TRADEMARK="De Rosa"
        MODEL_CLEAN=$(echo "${TRADEMARK_MODEL_CLEAN}" | awk {'for(i=3;i<=NF;i++){printf $i; if(i<NF){printf " "}}'} | sed -e 's/^- //g')
      fi
      MODEL_NO_TRADEMARK="$(echo ${MODEL_CLEAN} | sed -e "s/${TRADEMARK}//g" | sed -e 's/^ - //g' )"
      MODEL_CAMEL=$(camel "${MODEL_NO_TRADEMARK}" "${NO_CAMEL_MIN}")
      TRADEMARK_CAMEL=$(camel "${TRADEMARK}" "${NO_CAMEL_MIN}")
      URL=$(print_url "${model}" "${FILE_BASE}")
      PRICE=$(print_price "${FILE_BASE}" "${URL}" | tr -d '\n')
      #echo "========================================================================"
      #echo "model=>${model}<="
      #echo "TRADEMARK_MODEL=>${TRADEMARK_MODEL}<="
      #echo "TRADEMARK_MODEL_CLEAN=>${TRADEMARK_MODEL_CLEAN}<="
      #echo "TRADEMARK=>${TRADEMARK}<="
      #echo "MODEL_NO_TRADEMARK=>${MODEL_NO_TRADEMARK}<="
      #echo "TRADEMARK_CAMEL=>${TRADEMARK_CAMEL}<="
      #echo "MODEL_CAMEL=>${MODEL_CAMEL}<="
      #echo "URL=>${URL}<="
      #echo "STORE=>${STORE}<="
      #echo "TYPE=>${TYPE}<="
      #echo "PRICE=>${PRICE}<="
      #echo "========================================================================"
      bubic_dump_bike "${MODEL_CAMEL}" "${URL}" "${TRADEMARK_CAMEL}" "${PRICE}" "${STORE}" "${TYPE}"
    done
  fi
}

function process_pages()
{
  BASE_FILE="$1"
  PAGES="$2"
  STORE="$3"
  TYPE="$4"
  #echo "========================================================================"
  #echo "BASE_FILE=${BASE_FILE}"
  #echo "PAGES=>${PAGES}<="
  #echo "STORE=${STORE}"
  #echo "TYPE=${TYPE}"
  #echo "========================================================================"

  if [ "${PAGES}" = "" ];
  then
    process_page_file "${BASE_FILE}" "${STORE}" "${TYPE}"
  else
    echo "${PAGES}" | while read page;
    do
      process_page_file "${BASE_FILE}?p=${page}" "${STORE}" "${TYPE}"
    done 
  fi
}

RACETRACK_BIKES_BASE="racetrack.html"
RACETRACK_BIKES_PAGES=

FIXIE_BIKES_BASE="fixies.html"
FIXIE_BIKES_PAGES="$(seq 1 2)"

BMX_BIKES_BASE="bmx.html"
BMX_BIKES_PAGES="$(seq 1 5)"

ROAD_BIKES_BASE="road.html"
ROAD_BIKES_PAGES="$(seq 1 10)"

CICLOCROSS_BIKES_BASE="ciclocross.html"
CICLOCROSS_BIKES_PAGES="$(seq 1 3)"

KIDS_BIKES_BASE="bicis-para-ninos.html"
KIDS_BIKES_PAGES="$(seq 1 2)"

MTB_BIKES_BASE="mtb.html"
MTB_BIKES_PAGES="$(seq 1 5)"

MTB_DOUBLE_BIKES_BASE="mtb-double.html"
MTB_DOUBLE_BIKES_PAGES="$(seq 1 5)"

URBAN_BIKES_BASE="urban.html"
URBAN_BIKES_PAGES="$(seq 1 5)"

> ${OUTPUT_FILE}

process_pages "${RACETRACK_BIKES_BASE}" "${RACETRACK_BIKES_PAGES}"   "Wiggle" "ROAD-RACETRACK" >> ${OUTPUT_FILE}
process_pages "${FIXIE_BIKES_BASE}" "${FIXIE_BIKES_PAGES}"           "Wiggle" "URBAN" >> ${OUTPUT_FILE}
process_pages "${BMX_BIKES_BASE}"   "${BMX_BIKES_PAGES}"             "Wiggle" "BMX"   >> ${OUTPUT_FILE}
process_pages "${ROAD_BIKES_BASE}"  "${ROAD_BIKES_PAGES}"            "Wiggle" "ROAD"  >> ${OUTPUT_FILE}
process_pages "${CICLOCROSS_BIKES_BASE}" "${CICLOCROSS_BIKES_PAGES}" "Wiggle" "URBAN"  >> ${OUTPUT_FILE}
process_pages "${MTB_BIKES_BASE}" "${MTB_BIKES_PAGES}"               "Wiggle" "MTB" >> ${OUTPUT_FILE}
process_pages "${MTB_DOUBLE_BIKES_BASE}" "${MTB_DOUBLE_BIKES_PAGES}" "Wiggle" "MTB-DOUBLE" >> ${OUTPUT_FILE}
process_pages "${KIDS_BIKES_BASE}" "${KIDS_BIKES_PAGES}"             "Wiggle" "KIDS"  >> ${OUTPUT_FILE}
process_pages "${URBAN_BIKES_BASE}" "${URBAN_BIKES_PAGES}"           "Wiggle" "URBAN"  >> ${OUTPUT_FILE}
