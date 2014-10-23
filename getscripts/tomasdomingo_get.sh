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
URL="www.tomasdomingo.com"
ONLY_DOMAIN="tomasdomingo.com"
EXCLUDE="-Rgif -Rpng -Rjpg"
MAX_TRIES=10
MAX_TIMEOUT=30

function get_page()
{
  BASE_URL="$1"
  FILE="$2"
  PAGES="$3"

  if [ "${PAGES}" = "" ];
  then
    wget -w5 --random-wait -e robots=off -U 'mozilla' \
      --tries=${MAX_TRIES} --timeout=${MAX_TIMEOUT} "${BASE_URL}" -O"${FILE}"
  else
    for page in ${PAGES};
    do
      wget -w5 --random-wait -e robots=off -U 'mozilla' \
        --tries=${MAX_TRIES} --timeout=${MAX_TIMEOUT} "${BASE_URL}${page}" -O"${FILE}-${page}"
    done
  fi
}

ROAD_BIKES_BASE="${URL}/es/catalogo/bicis/bici-carretera/0/asc/"
ROAD_BIKES_PAGES="$(seq 1 5)"

ROAD_WOMAN_BIKES_BASE="${URL}/es/catalogo/bicis/bici-carretera-mujer/0/asc/"
ROAD_WOMAN_BIKES_PAGES=""

ROAD_CROSS_BIKES_BASE="${URL}/es/catalogo/bicis/bici-cross/0/asc/"
ROAD_CROSS_BIKES_PAGES=""

URBAN_CONFORT_BIKES_BASE="${URL}/es/catalogo/bicis/bici-confort/0/asc/"
URBAN_CONFORT_BIKES_PAGES=""

URBAN_CONFORTM_BIKES_BASE="${URL}/es/catalogo/bicis/bici-confort-m/0/asc/"
URBAN_CONFORTM_BIKES_PAGES=""

URBAN_CONFORT_HYBRID_BASE="${URL}/es/catalogo/bicis/bici-hibrida/0/asc/"
URBAN_CONFORT_HYBRID_PAGES=""

URBAN_CONFORT_HYBRIDM_BASE="${URL}/es/catalogo/bicis/bici-hibrida-m/0/asc/"
URBAN_CONFORT_HYBRIDM_PAGES=""

URBAN_FOLDING_BIKES_BASE="${URL}/es/catalogo/bicis/bici-plegable/0/asc/"
URBAN_FOLDING_BIKES_PAGES="$(seq 1 2)"

URBAN_ELECTRIC_BIKES_BASE="${URL}/es/catalogo/bicis/bici-electrica/0/asc/"
URBAN_ELECTRIC_BIKES_PAGES=""

URBAN_WALK_BIKES_BASE="${URL}/es/catalogo/bicis/bici-paseo/0/asc/"
URBAN_WALK_BIKES_PAGES=""

MTB_DOUBLE_27_BIKES_BASE="${URL}/es/catalogo/bicis/bici-doble-275/0/asc/"
MTB_DOUBLE_27_BIKES_PAGES="$(seq 1 3)"

MTB_DOUBLE_29_BIKES_BASE="${URL}/es/catalogo/bicis/bici-doble-29/0/asc/"
MTB_DOUBLE_29_BIKES_PAGES="$(seq 1 3)"

MTB_DOUBLE_29_WOMAN_BIKES_BASE="${URL}/es/catalogo/bicis/bici-doble-mujer-29/0/asc/"
MTB_DOUBLE_29_WOMAN_BIKES_PAGES=""

MTB_FIX_26_BIKES_BASE="${URL}/es/catalogo/bicis/bici-rigida-26/0/asc/"
MTB_FIX_26_BIKES_PAGES=""

MTB_FIX_27_BIKES_BASE="${URL}/es/catalogo/bicis/bici-rigida-27/0/asc/"
MTB_FIX_27_BIKES_PAGES="$(seq 1 5)"

MTB_FIX_29_BIKES_BASE="${URL}/es/catalogo/bicis/bici-rigida-29/0/asc/"
MTB_FIX_29_BIKES_PAGES="$(seq 1 7)"

MTB_FIX_26_WOMAN_BIKES_BASE="${URL}/es/catalogo/bicis/bici-rigida-mujer-26/0/asc/"
MTB_FIX_26_WOMAN_BIKES_PAGES=""

MTB_FIX_27_WOMAN_BIKES_BASE="${URL}/es/catalogo/bicis/bici-rigida-mujer-27/0/asc/"
MTB_FIX_27_WOMAN_BIKES_PAGES="$(seq 1 3)"

MTB_FIX_29_WOMAN_BIKES_BASE="${URL}/es/catalogo/bicis/bici-rigida-mujer-29/0/asc/"
MTB_FIX_29_WOMAN_BIKES_PAGES=""

KIDS_BIKES_BASE="${URL}/es/catalogo/bicis/bici-infantil/0/asc/"
KIDS_BIKES_PAGES="$(seq 1 3)"

get_page "${ROAD_BIKES_BASE}"             road                 "${ROAD_BIKES_PAGES}"
get_page "${ROAD_WOMAN_BIKES_BASE}"       road-woman
get_page "${ROAD_CROSS_BIKES_BASE}"       road-cross
get_page "${URBAN_CONFORT_BIKES_BASE}"    urban-confort
get_page "${URBAN_CONFORTM_BIKES_BASE}"   urban-confort-m
get_page "${URBAN_CONFORT_HYBRID_BASE}"   urban-confort-hybrid
get_page "${URBAN_CONFORT_HYBRIDM_BASE}"  urban-confort-hybrid-m
get_page "${URBAN_FOLDING_BIKES_BASE}"    urban-folding        "${URBAN_FOLDING_BIKES_PAGES}"
get_page "${URBAN_ELECTRIC_BIKES_BASE}"   urban-electric
get_page "${URBAN_WALK_BIKES_BASE}"       urban-walk
get_page "${MTB_DOUBLE_27_BIKES_BASE}"    mtb-double-27        "${MTB_DOUBLE_27_BIKES_PAGES}"
get_page "${MTB_DOUBLE_29_BIKES_BASE}"    mtb-double-29        "${MTB_DOUBLE_29_BIKES_PAGES}"
get_page "${MTB_DOUBLE_29_WOMAN_BIKES_BASE}" mtb-double-29-woman  "${MTB_DOUBLE_29_WOMAN_BIKES_PAGES}"
get_page "${MTB_FIX_26_BIKES_BASE}"       mtb-fix-26
get_page "${MTB_FIX_27_BIKES_BASE}"       mtb-fix-27           "${MTB_FIX_27_BIKES_PAGES}"
get_page "${MTB_FIX_29_BIKES_BASE}"       mtb-fix-29           "${MTB_FIX_29_BIKES_PAGES}"
get_page "${MTB_FIX_26_WOMAN_BIKES_BASE}" mtb-fix-woman-26
get_page "${MTB_FIX_27_WOMAN_BIKES_BASE}" mtb-fix-woman-27     "${MTB_FIX_27_WOMAN_BIKES_PAGES}"
get_page "${MTB_FIX_29_WOMAN_BIKES_BASE}" mtb-fix-woman-29
get_page "${KIDS_BIKES_BASE}"             kids                 "${KIDS_BIKES_PAGES}"
