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
OUTPUT_FILE=bicimania.txt
URL="www.bicimania.com"
ONLY_DOMAIN="bicimania.com"
EXCLUDE="-Rgif -Rpng -Rjpg"
MAX_TRIES=20
MAX_TIMEOUT=10
#EXCLUDE="-Ahtml"
#HOST_ONLY="-D${ONLY_DOMAIN}"

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

FIX_BIKES_BASE="http://bicimania.com/mtb-rigida-c-21_28.html?page="
FIX_BIKES_PAGES=$(seq 1 10)

DOUBLE_BIKES_BASE="http://bicimania.com/doble-suspension-c-21_30.html?page="
DOUBLE_BIKES_PAGES=$(seq 1 10)

ROAD_BIKES_BASE="http://bicimania.com/carretera-c-21_32.html?page="
ROAD_BIKES_PAGES=$(seq 1 10)

BMX_BIKES_BASE="http://bicimania.com/bmx-y-freestyle-c-21_31.html"

CONFORT_BIKES_BASE="http://bicimania.com/confort-c-21_107.html?page="
CONFORT_BIKES_PAGES=$(seq 1 3)

FOLDING_BIKES_BASE="http://bicimania.com/plegables-c-21_133.html?page="
FOLDING_BIKES_PAGES=$(seq 1 3)

CHILDREN_BIKES_BASE="http://bicimania.com/bicis-nino-c-21_98.html"

get_page "${FIX_BIKES_BASE}" "${FIX_BIKES_PAGES}"
get_page "${DOUBLE_BIKES_BASE}" "${DOUBLE_BIKES_PAGES}"
get_page "${ROAD_BIKES_BASE}" "${ROAD_BIKES_PAGES}"
get_page "${BMX_BIKES_BASE}" ""
get_page "${CONFORT_BIKES_BASE}" "${CONFORT_BIKES_PAGES}"
get_page "${FOLDING_BIKES_BASE}" "${FOLDING_BIKES_PAGES}"
get_page "${CHILDREN_BIKES_BASE}" ""
