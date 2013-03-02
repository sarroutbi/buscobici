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
URL="www.labicitienda.com"
ONLY_DOMAIN="www.labicitienda.com"
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

MTB_BIKES_BASE="${URL}/index.php?cPath=30_112&sort=2a&page="
MTB_BIKES_PAGES="$(seq 1 10)"

MTB_WOMAN_BIKES_BASE="${URL}/index.php?cPath=30_145"
MTB_WOMAN_BIKES_PAGES=""

MTB_DOUBLE_BIKES_BASE="${URL}/index.php?cPath=30_252&page="
MTB_DOUBLE_BIKES_PAGES="$(seq 1 5)"

MTB_DOUBLE_WOMAN_BIKES_BASE="${URL}/index.php?cPath=30_291"
MTB_DOUBLE_WOMAN_BIKES_PAGES=""

ROAD_BIKES_BASE="${URL}/index.php?cPath=30_113&sort=2a&page="
ROAD_BIKES_PAGES="$(seq 1 5)"

ROAD_TRIATLON_BIKES_BASE="${URL}/index.php?cPath=30_139"
ROAD_TRIATLON_BIKES_PAGES=""

DIRT_BIKES_BASE="${URL}/product_info.php?cPath=30_287&products_id=1761"
DIRT_BIKES_PAGES=""

BMX_FREE_BIKES_BASE="${URL}/index.php?cPath=30_254"
BMX_FREE_BIKES_PAGES=""

URBAN_HYBRID_BIKES_BASE="${URL}/index.php?cPath=30_293"
URBAN_HYBRID_BIKES_PAGES=""

KIDS_BIKES_BASE="${URL}/index.php?cPath=30_115&sort=2a&page="
KIDS_BIKES_PAGES="$(seq 1 3)"

KIDS_JUNIOR_BIKES_BASE="${URL}/index.php?cPath=30_117"
KIDS_JUNIOR_BIKES_PAGES=""

URBAN_FOLDING_BIKES_BASE="${URL}/index.php?cPath=30_118"
URBAN_FOLDING_BIKES_PAGES=""

URBAN_BIKES_BASE="${URL}/index.php?cPath=30_114&sort=2a&page="
URBAN_BIKES_PAGES="$(seq 1 3)"

URBAN_WOMAN_BIKES_BASE="${URL}/index.php?cPath=30_253"
URBAN_WOMAN_BIKES_PAGES=""

get_page "${MTB_BIKES_BASE}"              "${MTB_BIKES_PAGES}"
get_page "${MTB_WOMAN_BIKES_BASE}"        "${MTB_WOMAN_BIKES_PAGES}"
get_page "${MTB_DOUBLE_BIKES_BASE}"       "${MTB_DOUBLE_BIKES_PAGES}"
get_page "${MTB_DOUBLE_WOMAN_BIKES_BASE}" "${MTB_DOUBLE_WOMAN_BIKES_PAGES}"
get_page "${ROAD_BIKES_BASE}"             "${ROAD_BIKES_PAGES}"
get_page "${ROAD_TRIATHLON_BIKES_BASE}"   "${ROAD_TRIATHLON_BIKES_PAGES}"
get_page "${DIRT_BIKES_BASE}"             "${DIRT_BIKES_PAGES}"
get_page "${BMX_FREE_BIKES_BASE}"         "${BMX_FREE_BIKES_PAGES}"
get_page "${URBAN_HYBRID_BIKES_BASE}"     "${URBAN_HYBRID_BIKES_PAGES}"
get_page "${KIDS_BIKES_BASE}"             "${KIDS_BIKES_PAGES}"
get_page "${KIDS_JUNIOR_BIKES_BASE}"      "${KIDS_JUNIOR_BIKES_PAGES}"
get_page "${URBAN_FOLDING_BIKES_BASE}"    "${URBAN_FOLDING_BIKES_PAGES}"
get_page "${URBAN_BIKES_BASE}"            "${URBAN_BIKES_PAGES}"

