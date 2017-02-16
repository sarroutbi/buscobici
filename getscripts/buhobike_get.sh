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
# Bicimania store !
# URL: www.bicimania.com
URL="http://www.buhobike.com"
ONLY_DOMAIN="buhobike.com"
EXCLUDE="-Rgif -Rpng -Rjpg"
MAX_TRIES=10
MAX_TIMEOUT=10

. ./common_get

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

MTB_BIKES_BASE="${URL}/bicicletas/bicicletas-montana?p="
MTB_BIKES_PAGES=$(seq 1 25)

ROAD_BIKES_BASE="${URL}/bicicletas/bicicletas-carretera?p="
ROAD_BIKES_PAGES=$(seq 1 10)

URBAN_ELECTRIC_BIKES_BASE="${URL}/bicicletas/bicicletas-electricas?p="
URBAN_ELECTRIC_BIKES_PAGES=$(seq 1 12)

URBAN_BIKES_BASE="${URL}/bicicletas/bicicletas-urbanas?p="
URBAN_BIKES_PAGES=$(seq 1 7)

TREKKING_BIKES_BASE="${URL}/bicicletas/bicicletas-trekking?p="
TREKKING_BIKES_PAGES=$(seq 1 4)

BMX_BIKES_BASE="${URL}/bicicletas/bicicletas-bmx?p="
BMX_BIKES_PAGES=$(seq 1 2)

ROAD_CICLOCROSS_BIKES_BASE="${URL}/bicicletas/bicicletas-ciclocross?p="
ROAD_CICLOCROSS_BIKES_PAGES=$(seq 1 2)

KIDS_BIKES_BASE="${URL}/bicicletas/bicicletas-infantiles?p="
KIDS_BIKES_PAGES=$(seq 1 4)

bubic_get_page_outfile "${MTB_BIKES_BASE}" "${MTB_BIKES_PAGES}" mtb
bubic_get_page_outfile "${ROAD_BIKES_BASE}" "${ROAD_BIKES_PAGES}" road
bubic_get_page_outfile "${URBAN_ELECTRIC_BIKES_BASE}" "${URBAN_ELECTRIC_BIKES_PAGES}" urban-electric
bubic_get_page_outfile "${URBAN_BIKES_BASE}" "${URBAN_BIKES_PAGES}" urban
bubic_get_page_outfile "${TREKKING_BIKES_BASE}" "${TREKKING_BIKES_PAGES}" trekking
bubic_get_page_outfile "${BMX_BIKES_BASE}" "${BMX_BIKES_PAGES}" bmx
bubic_get_page_outfile "${ROAD_CICLOCROSS_BIKES_BASE}" "${ROAD_CICLOCROSS_BIKES_PAGES}" road-ciclocross
bubic_get_page_outfile "${KIDS_BIKES_BASE}" "${KIDS_BIKES_PAGES}" kids
