#!/bin/bash
#
# Copyright © 2012-2016 Sergio Arroutbi Braojos <sarroutbi@gmail.com>
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
URL="bicispasaje.es"
ONLY_DOMAIN="bicispasaje.es"
MAX_TRIES=15
MAX_TIMEOUT=15

. ./common_get

function get_pages()
{
  BASE_URL="$1"
  PAGES="$2"
  if [ "${PAGES}" = "" ];
  then
    wget --tries=${MAX_TRIES} --timeout=${MAX_TIMEOUT} "${BASE_URL}" 
  else
    for page in ${PAGES};
    do
      wget --tries=${MAX_TRIES} --timeout=${MAX_TIMEOUT} "${BASE_URL}?p=${page}"
    done 
  fi
}

MTB_BIKES_26_BASE="${URL}/7-mtb-rígidas"
MTB_BIKES_26_PAGES=""
MTB_BIKES_CUBE_26_BASE="${URL}/160-cube-rígidas-26-2014"
MTB_BIKES_MMR_26_BASE="${URL}/181-mmr-rígidas-26-2014"
MTB_BIKES_27_5_BASE="${URL}/158-mtb-rígida-275?p="
MTB_BIKES_27_5_PAGES="$(seq 1 7)"
MTB_BIKES_29_BASE="${URL}/10-mtb-rígida-29er?p="
MTB_BIKES_29_PAGES="$(seq 1 9)"
MTB_BIKES_DOUBLE_26_BASE="${URL}/17-doble-susp-26"
MTB_BIKES_DOUBLE_27_5_BASE="${URL}/164-doble-susp-275-?p="
MTB_BIKES_DOUBLE_27_5_PAGES="$(seq 1 4)"
MTB_BIKES_DOUBLE_29_BASE="${URL}/21-doble-susp-29?p="
MTB_BIKES_DOUBLE_29_PAGES="$(seq 1 3)"
MTB_2013_BIKES_BASE="${URL}/64-bicis-mtb-2013"
ROAD_BIKES_BASE="${URL}/31-carretera?p="
ROAD_BIKES_PAGES="$(seq 1 7)"
ROAD_2013_BIKES_BASE="${URL}/63-bicis-carretera-2013"
ROAD_TRIATLON_BIKES_BASE="${URL}/142-triatlón"
KIDS_BIKES_BASE="${URL}/34-infantilesbmx?p="
KIDS_BIKES_PAGES="$(seq 1 3)"
WOMAN_BIKES_BASE="${URL}/122-dama?p="
WOMAN_BIKES_PAGES="$(seq 1 3)"
URBAN_BIKES_BASE="${URL}/153-trekking-ciudad?p="
URBAN_BIKES_PAGES="$(seq 1 3)"
URBAN_2013_BIKES_BASE="${URL}/178-trekking-ciudad?p="
URBAN_2013_BIKES_PAGES="$(seq 1 3)"

bubic_get_page_outfile "${MTB_BIKES_26_BASE}" "${MTB_BIKES_26_PAGES}" mtb-26
bubic_get_page_outfile "${MTB_BIKES_CUBE_26_BASE}" "${MTB_BIKES_CUBE_26_PAGES}" mtb-26-cube
bubic_get_page_outfile "${MTB_BIKES_MMR_26_BASE}" "${MTB_BIKES_MMR_26_PAGES}" mtb-26-mmr
bubic_get_page_outfile "${MTB_BIKES_27_5_BASE}" "${MTB_BIKES_27_5_PAGES}" mtb-27-5
bubic_get_page_outfile "${MTB_BIKES_29_BASE}" "${MTB_BIKES_29_PAGES}" mtb-29
bubic_get_page_outfile "${MTB_BIKES_DOUBLE_26_BASE}" "${MTB_BIKES_DOUBLE_26_PAGES}" mtb-double-26
bubic_get_page_outfile "${MTB_BIKES_DOUBLE_27_5_BASE}" "${MTB_BIKES_DOUBLE_27_5_PAGES}" mtb-double-27-5
bubic_get_page_outfile "${MTB_BIKES_DOUBLE_29_BASE}" "${MTB_BIKES_DOUBLE_29_PAGES}" mtb-double-29
bubic_get_page_outfile "${MTB_2013_BIKES_BASE}" "${MTB_2013_BIKES_PAGES}" mtb-2013
bubic_get_page_outfile "${ROAD_BIKES_BASE}" "${ROAD_BIKES_PAGES}" road
bubic_get_page_outfile "${ROAD_TRIATLON_BIKES_BASE}" "${ROAD_TRIATLON_BIKES_PAGES}" road-triatlon
bubic_get_page_outfile "${ROAD_2013_BIKES_BASE}" "${ROAD_2013_BIKES_PAGES}" road-2013
bubic_get_page_outfile "${KIDS_BIKES_BASE}" "${KIDS_BIKES_PAGES}" kids
bubic_get_page_outfile "${WOMAN_BIKES_BASE}" "${WOMAN_BIKES_PAGES}" woman
bubic_get_page_outfile "${URBAN_BIKES_BASE}" "${URBAN_BIKES_PAGES}" urban
bubic_get_page_outfile "${URBAN_2013_BIKES_BASE}" "${URBAN_2013_BIKES_PAGES}" urban-2013
