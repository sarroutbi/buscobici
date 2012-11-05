#!/bin/bash
#
# This script processes entries from 
# Gil Bicicletas !
# URL: www.bicicletasgil.com
# It outputs site common structure:
# 
# [7.6 FX WSD]
# SUBURL="http://www.mammoth.es/producto/bicicletas/trek/76-fx-wsd"
# TRADEMARK=Trek
# PRICE=1099,00€
# STORE=Mammoth
# KIND=MTB

OUTPUT_FILE=output
MTB_FIX_FILE='mtb rigida'
MTB_DOUBLE_FILE='mtb dobles'
MTB_TWENTYNINE_FILE='mtb 29'
URBAN_FILE='urbanas'
WOMAN_FILE='mujer'
KID_FILE='infantil'
ROAD_FILE='carretera'

MAX_TO_PRICE=20
URL_ROOT="http://www.bicicletasgil.com/"

# 1 - The file to be processed
# 2 - The Store
# 3 - The Type (as there is a classifcation via files)
proc_file()
{
  cat "$1" |  grep "<a id" | grep "href=" | grep "Listado" | while read line;
  do
    MODEL=$(echo "${line}" | grep "<a id" | grep "href=" | grep "Listado" | sed -e 's/<[^>]*>//g' | awk {'for(i=2;i<=NF;++i){printf $i; if(i<NF){printf " "}}'} | tr -d '\r')
    TRADEMARK=$(echo "${line}" | grep "<a id" | grep "href=" | grep "Listado" | sed -e 's/<[^>]*>//g' | awk {'print $1'})
    PRICE=$(grep "${MODEL}" "${1}" -A${MAX_TO_PRICE} | grep -o "[0-9,\.]*,[0-9]*" | sed -e 's/<[^>]*>//g' | tr -d ' ' | tr -d '\.' | awk {'print $1'} | head -1)
    SUBURL=$(echo ${line} |  grep "<a id" | grep "href=" | grep "Listado" | awk -F "href=" {'print $2'} | awk -F ">" {'print $1'} | sed s-"../../"-${URL_ROOT}-g)
    echo "[${MODEL}]"
    echo "SUBURL=${SUBURL}"
    echo "TRADEMARK=${TRADEMARK}"
    echo "PRICE=${PRICE}"
    echo "STORE=${2}"
    echo "KIND=${3}"
    echo ""
  done >> ${OUTPUT_FILE}
}

> ${OUTPUT_FILE}

proc_file "${ROAD_FILE}" "Bicicletas Gil" "ROAD"
proc_file "${MTB_FIX_FILE}" "Bicicletas Gil" "MTB-FIX"
proc_file "${MTB_DOUBLE_FILE}" "Bicicletas Gil" "MTB-DOUBLE"
proc_file "${MTB_TWENTYNINE_FILE}" "Bicicletas Gil" "MTB-29"
proc_file "${URBAN_FILE}" "Bicicletas Gil" "URBAN-CONFORT-FOLDING"
proc_file "${WOMAN_FILE}" "Bicicletas Gil" "WOMAN"
proc_file "${KID_FILE}" "Bicicletas Gil" "KIDS"
