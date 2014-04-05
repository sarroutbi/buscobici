#!/bin/bash
#
# Copyright © 2012-2014 Sergio Arroutbi Braojos <sarroutbi@gmail.com>
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
URL="www.bikingpoint.es"
ONLY_DOMAIN="bikingpoint.es"
EXCLUDE="-Rgif -Rpng -Rjpg"
MAX_TRIES=10
MAX_TIMEOUT=10

function get_page()
{
  BASE_URL="$1"
  PAGES="$2"
  FILE="$3"

  if [ "${PAGES}" = "" ];
  then
    wget --tries=${MAX_TRIES} --timeout=${MAX_TIMEOUT} "${BASE_URL}" -O"${FILE}"
  else
    for page in ${PAGES};
    do
      wget --tries=${MAX_TRIES} --timeout=${MAX_TIMEOUT} "${BASE_URL}/?p=${page}" -O"${FILE}?p=${page}"
    done
  fi
}

#### ROAD ####
ROAD_BIKES_BASE="${URL}/bicicletas/carretera.html"
ROAD_BIKES_PAGES="$(seq 0 3)"

get_page "${ROAD_BIKES_BASE}" "${ROAD_BIKES_PAGES}" road

#### MTB ####
MTB_DOUBLE_BIKES_BASE="${URL}/bicicletas/mtb-full-suspencion.html"
MTB_DOUBLE_BIKES_PAGES="$(seq 0 3)"
MTB_FIX_BIKES_BASE="${URL}/bicicletas/mtb-rigidas.html"
MTB_FIX_BIKES_PAGES="$(seq 0 7)"
MTB_FREERIDE_BIKES_BASE="${URL}/bicicletas/mtb-freeride.html"
MTB_FREERIDE_BIKES_PAGES="$(seq 0 1)"

get_page "${MTB_DOUBLE_BIKES_BASE}" "${MTB_DOUBLE_BIKES_PAGES}" mtb-double
get_page "${MTB_FIX_BIKES_BASE}" "${MTB_FIX_BIKES_PAGES}" mtb-fix
get_page "${MTB_FREERIDE_BIKES_BASE}" "${MTB_FREERIDE_BIKES_PAGES}" mtb-freeride

#### URBAN ####
URBAN_ELECTRIC_BIKES_BASE="${URL}/bicicletas/electricas.html"
URBAN_ELECTRIC_BIKES_PAGES="$(seq 0 1)"

URBAN_TREKKING_BIKES_BASE="${URL}/bicicletas/trekking.html"
URBAN_TREKKING_BIKES_PAGES="$(seq 0 2)"

URBAN_FOLDING_BIKES_BASE="${URL}/bicicletas/paseo-city-cruiser.html"
URBAN_FOLDING_BIKES_PAGES="$(seq 0 2)"

get_page "${URBAN_ELECTRIC_BIKES_BASE}" "${URBAN_ELECTRIC_BIKES_PAGES}" urban-electric
get_page "${URBAN_TREKKING_BIKES_BASE}" "${URBAN_TREKKING_BIKES_PAGES}" urban-trekking
get_page "${URBAN_FOLDING_BIKES_BASE}" "${URBAN_FOLDING_BIKES_PAGES}" urban-folding

#### BMX ####
BMX_BIKES_BASE="${URL}/bicicletas/bmx-trial-dirt.html"
BMX_BIKES_PAGES="$(seq 0 1)"
get_page "${BMX_BIKES_BASE}" "${BMX_BIKES_PAGES}" bmx

#### KIDS ####
KIDS_BIKES_BASE="${URL}/bicicletas/infantil.html"
KIDS_BIKES_PAGES="$(seq 0 3)"
get_page "${KIDS_BIKES_BASE}" "${KIDS_BIKES_PAGES}" kids