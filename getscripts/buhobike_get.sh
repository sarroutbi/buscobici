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

MTB_BIKES_BASE="${URL}/estandar.php/montana?_pagi_pg="
MTB_BIKES_PAGES=$(seq 1 55)

ROAD_BIKES_BASE="${URL}/estandar.php/carretera-y-variantes?_pagi_pg="
ROAD_BIKES_PAGES=$(seq 1 25)

TREKKING_BIKES_BASE="${URL}/estandar.php/trekking?_pagi_pg="
TREKKING_BIKES_PAGES=$(seq 1 9)

BMX_BIKES_BASE="${URL}/estandar.php?mp=1&opc=bmx&pagi_pg="
BMX_BIKES_PAGES=$(seq 1 2)

URBAN_BIKES_BASE="${URL}/estandar.php/ciudad-plegables-y-electricas?_pagi_pg="
URBAN_BIKES_PAGES=$(seq 1 18)

KIDS_BIKES_BASE="${URL}/estandar.php/infantiles?_pagi_pg="
KIDS_BIKES_PAGES=$(seq 1 7)

bubic_get_page_outfile "${MTB_BIKES_BASE}" "${MTB_BIKES_PAGES}" mtb
bubic_get_page_outfile "${ROAD_BIKES_BASE}" "${ROAD_BIKES_PAGES}" road
bubic_get_page_outfile "${TREKKING_BIKES_BASE}" "${TREKKING_BIKES_PAGES}" trekking
bubic_get_page_outfile "${URBAN_BIKES_BASE}" "${URBAN_BIKES_PAGES}" urban
bubic_get_page_outfile "${BMX_BIKES_BASE}" "${BMX_BIKES_PAGES}" bmx
bubic_get_page_outfile "${KIDS_BIKES_BASE}" "${KIDS_BIKES_PAGES}" kids
