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
URL="http://www.mammoth.es"
ONLY_DOMAIN="mammoth.es"
EXCLUDE="-Rgif -Rpng -Rjpg"
MAX_TRIES=15
MAX_TIMEOUT=15

function get_page()
{
  BASE_URL="$1"
  PAGES="$2"
  OUT_FILE="$3"
  test -z "${OUT_FILE}" && OUT_FILE="index.html"
  if [ "${PAGES}" = "" ];
  then
    wget --tries=${MAX_TRIES} --timeout=${MAX_TIMEOUT} --output-document=${OUT_FILE} "${BASE_URL}"
  else
    for page in ${PAGES};
    do
      wget --tries=${MAX_TRIES} --timeout=${MAX_TIMEOUT} --output-document="${OUT_FILE}?p=${page}" "${BASE_URL}${page}"
    done
  fi
}

MTB_XC_BIKES_BASE="${URL}/catalogo/bicicletas/mtb/xc?page="
MTB_XC_BIKES_PAGES="$(seq 0 5)"

MTB_FIX_BIKES_BASE="${URL}/catalogo/bicicletas/mtb/rigidas?page="
MTB_FIX_BIKES_PAGES="$(seq 0 5)"

MTB_FREERIDE_BIKES_BASE="${URL}/catalogo/bicicletas/mtb/freeride"
MTB_FREERIDE_BIKES_PAGE="$(seq 0 2)"

MTB_DOWNHILL_BIKES_BASE="${URL}/catalogo/bicicletas/mtb/descenso"
MTB_DOWNHILL_BIKES_PAGE="$(seq 0 2)"

MTB_ENDURO_BIKES_BASE="${URL}/catalogo/bicicletas/mtb/enduro"
MTB_ENDURO_BIKES_PAGE="$(seq 0 2)"

MTB_29_BIKES_BASE="${URL}/catalogo/bicicletas/mtb/rueda-de-29?page="
MTB_29_BIKES_PAGES="$(seq 0 3)"

BMX_BIKES_BASE="${URL}/catalogo/bicicletas/bmx?page="
BMX_BIKES_PAGES="$(seq 0 1)"

URBAN_BIKES_BASE="${URL}/catalogo/bicicletas/urbanas-plegables-hibridas?page="
URBAN_BIKES_PAGES="$(seq 0 5)"

ROAD_BIKES_BASE="${URL}/catalogo/bicicletas/carretera?page="
ROAD_BIKES_PAGES="$(seq 0 5)"

CROSS_BIKES_BASE="${URL}/catalogo/bicicletas/ciclocross-triathlon?page="
CROSS_BIKES_PAGES="$(seq 0 3)"

WOMAN_BIKES_BASE="${URL}/catalogo/bicicletas/mujer?page="
WOMAN_BIKES_PAGES="$(seq 0 3)"

KIDS_BIKES_BASE="${URL}/catalogo/bicicletas/ninos?page="
KIDS_BIKES_PAGES="$(seq 0 1)"

ELECTRIC_BIKES_BASE="${URL}/catalogo/bicicletas/electricas?page="
ELECTRIC_BIKES_PAGES="$(seq 0 1)"

get_page "${MTB_XC_BIKES_BASE}"  "${MTB_XC_BIKES_PAGES}"  "mtb_xc.html"
get_page "${MTB_FIX_BIKES_BASE}" "${MTB_FIX_BIKES_PAGES}" "mtb_fix.html"
get_page "${MTB_FREERIDE_BIKES_BASE}" "${MTB_FREERIDE_BIKES_PAGES}" "mtb_freeride.html"
get_page "${MTB_DOWNHILL_BIKES_BASE}" "${MTB_DOWNHILL_BIKES_PAGES}" "mtb_downhill.html"
get_page "${MTB_ENDURO_BIKES_BASE}" "${MTB_ENDURO_BIKES_PAGES}" "mtb_enduro.html"
get_page "${MTB_29_BIKES_BASE}"   "${MTB_29_BIKES_PAGES}"   "mtb_29.html"
get_page "${BMX_BIKES_BASE}"      "${BMX_BIKES_PAGES}"      "bmx.html"
get_page "${URBAN_BIKES_BASE}"    "${URBAN_BIKES_PAGES}"    "urban.html"
get_page "${ROAD_BIKES_BASE}"     "${ROAD_BIKES_PAGES}"     "road.html"
get_page "${CROSS_BIKES_BASE}"    "${CROSS_BIKES_PAGES}"    "ciclocross.html"
get_page "${WOMAN_BIKES_BASE}"    "${WOMAN_BIKES_PAGES}"    "woman.html"
get_page "${KIDS_BIKES_BASE}"     "${KIDS_BIKES_PAGES}"     "kids.html"
get_page "${ELECTRIC_BIKES_BASE}" "${ELECTRIC_BIKES_PAGES}" "electric.html"