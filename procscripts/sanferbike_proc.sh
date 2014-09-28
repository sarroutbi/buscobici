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
# PROCESSING INFORMATION FOR SANFERBIKE STORE
#
# OUTPUT:
# [Hotwalk]
# SUBURL="http://bicimania.com/specialized-hotwalk-nina-2011-p-5739.html"
# TRADEMARK=Specialized
# PRICE=139,38
# STORE=Bicimania
# KIND=KIDS (Values valid:KIDS,MTB-*,URBAN,BMX,ROAD)

#### Some global configs
URL_BASE="http://www.sanferbike.com"
OUTPUT_FILE="output"
#OUTPUT_FILE=/dev/stdout
NO_CAMEL_MIN=6

#### LOAD COMMON FUNCTIONS
. ./common_proc

#### The keys
KEY_URL="SUBURL"
KEY_TRADEMARK="TRADEMARK"
KEY_PRICE="PRICE"
KEY_STORE="STORE"
KEY_KIND="KIND"

#### The files to process
FILE_29="29.asp"
FILE_BMC="bmc.asp"
FILE_CANNONDALE="cannondale.asp"
FILE_WOMAN="ellas.asp"
FILE_GIANT="giant.asp"
FILE_LAPIERRE="lapierre.asp"
FILE_ORBEA="orbea.asp"
FILE_TRIATLON="triatlon.asp"

MAX_REV_SEARCH=10000
TRADEMARK_SEP="&nbsp;"
PRICE_KEY="Precio"
MAX_BIKES_PAGE=200
MAX_PRICE_DOWN=20

#
# 1 - URL
#
function get_price_from_url()
{
  #wget "${1}" -O - 2>/dev/null | egrep -E -o "[0-9]{1,2} {0,1}[0-9]{1,3},{1,2}[0-9]{1,2} €" | tr -d '€' | tr -d ' ' | grep [0-9] | head -1
  wget "${1}" -O - 2>/dev/null |  sed -e 's@<span id="our_price_display"@\n<span id="our_price_display"@g' | grep ^'<span id="our_price_display"' | egrep -E "[0-9]{1,2} {0,1}[0-9]{1,3},{1,2}[0-9]{1,2} €" -o | head -1 | tr -d ' '
}

#
# 1 - The sentence: THIS IS A SENTENCE => This Is A Sentence
# 2 - The min length: 4 => THIS IS A SENTENCE => This IS A Sentence
#
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
      firstLetter=$(echo "${word:0:1}" | tr "[a-z]" "[A-Z]")
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

#
# 1 - The URL
#
function get_price()
{
  TMP_FILE=$(mktemp)
  TMP_FILE2=$(mktemp)
  URL=$(echo "${1}" | tr -d '"')
  wget "${URL}" -o ${TMP_FILE2} -O ${TMP_FILE} 2>&1 > /dev/null 
  cat ${TMP_FILE} | grep "${PRICE_KEY}" | awk -F "&nbsp;" {'print $2'} 
  rm ${TMP_FILE}
  rm ${TMP_FILE2}
}

#
# 1 - The file
# 2 - The model
#
function get_price_fm()
{
  PRICE=$(grep "${2}" "${1}" -A${MAX_PRICE_DOWN} | grep 'class="price"' | sed -e 's/<[^>]*>//g' | tr -d ' ' | sed -e 's/\t//g' | egrep -o -E "[0-9]{1,},{0,1}[0-9]{1,3}" | head -1)
  echo "${PRICE}"
}

#
# 1 - The model
# Prints the trademark
function get_trademark()
{
  TRADEMARK=$(echo "$1" | tr -d '"' | awk {'print $1'})
  echo "${TRADEMARK}"
}

#
# 1 - The file
# 2 - The model
# Prints the url
function get_url()
{
  SUBURL=$(grep "$2" "$1" -A10 | grep "a href" | head -1 | awk -F "a href=" {'print $2'} | awk -F " " {'print $1'}) 
  echo "${SUBURL}"
}

#
# 1 - Original type
# Prints valid type 
function translate_type()
{
  echo "${1}" | grep "Monta" 2>&1 > /dev/null
  if [ $? -eq 0 ];
  then
    echo "MTB"
    return 0
  fi
  echo "${1}" | grep "Carret" 2>&1 > /dev/null
  if [ $? -eq 0 ];
  then
    echo "ROAD"
    return 0
  fi
  echo "${1}" | grep "Infantil" 2>&1 > /dev/null
  if [ $? -eq 0 ];
  then
    echo "KIDS"
    return 0
  fi
  echo "${1}" | grep "Urbanas\|Híbridas" 2>&1 > /dev/null
  if [ $? -eq 0 ];
  then
    echo "URBAN-CONFORT-FOLDING"
    return 0
  fi
  echo ""
}

#
# 1 - URL of file
# 2 - The model
function get_type()
{
  TYPE=$(grep "$2" "$1" -B ${MAX_REV_SEARCH} | grep '<div class' | tail -1 | sed -e 's/<[^>]*>//g' | grep "Montaña\|Carretera\|Infantil\|Urbanas\|Híbridas\|" | tr -d ' ' | tr -d '\r' | tr -d '\n')
  TYPE_CONVERSED=$(translate_type "${TYPE}")
  translate_type "${TYPE}"
  #echo "${TYPE_CONVERSED}"
  #echo "${TYPE}"
}

# 
# 1 - URL of site 
# 2 - The Store
function process_file()
{
  cat "$1" | grep 'class="product_link"' | sed -e 's/<[^>]*>//g' | grep "[A-Z,a-z]" | tr -d '\r' | while read model;
  do
     TYPE=$3
     URL=$(get_url "$1" "${model}")
     TRADEMARK=$(get_trademark "${model}")
     PRICE=$(get_price_fm "${1}" "${model}")
     MODEL=$(echo "${model}" | awk {'for(i=2;i<=NF;++i){printf $i; if(i<NF){printf " "}}'})
     if [ "${MODEL}" = "" ];
     then
       MODEL=$(echo "${model}" | awk -F "&nbsp;&nbsp;" {'print $2'})
       if [ "${MODEL}" = "" ];
       then
         MODEL="${model}"
       fi
     fi
     TRADEMARK_CAMEL=$(bubic_camel "${TRADEMARK}" 0)
     MODEL_CAMEL=$(bubic_camel "${MODEL}" ${NO_CAMEL_MIN})
     if [ "${TYPE}" != "" ];
     then 
       echo "[${MODEL_CAMEL}]"
       echo "${KEY_URL}=${URL}"
       echo "${KEY_TRADEMARK}=${TRADEMARK_CAMEL}"
       echo "${KEY_PRICE}=${PRICE}"
       echo "${KEY_STORE}=${2}"
       echo "${KEY_KIND}=${3}"
       echo 
     fi
  done
} 

# 
# 1 - URL of site 
# 2 - The Store
function process_file2()
{
  cat "$1" | sed -e 's@/div><@/div>\n<@g'| grep -i 'product_desc' | awk -F "<h3>" {'print $2'} | awk -F "</h3>" {'print $1'} | while read model
  do
     TYPE=$3
     MODEL_TRADEMARK=$(echo ${model} | sed -e 's/<[^>]*>//g')
     TRADEMARK=$(get_trademark "${MODEL_TRADEMARK}")
     MODEL=$(echo "${MODEL_TRADEMARK}" | awk {'for(i=2;i<=NF;++i){printf $i; if(i<NF){printf " "}}'})
     URL=$(echo "${model}" | awk -F '<a href=' {'print $2'} | awk {'print $1'})
     #PRICE=$(cat "${1}" | awk -F "${MODEL_TRADEMARK}" {'print $2'} | awk -F '<span class="price"' {'print $2'} | awk -F '</span>' {'print $1'} | sed -e 's/<[^>]*>//g')
     #PRICE=$(cat "${1}" | awk -F "${MODEL_TRADEMARK}" {'print $6'} | awk -F '<span class="price"' {'print $2'} | awk -F '</span>' {'print $1'} | awk -F ">" {'print $2'} | sed -e 's/<[^>]*>//g' | tr -d '€' | tr -d ' ' | grep [0-9])
     if [ "${MODEL}" = "" ];
     then
       MODEL=$(echo "${model}" | awk -F "&nbsp;&nbsp;" {'print $2'})
       if [ "${MODEL}" = "" ];
       then
         MODEL="${model}"
       fi
     fi
     URL_NO_DASH=$(echo ${URL} | tr -d '"')
     PRICE=$(get_price_from_url "${URL_NO_DASH}")
     TRADEMARK_CAMEL=$(bubic_camel "${TRADEMARK}" 0)
     MODEL_CAMEL=$(bubic_camel "${MODEL}" ${NO_CAMEL_MIN})
     if [ "${TYPE}" != "" ];
     then 
       echo "[${MODEL_CAMEL}]"
       echo "${KEY_URL}=${URL}"
       echo "${KEY_TRADEMARK}=${TRADEMARK_CAMEL}"
       echo "${KEY_PRICE}=${PRICE}"
       echo "${KEY_STORE}=${2}"
       echo "${KEY_KIND}=${3}"
       echo 
       echo 
     fi
  done
} 

> ${OUTPUT_FILE}

# 2014 third review
# Liv
process_file2 "20009-liv-montaa?n=${MAX_BIKES_PAGE}" "Sanferbike" "MTB" >> ${OUTPUT_FILE}
process_file2 "20008-liv-carretera?n=${MAX_BIKES_PAGE}" "Sanferbike" "ROAD" >> ${OUTPUT_FILE}
process_file2 "20010-liv-paseourban?n=${MAX_BIKES_PAGE}" "Sanferbike" "URBAN" >> ${OUTPUT_FILE}

# 2014 second review
# Cannondale
process_file2 "464-bicicletas-cannondale-montana?n=${MAX_BIKES_PAGE}" "Sanferbike" "MTB" >> ${OUTPUT_FILE}
process_file2 "465-montana-mujer-cannondale?n=${MAX_BIKES_PAGE}" "Sanferbike" "MTB-WOMAN" >> ${OUTPUT_FILE}
process_file2 "462-carretera-hombre-cannondale?n=${MAX_BIKES_PAGE}"  "Sanferbike" "ROAD" >> ${OUTPUT_FILE}
process_file2 "458-carretera-mujer?n=${MAX_BIKES_PAGE}" "Sanferbike" "ROAD-WOMAN" >> ${OUTPUT_FILE}
process_file2 "478-urbanas-cannondale?n=${MAX_BIKES_PAGE}" "Sanferbike" "URBAN" >> ${OUTPUT_FILE}
process_file2 "479-cannondale-para-ninos?n=${MAX_BIKES_PAGE}" "Sanferbike" "KIDS" >> ${OUTPUT_FILE}
process_file2 "527-electricas-cannondale?n=${MAX_BIKES_PAGE}" "Sanferbike" "URBAN" >> ${OUTPUT_FILE}

# Orbea
process_file2 "409-orbea-mtb?n=${MAX_BIKES_PAGE}" "Sanferbike" "MTB" >> ${OUTPUT_FILE}
process_file2 "482-montana-mujer?n=${MAX_BIKES_PAGE}" "Sanferbike" "MTB-WOMAN" >> ${OUTPUT_FILE}
process_file2 "406-orbea-road?n=${MAX_BIKES_PAGE}" "Sanferbike" "ROAD" >> ${OUTPUT_FILE}
process_file2 "412-urban?n=${MAX_BIKES_PAGE}" "Sanferbike" "URBAN" >> ${OUTPUT_FILE}
process_file2 "410-all-use?n=${MAX_BIKES_PAGE}" "Sanferbike" "URBAN" >> ${OUTPUT_FILE}
process_file2 "405-nuevas-orbea-mx?n=${MAX_BIKES_PAGE}" "Sanferbike" "KIDS" >> ${OUTPUT_FILE}

# Giant
process_file2 "537-montaña-hombre-giant?n=${MAX_BIKES_PAGE}" "Sanferbike" "MTB" >> ${OUTPUT_FILE}
process_file2 "538-montaña-mujer-giant?n=${MAX_BIKES_PAGE}"  "Sanferbike" "MTB-WOMAN" >> ${OUTPUT_FILE}
process_file2 "539-carretera-hombre-giant?n=${MAX_BIKES_PAGE}" "Sanferbike" "ROAD" >> ${OUTPUT_FILE}
process_file2 "540-carretera-mujer-giant?n=${MAX_BIKES_PAGE}"  "Sanferbike" "ROAD-WOMAN" >> ${OUTPUT_FILE}
process_file2 "541-urbanas-giant?n=${MAX_BIKES_PAGE}" "Sanferbike" "URBAN" >> ${OUTPUT_FILE}
process_file2 "550-h?n=${MAX_BIKES_PAGE}"             "Sanferbike" "URBAN" >> ${OUTPUT_FILE}
process_file2 "536-ninos-giant?n=${MAX_BIKES_PAGE}"   "Sanferbike" "KIDS" >> ${OUTPUT_FILE}

# Bmc
process_file2 "365-nuevas-bmc-carretera?n=${MAX_BIKES_PAGE}" "Sanferbike" "ROAD" >> ${OUTPUT_FILE}
process_file2 "373-nuevas-bmc-montana?n=${MAX_BIKES_PAGE}"   "Sanferbike" "MTB" >> ${OUTPUT_FILE}
process_file2 "376-urbanas-bmc?n=${MAX_BIKES_PAGE}"          "Sanferbike" "URBAN" >> ${OUTPUT_FILE}

# outlet
process_file2 "20002-ofertas-road?n=${MAX_BIKES_PAGE}" "Sanferbike" "ROAD" >> ${OUTPUT_FILE}
process_file2 "20001-ofertas-mtb?n=${MAX_BIKES_PAGE}" "Sanferbike" "MTB" >> ${OUTPUT_FILE}

# folding
process_file2 "528-bicis-plegables?n=${MAX_BIKES_PAGE}" "Sanferbike" "URBAN-FOLDING" >> ${OUTPUT_FILE}

# electric
process_file2 "305-bicis-electricas?n=${MAX_BIKES_PAGE}" "Sanferbike" "URBAN-ELECTRIC" >> ${OUTPUT_FILE}
