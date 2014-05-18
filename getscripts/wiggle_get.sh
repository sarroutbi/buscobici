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
URL="www.wiggle.es"
ONLY_DOMAIN="wiggle.es"
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
      wget --tries=${MAX_TRIES} --timeout=${MAX_TIMEOUT} --output-document="${OUT_FILE}?p=${page}" "${BASE_URL}?p=${page}"
    done 
  fi
}

RACETRACK_BIKES_BASE="${URL}/ciclismo/bicis-de-pista/"
RACETRACK_BIKES_PAGES=""

FIXIE_BIKES_BASE="${URL}/ciclismo/bicis-sin-cambios/"
FIXIE_BIKES_PAGES=$(seq 1 2)

BMX_BIKES_BASE="${URL}/ciclismo/bicis-bmx/"
BMX_BIKES_PAGES=$(seq 1 3)

ROAD_BIKES_BASE="${URL}/ciclismo/bicis-de-carretera-y-contrarreloj/"
ROAD_BIKES_PAGES=$(seq 1 10)

CICLOCROSS_BIKES_BASE="${URL}/ciclismo/bicis-de-ciclocross/"
CICLOCROSS_BIKES_PAGES=""

MTB_BIKES_BASE="${URL}/ciclismo/bicis-mtb-rigidas"
MTB_BIKES_PAGES=$(seq 1 5)

MTB_DOUBLE_BIKES_BASE="${URL}/ciclismo/bicis-mtb-doble-suspension/"
MTB_DOUBLE_BIKES_PAGES=$(seq 1 5)

KIDS_BIKES_BASE="${URL}/ciclismo/bicis-para-ninos/"
KIDS_BIKES_PAGES=$(seq 1 2)

URBAN_BIKES_BASE="${URL}/ciclismo/bicis-urbanas/"
URBAN_BIKES_PAGES=$(seq 1 5)

get_page "${RACETRACK_BIKES_BASE}"   "${RACETRACK_BIKES_PAGES}"         "racetrack.html"
get_page "${FIXIE_BIKES_BASE}"       "${FIXIE_BIKES_PAGES}"             "fixies.html"
get_page "${BMX_BIKES_BASE}"         "${BMX_BIKES_PAGES}"               "bmx.html"
get_page "${ROAD_BIKES_BASE}"        "${ROAD_BIKES_PAGES}"              "road.html"
get_page "${CICLOCROSS_BIKES_BASE}"  "${CICLOCROSS_BIKES_PAGES}"        "ciclocross.html"
get_page "${MTB_BIKES_BASE}"         "${MTB_BIKES_PAGES}"               "mtb.html"
get_page "${MTB_DOUBLE_BIKES_BASE}"  "${MTB_DOUBLE_BIKES_PAGES}"        "mtb-double.html"
get_page "${KIDS_BIKES_BASE}"        "${KIDS_BIKES_PAGES}"              "bicis-para-ninos.html"
get_page "${URBAN_BIKES_BASE}"       "${URBAN_BIKES_PAGES}"             "urban.html"
