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
URL="www.calmera.es/tienda2016/es"
ONLY_DOMAIN="calmera.es"
EXCLUDE="-Rgif -Rpng -Rjpg"
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

MTB_BIKES_BASE="${URL}/18-montana?p="
MTB_BIKES_PAGES="$(seq 1 16)"

MTB_DOUBLE_BASE="${URL}/27-doble-suspension?p="
MTB_DOUBLE_PAGES="$(seq 1 9)"

ROAD_BIKES_BASE="${URL}/17-carretera?p="
ROAD_BIKES_PAGES="$(seq 1 16)"

ROAD_CARBON_BIKES_BASE="${URL}/24-carbono?p="
ROAD_CARBON_BIKES_PAGES="$(seq 1 10)"

ROAD_TRIATLON_BIKES_BASE="${URL}/25-triathlon?p="
ROAD_TRIATLON_BIKES_PAGES="$(seq 1 3)"

ROAD_CICLOCROSS_BIKES_BASE="${URL}/132-ciclocross-y-cicloturismo?p="
ROAD_CICLOCROSS_BIKES_PAGES="$(seq 1 3)"

ROAD_FIXIES_BIKES_BASE="${URL}/133-fixies?p="
ROAD_FIXIES_BIKES_PAGES="$(seq 1 2)"

URBAN_BIKES_BASE="${URL}/19-urbanas-y-mixtastrekking?p="
URBAN_BIKES_PAGES="$(seq 1 13)"

KIDS_BIKES_BASE="${URL}/20-infantiles?p="
KIDS_BIKES_PAGES="$(seq 1 7)"

TRICYCLE_BIKES_BASE="${URL}/21-triciclos-y-tandems?p="
TRICYCLE_BIKES_PAGES="$(seq 1 3)"

BMX_BIKES_BASE="${URL}/22-bmxfreestyletrial?p="
BMX_BIKES_PAGES="$(seq 1 2)"

get_page "${MTB_BIKES_BASE}"           "${MTB_BIKES_PAGES}"
get_page "${MTB_DOUBLE_BASE}"          "${MTB_DOUBLE_PAGES}"
get_page "${ROAD_BIKES_BASE}"          "${ROAD_BIKES_PAGES}"
get_page "${ROAD_CARBON_BIKES_BASE}"   "${ROAD_CARBON_BIKES_PAGES}"
get_page "${ROAD_TRIATLON_BIKES_BASE}" "${ROAD_TRIATLON_BIKES_PAGES}"
get_page "${ROAD_FIXIES_BASE}"         "${ROAD_FIXIES_PAGES}"
get_page "${ROAD_CICLOCROSS_BASE}"     "${ROAD_CICLOCROSS_PAGES}"
get_page "${URBAN_BIKES_BASE}"         "${URBAN_BIKES_PAGES}"
get_page "${KIDS_BIKES_BASE}"          "${KIDS_BIKES_PAGES}"
get_page "${TRICYCLE_BIKES_BASE}"      "${TRICYCLE_BIKES_PAGES}"
get_page "${BMX_BIKES_BASE}"           "${BMX_BIKES_PAGES}"
