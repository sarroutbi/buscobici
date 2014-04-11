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
MAX_TRIES=10
MAX_TIMEOUT=10

function get_page()
{
  BASE_URL="$1"
  PAGES="$2"
  if [ "${PAGES}" = "" ];
  then
    echo "GETTING PAGE=>${BASE_URL}<="
    wget --tries=${MAX_TRIES} --timeout=${MAX_TIMEOUT} "${BASE_URL}" 
  else
    for page in ${PAGES};
    do
    echo "GETTING PAGE=>${BASE_URL}${page}<="
      wget --tries=${MAX_TRIES} --timeout=${MAX_TIMEOUT} "${BASE_URL}${page}" 
    done 
  fi
}

URBAN_BIKES_BASE="${URL}/carretera/ciudad-bicicletas-urbanas-c1088.html"

MTB_BIKES_BASE="${URL}/mtb/bicicletas-c517.html?page="
MTB_BIKES_PAGES="$(seq 1 5)"

MTB_WOMAN_BASE="${URL}/mujer/bicicletas-c640.html"

ROAD_BIKES_BASE="${URL}/carretera/bicicletas-c616.html?page="
ROAD_BIKES_PAGES="$(seq 1 3)"

BMX_BIKES_BASE="${URL}/bmx/bicicletas-bmx-c673.html?page="
BMX_BIKES_PAGES="$(seq 1 10)"

KIDS00_BIKES_BASE="${URL}/ninos/bicicletas-ninos-bicis-ninos-de-12-a-18-c739.html"
KIDS01_BIKES_BASE="${URL}/ninos/bicicletas-ninos-c692.html"
KIDS02_BIKES_BASE="${URL}/ninos/bicicletas-ninos-bicis-sin-pedales-c693.html"
KIDS03_BIKES_BASE="${URL}/ninos/bicicletas-ninos-cuatriciclos-c696.html"
KIDS04_BIKES_BASE="${URL}/ninos/bicicletas-ninos-triciclos-c697.html"

get_page "${URBAN_BIKES_BASE}"
get_page "${MTB_BIKES_BASE}" "${MTB_BIKES_PAGES}"
get_page "${MTB_WOMAN_BASE}"
get_page "${ROAD_BIKES_BASE}" "${ROAD_BIKES_PAGES}"
get_page "${BMX_BIKES_BASE}" "${BMX_BIKES_PAGES}"
get_page "${KIDS00_BIKES_BASE}"
get_page "${KIDS01_BIKES_BASE}"
get_page "${KIDS02_BIKES_BASE}"
get_page "${KIDS03_BIKES_BASE}"
get_page "${KIDS04_BIKES_BASE}"
