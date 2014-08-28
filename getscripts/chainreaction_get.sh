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

# Import the get_common
. ./common_get

URL="www.chainreactioncycles.com"
ONLY_DOMAIN="chainreactioncycles.com"
MAX_TRIES=15
MAX_TIMEOUT=15
COOKIE_FILE="chainreactioncookies.txt"

function get_page() 
{
  bubic_get_page_cookies "$1" "$2" "${COOKIE_FILE}"
}

function prev_get_page()
{
  BASE_URL="$1"
  PAGES="$2"
  if [ "${PAGES}" = "" ];
  then
    wget --load-cookies=${COOKIE_FILE} --tries=${MAX_TRIES} --timeout=${MAX_TIMEOUT} "${BASE_URL}" 
  else
    for page in ${PAGES};
    do
      wget --load-cookies=${COOKIE_FILE} --tries=${MAX_TRIES} --timeout=${MAX_TIMEOUT} "${BASE_URL}${page}" 
    done 
  fi
}


MTB_BIKES_BASE="${URL}/es/es/bicis-montana/rigidos?page="
MTB_BIKES_PAGES="$(seq 1 3)"

MTB_DOUBLE_BIKES_BASE="${URL}/es/es/bicis-montana/suspension-total?page="
MTB_DOUBLE_BIKES_PAGES="$(seq 1 3)"

ROAD_BIKES_BASE="${URL}/es/es/bicis-de-carretera?page="
ROAD_BIKES_PAGES="$(seq 1 2)"

ROAD_TIME_BIKES_BASE="${URL}es/es/bicis-de-contra-reloj?page="
ROAD_TIME_BIKES_PAGES="1"

ELECTRIC_BIKES_BASE=""
ELECTRIC_BIKES_PAGES=""

FOLDING_BIKES_BASE=""
FOLDING_BIKES_PAGES=""

CRUISER_BIKES_BASE="${URL}/es/es/bicis-cruiser?page="
CRUISER_BIKES_PAGES="1"

BMX_BIKES_BASE="${URL}/es/es/bicis-bmx?page="
BMX_BIKES_PAGES="$(seq 1 3)"

KIDS_BIKES_BASE="${URL}/es/es/bicis-infantiles?page="
KIDS_BIKES_PAGES="$(seq 1 2)"
 
URBAN_BIKES_BASE="${URL}/es/es/bicis-urbanas?page="
URBAN_BIKES_PAGES="$(seq 1 3)"

URBAN_FOLDING_BIKES_BASE="${URL}/es/es/bicis-plegables?page="
URBAN_FOLDING_BIKES_PAGES="$(seq 1 2)"

CICLOCROSS_BIKES_BASE="${URL}/es/es/bicis-ciclocross?page="
CICLOCROSS_BIKES_PAGES="1"

get_page "${MTB_BIKES_BASE}"        "${MTB_BIKES_PAGES}"
get_page "${MTB_DOUBLE_BIKES_BASE}" "${MTB_DOUBLE_BIKES_PAGES}"
get_page "${ROAD_BIKES_BASE}"       "${ROAD_BIKES_PAGES}"
get_page "${ROAD_TIME_BIKES_BASE}"  "${ROAD_TIME_BIKES_PAGES}"
get_page "${CRUISER_BIKES_BASE}"    "${CRUISER_BIKES_PAGES}"
get_page "${BMX_BIKES_BASE}"        "${BMX_BIKES_PAGES}"
get_page "${KIDS_BIKES_BASE}"       "${KIDS_BIKES_PAGES}"
get_page "${URBAN_BIKES_BASE}"      "${URBAN_BIKES_PAGES}"
get_page "${URBAN_FOLDING_BIKES_BASE}" "${URBAN_FOLDING_BIKES_PAGES}"
get_page "${CICLOCROSS_BIKES_BASE}" "${CICLOCROSS_BIKES_PAGES}"
