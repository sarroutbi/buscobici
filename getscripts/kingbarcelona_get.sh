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
URL="www.kingbarcelona.com"
ONLY_DOMAIN="kingbarcelona.com"
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

ROAD_BIKES_BASE="${URL}/es/ciclismo-c-225_239.html?page="
ROAD_BIKES_PAGES="$(seq 1 2)"

ROAD_TRIATLON_BASE="${URL}/es/triathlon-c-225_460.html"
ROAD_TRIATLON_PAGES=""

URBAN_ELECTRIC_BIKES_BASE="${URL}/es/bicicletas-electricas-c-225_443.html?page="
URBAN_ELECTRIC_BIKES_PAGES="$(seq 1 2)"

URBAN_BIKES_BASE="${URL}/es/ciudad-c-225_375.html?page="
URBAN_BIKES_PAGES="$(seq 1 5)"

KIDS_BIKES_BASE="${URL}/es/ninos-c-225_241.html?page="
KIDS_BIKES_PAGES="$(seq 1 2)"

KIDS_BTT_BIKES_BASE="${URL}/es/99-349-euros-c-405_406.html"
KIDS_BTT_BIKES_PAGES=""

BMX_BIKES_BASE="${URL}/es/bmx-c-225_502.html"
BMX_BIKES_PAGES=""

MTB_DOUBLE_BIKES_BASE="${URL}/es/ciclocross-c-225_532.html"
MTB_DOUBLE_BIKES_PAGES=""

MTB_DOWNHILL_BIKES_BASE="${URL}/es/dh-c-225_503.html"
MTB_DOWNHILL_BIKES_PAGES=""

MTB_GEN1_BIKES_BASE="${URL}/es/3500-8999-euros-c-405_414.html?page="
MTB_GEN1_BIKES_PAGES="$(seq 1 2)"

MTB_GEN2_BIKES_BASE="${URL}/es/3000-3499-euros-c-405_413.html"
MTB_GEN2_BIKES_PAGES=""

MTB_GEN3_BIKES_BASE="${URL}/es/2500-2999-euros-c-405_412.html"
MTB_GEN3_BIKES_PAGES=""

MTB_GEN4_BIKES_BASE="${URL}/es/2000-2499-euros-c-405_411.html?page="
MTB_GEN4_BIKES_PAGES="$(seq 1 2)"

MTB_GEN5_BIKES_BASE="${URL}/es/1500-1999-euros-c-405_410.html?page="
MTB_GEN5_BIKES_PAGES="$(seq 1 2)"

MTB_GEN6_BIKES_BASE="${URL}/es/1000-1499-euros-c-405_409.html"
MTB_GEN6_BIKES_PAGES=""

MTB_GEN7_BIKES_BASE="${URL}/es/600-999-euros-c-405_408.html?page="
MTB_GEN7_BIKES_PAGES="$(seq 1 3)"

MTB_GEN7_BIKES_BASE="${URL}/es/350-599-euros-c-405_407.html?page="
MTB_GEN7_BIKES_PAGES="$(seq 1 2)"

get_page "${ROAD_BIKES_BASE}"                   "${ROAD_BIKES_PAGES}"
get_page "${ROAD_TRIATLON_BASE}"                "${ROAD_TRIATLON_PAGES}"
get_page "${URBAN_ELECTRIC_BIKES_BASE}"         "${URBAN_ELECTRIC_BIKES_PAGES}"
get_page "${URBAN_BIKES_BASE}"                  "${URBAN_BIKES_PAGES}"
get_page "${KIDS_BIKES_BASE}"                   "${KIDS_BIKES_PAGES}"
get_page "${KIDS_BTT_BIKES_BASE}"               "${KIDS_BTT_BIKES_PAGES}"
get_page "${BMX_BIKES_BASE}"                    "${BMX_BIKES_PAGES}"
get_page "${MTB_DOUBLE_BIKES_BASE}"             "${MTB_DOUBLE_BIKES_PAGES}"
get_page "${MTB_DOWNHILL_BIKES_BASE}"           "${MTB_DOWNHILL_BIKES_PAGES}"
get_page "${MTB_GEN1_BIKES_BASE}"               "${MTB_GEN1_BIKES_PAGES}"
get_page "${MTB_GEN2_BIKES_BASE}"               "${MTB_GEN2_BIKES_PAGES}"
get_page "${MTB_GEN3_BIKES_BASE}"               "${MTB_GEN3_BIKES_PAGES}"
get_page "${MTB_GEN4_BIKES_BASE}"               "${MTB_GEN4_BIKES_PAGES}"
get_page "${MTB_GEN5_BIKES_BASE}"               "${MTB_GEN5_BIKES_PAGES}"
get_page "${MTB_GEN6_BIKES_BASE}"               "${MTB_GEN6_BIKES_PAGES}"
get_page "${MTB_GEN7_BIKES_BASE}"               "${MTB_GEN7_BIKES_PAGES}"
