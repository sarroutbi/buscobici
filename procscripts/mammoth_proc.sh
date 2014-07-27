#!/bin/bash
#
# Copyright © 2012-2014 Sergio Arroutbi Braojos <sarroutbi@gmail.com>
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

MAX_PRICE=20
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

function clean()
{
    STRING="${1}"
    echo "${STRING}" | sed -e 's/Bicicleta de carretera blanca y roja //g' | sed -e 's/sin pedales para ni&#241;os //g' | sed -e 's/"Bicicleta 29&quot; de MTB"//g' | sed -e 's/"Bicicleta de MTB 29&quot;"//g' | sed -e 's/"Bicicleta de 29&quot; "//g' | sed -e 's/Bicicleta profesional//g'| sed -e 's/(edici&#243;n limitada)//g' | sed -e 's/Bicicleta de ciclocr&#243;s //g' | sed -e 's/[Bb]icicleta h&#237;brida //g' | sed -e 's/[Bb]icicleta [Pp]legable //g' | sed -e 's/[Bb]icicleta urbana para mujer //g' | sed -e 's/[Bb]each [Cc]ruiser//g' | sed -e 's/[Bb]icicleta de [Cc]arrera negra//g' | sed -e 's/[Bb]icicleta de [Cc]arreras//g' | sed -e 's/[Bb]icicleta de [Cc]arrera//g' | sed -e 's/[Bb]icicleta Dirt-HI//g' | sed -e 's/Bici sin pedales//g' | sed -e 's/[Bb]icicletas para ni.os//g' | sed -e 's/[Mm]onopat.n para ni.os//g' | sed -e 's/[Cc]arretera //g' | sed -e 's/sin cambios//g' | sed -e 's/para hombre//g' | sed -e 's/para mujer//g' | sed -e 's/para nin.os//g' | sed -e 's/[Nn]in.os//g' | sed -e 's/[Cc]iclocross //g' | sed -e 's/[Mm]onta.a //g' | sed -e 's/[Tt]rial //g' | sed -e 's/[Tt]rekking//g' | sed -e 's/[Tt]riatl.n//g' | sed -e 's/[Dd]escenso //g' | sed -e 's-dirt/freeride--g' | sed -e 's-dirt/street--g' | sed -e 's/[Dd]oble //g' | sed -e 's/[Ff]reeride //g' | sed -e 's/[Pp]aseo//g' | sed -e 's/[Pp]legable//g' | sed -e 's/[Ii]nfantil //g' | sed -e 's/[Ee]l.ctrica //g' | sed -e 's/[Mm]inibike//g' | sed -e 's/[Ss]uspensi.on //g' | sed -e 's/[Tt]riciclo //g' | sed -e 's/[Ss]tick//g' | sed -e 's/[Ss]uspensi.n //g' | sed -e 's/de //g' | sed -e 's/BTT //g' | sed -e 's/BMX //g' | sed -e 's/TRAIL //g' | sed -e 's/[Ss]ill.n //g' | sed -e 's/[Ee]l.ctrico //g' | sed -e 's/[Ss]ill.n //g' | sed -e 's/[Ss]oporte //g' | sed -e 's/[Cc]erradura + llaves//g' | sed -e 's/[Dd]isplay //g' | sed -e 's/[Bb]mx//g' | sed -e 's/[Cc]arretera//g' | sed -e 's/[Dd]irt-hi//g'| sed -e 's/[Dd]irt//g' | sed -e 's/[Dd]oble//g' | sed -e 's/[Ee]l.ctrica//g' | sed -e 's![Ff]reeride/[Dd]ownhill!!g' | sed -e 's/[Hh]olandesa//g' | sed -e 's/[M]tb//g' | sed -e 's/[Mm]onopat.n//g' | sed -e 's/[Pp]legable//g' | sed -e 's/[Tt]riatl.n//g' | sed -e 's/[Uu]rbana//g' | sed -e 's/[Vv]eh.culos//g' | sed -e 's/[Cc]arreras//g' | sed -e 's/[Dd]irt//g' | sed -e 's/[Dd]ownhill//g' | sed -e 's/[Rr]ueda//g' | sed -e 's/[Bb]icicleta//g' | sed -e 's/[Tt]riciclo//g' | sed -e 's/[Bb]icicleta//g' | sed -e 's/[Bb]icileta //g' | sed -e 's/29&quot; //g' | sed -e 's/[Bb]ici //g'
}

# Params:
# 1 - The FILE  of bike
# 2 - The MODEL of bike
function print_price()
{
  PRICE="$(grep -A15 "$2" "$1"  | grep '€' | head -1 | sed -e 's/<[^>]*>//g' | egrep -o -E " [0-9]{1,}.{0,1}[0-9]{1,3},{1,2}[0-9]{1,2}" | tr -d '.' | sed -e 's/^[ \t]*//g')"
  echo "${PRICE}"
}

function print_url()
{
  model="$1"
  BASE_FILE="$2"
  URL=$(grep "${model}" "${BASE_FILE}" | awk -F "a href=" {'print $2'} | awk {'print $1'} | awk -F ">" {'print $1'}| head -1)
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
    MODELS="$(cat ${FILE_BASE} | grep "field-content" | grep "a href" | sed -e 's/<[^>]*>//g' | grep [A-Z,a-z] | grep -vi "cesta" | grep -vi "cuadro")"
    echo "${MODELS}" | while read model;
    do
      MODEL="$(echo ${model})"
      MODEL_CLEAN=$(clean "${MODEL}")
      TRADEMARK="$(grep "${model}" ${FILE_BASE} -A5 | tail -3 | sed -e 's/<[^>]*>//g' | grep [A-Z,a-z])"
      TRADEMARK_CLEAN="$(clean "${TRADEMARK}")"
      MODEL_NO_TRADEMARK="$(echo ${MODEL_CLEAN} | sed -e "s/${TRADEMARK}//g" | sed -e 's/^ - //g' )"
      MODEL_CAMEL=$(camel "${MODEL_NO_TRADEMARK}" "${NO_CAMEL_MIN}")
      TRADEMARK_CAMEL=$(camel "${TRADEMARK_CLEAN}" "${NO_CAMEL_MIN}")
      URL=$(print_url "${MODEL}" "${FILE_BASE}")
      PRICE=$(print_price "${FILE_BASE}" "${MODEL}" | tr -d '\n')
      #echo "========================================================================"
      #echo "MODEL=>${MODEL}<="
      #echo "MODEL_CLEAN=>${MODEL_CLEAN}<="
      #echo "TRADEMARK=>${TRADEMARK}<="
      #echo "MODEL_NO_TRADEMARK=>${MODEL_NO_TRADEMARK}<="
      #echo "TRADEMARK_CAMEL=>${TRADEMARK_CAMEL}<="
      #echo "MODEL_CAMEL=>${MODEL_CAMEL}<="
      #echo "URL=>${URL}<="
      #echo "STORE=>${STORE}<="
      #echo "TYPE=>${TYPE}<="
      #echo "PRICE=>${PRICE}<="
      #echo "========================================================================"
      dump_bike "${MODEL_CAMEL}" "${URL}" "${TRADEMARK_CAMEL}" "${PRICE}" "${STORE}" "${TYPE}"
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

MTB_FIX_BIKES_BASE="mtb_fix.html"
MTB_FIX_BIKES_PAGES="$(seq 0 5)"

MTB_XC_BIKES_BASE="mtb_xc.html"
MTB_XC_BIKES_PAGES="$(seq 0 5)"

MTB_FREERIDE_BIKES_BASE="mtb_freeride.html"
MTB_FREERIDE_BIKES_PAGES="$(seq 0 3)"

MTB_DOWNHILL_BIKES_BASE="mtb_downhill.html"
MTB_DOWNHILL_BIKES_PAGES="$(seq 0 3)"

MTB_ENDURO_BIKES_BASE="mtb_enduro.html"
MTB_ENDURO_BIKES_PAGES="$(seq 0 3)"

MTB_29_BIKES_BASE="mtb_29.html"
MTB_29_BIKES_PAGES="$(seq 0 3)"

ROAD_BIKES_BASE="road.html"
ROAD_BIKES_PAGES="$(seq 0 5)"

URBAN_BIKES_BASE="urban.html"
URBAN_BIKES_PAGES="$(seq 0 5)"

BMX_BIKES_BASE="bmx.html"
BMX_BIKES_PAGES="$(seq 0 1)"

CICLOCROSS_BIKES_BASE="ciclocross.html"
CICLOCROSS_BIKES_PAGES="$(seq 0 3)"

WOMAN_BIKES_BASE="woman.html"
WOMAN_BIKES_PAGES="$(seq 0 3)"

KIDS_BIKES_BASE="kids.html"
KIDS_BIKES_PAGES="$(seq 0 1)"

ELECTRIC_BIKES_BASE="electric.html"
ELECTRIC_BIKES_PAGES="$(seq 0 1)"

> ${OUTPUT_FILE}

process_pages "${MTB_FIX_BIKES_BASE}"    "${MTB_FIX_BIKES_PAGES}"    "Mammoth" "MTB-FIX"  \
>> ${OUTPUT_FILE}
process_pages "${MTB_XC_BIKES_BASE}"     "${MTB_XC_BIKES_PAGES}"     "Mammoth" "MTB"      \
>> ${OUTPUT_FILE}
process_pages "${MTB_FREERIDE_BIKES_BASE}"    "${MTB_FREERIDE_BIKES_PAGES}"    "Mammoth" "MTB-DOUBLE"  \
>> ${OUTPUT_FILE}
process_pages "${MTB_DOWNHILL_BIKES_BASE}"    "${MTB_DOWNHILL_BIKES_PAGES}"    "Mammoth" "MTB-DOUBLE"  \
>> ${OUTPUT_FILE}
process_pages "${MTB_ENDURO_BIKES_BASE}"    "${MTB_ENDURO_BIKES_PAGES}"    "Mammoth" "MTB-DOUBLE"  \
>> ${OUTPUT_FILE}
process_pages "${MTB_29_BIKES_BASE}"     "${MTB_29_BIKES_PAGES}"     "Mammoth" "MTB-29"   \
>> ${OUTPUT_FILE}
process_pages "${ROAD_BIKES_BASE}"       "${ROAD_BIKES_PAGES}"       "Mammoth" "ROAD"     \
>> ${OUTPUT_FILE}
process_pages "${URBAN_BIKES_BASE}"      "${URBAN_BIKES_PAGES}"      "Mammoth" "URBAN"    \
>> ${OUTPUT_FILE}
process_pages "${BMX_BIKES_BASE}"        "${BMX_BIKES_PAGES}"        "Mammoth" "BMX"      \
>> ${OUTPUT_FILE}
process_pages "${CICLOCROSS_BIKES_BASE}" "${CICLOCROSS_BIKES_PAGES}" "Mammoth" "ROAD"     \
>> ${OUTPUT_FILE}
process_pages "${WOMAN_BIKES_BASE}"      "${WOMAN_BIKES_PAGES}"      "Mammoth" "MTB-WOMAN"\
>> ${OUTPUT_FILE}
process_pages "${KIDS_BIKES_BASE}"       "${KIDS_BIKES_PAGES}"       "Mammoth" "KIDS"     \
>> ${OUTPUT_FILE}
process_pages "${ELECTRIC_BIKES_BASE}"       "${ELECTRIC_BIKES_PAGES}"       "Mammoth" "URBAN"     \
>> ${OUTPUT_FILE}