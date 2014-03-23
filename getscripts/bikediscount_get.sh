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
URL="www.bike-discount.de"
ONLY_DOMAIN="bike-discount.de"
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
      wget --tries=${MAX_TRIES} --timeout=${MAX_TIMEOUT} "${BASE_URL}/p-${page}" -O"${FILE}-p${page}"
    done
  fi
}
ROAD_BIKES_ALUM_BASE="${URL}/es/shop/bici-de-carrera-aluminio-110"
ROAD_BIKES_ALUM_PAGES="$(seq 0 5)"

ROAD_BIKES_CARBON_BASE="${URL}/es/shop/bici-de-carrera-carbono-111"
ROAD_BIKES_CARBON_PAGES="$(seq 0 5)"

ROAD_BIKES_WOMAN_BASE="${URL}/es/shop/bici-de-carrera-mujer-114"
ROAD_BIKES_WOMAN_PAGES="$(seq 0 5)"

ROAD_BIKES_TRIATLON_BASE="${URL}/es/shop/triatl-n-bici-30"
ROAD_BIKES_TRIATLON_PAGES="$(seq 0 5)"

ROAD_BIKES_CYCLOCROSS_BASE="${URL}/es/shop/cyclocross-40"
ROAD_BIKES_CYCLOCROSS_PAGES="$(seq 0 5)"

get_page "${ROAD_BIKES_ALUM_BASE}" "${ROAD_BIKES_ALUM_PAGES}" road-alum
get_page "${ROAD_BIKES_CARBON_BASE}" "${ROAD_BIKES_CARBON_PAGES}" road-carbon
get_page "${ROAD_BIKES_WOMAN_BASE}" "${ROAD_BIKES_WOMAN_PAGES}" road-woman
get_page "${ROAD_BIKES_TRIATLON_BASE}" "${ROAD_BIKES_TRIATLON_PAGES}" road-triatlon
get_page "${ROAD_BIKES_CYCLOCROSS_BASE}" "${ROAD_BIKES_CYCLOCROSS_PAGES}" road-cyclocross
