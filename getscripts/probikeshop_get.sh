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
# This script gets all the bicycles from
# Probikeshop store !
# URL: www.probikeshop.es
URL="http://www.probikeshop.es"
ONLY_DOMAIN="probikeshop.es"
EXCLUDE="-Rgif -Rpng -Rjpg"
MAX_TRIES=15
MAX_TIMEOUT=15
MAX_WGET_TRIES=10

# include common functions
. ./common_get

function get_page()
{
  let counter=0 
  let result=1
  BASE_URL="$1"
  PAGES="$2"
  if [ "${PAGES}" = "" ];
  then
    echo "GETTING PAGE=>${BASE_URL}<="
    while [ $counter -le ${MAX_WGET_TRIES} -a $result -ne 0 ]; do
      wget --retry-connrefused -w5 --random-wait -e robots=off -U 'mozilla' --tries=${MAX_TRIES} --timeout=${MAX_TIMEOUT} "${BASE_URL}" 
      result=$?
      echo "RESULT:${result},WGET_TRIES:${counter}<="
      let counter=$counter+1
    done
  else
    for page in ${PAGES};
    do
    echo "GETTING PAGE=>${BASE_URL}${page}<="
      while [ $counter -le ${MAX_WGET_TRIES} -a $result -ne 0 ]; do
        wget --retry-connrefused -w5 --random-wait -e robots=off -U 'mozilla' --tries=${MAX_TRIES} --timeout=${MAX_TIMEOUT} "${BASE_URL}${page}" 
        result=$?
        echo "RESULT:${result},WGET_TRIES:${counter}<="
        let counter=$counter+1
      done
     let counter=0 
     let result=1
    done 
  fi
}

URBAN_BIKES_FILE="ciudad-bicicletas-urbanas-c3656.html"
URBAN_BIKES_BASE="${URL}/carretera/${URBAN_BIKES_FILE}"

MTB_BIKES_FILE="bicicletas-c517.html?page="
MTB_BIKES_BASE="${URL}/mtb/${MTB_BIKES_FILE}"
MTB_BIKES_PAGES="$(seq -s ' ' 1 7)"

MTB_WOMAN_FILE="bicicletas-c640.html"
MTB_WOMAN_BASE="${URL}/mujer/${MTB_WOMAN_FILE}"

ROAD_BIKES_FILE="bicicletas-c616.html?page="
ROAD_BIKES_BASE="${URL}/carretera/${ROAD_BIKES_FILE}"
ROAD_BIKES_PAGES="$(seq -s ' ' 1 3)"

BMX_BIKES_FILE="bicicletas-bmx-c673.html?page="
BMX_BIKES_BASE="${URL}/bmx/${BMX_BIKES_FILE}"
BMX_BIKES_PAGES="$(seq -s ' ' 1 10)"

KIDS00_BIKES_FILE="bicicletas-ninos-bicis-ninos-de-12-a-18-c739.html"
KIDS01_BIKES_FILE="bicicletas-ninos-c692.html"
KIDS01B_BIKES_FILE="bicis-de-aprendizaje-patinetes-c698.html"
KIDS02_BIKES_FILE="bicis-de-aprendizaje-sin-pedales-c693.html?page="
KIDS03_BIKES_FILE="bicis-de-aprendizaje-cuatriciclos-c696.html"
KIDS04_BIKES_FILE="bicis-de-aprendizaje-triciclos-c697.html"
KIDS05_BIKES_FILE="bicicletas-ninos-bmx-ninos-c3489.html"
KIDS06_BIKES_FILE="bicicletas-ninos-bicis-ninos-de-12-a-14-c739.html"
KIDS07_BIKES_FILE="bicicletas-ninos-bicis-ninos-de-16-a-18-c3490.html"
KIDS08_BIKES_FILE="bicicletas-ninos-bicis-ninos-de-20-c757.html"
KIDS09_BIKES_FILE="bicicletas-ninos-bicis-ninos-de-24-c3491.html"

KIDS00_BIKES_BASE="${URL}/ninos/${KIDS00_BIKES_FILE}"
KIDS01_BIKES_BASE="${URL}/ninos/${KIDS01_BIKES_FILE}"
KIDS01B_BIKES_BASE="${URL}/ninos/${KIDS01B_BIKES_FILE}"
KIDS02_BIKES_BASE="${URL}/ninos/${KIDS02_BIKES_FILE}"
KIDS02_BIKES_PAGES="$(seq -s ' ' 1 3)"
KIDS03_BIKES_BASE="${URL}/ninos/${KIDS03_BIKES_FILE}"
KIDS04_BIKES_BASE="${URL}/ninos/${KIDS04_BIKES_FILE}"
KIDS05_BIKES_BASE="${URL}/ninos/${KIDS05_BIKES_FILE}"
KIDS06_BIKES_BASE="${URL}/ninos/${KIDS06_BIKES_FILE}"
KIDS07_BIKES_BASE="${URL}/ninos/${KIDS07_BIKES_FILE}"
KIDS08_BIKES_BASE="${URL}/ninos/${KIDS08_BIKES_FILE}"
KIDS09_BIKES_BASE="${URL}/ninos/${KIDS09_BIKES_FILE}"

bubic_get_page_js  "${URBAN_BIKES_BASE}" "${URBAN_BIKES_FILE}"
bubic_get_pages_js "${MTB_BIKES_BASE}" "${MTB_BIKES_FILE}" "${MTB_BIKES_PAGES}"
bubic_get_page_js  "${MTB_WOMAN_BASE}" "${MTB_WOMAN_FILE}"
bubic_get_pages_js "${ROAD_BIKES_BASE}" "${ROAD_BIKES_FILE}" "${ROAD_BIKES_PAGES}"
bubic_get_pages_js "${BMX_BIKES_BASE}"  "${BMX_BIKES_FILE}" "${BMX_BIKES_PAGES}"
bubic_get_page_js  "${KIDS00_BIKES_BASE}" "${KIDS00_BIKES_FILE}"
bubic_get_page_js  "${KIDS01_BIKES_BASE}" "${KIDS01_BIKES_FILE}"
bubic_get_page_js  "${KIDS01B_BIKES_BASE}" "${KIDS01B_BIKES_FILE}"
bubic_get_pages_js "${KIDS02_BIKES_BASE}" "${KIDS02_BIKES_FILE}" "${KIDS02_BIKES_PAGES}"
bubic_get_page_js  "${KIDS03_BIKES_BASE}" "${KIDS03_BIKES_FILE}"
bubic_get_page_js  "${KIDS04_BIKES_BASE}" "${KIDS04_BIKES_FILE}"
bubic_get_page_js  "${KIDS05_BIKES_BASE}" "${KIDS05_BIKES_FILE}"
bubic_get_page_js  "${KIDS06_BIKES_BASE}" "${KIDS06_BIKES_FILE}"
bubic_get_page_js  "${KIDS07_BIKES_BASE}" "${KIDS07_BIKES_FILE}"
bubic_get_page_js  "${KIDS08_BIKES_BASE}" "${KIDS08_BIKES_FILE}"
bubic_get_page_js  "${KIDS09_BIKES_BASE}" "${KIDS09_BIKES_FILE}"
