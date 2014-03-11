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

# 
# 1 - URL of site 
# 2 - The Store
function process_file2()
{
  cat "$1" | grep '<h3>' | sed -e 's/<[^>]*>//g' | while read model;
  do
     TYPE=$3
     PRICE=$(grep "${model}" -A20 "${1}" | grep '<span class="price"' | sed -e 's/<[^>]*>//g' | tr -d ' ' | egrep -o -E "[0-9]{2,5},{0,1}[0-9]{0,2}" | head -1)
     TRADEMARK=$(get_trademark "${model}")
     MODEL=$(echo "${model}" | awk {'for(i=2;i<=NF;++i){printf $i; if(i<NF){printf " "}}'})
     URL=$(grep "${model}" -A20 "${1}" | awk -F 'a href=' {'print $2'} | awk {'print $1'} | head -1)
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
       echo 
     fi
  done
} 

> ${OUTPUT_FILE}

process_file2 "164-lap-carretera-hombre?n=${MAX_BIKES_PAGE}"                  "Sanferbike" "ROAD" >> ${OUTPUT_FILE}
process_file2 "165-lap-carretera-mujer?n=${MAX_BIKES_PAGE}"                   "Sanferbike" "ROAD" >> ${OUTPUT_FILE}
process_file2 "166-lap-montana-hombre?n=${MAX_BIKES_PAGE}"                    "Sanferbike" "MTB" >> ${OUTPUT_FILE}
process_file2 "167-lap-montana-mujer?n=${MAX_BIKES_PAGE}"                     "Sanferbike" "MTB" >> ${OUTPUT_FILE}
process_file2 "168-bicicletas-hibridas-mujeres?n=${MAX_BIKES_PAGE}"           "Sanferbike" "URBAN" >> ${OUTPUT_FILE}
process_file2 "169-lap-urbanas?n=${MAX_BIKES_PAGE}"                           "Sanferbike" "URBAN" >> ${OUTPUT_FILE}
process_file2 "173-over-ride-montana-lapierre?n=${MAX_BIKES_PAGE}"            "Sanferbike" "MTB-DOUBLE" >> ${OUTPUT_FILE}
process_file2 "179-orbea-infantil-2013?n=${MAX_BIKES_PAGE}"                   "Sanferbike" "KIDS" >> ${OUTPUT_FILE}
process_file2 "186-hibridas-hombres?n=${MAX_BIKES_PAGE}"                      "Sanferbike" "URBAN" >> ${OUTPUT_FILE}
process_file2 "187-hibridas-mujeres?n=${MAX_BIKES_PAGE}"                      "Sanferbike" "URBAN" >> ${OUTPUT_FILE}
process_file2 "193-bmc-2013-carretera?n=${MAX_BIKES_PAGE}"                    "Sanferbike" "ROAD" >> ${OUTPUT_FILE}
process_file2 "195-all-mountain?n=${MAX_BIKES_PAGE}"                          "Sanferbike" "MTB-DOUBLE" >> ${OUTPUT_FILE}
process_file2 "197-bmc-2013-urbanas-fitness?n=${MAX_BIKES_PAGE}"              "Sanferbike" "URBAN" >> ${OUTPUT_FILE}
process_file2 "198-lapierre-bmx-dirt?n=${MAX_BIKES_PAGE}"                     "Sanferbike" "BMX" >> ${OUTPUT_FILE}
process_file2 "200-mujeres?n=${MAX_BIKES_PAGE}"                               "Sanferbike" "URBAN" >> ${OUTPUT_FILE}
process_file2 "201-orbea-montana-mujer?n=${MAX_BIKES_PAGE}"                   "Sanferbike" "MTB-WOMAN" >> ${OUTPUT_FILE}
process_file2 "204-montana-mujer?n=${MAX_BIKES_PAGE}"                         "Sanferbike" "MTB-WOMAN" >> ${OUTPUT_FILE}
process_file2 "205-carretera?n=${MAX_BIKES_PAGE}"                             "Sanferbike" "ROAD" >> ${OUTPUT_FILE}
process_file2 "206-urbanas?n=${MAX_BIKES_PAGE}"                               "Sanferbike" "URBAN" >> ${OUTPUT_FILE}
process_file2 "207-sport-maraton?n=${MAX_BIKES_PAGE}"                         "Sanferbike" "MTB" >> ${OUTPUT_FILE}
process_file2 "208-all-enduro-cannondale?n=${MAX_BIKES_PAGE}"                 "Sanferbike" "MTB-DOUBLE" >> ${OUTPUT_FILE}
process_file2 "209-over-mountain?n=${MAX_BIKES_PAGE}"                         "Sanferbike" "MTB-DOUBLE" >> ${OUTPUT_FILE}
process_file2 "217-bicicletas-montana-hombre-over-mountain?n=${MAX_BIKES_PAGE}" "Sanferbike" "MTB-DOUBLE" >> ${OUTPUT_FILE}
process_file2 "218-bicicletas-ciudad-urbanas-hombres?n=${MAX_BIKES_PAGE}"     "Sanferbike" "URBAN" >> ${OUTPUT_FILE}
process_file2 "220-bicicletas-hibridas-madrid?n=${MAX_BIKES_PAGE}"            "Sanferbike" "URBAN" >> ${OUTPUT_FILE}
process_file2 "222-bicicletas-ciudad-urbanas-giant?n=${MAX_BIKES_PAGE}"       "Sanferbike" "URBAN" >> ${OUTPUT_FILE}
process_file2 "223-bicicletas-ciudad-urbanas-mujeres?n=${MAX_BIKES_PAGE}"     "Sanferbike" "URBAN" >> ${OUTPUT_FILE}
process_file2 "225-dahon-calidad-plegables?n=${MAX_BIKES_PAGE}"               "Sanferbike" "URBAN" >> ${OUTPUT_FILE}
process_file2 "226-carretera-mujer-2013?n=${MAX_BIKES_PAGE}"                  "Sanferbike" "ROAD" >> ${OUTPUT_FILE}
process_file2 "227-competicion?n=${MAX_BIKES_PAGE}"                           "Sanferbike" "ROAD" >> ${OUTPUT_FILE}
process_file2 "228-rendimiento?n=${MAX_BIKES_PAGE}"                           "Sanferbike" "ROAD" >> ${OUTPUT_FILE}
process_file2 "230-sport?n=${MAX_BIKES_PAGE}"                                 "Sanferbike" "ROAD" >> ${OUTPUT_FILE}
process_file2 "231-fitness?n=${MAX_BIKES_PAGE}"                               "Sanferbike" "ROAD" >> ${OUTPUT_FILE}
process_file2 "232-bicicletas-ciudad-urbanas-mujeres?n=${MAX_BIKES_PAGE}"     "Sanferbike" "URBAN" >> ${OUTPUT_FILE}
process_file2 "233-bici-mujer-cross?n=${MAX_BIKES_PAGE}"                      "Sanferbike" "URBAN" >> ${OUTPUT_FILE}
process_file2 "234-orca?n=${MAX_BIKES_PAGE}"                                  "Sanferbike" "ROAD" >> ${OUTPUT_FILE}
process_file2 "235-aqua?n=${MAX_BIKES_PAGE}"                                  "Sanferbike" "ROAD" >> ${OUTPUT_FILE}
process_file2 "236-onix?n=${MAX_BIKES_PAGE}"                                  "Sanferbike" "ROAD" >> ${OUTPUT_FILE}
process_file2 "237-terra-bicicletas-ciclocross?n=${MAX_BIKES_PAGE}"           "Sanferbike" "ROAD" >> ${OUTPUT_FILE}
process_file2 "238-ordu?n=${MAX_BIKES_PAGE}"                                  "Sanferbike" "ROAD" >> ${OUTPUT_FILE}
process_file2 "239-bicicleta-orca-mujer?n=${MAX_BIKES_PAGE}"                  "Sanferbike" "ROAD" >> ${OUTPUT_FILE}
process_file2 "240-bicicleta-aqua-mujer?n=${MAX_BIKES_PAGE}"                  "Sanferbike" "ROAD" >> ${OUTPUT_FILE}
process_file2 "241-bicicletas-orbea-montana?n=${MAX_BIKES_PAGE}"              "Sanferbike" "MTB-DOUBLE" >> ${OUTPUT_FILE}
process_file2 "242-bicicletas-orbea-montana?n=${MAX_BIKES_PAGE}"              "Sanferbike" "MTB" >> ${OUTPUT_FILE}
process_file2 "243-bicicletas-sport-orbea?n=${MAX_BIKES_PAGE}"                "Sanferbike" "MTB" >> ${OUTPUT_FILE}
process_file2 "245-bicicletas-ciudad-urbanas-orbea?n=${MAX_BIKES_PAGE}"       "Sanferbike" "URBAN" >> ${OUTPUT_FILE}
process_file2 "247-bicicletas-ciudad-urbanas-orbea-carpe?n=${MAX_BIKES_PAGE}" "Sanferbike" "URBAN" >> ${OUTPUT_FILE}
process_file2 "249-bicicletas-ciudad-urbanas-orbea-dude?n=${MAX_BIKES_PAGE}"  "Sanferbike" "URBAN" >> ${OUTPUT_FILE}
process_file2 "251-bicicletas-ciudad-urbanas-orbea-boulevard?n=${MAX_BIKES_PAGE}" "Sanferbike" "URBAN" >> ${OUTPUT_FILE}
process_file2 "255-bicicletas-carretera-fitness-orbea?n=${MAX_BIKES_PAGE}"    "Sanferbike" "URBAN" >> ${OUTPUT_FILE}
process_file2 "257-bicicletas-giant-montana-mujer?n=${MAX_BIKES_PAGE}"        "Sanferbike" "MTB-WOMAN" >> ${OUTPUT_FILE}
process_file2 "258-ruedas-29?n=${MAX_BIKES_PAGE}"                             "Sanferbike" "MTB-29" >> ${OUTPUT_FILE}
process_file2 "259-bicis-29?n=${MAX_BIKES_PAGE}"                              "Sanferbike" "MTB-29" >> ${OUTPUT_FILE}
process_file2 "263-scalpel?n=${MAX_BIKES_PAGE}"                               "Sanferbike" "MTB-DOUBLE" >> ${OUTPUT_FILE}
process_file2 "264-rz?n=${MAX_BIKES_PAGE}"                                    "Sanferbike" "MTB-DOUBLE" >> ${OUTPUT_FILE}
process_file2 "265-trail?n=${MAX_BIKES_PAGE}"                                 "Sanferbike" "MTB" >> ${OUTPUT_FILE}
process_file2 "266-b?n=${MAX_BIKES_PAGE}"                                     "Sanferbike" "MTB-29" >> ${OUTPUT_FILE}
process_file2 "267-caad?n=${MAX_BIKES_PAGE}"                                  "Sanferbike" "ROAD" >> ${OUTPUT_FILE}
process_file2 "268-supersix?n=${MAX_BIKES_PAGE}"                              "Sanferbike" "ROAD" >> ${OUTPUT_FILE}
process_file2 "269-shinapse?n=${MAX_BIKES_PAGE}"                              "Sanferbike" "ROAD" >> ${OUTPUT_FILE}
process_file2 "270-slice?n=${MAX_BIKES_PAGE}"                                 "Sanferbike" "ROAD" >> ${OUTPUT_FILE}
process_file2 "274-bicicletas-29er?n=${MAX_BIKES_PAGE}"                       "Sanferbike" "MTB-29" >> ${OUTPUT_FILE}
process_file2 "275-pro-race?n=${MAX_BIKES_PAGE}"                              "Sanferbike" "MTB" >> ${OUTPUT_FILE}
process_file2 "276-x-control?n=${MAX_BIKES_PAGE}"                             "Sanferbike" "MTB-DOUBLE" >> ${OUTPUT_FILE}
process_file2 "277-x-flow?n=${MAX_BIKES_PAGE}"                                "Sanferbike" "MTB-DOUBLE" >> ${OUTPUT_FILE}
process_file2 "278-raid?n=${MAX_BIKES_PAGE}"                                  "Sanferbike" "MTB" >> ${OUTPUT_FILE}
process_file2 "279-xr?n=${MAX_BIKES_PAGE}"                                    "Sanferbike" "MTB-DOUBLE" >> ${OUTPUT_FILE}
process_file2 "280-zesty?n=${MAX_BIKES_PAGE}"                                 "Sanferbike" "MTB-DOUBLE" >> ${OUTPUT_FILE}
process_file2 "281-spicy?n=${MAX_BIKES_PAGE}"                                 "Sanferbike" "MTB-DOUBLE" >> ${OUTPUT_FILE}
process_file2 "286-b?n=${MAX_BIKES_PAGE}"                                     "Sanferbike" "MTB-29" >> ${OUTPUT_FILE}
process_file2 "287-anthem?n=${MAX_BIKES_PAGE}"                                "Sanferbike" "MTB-DOUBLE" >> ${OUTPUT_FILE}
process_file2 "288-bicicleta-montana-maraton?n=${MAX_BIKES_PAGE}"             "Sanferbike" "MTB" >> ${OUTPUT_FILE}
process_file2 "289-trance?n=${MAX_BIKES_PAGE}"                                "Sanferbike" "MTB-DOUBLE" >> ${OUTPUT_FILE}
process_file2 "290-talon?n=${MAX_BIKES_PAGE}"                                 "Sanferbike" "MTB" >> ${OUTPUT_FILE}
process_file2 "291-revel?n=${MAX_BIKES_PAGE}"                                 "Sanferbike" "MTB" >> ${OUTPUT_FILE}
process_file2 "292-b?n=${MAX_BIKES_PAGE}"                                     "Sanferbike" "MTB-29" >> ${OUTPUT_FILE}
process_file2 "293-team-elite?n=${MAX_BIKES_PAGE}"                            "Sanferbike" "MTB" >> ${OUTPUT_FILE}
process_file2 "294-foustroke?n=${MAX_BIKES_PAGE}"                             "Sanferbike" "MTB-DOUBLE" >> ${OUTPUT_FILE}
process_file2 "295-sport-elite?n=${MAX_BIKES_PAGE}"                           "Sanferbike" "MTB" >> ${OUTPUT_FILE}
process_file2 "296-speed-fox?n=${MAX_BIKES_PAGE}"                             "Sanferbike" "MTB-DOUBLE" >> ${OUTPUT_FILE}
process_file2 "298-teammachine?n=${MAX_BIKES_PAGE}"                           "Sanferbike" "ROAD" >> ${OUTPUT_FILE}
process_file2 "299-roadracer?n=${MAX_BIKES_PAGE}"                             "Sanferbike" "ROAD" >> ${OUTPUT_FILE}
process_file2 "300-racemachine?n=${MAX_BIKES_PAGE}"                           "Sanferbike" "ROAD" >> ${OUTPUT_FILE}
process_file2 "301-impec?n=${MAX_BIKES_PAGE}"                                 "Sanferbike" "ROAD" >> ${OUTPUT_FILE}
process_file2 "302-granfondo?n=${MAX_BIKES_PAGE}"                             "Sanferbike" "ROAD" >> ${OUTPUT_FILE}
process_file2 "303-trance-29?n=${MAX_BIKES_PAGE}"                             "Sanferbike" "MTB-DOUBLE" >> ${OUTPUT_FILE}
process_file2 "304-reign?n=${MAX_BIKES_PAGE}"                                 "Sanferbike" "MTB-DOUBLE" >> ${OUTPUT_FILE}
process_file2 "305-bicis-electricas?n=${MAX_BIKES_PAGE}"                      "Sanferbike" "URBAN" >> ${OUTPUT_FILE}
process_file2 "306-defy?n=${MAX_BIKES_PAGE}"                                  "Sanferbike" "ROAD" >> ${OUTPUT_FILE}
process_file2 "307-tcr?n=${MAX_BIKES_PAGE}"                                   "Sanferbike" "ROAD" >> ${OUTPUT_FILE}
process_file2 "308-trinity?n=${MAX_BIKES_PAGE}"                               "Sanferbike" "ROAD" >> ${OUTPUT_FILE}
process_file2 "309-flash?n=${MAX_BIKES_PAGE}"                                 "Sanferbike" "MTB" >> ${OUTPUT_FILE}
process_file2 "310-superx?n=${MAX_BIKES_PAGE}"                                "Sanferbike" "ROAD" >> ${OUTPUT_FILE}
process_file2 "311-plegables-orbea?n=${MAX_BIKES_PAGE}"                       "Sanferbike" "URBAN" >> ${OUTPUT_FILE}
process_file2 "318-ofertas-2012-bicis-montana?n=${MAX_BIKES_PAGE}"            "Sanferbike" "MTB"  >> ${OUTPUT_FILE}
process_file2 "319-carretera-road-ofertas-bicicletas?n=${MAX_BIKES_PAGE}"     "Sanferbike" "ROAD" >> ${OUTPUT_FILE}
process_file2 "320-ofertas-2013-road?n=${MAX_BIKES_PAGE}"                     "Sanferbike" "ROAD" >> ${OUTPUT_FILE}
process_file2 "321-ofertas-2013-mtb?n=${MAX_BIKES_PAGE}"                      "Sanferbike" "MTB"  >> ${OUTPUT_FILE}
process_file2 "322-ofertas-2011-bicis-carretera?n=${MAX_BIKES_PAGE}"          "Sanferbike" "ROAD" >> ${OUTPUT_FILE}
process_file2 "323-bicis-montana-2011-en-oferta?n=${MAX_BIKES_PAGE}"          "Sanferbike" "MTB"  >> ${OUTPUT_FILE}
process_file2 "325-tm?n=${MAX_BIKES_PAGE}"                                    "Sanferbike" "ROAD" >> ${OUTPUT_FILE}
process_file2 "326-tmr?n=${MAX_BIKES_PAGE}"                                   "Sanferbike" "ROAD" >> ${OUTPUT_FILE}
process_file2 "331-plegables?n=${MAX_BIKES_PAGE}"                             "Sanferbike" "URBAN" >> ${OUTPUT_FILE}
process_file2 "43-bicicletas?n=${MAX_BIKES_PAGE}"                             "Sanferbike" "ROAD" >> ${OUTPUT_FILE}

# MTB-DOUBLE
process_file2 "474-scalpel-2014?n=${MAX_BIKES_PAGE}"                      "Sanferbike" "MTB-DOUBLE" >> ${OUTPUT_FILE}
process_file2 "475-rush-cannondale-2014?n=${MAX_BIKES_PAGE}"              "Sanferbike" "MTB-DOUBLE" >> ${OUTPUT_FILE}
process_file2 "455-over-mountain-cannondale-2014?n=${MAX_BIKES_PAGE}"     "Sanferbike" "MTB-DOUBLE" >> ${OUTPUT_FILE}
process_file2 "497-xc?n=${MAX_BIKES_PAGE}"                                "Sanferbike" "MTB-DOUBLE" >> ${OUTPUT_FILE}
process_file2 "498-xr?n=${MAX_BIKES_PAGE}"                                "Sanferbike" "MTB-DOUBLE" >> ${OUTPUT_FILE}
process_file2 "500-zt?n=${MAX_BIKES_PAGE}"                                "Sanferbike" "MTB-DOUBLE" >> ${OUTPUT_FILE}
process_file2 "501-sp?n=${MAX_BIKES_PAGE}"                                "Sanferbike" "MTB-DOUBLE" >> ${OUTPUT_FILE}
process_file2 "494-big-mountain-lapierre?n=${MAX_BIKES_PAGE}"             "Sanferbike" "MTB-DOUBLE" >> ${OUTPUT_FILE}
process_file2 "418-occam-2014?n=${MAX_BIKES_PAGE}"                        "Sanferbike" "MTB-DOUBLE" >> ${OUTPUT_FILE}
process_file2 "390-nuevas-orbea-oiz-2014?n=${MAX_BIKES_PAGE}"             "Sanferbike" "MTB-DOUBLE" >> ${OUTPUT_FILE}
process_file2 "530-giant-2014?n=${MAX_BIKES_PAGE}"                        "Sanferbike" "MTB-DOUBLE" >> ${OUTPUT_FILE}
process_file2 "544-all?n=${MAX_BIKES_PAGE}"                               "Sanferbike" "MTB-DOUBLE" >> ${OUTPUT_FILE}
process_file2 "379-trailfox-montana-bmc?n=${MAX_BIKES_PAGE}"              "Sanferbike" "MTB-DOUBLE" >> ${OUTPUT_FILE}
 
# MTB-FIX
process_file2 "477-bicicletas-flash?n=${MAX_BIKES_PAGE}"                  "Sanferbike" "MTB" >> ${OUTPUT_FILE}
process_file2 "476-trail-cannondale-2014?n=${MAX_BIKES_PAGE}"             "Sanferbike" "MTB" >> ${OUTPUT_FILE}
process_file2 "495-pro?n=${MAX_BIKES_PAGE}"                               "Sanferbike" "MTB" >> ${OUTPUT_FILE}
process_file2 "496-ra?n=${MAX_BIKES_PAGE}"                                "Sanferbike" "MTB" >> ${OUTPUT_FILE}
process_file2 "393-nuevas-orbea-alma-2014?n=${MAX_BIKES_PAGE}"            "Sanferbike" "MTB" >> ${OUTPUT_FILE}
process_file2 "395-nuevas-orbea-sport-2014?n=${MAX_BIKES_PAGE}"           "Sanferbike" "MTB" >> ${OUTPUT_FILE}
process_file2 "385-nuevas-orbea-mx-2014?n=${MAX_BIKES_PAGE}"              "Sanferbike" "MTB" >> ${OUTPUT_FILE}
process_file2 "533-giant-2014?n=${MAX_BIKES_PAGE}"                        "Sanferbike" "MTB" >> ${OUTPUT_FILE}
process_file2 "543-revel-2014?n=${MAX_BIKES_PAGE}"                        "Sanferbike" "MTB" >> ${OUTPUT_FILE}
process_file2 "547-x?n=${MAX_BIKES_PAGE}"                                 "Sanferbike" "MTB" >> ${OUTPUT_FILE}
process_file2 "378-sportelite-montana-bmc?n=${MAX_BIKES_PAGE}"            "Sanferbike" "MTB" >> ${OUTPUT_FILE}
                                                                                               
# MTB-29
process_file2 "472-bicis-29-cannondale-2014?n=${MAX_BIKES_PAGE}"          "Sanferbike" "MTB-29" >> ${OUTPUT_FILE}
process_file2 "499-l29?n=${MAX_BIKES_PAGE}"                               "Sanferbike" "MTB-29" >> ${OUTPUT_FILE}
process_file2 "481-b?n=${MAX_BIKES_PAGE}"                                 "Sanferbike" "MTB-29" >> ${OUTPUT_FILE}
process_file2 "375-bmc-montana-foustroke?n=${MAX_BIKES_PAGE}"             "Sanferbike" "MTB-29" >> ${OUTPUT_FILE}
process_file2 "374-bmc-montana-teamelite?n=${MAX_BIKES_PAGE}"             "Sanferbike" "MTB-29" >> ${OUTPUT_FILE}
                                                                                               
# MTB-27'5
process_file2 "508-bi?n=${MAX_BIKES_PAGE}"                                "Sanferbike" "MTB-27-5" >> ${OUTPUT_FILE}
process_file2 "484-bicis-27?n=${MAX_BIKES_PAGE}"                          "Sanferbike" "MTB-27-5" >> ${OUTPUT_FILE}
process_file2 "483-bi?n=${MAX_BIKES_PAGE}"                                "Sanferbike" "MTB-27-5" >> ${OUTPUT_FILE}
     
# MTB-WOMAN
process_file2 "465-montana-mujer-cannondale-2014?n=${MAX_BIKES_PAGE}"     "Sanferbike" "MTB-WOMAN" >> ${OUTPUT_FILE}
process_file2 "487-montana-mujer-lap?n=${MAX_BIKES_PAGE}"                 "Sanferbike" "MTB-WOMAN" >> ${OUTPUT_FILE}
process_file2 "482-montana-mujer?n=${MAX_BIKES_PAGE}"                     "Sanferbike" "MTB-WOMAN" >> ${OUTPUT_FILE}
process_file2 "538-m?n=${MAX_BIKES_PAGE}"                                 "Sanferbike" "MTB-WOMAN" >> ${OUTPUT_FILE}
process_file2 "518-hibridas-mujeres?n=${MAX_BIKES_PAGE}"                  "Sanferbike"  "URBAN" >> ${OUTPUT_FILE}

# ROAD
process_file2 "462-carretera-hombre-cannondale-2014?n=${MAX_BIKES_PAGE}"     "Sanferbike" "ROAD" >> ${OUTPUT_FILE}
process_file2 "488-bicis-carretera-hombre-lapierre-2014?n=${MAX_BIKES_PAGE}" "Sanferbike" "ROAD" >> ${OUTPUT_FILE}
process_file2 "406-orbea-road?n=${MAX_BIKES_PAGE}"                           "Sanferbike" "ROAD" >> ${OUTPUT_FILE}
process_file2 "539-car?n=${MAX_BIKES_PAGE}"                                  "Sanferbike" "ROAD" >> ${OUTPUT_FILE}
process_file2 "365-nuevas-bmc-carretera?n=${MAX_BIKES_PAGE}"                 "Sanferbike" "ROAD" >> ${OUTPUT_FILE}
                                                                                               
# ROAD-WOMAN
process_file2 "458-carretera-mujer-2014?n=${MAX_BIKES_PAGE}"              "Sanferbike" "ROAD-WOMAN" >> ${OUTPUT_FILE}
process_file2 "489-cml?n=${MAX_BIKES_PAGE}"                               "Sanferbike" "ROAD-WOMAN" >> ${OUTPUT_FILE}
process_file2 "485-carretera-mujer-2014?n=${MAX_BIKES_PAGE}"              "Sanferbike" "ROAD-WOMAN" >> ${OUTPUT_FILE}
process_file2 "540-car?n=${MAX_BIKES_PAGE}"                               "Sanferbike" "ROAD-WOMAN" >> ${OUTPUT_FILE}
                                                                                               
# URBAN
process_file2 "478-urbanas-cannondale-2014?n=${MAX_BIKES_PAGE}"           "Sanferbike"  "URBAN" >> ${OUTPUT_FILE}
process_file2 "527-electricas-cannondale?n=${MAX_BIKES_PAGE}"             "Sanferbike"  "URBAN" >> ${OUTPUT_FILE}
process_file2 "490-ul?n=${MAX_BIKES_PAGE}"                                "Sanferbike"  "URBAN" >> ${OUTPUT_FILE}
process_file2 "412-urban?n=${MAX_BIKES_PAGE}"                             "Sanferbike"  "URBAN" >> ${OUTPUT_FILE}
process_file2 "550-h?n=${MAX_BIKES_PAGE}"                                 "Sanferbike"  "URBAN" >> ${OUTPUT_FILE}
process_file2 "541-e?n=${MAX_BIKES_PAGE}"                                 "Sanferbike"  "URBAN" >> ${OUTPUT_FILE}
process_file2 "517-brompton-2014?n=${MAX_BIKES_PAGE}"                     "Sanferbike"  "URBAN" >> ${OUTPUT_FILE}
process_file2 "225-dahon-calidad-plegables?n=${MAX_BIKES_PAGE}"           "Sanferbike"  "URBAN" >> ${OUTPUT_FILE}
process_file2 "528-bicis-plegables?n=${MAX_BIKES_PAGE}"                   "Sanferbike"  "URBAN" >> ${OUTPUT_FILE}
process_file2 "305-bicis-electricas?n=${MAX_BIKES_PAGE}"                  "Sanferbike"  "URBAN" >> ${OUTPUT_FILE}
                                                                                               
# KIDS
process_file2 "479-cannondale-para-ninos?n=${MAX_BIKES_PAGE}"             "Sanferbike"  "KIDS" >> ${OUTPUT_FILE}
process_file2 "507-n?n=${MAX_BIKES_PAGE}"                                 "Sanferbike"  "KIDS" >> ${OUTPUT_FILE}
process_file2 "405-nuevas-orbea-mx-2014?n=${MAX_BIKES_PAGE}"              "Sanferbike"  "KIDS" >> ${OUTPUT_FILE}
process_file2 "536-ninos?n=${MAX_BIKES_PAGE}"                             "Sanferbike"  "KIDS" >> ${OUTPUT_FILE}

# 2014 REVIEW
process_file2 "11058-bicicletas-cannondale-trigger-2014?n=${MAX_BIKES_PAGE}" "Sanferbike" "MTB-DOUBLE" >> ${OUTPUT_FILE}
process_file2 "11059-bicicletas-cannondale-jekyll-2014?n=${MAX_BIKES_PAGE}" "Sanferbike" "MTB-DOUBLE" >> ${OUTPUT_FILE}
process_file2 "463-sport-maraton-cannondale-2014?n=${MAX_BIKES_PAGE}" "Sanferbike" "MTB-DOUBLE" >> ${OUTPUT_FILE}
process_file2 "466-caad-cannondale-2014?n=${MAX_BIKES_PAGE}" "Sanferbike" "ROAD" >> ${OUTPUT_FILE}
process_file2 "468-cannondale-supersix-2014?n=${MAX_BIKES_PAGE}" "Sanferbike" "ROAD" >> ${OUTPUT_FILE}
process_file2 "457-synapse-cannondale?n=${MAX_BIKES_PAGE}" "Sanferbike" "ROAD" >> ${OUTPUT_FILE}
process_file2 "470-superx-2014?n=${MAX_BIKES_PAGE}" "Sanferbike" "ROAD" >> ${OUTPUT_FILE}
process_file2 "469-slice-2014?n=${MAX_BIKES_PAGE}" "Sanferbike" "ROAD" >> ${OUTPUT_FILE}
process_file2 "524-bad-boys?n=${MAX_BIKES_PAGE}" "Sanferbike" "URBAN" >> ${OUTPUT_FILE}
process_file2 "525-tesoro?n=${MAX_BIKES_PAGE}" "Sanferbike" "URBAN" >> ${OUTPUT_FILE}
process_file2 "526-quick?n=${MAX_BIKES_PAGE}" "Sanferbike" "URBAN" >> ${OUTPUT_FILE}
process_file2 "480-tandem-cannondale?n=${MAX_BIKES_PAGE}" "Sanferbike" "URBAN-TANDEM" >> ${OUTPUT_FILE}
process_file2 "492-xml?n=${MAX_BIKES_PAGE}" "Sanferbike" "MTB" >> ${OUTPUT_FILE}
process_file2 "493-aml?n=${MAX_BIKES_PAGE}" "Sanferbike" "MTB-DOUBLE" >> ${OUTPUT_FILE}
process_file2 "512-bi?n=${MAX_BIKES_PAGE}" "Sanferbike" "MTB-WOMAN" >> ${OUTPUT_FILE}
process_file2 "513-bi?n=${MAX_BIKES_PAGE}" "Sanferbike" "MTB-WOMAN" >> ${OUTPUT_FILE}
process_file2 "502-au?n=${MAX_BIKES_PAGE}" "Sanferbike"  "ROAD" >> ${OUTPUT_FILE}
process_file2 "503-sen?n=${MAX_BIKES_PAGE}" "Sanferbike" "ROAD" >> ${OUTPUT_FILE}
process_file2 "504-xel?n=${MAX_BIKES_PAGE}" "Sanferbike" "ROAD" >> ${OUTPUT_FILE}
process_file2 "505-cc?n=${MAX_BIKES_PAGE}" "Sanferbike"  "ROAD" >> ${OUTPUT_FILE}
process_file2 "506-sha?n=${MAX_BIKES_PAGE}" "Sanferbike" "ROAD" >> ${OUTPUT_FILE}
process_file2 "388-nuevas-orbea-alma-2014?n=${MAX_BIKES_PAGE}" "Sanferbike" "MTB" >> ${OUTPUT_FILE}
process_file2 "389-alma-27?n=${MAX_BIKES_PAGE}" "Sanferbike" "MTB" >> ${OUTPUT_FILE}
process_file2 "387-nuevas-orbea-alma-2014?n=${MAX_BIKES_PAGE}" "Sanferbike" "MTB" >> ${OUTPUT_FILE}
process_file2 "381-aqua-2014?n=${MAX_BIKES_PAGE}" "Sanferbike" "ROAD" >> ${OUTPUT_FILE}
process_file2 "382-orca-2014?n=${MAX_BIKES_PAGE}" "Sanferbike" "ROAD" >> ${OUTPUT_FILE}
process_file2 "383-nuevas-orbea-avant-2014?n=${MAX_BIKES_PAGE}" "Sanferbike" "ROAD" >> ${OUTPUT_FILE}
process_file2 "384-nuevas-orbea-ordu-2014?n=${MAX_BIKES_PAGE}" "Sanferbike" "ROAD" >> ${OUTPUT_FILE}
process_file2 "11063-avant-dama-2014?n=${MAX_BIKES_PAGE}" "Sanferbike" "ROAD-WOMAN" >> ${OUTPUT_FILE}
process_file2 "11064-orca-dama-2014?n=${MAX_BIKES_PAGE}" "Sanferbike" "ROAD-WOMAN" >> ${OUTPUT_FILE}
process_file2 "394-nuevas-orbea-boulevard-2014?n=${MAX_BIKES_PAGE}" "Sanferbike" "URBAN" >> ${OUTPUT_FILE}
process_file2 "401-nuevas-orbea-rude-2014?n=${MAX_BIKES_PAGE}" "Sanferbike" "BMX" >> ${OUTPUT_FILE}
process_file2 "447-fixie-carpe-2014?n=${MAX_BIKES_PAGE}" "Sanferbike" "ROAD" >> ${OUTPUT_FILE}
process_file2 "448-dude?n=${MAX_BIKES_PAGE}" "Sanferbike" "URBAN" >> ${OUTPUT_FILE}
process_file2 "403-nuevas-orbea-folding-2014?n=${MAX_BIKES_PAGE}" "Sanferbike" "URBAN-FOLDING" >> ${OUTPUT_FILE}
process_file2 "410-all-use?n=${MAX_BIKES_PAGE}" "Sanferbike" "URBAN" >> ${OUTPUT_FILE}
process_file2 "398-nuevas-orbea-confort-2014?n=${MAX_BIKES_PAGE}" "Sanferbike" "URBAN" >> ${OUTPUT_FILE}
process_file2 "397-nuevas-orbea-confort-2014?n=${MAX_BIKES_PAGE}" "Sanferbike" "URBAN" >> ${OUTPUT_FILE}
process_file2 "446-travel-2014?n=${MAX_BIKES_PAGE}" "Sanferbike" "URBAN" >> ${OUTPUT_FILE}
process_file2 "521-comfort-28-dama-2014?n=${MAX_BIKES_PAGE}" "Sanferbike" "URBAN-WOMAN" >> ${OUTPUT_FILE}
process_file2 "522-comfort-26-dama-2014?n=${MAX_BIKES_PAGE}" "Sanferbike" "URBAN-WOMAN" >> ${OUTPUT_FILE}
process_file2 "523-travel-dama-2014?n=${MAX_BIKES_PAGE}" "Sanferbike" "URBAN-WOMAN" >> ${OUTPUT_FILE}
process_file2 "542-s?n=${MAX_BIKES_PAGE}" "Sanferbike" "MTB-FIX" >> ${OUTPUT_FILE}
process_file2 "545-reign-2014?n=${MAX_BIKES_PAGE}" "Sanferbike"  "MTB-DOUBLE" >> ${OUTPUT_FILE}
process_file2 "546-trance-2014?n=${MAX_BIKES_PAGE}" "Sanferbike" "MTB-DOUBLE" >> ${OUTPUT_FILE}
process_file2 "534-giant-2014?n=${MAX_BIKES_PAGE}" "Sanferbike"  "ROAD" >> ${OUTPUT_FILE}
process_file2 "548-trinity-14?n=${MAX_BIKES_PAGE}" "Sanferbike"  "ROAD" >> ${OUTPUT_FILE}
process_file2 "549-defy-14?n=${MAX_BIKES_PAGE}" "Sanferbike"     "ROAD" >> ${OUTPUT_FILE}
process_file2 "535-giant-2014?n=${MAX_BIKES_PAGE}" "Sanferbike"  "ROAD" >> ${OUTPUT_FILE}
process_file2 "371-bmc-timemachine-carretera?n=${MAX_BIKES_PAGE}" "Sanferbike" "ROAD" >> ${OUTPUT_FILE}
process_file2 "372-bmc-road-trackmachine?n=${MAX_BIKES_PAGE}" "Sanferbike" "ROAD" >> ${OUTPUT_FILE}
process_file2 "366-nuevas-bicis-bmc?n=${MAX_BIKES_PAGE}" "Sanferbike" "ROAD" >> ${OUTPUT_FILE}
process_file2 "370-bicis-grandfondo-carretera-bmc?n=${MAX_BIKES_PAGE}" "Sanferbike" "ROAD" >> ${OUTPUT_FILE}
process_file2 "369-bicicletas-2014-bmc-teammachine?n=${MAX_BIKES_PAGE}" "Sanferbike" "ROAD" >> ${OUTPUT_FILE}
process_file2 "551-trailfox-2014?n=${MAX_BIKES_PAGE}" "Sanferbike" "MTB-DOUBLE" >> ${OUTPUT_FILE}
process_file2 "509-sport-maraton?n=${MAX_BIKES_PAGE}" "Sanferbike" "MTB-29" >> ${OUTPUT_FILE}
process_file2 "376-urbanas-bmc?n=${MAX_BIKES_PAGE}" "Sanferbike" "URBAN" >> ${OUTPUT_FILE}
process_file2 "377-urbanas-bmc?n=${MAX_BIKES_PAGE}" "Sanferbike" "URBAN" >> ${OUTPUT_FILE}