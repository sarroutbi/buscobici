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
URL="www.probike.com"
ONLY_DOMAIN="probike.com"
EXCLUDE="-Rgif -Rpng -Rjpg"
MAX_TRIES=15
MAX_TIMEOUT=15

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


ROAD_BIKES_BASE="${URL}/bicicletas/carretera.html?p="
ROAD_BIKES_PAGES="$(seq 1 3)"

BMX_BIKES_BASE="${URL}/bicicletas/free-dh.html"

KIDS_BIKES_BASE="${URL}/bicicletas/infantil.html"

MTB_BIKES_BASE="${URL}/bicicletas/mtb.html?p="
MTB_BIKES_PAGES=$(seq 1 8)

URBAN_BIKES_BASE="${URL}/bicicletas/urbana.html?p="
URBAN_BIKES_PAGES=$(seq 1 3)

get_page "${ROAD_BIKES_BASE}"  "${ROAD_BIKES_PAGES}"
get_page "${BMX_BIKES_BASE}"   "${BMX_BIKES_PAGES}"
get_page "${KIDS_BIKES_BASE}"  "${KIDS_BIKES_PAGES}"
get_page "${MTB_BIKES_BASE}"   "${MTB_BIKES_PAGES}"
get_page "${URBAN_BIKES_BASE}" "${URBAN_BIKES_PAGES}"
