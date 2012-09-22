#!/bin/bash
#
# This script gets all the bicycles from
# Mammoth store !

OUTPUT_FILE=bicimania.txt
URL="www.mammoth.es"
URL_BASE=http://www.mammoth.es/catalogo/bicicletas?page=
EXCLUDE="-Rgif -Rpng -Rjpg -Rcss"
PAGE_BASE="bicicletas?page="
#EXCLUDE="-Ahtml"
#ONLY_DOMAIN="bicimania.com"
#HOST_ONLY="-D${ONLY_DOMAIN}"
ALL_BIKENAMES_FILE="./output.bikes"
ALL_URLS_FILE="./output.url"
ALL_BIKEURLS_FILE="./output"

#### KEYS GENERATED
SUBURL_KEY="SUBURL"
PRIZE_KEY="PRICE"
TRADEMARK_KEY="TRADEMARK"

#### Per Bike Field
PRIZE_SEARCH="Precio:"
TRADEMARK_SEARCH="cabeceraProducto"
FRAME_SEARCH="Cuadro"
SUSP_SEARCH="Suspensión"
WHEELS_SEARCH="Ruedas"
CUB_SEARCH="Cubiertas"
TR_SEARCH="Transmisión"
HCH_SEARCH="Manetas de cambio"
SCH_SEARCH="Desviador Shimano"
CH_SEARCH="Cambio Shimano TX35"
CRANK_SEARCH="Bielas"
CRANKBOX_SEARCH="Caja de pedalier"
CAS_SEARCH="Cassette"
PEDAL_SEARCH="Pedales"
SADDLE_SEARCH="Sillín"
SADDLE2_SEARCH="Tija de sillín"
HANDLEBAR_SEARCH="Manillar"
POWER_SEARCH="Potencia"
CUFFS_SEARCH="Puños"
DIR_SEARCH="Dirección"
BREAK_SEARCH="Frenos"

pages="$(seq 1 13)"

test -f ${ALL_BIKEURLS_FILE}  && rm ${ALL_BIKEURLS_FILE}
test -f ${ALL_BIKENAMES_FILE} && rm ${ALL_BIKENAMES_FILE}

# Params
# 1 - The URL of one single bike to parse
function parseMammothBike()
{
  URL=$(echo $1 | tr -d '"')
  THE_FILE=$(echo ${URL} | awk -F "/" {'print $NF'})
  test ! -z ${URL} && test ! -z ${THE_FILE} 
  if [ $? -eq 0 ];
  then
    wget -o /tmp/log ${URL} 2>&1 >/dev/null
    echo "${PRIZE_KEY}=$(cat ${THE_FILE} | grep "${PRIZE_SEARCH}" | awk -F " " {'print $2'} \
      | awk -F " " {'print $1'})"
    echo "${TRADEMARK_KEY}=$(cat ${THE_FILE} | grep "${TRADEMARK_SEARCH}" -A1 \
      | sed -e 's/<[^>]*>//g' | tr -d " " | tr -d '\n')"
    rm ${THE_FILE}
  fi
}

function getNLine()
{
  head -${1} $2 | tail -1
}

for page in ${pages};
do
  # NAME PARSING:
  cat ${PAGE_BASE}${page} | grep -i "field-content" | grep -i "a href" | sed 's/<a href=/\n/g' | awk -F ">" {'print $2'} | awk -F "<" {'print $1'} | while read NAME;
  do
    test -z "${NAME}" || echo "$NAME" 
  done | uniq >> ${ALL_BIKENAMES_FILE}
 
  # LINK 
  cat ${PAGE_BASE}${page} | grep -i "field-content" | grep -i "a href" | sed 's/<a href=/\n/g' | awk -F ">" {'print $1'} | grep -v " " | tr -d '"' | while read SUBURL;
  do
    echo ${SUBURL} | grep -v ^\< 2>&1 >/dev/null &&
      echo "${SUBURL_KEY}=\"${URL}${SUBURL}\""
  done | uniq >> ${ALL_URLS_FILE}
done

NUM_ENTRIES=$(cat ${ALL_BIKENAMES_FILE} | wc -l)
let counter=0
while [ ${counter} -ne ${NUM_ENTRIES} ];
do
  NAME=$(getNLine ${counter} ${ALL_BIKENAMES_FILE})
  test -z "${NAME}"
  if [ $? -ne 0 ];
  then
    echo -n "[" 
    echo -n "${NAME}"
    echo "]" 
    URL2=$(getNLine ${counter} ${ALL_URLS_FILE} | grep ${SUBURL_KEY} | awk -F "=" {'print $NF'})
    getNLine ${counter} ${ALL_URLS_FILE}
    parseMammothBike ${URL2}
    echo
  fi
  let counter=${counter}+1
done
#done >> ${ALL_BIKEURLS_FILE}

#rm ${ALL_BIKEURLS}
test -f ${ALL_BIKENAMES_FILE} && rm ${ALL_BIKENAMES_FILE}
test -f ${ALL_URLS_FILE} && rm ${ALL_URLS_FILE}
