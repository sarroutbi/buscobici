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
URL="www.biciescapa.com"
ONLY_DOMAIN="biciescapa.com"
MAX_TRIES=10
MAX_TIMEOUT=10

function get_page()
{
  BASE_URL="$1"
  PAGES="$2"
  if [ "${PAGES}" = "" ];
  then
    wget --tries=${MAX_TRIES} --timeout=${MAX_TIMEOUT} "${BASE_URL}" 
  else
    for page in ${PAGES};
    do
      wget --tries=${MAX_TRIES} --timeout=${MAX_TIMEOUT} "${BASE_URL}${page}" 
    done 
  fi
}

MTB_FIX_BIKES_BASE="${URL}/lang-es/12-bicicletas-rigidas?p="
MTB_FIX_BIKES_PAGES="$(seq 1 10)"

MTB_DOUBLE_BIKES_BASE="${URL}/lang-es/14-doble-suspensio?p="
MTB_DOUBLE_BIKES_PAGES="$(seq 1 5)"

MTB_DOWN_BIKES_BASE="${URL}/lang-es/13-descenso"
MTB_DOWN_BIKES_PAGES=""

MTB_ELECTRIC_BIKES_BASE="${URL}/lang-es/55932276-btt-electricas"
MTB_ELECTRIC_BIKES_PAGES=""

ROAD_BIKES_BASE="${URL}/lang-es/8-carretera?p="
ROAD_BIKES_PAGES="$(seq 1 5)"

BMX_BIKES_BASE="${URL}/lang-es/9-bmx-freestyle"
BMX_BIKES_PAGES=""

URBAN_BIKES_BASE="${URL}/lang-es/10-bicicletas-paseo-electricas?p="
URBAN_BIKES_PAGES="$(seq 1 8)"

FOLDING_BIKES_BASE="${URL}/lang-es/11-plegables?p="
FOLDING_BIKES_PAGES="$(seq 1 2)"

KIDS_BIKES_BASE="${URL}/lang-es/61-junior?p="
KIDS_BIKES_PAGES="$(seq 1 5)"

get_page "${MTB_FIX_BIKES_BASE}"    "${MTB_FIX_BIKES_PAGES}"   
get_page "${MTB_DOUBLE_BIKES_BASE}" "${MTB_DOUBLE_BIKES_PAGES}"
get_page "${MTB_DOWN_BIKES_BASE}"   "${MTB_DOWN_BIKES_PAGES}"  
get_page "${MTB_ELECTRIC_BIKES_BASE}" "${MTB_ELECTRIC_BIKES_PAGES}"  
get_page "${ROAD_BIKES_BASE}"       "${ROAD_BIKES_PAGES}"      
get_page "${BMX_BIKES_BASE}"        "${BMX_BIKES_PAGES}"       
get_page "${URBAN_BIKES_BASE}"      "${URBAN_BIKES_PAGES}"     
get_page "${FOLDING_BIKES_BASE}"    "${FOLDING_BIKES_PAGES}"   
get_page "${KIDS_BIKES_BASE}"       "${KIDS_BIKES_PAGES}"      
