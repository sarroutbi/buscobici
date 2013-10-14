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
# Biciescapa store !
#
URL="www.csbike.es"
ONLY_DOMAIN="csbike.es"
MAX_TRIES=10
MAX_TIMEOUT=10

function get_page()
{
  BASE_URL="$1"
  PAGES="$2"
  OUTPUT_FILE="$3"
  
  if [ "${OUTPUT_FILE}" = "" ];
  then
    OUT_OPTION=""    
  else
    OUT_OPTION="-O${3}" 
  fi

  if [ "${PAGES}" = "" ];
  then
    wget --tries=${MAX_TRIES} --timeout=${MAX_TIMEOUT} "${BASE_URL}" "${OUT_OPTION}_${page}"
  else
    for page in ${PAGES};
    do
      wget --tries=${MAX_TRIES} --timeout=${MAX_TIMEOUT} "${BASE_URL}${page}" "${OUT_OPTION}_${page}"
    done 
  fi
}

ROAD_BIKES_BASE="${URL}/products/index/bicicletas/carretera/page:"
ROAD_BIKES_PAGES="$(seq 1 2)"

MTB_DOUBLE_BIKES_BASE="${URL}/products/index/bicicletas/mtb_dobles/page:"
MTB_DOUBLE_BIKES_PAGES="$(seq 1 3)"

MTB_DOUBLE_BIKES_CARBON_BASE="${URL}/products/index/bicicletas/mtb_dobles_carbono/page:"
MTB_DOUBLE_BIKES_CARBON_PAGES="$(seq 1 2)"

MTB_FIX_BIKES_BASE="${URL}/products/index/bicicletas/mtb_rigidas/page:"
MTB_FIX_BIKES_PAGES="$(seq 1 5)"

MTB_DOWNHILL_BIKES_BASE="${URL}/products/index/bicicletas/descenso/page:"
MTB_DOWNHILL_BIKES_PAGES="$(seq 1 2)"

MTB_FIX_BIKES_CARBON_BASE="${URL}/products/index/bicicletas/mtb_rigidas_carbono/page:"
MTB_FIX_BIKES_CARBON_PAGES="$(seq 1 2)"

MTB_WOMAN_BIKES_BASE="${URL}/products/index/bicicletas/coluer/page:" 
MTB_WOMAN_BIKES_PAGES="$(seq 1 1)"

KIDS_BIKES_BASE="${URL}/products/index/bicicletas/ninos/page:" 
KIDS_BIKES_PAGES="$(seq 1 2)"

get_page "${ROAD_BIKES_BASE}"        "${ROAD_BIKES_PAGES}"       "road_bikes"
get_page "${MTB_DOUBLE_BIKES_BASE}"  "${MTB_DOUBLE_BIKES_PAGES}" "mtb_double_bikes"
get_page "${MTB_FIX_BIKES_BASE}"     "${MTB_FIX_BIKES_PAGES}"    "mtb_fix_bikes"
get_page "${MTB_WOMAN_BIKES_BASE}"   "${MTB_WOMAN_BIKES_PAGES}"  "mtb_woman_bikes"
get_page "${KIDS_BIKES_BASE}"        "${KIDS_BIKES_PAGES}"       "kids_bikes"
get_page "${MTB_DOUBLE_BIKES_CARBON_BASE}" "${MTB_DOUBLE_BIKES_CARBON_PAGES}" "mtb_double_bikes_carbon"
get_page "${MTB_FIX_BIKES_CARBON_BASE}"    "${MTB_FIX_BIKES_CARBON_PAGES}"    "mtb_fix_bikes_carbon"
get_page "${MTB_DOWNHILL_BIKES_BASE}" "${MTB_DOWNHILL_BIKES_PAGES}" "mtb_downhill_bikes"
