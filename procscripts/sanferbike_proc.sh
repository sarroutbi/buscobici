#!/bin/bash
#
# PROCESSING INFORMATION FOR SANFERBIKE STORE
#
# OUTPUT:
# [Hotwalk Ni�a 2011Specialized Hotwalk Ni�a 2011">Specialized Hotwalk Ni�a 2011">]
# SUBURL="http://bicimania.com/specialized-hotwalk-nina-2011-p-5739.html"
# TRADEMARK=Specialized
# PRICE=139,38
# STORE=Bicimania
# KIND=KIDS (Values valid:KIDS,MTB-*,URBAN-CONFORT-FOLDING,WOMEN,BMX,ROAD)

#### Some global configs
URL_BASE="http://www.sanferbike.com"
OUTPUT_FILE="output"
NO_CAMEL_MIN=6

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
# 1 - The model
# Prints the trademark
function get_trademark()
{
  TRADEMARK=$(echo "$1" | tr -d '"' | awk -F "${TRADEMARK_SEP}" {'print $1'} | awk -F "&nbsp;" {'print $1'})
  echo "${TRADEMARK}"
}

#
# 1 - The file
# 2 - The model
# Prints the url
function get_url()
{
  SUBURL=$(grep "$2" "$1" -A10 | grep "a href" | head -1 | awk -F "a href=" {'print $2'}| awk -F ">" {'print $1'})
  echo "\"${URL_BASE}/${SUBURL}\""
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
  cat "$1" | grep 'class="marca"' -A2 | sed -e 's/<[^>]*>//g' | grep "[A-Z,a-z]" | tr -d '\r' | while read model;
  do
     TYPE=$(get_type "$1" "${model}")
     URL=$(get_url "$1" "${model}")
     TRADEMARK=$(get_trademark "${model}")
     PRICE=$(get_price "${URL}")
     MODEL=$(echo "${model}" | awk -F "&nbsp;" {'print $2'})
     if [ "${MODEL}" = "" ];
     then
       MODEL=$(echo "${model}" | awk -F "&nbsp;&nbsp;" {'print $2'})
       if [ "${MODEL}" = "" ];
       then
         MODEL="${model}"
       fi
     fi
     TRADEMARK_CAMEL=$(camel "${TRADEMARK}" 0)
     MODEL_CAMEL=$(camel "${MODEL}" ${NO_CAMEL_MIN})
     if [ "${TYPE}" != "" ];
     then 
       echo "[${MODEL_CAMEL}]"
       echo "${KEY_URL}=${URL}"
       echo "${KEY_TRADEMARK}=${TRADEMARK_CAMEL}"
       echo "${KEY_PRICE}=${PRICE}"
       echo "${KEY_STORE}=${2}"
       echo "${KEY_KIND}=${TYPE}"
       echo 
     fi
  done
} 

> ${OUTPUT_FILE}
process_file "${FILE_29}" "Sanferbike"  >> ${OUTPUT_FILE}
process_file "${FILE_BMC}" "Sanferbike" >> ${OUTPUT_FILE}
process_file "${FILE_CANNONDALE}" "Sanferbike" >> ${OUTPUT_FILE}
process_file "${FILE_ORBEA}" "Sanferbike" >> ${OUTPUT_FILE}
process_file "${FILE_WOMAN}" "Sanferbike" >> ${OUTPUT_FILE}
process_file "${FILE_GIANT}" "Sanferbike" >> ${OUTPUT_FILE}
process_file "${FILE_LAPIERRE}" "Sanferbike" >> ${OUTPUT_FILE}
process_file "${FILE_TRIATLON}" "Sanferbike" >> ${OUTPUT_FILE}
