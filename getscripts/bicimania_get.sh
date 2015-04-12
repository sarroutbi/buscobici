#!/bin/bash
#
# Copyright © 2012-2015 Sergio Arroutbi Braojos <sarroutbi@gmail.com>
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
OUTPUT_FILE=bicimania.txt
URL="www.bicimania.com"
ONLY_DOMAIN="bicimania.com"
EXCLUDE="-Rgif -Rpng -Rjpg"
MAX_TRIES=20
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

FIX_BIKES_BASE="http://bicimania.com/es/4-montana-rigidas?p="
FIX_BIKES_PAGES=$(seq 1 5)

DOUBLE_BIKES_BASE="http://bicimania.com/es/169-montana-doble-suspension-todas?p="
DOUBLE_BIKES_PAGES=$(seq 1 5)

MTB_WOMAN_BIKES_BASE="http://bicimania.com/es/170-montana-de-mujer?p="
MTB_WOMAN_BIKES_PAGES=$(seq 1 3)

ROAD_BIKES_BASE="http://bicimania.com/es/26-carretera?p="
ROAD_BIKES_PAGES=$(seq 1 6)

BMX_BIKES_BASE="http://bicimania.com/es/11-bmx-campillo"

CHILDREN_BIKES_BASE="http://bicimania.com/es/16-ninos?p="
CHILDREN_BIKES_PAGES=$(seq 1 3)

URBAN_BIKES_BASE="http://bicimania.com/es/7-urbanas?p="
URBAN_BIKES_PAGES=$(seq 1 4)

URBAN_ELECTRIC_BIKES_BASE="http://bicimania.com/es/23-urbanas"

MTB_ELECTRIC_BIKES_BASE="http://bicimania.com/es/38-montana"

get_page "${FIX_BIKES_BASE}" "${FIX_BIKES_PAGES}"
get_page "${DOUBLE_BIKES_BASE}" "${DOUBLE_BIKES_PAGES}"
get_page "${ROAD_BIKES_BASE}" "${ROAD_BIKES_PAGES}"
get_page "${BMX_BIKES_BASE}" ""
get_page "${CHILDREN_BIKES_BASE}" "${CHILDREN_BIKES_PAGES}"
get_page "${URBAN_BIKES_BASE}" "${URBAN_BIKES_PAGES}"
get_page "${URBAN_ELECTRIC_BIKES_BASE}" ""
get_page "${MTB_ELECTRIC_BIKES_BASE}" ""
