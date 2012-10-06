#!/bin/sh
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

#
# 1 - The file
# 2 - The model
# Prints the url
function get_url()
{
  SUBURL=$(grep "$2" "$1" -A10 | grep "a href" | awk -F "a href=" {'print $2'}| awk -F ">" {'print $1'})
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
  echo "MTB"
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
     echo "[${model}]"
     echo "${KEY_URL}=${URL}"
     echo "${KEY_TRADEMARK}="
     echo "${KEY_PRICE}="
     echo "${KEY_STORE}=${2}"
     echo "${KEY_KIND}=${TYPE}"
     echo 
  done
}

process_file "${FILE_29}" "Sanferbike"
process_file "${FILE_BMC}" "Sanferbike"
process_file "${FILE_CANNONDALE}" "Sanferbike"
process_file "${FILE_ORBEA}" "Sanferbike"
process_file "${FILE_WOMAN}" "Sanferbike"
process_file "${FILE_GIANT}" "Sanferbike"
process_file "${FILE_LAPIERRE}" "Sanferbike"
process_file "${FILE_TRIATLON}" "Sanferbike"
