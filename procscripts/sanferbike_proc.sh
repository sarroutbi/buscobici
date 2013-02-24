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
#OUTPUT_FILE=/dev/stdout
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
MAX_BIKES_PAGE=200
MAX_PRICE_DOWN=20

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
     TRADEMARK_CAMEL=$(camel "${TRADEMARK}" 0)
     MODEL_CAMEL=$(camel "${MODEL}" ${NO_CAMEL_MIN})
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

> ${OUTPUT_FILE}

process_file "164-lap-carretera-hombre?n=${MAX_BIKES_PAGE}"                  "Sanferbike" "ROAD" >> ${OUTPUT_FILE}
process_file "165-lap-carretera-mujer?n=${MAX_BIKES_PAGE}"                   "Sanferbike" "ROAD" >> ${OUTPUT_FILE}
process_file "166-lap-montana-hombre?n=${MAX_BIKES_PAGE}"                    "Sanferbike" "MTB" >> ${OUTPUT_FILE}
process_file "167-lap-montana-mujer?n=${MAX_BIKES_PAGE}"                     "Sanferbike" "MTB" >> ${OUTPUT_FILE}
process_file "168-bicicletas-hibridas-mujeres?n=${MAX_BIKES_PAGE}"           "Sanferbike" "URBAN" >> ${OUTPUT_FILE}
process_file "169-lap-urbanas?n=${MAX_BIKES_PAGE}"                           "Sanferbike" "URBAN" >> ${OUTPUT_FILE}
process_file "173-over-ride-montana-lapierre?n=${MAX_BIKES_PAGE}"            "Sanferbike" "MTB-DOUBLE" >> ${OUTPUT_FILE}
process_file "179-orbea-infantil-2013?n=${MAX_BIKES_PAGE}"                   "Sanferbike" "KIDS" >> ${OUTPUT_FILE}
process_file "186-hibridas-hombres?n=${MAX_BIKES_PAGE}"                      "Sanferbike" "URBAN" >> ${OUTPUT_FILE}
process_file "187-hibridas-mujeres?n=${MAX_BIKES_PAGE}"                      "Sanferbike" "URBAN" >> ${OUTPUT_FILE}
process_file "193-bmc-2013-carretera?n=${MAX_BIKES_PAGE}"                    "Sanferbike" "ROAD" >> ${OUTPUT_FILE}
process_file "195-all-mountain?n=${MAX_BIKES_PAGE}"                          "Sanferbike" "MTB-DOUBLE" >> ${OUTPUT_FILE}
process_file "197-bmc-2013-urbanas-fitness?n=${MAX_BIKES_PAGE}"              "Sanferbike" "URBAN" >> ${OUTPUT_FILE}
process_file "198-lapierre-bmx-dirt?n=${MAX_BIKES_PAGE}"                     "Sanferbike" "BMX" >> ${OUTPUT_FILE}
process_file "200-mujeres?n=${MAX_BIKES_PAGE}"                               "Sanferbike" "URBAN" >> ${OUTPUT_FILE}
process_file "201-orbea-montana-mujer?n=${MAX_BIKES_PAGE}"                   "Sanferbike" "MTB-WOMAN" >> ${OUTPUT_FILE}
process_file "204-montana-mujer?n=${MAX_BIKES_PAGE}"                         "Sanferbike" "MTB-WOMAN" >> ${OUTPUT_FILE}
process_file "205-carretera?n=${MAX_BIKES_PAGE}"                             "Sanferbike" "ROAD" >> ${OUTPUT_FILE}
process_file "206-urbanas?n=${MAX_BIKES_PAGE}"                               "Sanferbike" "URBAN" >> ${OUTPUT_FILE}
process_file "207-sport-maraton?n=${MAX_BIKES_PAGE}"                         "Sanferbike" "MTB" >> ${OUTPUT_FILE}
process_file "208-all-enduro-cannondale?n=${MAX_BIKES_PAGE}"                 "Sanferbike" "MTB-DOUBLE" >> ${OUTPUT_FILE}
process_file "209-over-mountain?n=${MAX_BIKES_PAGE}"                         "Sanferbike" "MTB-DOUBLE" >> ${OUTPUT_FILE}
process_file "217-bicicletas-montana-hombre-over-mountain?n=${MAX_BIKES_PAGE}" "Sanferbike" "MTB-DOUBLE" >> ${OUTPUT_FILE}
process_file "218-bicicletas-ciudad-urbanas-hombres?n=${MAX_BIKES_PAGE}"     "Sanferbike" "URBAN" >> ${OUTPUT_FILE}
process_file "220-bicicletas-hibridas-madrid?n=${MAX_BIKES_PAGE}"            "Sanferbike" "URBAN" >> ${OUTPUT_FILE}
process_file "222-bicicletas-ciudad-urbanas-giant?n=${MAX_BIKES_PAGE}"       "Sanferbike" "URBAN" >> ${OUTPUT_FILE}
process_file "223-bicicletas-ciudad-urbanas-mujeres?n=${MAX_BIKES_PAGE}"     "Sanferbike" "URBAN" >> ${OUTPUT_FILE}
process_file "225-dahon-calidad-plegables?n=${MAX_BIKES_PAGE}"               "Sanferbike" "URBAN" >> ${OUTPUT_FILE}
process_file "226-carretera-mujer-2013?n=${MAX_BIKES_PAGE}"                  "Sanferbike" "ROAD" >> ${OUTPUT_FILE}
process_file "227-competicion?n=${MAX_BIKES_PAGE}"                           "Sanferbike" "ROAD" >> ${OUTPUT_FILE}
process_file "228-rendimiento?n=${MAX_BIKES_PAGE}"                           "Sanferbike" "ROAD" >> ${OUTPUT_FILE}
process_file "230-sport?n=${MAX_BIKES_PAGE}"                                 "Sanferbike" "ROAD" >> ${OUTPUT_FILE}
process_file "231-fitness?n=${MAX_BIKES_PAGE}"                               "Sanferbike" "ROAD" >> ${OUTPUT_FILE}
process_file "232-bicicletas-ciudad-urbanas-mujeres?n=${MAX_BIKES_PAGE}"     "Sanferbike" "URBAN" >> ${OUTPUT_FILE}
process_file "233-bici-mujer-cross?n=${MAX_BIKES_PAGE}"                      "Sanferbike" "URBAN" >> ${OUTPUT_FILE}
process_file "234-orca?n=${MAX_BIKES_PAGE}"                                  "Sanferbike" "ROAD" >> ${OUTPUT_FILE}
process_file "235-aqua?n=${MAX_BIKES_PAGE}"                                  "Sanferbike" "ROAD" >> ${OUTPUT_FILE}
process_file "236-onix?n=${MAX_BIKES_PAGE}"                                  "Sanferbike" "ROAD" >> ${OUTPUT_FILE}
process_file "237-terra-bicicletas-ciclocross?n=${MAX_BIKES_PAGE}"           "Sanferbike" "ROAD" >> ${OUTPUT_FILE}
process_file "238-ordu?n=${MAX_BIKES_PAGE}"                                  "Sanferbike" "ROAD" >> ${OUTPUT_FILE}
process_file "239-bicicleta-orca-mujer?n=${MAX_BIKES_PAGE}"                  "Sanferbike" "ROAD" >> ${OUTPUT_FILE}
process_file "240-bicicleta-aqua-mujer?n=${MAX_BIKES_PAGE}"                  "Sanferbike" "ROAD" >> ${OUTPUT_FILE}
process_file "241-bicicletas-orbea-montana?n=${MAX_BIKES_PAGE}"              "Sanferbike" "MTB-DOUBLE" >> ${OUTPUT_FILE}
process_file "242-bicicletas-orbea-montana?n=${MAX_BIKES_PAGE}"              "Sanferbike" "MTB" >> ${OUTPUT_FILE}
process_file "243-bicicletas-sport-orbea?n=${MAX_BIKES_PAGE}"                "Sanferbike" "MTB" >> ${OUTPUT_FILE}
process_file "245-bicicletas-ciudad-urbanas-orbea?n=${MAX_BIKES_PAGE}"       "Sanferbike" "URBAN" >> ${OUTPUT_FILE}
process_file "247-bicicletas-ciudad-urbanas-orbea-carpe?n=${MAX_BIKES_PAGE}" "Sanferbike" "URBAN" >> ${OUTPUT_FILE}
process_file "249-bicicletas-ciudad-urbanas-orbea-dude?n=${MAX_BIKES_PAGE}"  "Sanferbike" "URBAN" >> ${OUTPUT_FILE}
process_file "251-bicicletas-ciudad-urbanas-orbea-boulevard?n=${MAX_BIKES_PAGE}" "Sanferbike" "URBAN" >> ${OUTPUT_FILE}
process_file "255-bicicletas-carretera-fitness-orbea?n=${MAX_BIKES_PAGE}"    "Sanferbike" "URBAN" >> ${OUTPUT_FILE}
process_file "257-bicicletas-giant-montana-mujer?n=${MAX_BIKES_PAGE}"        "Sanferbike" "MTB-WOMAN" >> ${OUTPUT_FILE}
process_file "258-ruedas-29?n=${MAX_BIKES_PAGE}"                             "Sanferbike" "MTB-29" >> ${OUTPUT_FILE}
process_file "259-bicis-29?n=${MAX_BIKES_PAGE}"                              "Sanferbike" "MTB-29" >> ${OUTPUT_FILE}
process_file "263-scalpel?n=${MAX_BIKES_PAGE}"                               "Sanferbike" "MTB-DOUBLE" >> ${OUTPUT_FILE}
process_file "264-rz?n=${MAX_BIKES_PAGE}"                                    "Sanferbike" "MTB-DOUBLE" >> ${OUTPUT_FILE}
process_file "265-trail?n=${MAX_BIKES_PAGE}"                                 "Sanferbike" "MTB" >> ${OUTPUT_FILE}
process_file "266-b?n=${MAX_BIKES_PAGE}"                                     "Sanferbike" "MTB-29" >> ${OUTPUT_FILE}
process_file "267-caad?n=${MAX_BIKES_PAGE}"                                  "Sanferbike" "ROAD" >> ${OUTPUT_FILE}
process_file "268-supersix?n=${MAX_BIKES_PAGE}"                              "Sanferbike" "ROAD" >> ${OUTPUT_FILE}
process_file "269-shinapse?n=${MAX_BIKES_PAGE}"                              "Sanferbike" "ROAD" >> ${OUTPUT_FILE}
process_file "270-slice?n=${MAX_BIKES_PAGE}"                                 "Sanferbike" "ROAD" >> ${OUTPUT_FILE}
process_file "274-bicicletas-29er?n=${MAX_BIKES_PAGE}"                       "Sanferbike" "MTB-29" >> ${OUTPUT_FILE}
process_file "275-pro-race?n=${MAX_BIKES_PAGE}"                              "Sanferbike" "MTB" >> ${OUTPUT_FILE}
process_file "276-x-control?n=${MAX_BIKES_PAGE}"                             "Sanferbike" "MTB-DOUBLE" >> ${OUTPUT_FILE}
process_file "277-x-flow?n=${MAX_BIKES_PAGE}"                                "Sanferbike" "MTB-DOUBLE" >> ${OUTPUT_FILE}
process_file "278-raid?n=${MAX_BIKES_PAGE}"                                  "Sanferbike" "MTB" >> ${OUTPUT_FILE}
process_file "279-xr?n=${MAX_BIKES_PAGE}"                                    "Sanferbike" "MTB-DOUBLE" >> ${OUTPUT_FILE}
process_file "280-zesty?n=${MAX_BIKES_PAGE}"                                 "Sanferbike" "MTB-DOUBLE" >> ${OUTPUT_FILE}
process_file "281-spicy?n=${MAX_BIKES_PAGE}"                                 "Sanferbike" "MTB-DOUBLE" >> ${OUTPUT_FILE}
process_file "286-b?n=${MAX_BIKES_PAGE}"                                     "Sanferbike" "MTB-29" >> ${OUTPUT_FILE}
process_file "287-anthem?n=${MAX_BIKES_PAGE}"                                "Sanferbike" "MTB-DOUBLE" >> ${OUTPUT_FILE}
process_file "288-bicicleta-montana-maraton?n=${MAX_BIKES_PAGE}"             "Sanferbike" "MTB" >> ${OUTPUT_FILE}
process_file "289-trance?n=${MAX_BIKES_PAGE}"                                "Sanferbike" "MTB-DOUBLE" >> ${OUTPUT_FILE}
process_file "290-talon?n=${MAX_BIKES_PAGE}"                                 "Sanferbike" "MTB" >> ${OUTPUT_FILE}
process_file "291-revel?n=${MAX_BIKES_PAGE}"                                 "Sanferbike" "MTB" >> ${OUTPUT_FILE}
process_file "292-b?n=${MAX_BIKES_PAGE}"                                     "Sanferbike" "MTB-29" >> ${OUTPUT_FILE}
process_file "293-team-elite?n=${MAX_BIKES_PAGE}"                            "Sanferbike" "MTB" >> ${OUTPUT_FILE}
process_file "294-foustroke?n=${MAX_BIKES_PAGE}"                             "Sanferbike" "MTB-DOUBLE" >> ${OUTPUT_FILE}
process_file "295-sport-elite?n=${MAX_BIKES_PAGE}"                           "Sanferbike" "MTB" >> ${OUTPUT_FILE}
process_file "296-speed-fox?n=${MAX_BIKES_PAGE}"                             "Sanferbike" "MTB-DOUBLE" >> ${OUTPUT_FILE}
process_file "298-teammachine?n=${MAX_BIKES_PAGE}"                           "Sanferbike" "ROAD" >> ${OUTPUT_FILE}
process_file "299-roadracer?n=${MAX_BIKES_PAGE}"                             "Sanferbike" "ROAD" >> ${OUTPUT_FILE}
process_file "300-racemachine?n=${MAX_BIKES_PAGE}"                           "Sanferbike" "ROAD" >> ${OUTPUT_FILE}
process_file "301-impec?n=${MAX_BIKES_PAGE}"                                 "Sanferbike" "ROAD" >> ${OUTPUT_FILE}
process_file "302-granfondo?n=${MAX_BIKES_PAGE}"                             "Sanferbike" "ROAD" >> ${OUTPUT_FILE}
process_file "303-trance-29?n=${MAX_BIKES_PAGE}"                             "Sanferbike" "MTB-DOUBLE" >> ${OUTPUT_FILE}
process_file "304-reign?n=${MAX_BIKES_PAGE}"                                 "Sanferbike" "MTB-DOUBLE" >> ${OUTPUT_FILE}
process_file "305-bicis-electricas?n=${MAX_BIKES_PAGE}"                      "Sanferbike" "URBAN" >> ${OUTPUT_FILE}
process_file "306-defy?n=${MAX_BIKES_PAGE}"                                  "Sanferbike" "ROAD" >> ${OUTPUT_FILE}
process_file "307-tcr?n=${MAX_BIKES_PAGE}"                                   "Sanferbike" "ROAD" >> ${OUTPUT_FILE}
process_file "308-trinity?n=${MAX_BIKES_PAGE}"                               "Sanferbike" "ROAD" >> ${OUTPUT_FILE}
process_file "309-flash?n=${MAX_BIKES_PAGE}"                                 "Sanferbike" "MTB" >> ${OUTPUT_FILE}
process_file "310-superx?n=${MAX_BIKES_PAGE}"                                "Sanferbike" "ROAD" >> ${OUTPUT_FILE}
process_file "311-plegables-orbea?n=${MAX_BIKES_PAGE}"                       "Sanferbike" "URBAN" >> ${OUTPUT_FILE}
process_file "318-ofertas-2012-bicis-montana?n=${MAX_BIKES_PAGE}"            "Sanferbike" "MTB"  >> ${OUTPUT_FILE}
process_file "319-carretera-road-ofertas-bicicletas?n=${MAX_BIKES_PAGE}"     "Sanferbike" "ROAD" >> ${OUTPUT_FILE}
process_file "320-ofertas-2013-road?n=${MAX_BIKES_PAGE}"                     "Sanferbike" "ROAD" >> ${OUTPUT_FILE}
process_file "321-ofertas-2013-mtb?n=${MAX_BIKES_PAGE}"                      "Sanferbike" "MTB"  >> ${OUTPUT_FILE}
process_file "322-ofertas-2011-bicis-carretera?n=${MAX_BIKES_PAGE}"          "Sanferbike" "ROAD" >> ${OUTPUT_FILE}
process_file "323-bicis-montana-2011-en-oferta?n=${MAX_BIKES_PAGE}"          "Sanferbike" "MTB"  >> ${OUTPUT_FILE}
process_file "325-tm?n=${MAX_BIKES_PAGE}"                                    "Sanferbike" "ROAD" >> ${OUTPUT_FILE}
process_file "326-tmr?n=${MAX_BIKES_PAGE}"                                   "Sanferbike" "ROAD" >> ${OUTPUT_FILE}
process_file "331-plegables?n=${MAX_BIKES_PAGE}"                             "Sanferbike" "URBAN" >> ${OUTPUT_FILE}
process_file "43-bicicletas?n=${MAX_BIKES_PAGE}"                             "Sanferbike" "ROAD" >> ${OUTPUT_FILE}
