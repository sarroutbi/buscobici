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
# Biciescapa store !
#
URL="www.csbike.es"
ONLY_DOMAIN="csbike.es"
MAX_TRIES=10
MAX_TIMEOUT=10

function get_page()
{
  BASE_URL="$1"
  PAGES="$2"
  OUTPUT_FILE="$3"
  
  if [ "${OUTPUT_FILE}" = "" ];
  then
    OUT_OPTION=""    
  else
    OUT_OPTION="-O${3}" 
  fi

  if [ "${PAGES}" = "" ];
  then
    wget --tries=${MAX_TRIES} --timeout=${MAX_TIMEOUT} "${BASE_URL}" "${OUT_OPTION}_${page}"
  else
    for page in ${PAGES};
    do
      wget --tries=${MAX_TRIES} --timeout=${MAX_TIMEOUT} "${BASE_URL}${page}" "${OUT_OPTION}_${page}"
    done 
  fi
}

BH_BIKES_BASE="${URL}/products/index/bicicletas/bh_bikes/page:"
BH_BIKES_PAGES="$(seq 1 6)"

CUBE_BIKES_BASE="${URL}/products/index/bicicletas/cube/page:"
CUBE_BIKES_PAGES="$(seq 1 3)"

GT_BIKES_BASE="${URL}/products/index/bicicletas/gt_bicycles/page:"
GT_BIKES_PAGES="$(seq 1 4)"

STEVENS_BIKES_BASE="${URL}/products/index/bicicletas/stevens/page:" 
STEVENS_BIKES_PAGES="$(seq 1 4)"

OTHER_BIKES_BASE="${URL}/products/index/bicicletas/gt_bicycles/page:" 
OTHER_BIKES_PAGES="$(seq 1 2)"

get_page "${BH_BIKES_BASE}"      "${BH_BIKES_PAGES}"      "bh_bikes"
get_page "${CUBE_BIKES_BASE}"    "${CUBE_BIKES_PAGES}"    "cube_bikes"
get_page "${GT_BIKES_BASE}"      "${GT_BIKES_PAGES}"      "gt_bikes"
get_page "${STEVENS_BIKES_BASE}" "${STEVENS_BIKES_PAGES}" "stevens_bikes"
get_page "${OTHER_BIKES_BASE}"   "${OTHER_BIKES_PAGES}"   "other_bikes"
