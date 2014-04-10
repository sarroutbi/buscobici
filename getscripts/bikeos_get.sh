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
URL="www.bikeos.com"
ONLY_DOMAIN="bikeos.com"
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


ROAD_BIKES_BASE="${URL}/index.php/bicicletas/carretera.html?p="
ROAD_BIKES_PAGES="$(seq 1 20)"

MTB_BIKES_BASE="${URL}/index.php/bicicletas/mountain-bike.html?p="
MTB_BIKES_PAGES="$(seq 1 35)"

BMX_BIKES_BASE="${URL}/index.php/bicicletas/bmx-trial-freeride.html?p="
BMX_BIKES_PAGES="$(seq 1 10)"

TREKKING_OUTLET_BIKES_BASE="${URL}/index.php/bicicletas/trekking-liquidacion.html?p="
TREKKING_OUTLET_BIKES_PAGES="$(seq 1 5)"

TREKKING_2012_BIKES_BASE="${URL}/index.php/bicicletas/trekking-2012.html?p="
TREKKING_2012_BIKES_PAGES="$(seq 1 5)"

TREKKING_2013_BIKES_BASE="${URL}/index.php/bicicletas/trekking-2013.html?p="
TREKKING_2013_BIKES_PAGES="$(seq 1 10)"

TREKKING_2014_BIKES_BASE="${URL}/index.php/bicicletas/trekking-2014.html?p="
TREKKING_2014_BIKES_PAGES="$(seq 1 10)"

FOLDING_BIKES_BASE="${URL}/index.php/bicicletas/plegables.html?p="
FOLDING_BIKES_PAGES="$(seq 1 5)"

ELECTRIC_BIKES_BASE="${URL}/index.php/bicicletas/electricas.html?p="
ELECTRIC_BIKES_PAGES="$(seq 1 20)"

KIDS_BIKES_BASE="${URL}/index.php/bicicletas/infantil.html?p="
KIDS_BIKES_PAGES="$(seq 1 10)"

MTB_29_BIKES_BASE="${URL}/index.php/bicicletas/29.html?p="
MTB_29_BIKES_PAGES="$(seq 1 10)"

get_page "${ROAD_BIKES_BASE}" "${ROAD_BIKES_PAGES}"
get_page "${MTB_BIKES_BASE}" "${MTB_BIKES_PAGES}"
get_page "${BMX_BIKES_BASE}" "${BMX_BIKES_PAGES}"
get_page "${TREKKING_OUTLET_BIKES_BASE}" "${TREKKING_OUTLET_BIKES_PAGES}"
get_page "${TREKKING_2012_BIKES_BASE}" "${TREKKING_2012_BIKES_PAGES}"
get_page "${TREKKING_2013_BIKES_BASE}" "${TREKKING_2013_BIKES_PAGES}"
get_page "${TREKKING_2014_BIKES_BASE}" "${TREKKING_2014_BIKES_PAGES}"
get_page "${FOLDING_BIKES_BASE}" "${FOLDING_BIKES_PAGES}"
get_page "${ELECTRIC_BIKES_BASE}" "${ELECTRIC_BIKES_PAGES}"
get_page "${KIDS_BIKES_BASE}" "${KIDS_BIKES_PAGES}"
get_page "${MTB_29_BIKES_BASE}" "${MTB_29_BIKES_PAGES}"
