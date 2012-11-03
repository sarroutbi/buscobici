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
BASE_URL="http://www.buhobike.com"
NO_CAMEL_MIN=6

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
function print_model()
{
  #echo "======================================"
  #  echo "======> URL:${1} <========="
  MODELS=$(wget -O - "$1" 2>&1 | grep "<title>" -A3 | sed -e 's/<[^>]*>//g' | grep "[A-Z,a-z,0-9]" | head -1 | awk -F " - " {'print $NF'} | tr -d "\n")
  echo "${MODELS}" | while read model;
  do
    MODEL="${model}"
    echo ${MODEL}
  done
  #echo "======================================"
}

# Params:
# 1 - The URL of bike
function print_price()
{
  PRICES=$(wget "$1" -O - 2>&1 | grep "IVA" | grep '&euro' | grep -o "[0-9,\.]*[0-9],[0-9]*" | tr -d '.' | tail -1)
  for price in ${PRICES};
  do
    PRICE=${price} 
  done
  echo ${PRICE}
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


MTB_BIKES_BASE="rapida?op=188&_pagi_pg="
MTB_BIKES_PAGES=$(seq 1 35)

ROAD_BIKES_BASE="rapida?op=288&_pagi_pg="
ROAD_BIKES_PAGES=$(seq 1 25)

TREKKING_BIKES_BASE="rapida?op=388&_pagi_pg="
TREKKING_BIKES_PAGES=$(seq 1 15)

URBAN_BIKES_BASE="rapida?op=488&_pagi_pg="
URBAN_BIKES_PAGES=$(seq 1 15)

BMX_BIKES_BASE="rapida?op=588&_pagi_pg="
BMX_BIKES_PAGES=$(seq 1 3)

KIDS_BIKES_BASE="rapida?op=688&_pagi_pg="
KIDS_BIKES_PAGES=$(seq 1 8)

function process_pages()
{
  BASE_FILE="$1"
  PAGES="$2"
  STORE="$3"
  TYPE="$4"
  if [ "${PAGES}" = "" ];
  then
      cat ${BASE_FILE} | grep "resumenproducto" | awk -F "<div class='resumenproducto'>" {'for(i=1;i<=NF;++i){printf $i"\n";}'} | while read bike;
      do
        # NOTE: each bike should be more or less like:
        # ORBEA<br>AQUA T23 2013<br><b>717 &euro;</b>
        # echo "BIKE:=>${bike}<="
        TRADEMARK=$(echo ${bike} | awk -F "<br>" {'print $1'} | sed -e 's/<[^>]*>//g')
        MODEL=$(echo ${bike} | awk -F "<br>" {'print $2'} | sed -e 's/<[^>]*>//g' | tr "'" '"')
        PRICE=$(echo ${bike} | awk -F "<br>" {'print $3'} | sed -e 's/<[^>]*>//g' | egrep "[0-9]{1,}.?[0-9]{0,},?[0-9]{0,}" -o)
        # echo "=========>${bike}<==========="
        URL=$(echo "${bike}" | awk -F "<a href='" {'print $2'} | awk -F ">" {'print $1'} | tr -d "'")
        FINAL_URL="${BASE_URL}${URL}"
        TRADEMARK_CAMEL=$(camel "${TRADEMARK}" 0)
        MODEL_CAMEL=$(camel "${MODEL}" ${NO_CAMEL_MIN})
        dump_bike "${MODEL_CAMEL}" "${FINAL_URL}" "${TRADEMARK_CAMEL}" "${PRICE}" "${STORE}" "${TYPE}"
      done
  else
    for page in ${PAGES};
    do 
      cat ${BASE_FILE}${page} | grep "resumenproducto" | awk -F "<div class='resumenproducto'>" {'for(i=1;i<=NF;++i){printf $i"\n";}'} | while read bike;
      do
        # NOTE: each bike should be more or less like:
        # <a href=""...>ORBEA<br>AQUA T23 2013<br><b>717 &euro;</b>
        # echo "BIKE:=>${bike}<="
        TRADEMARK=$(echo ${bike} | awk -F "<br>" {'print $1'} | sed -e 's/<[^>]*>//g')
        MODEL=$(echo ${bike} | awk -F "<br>" {'print $2'} | sed -e 's/<[^>]*>//g' | tr "'" '"')
        PRICE=$(echo ${bike} | awk -F "<br>" {'print $3'} | sed -e 's/<[^>]*>//g' | egrep "[0-9]{1,}.?[0-9]{0,},?[0-9]{0,}" -o)
        # echo "=========>${bike}<==========="
        URL=$(echo "${bike}" | awk -F "<a href='" {'print $2'} | awk -F ">" {'print $1'} | tr -d "'")
        FINAL_URL="${BASE_URL}${URL}"
        TRADEMARK_CAMEL=$(camel "${TRADEMARK}" 0)
        MODEL_CAMEL=$(camel "${MODEL}" ${NO_CAMEL_MIN})
        dump_bike "${MODEL_CAMEL}" "${FINAL_URL}" "${TRADEMARK_CAMEL}" "${PRICE}" "${STORE}" "${TYPE}"
      done
    done
  fi
}

> ${OUTPUT_FILE}

process_pages "${MTB_BIKES_BASE}" "${MTB_BIKES_PAGES}" "BuhoBike" "MTB" >> ${OUTPUT_FILE}
process_pages "${ROAD_BIKES_BASE}" "${ROAD_BIKES_PAGES}" "BuhoBike" "ROAD"  >> ${OUTPUT_FILE}
process_pages "${TREKKING_BIKES_BASE}" "${TREKKING_BIKES_PAGES}" "BuhoBike" "URBAN-CONFORT-FOLDING"  >> ${OUTPUT_FILE}
process_pages "${URBAN_BIKES_BASE}" "${URBAN_BIKES_PAGES}" "BuhoBike" "URBAN-CONFORT-FOLDING"  >> ${OUTPUT_FILE}
process_pages "${BMX_BIKES_BASE}" "${BMX_BIKES_PAGES}" "BuhoBike" "BMX" >> ${OUTPUT_FILE}
process_pages "${KIDS_BIKES_BASE}" "${KIDS_BIKES_PAGES}" "BuhoBike" "KIDS"  >> ${OUTPUT_FILE}

#process_pages "${MTB_BIKES_BASE}" "${MTB_BIKES_PAGES}" "BuhoBike" "MTB"
#process_pages "${ROAD_BIKES_BASE}" "${ROAD_BIKES_PAGES}" "BuhoBike" "ROAD"
#process_pages "${TREKKING_BIKES_BASE}" "${TREKKING_BIKES_PAGES}" "BuhoBike" "URBAN-CONFORT-FOLDING"  
#process_pages "${URBAN_BIKES_BASE}" "${URBAN_BIKES_PAGES}" "BuhoBike" "URBAN-CONFORT-FOLDING" 
#process_pages "${BMX_BIKES_BASE}" "${BMX_BIKES_PAGES}" "BuhoBike" "BMX" 
#process_pages "${KIDS_BIKES_BASE}" "${KIDS_BIKES_PAGES}" "BuhoBike" "KIDS"
