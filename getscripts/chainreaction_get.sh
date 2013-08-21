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
# Calmera store !
URL="www.chainreactioncycles.com"
ONLY_DOMAIN="chainreactioncycles.com"
MAX_TRIES=15
MAX_TIMEOUT=15
COOKIE_FILE="chainreactioncookies.txt"

function get_page()
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


MTB_BIKES_BASE="${URL}/es/es/bicis-montana/rigidos?f=2258&page="
MTB_BIKES_PAGES="$(seq 1 5)"

MTB_DOUBLE_BIKES_BASE="${URL}/es/es/bicis-montana/suspension-total?f=2258&page="
MTB_DOUBLE_BIKES_PAGES="$(seq 1 5)"

ROAD_BIKES_BASE="${URL}/es/es/bicis-de-carretera?f=2259&page="
ROAD_BIKES_PAGES="$(seq 1 5)"

ELECTRIC_BIKES_BASE=""
ELECTRIC_BIKES_PAGES=""

FOLDING_BIKES_BASE=""
FOLDING_BIKES_PAGES=""

CRUISER_BIKES_BASE="${URL}/es/es/bicis-cruiser?f=2260&page="
CRUISER_BIKES_PAGES=""

BMX_BIKES_BASE="${URL}/es/es/bicis-bmx?f=2263&page="
BMX_BIKES_PAGES="$(seq 1 3)"

KIDS_BIKES_BASE="${URL}/es/es/bicis-infantiles?f=2258&page="
KIDS_BIKES_PAGES="$(seq 1 3)"
 
URBAN_BIKES_BASE="${URL}/es/es/bicis-urbanas?f=2260&page="
URBAN_BIKES_PAGES="$(seq 1 3)"

CICLOCROSS_BIKES_BASE="${URL}/es/es/bicis-ciclocross?f=2259&page="
CICLOCROSS_BIKES_PAGES=""

get_page "${MTB_BIKES_BASE}"        "${MTB_BIKES_PAGES}"
get_page "${MTB_DOUBLE_BIKES_BASE}" "${MTB_DOUBLE_BIKES_PAGES}"
get_page "${ROAD_BIKES_BASE}"       "${ROAD_BIKES_PAGES}"
get_page "${CRUISER_BIKES_BASE}"    "${CRUISER_BIKES_PAGES}"
get_page "${BMX_BIKES_BASE}"        "${BMX_BIKES_PAGES}"
get_page "${KIDS_BIKES_BASE}"       "${KIDS_BIKES_PAGES}"
get_page "${URBAN_BIKES_BASE}"      "${URBAN_BIKES_PAGES}"
get_page "${CICLOCROSS_BIKES_BASE}" "${CICLOCROSS_BIKES_PAGES}"
