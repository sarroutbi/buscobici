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
# This script gets all the bicycles from
# Bicimania store !
# URL: www.bicimania.com
URL="www.bikestocks.es"
ONLY_DOMAIN="bikestocks.es"
EXCLUDE="-Rgif -Rpng -Rjpg"
MAX_TRIES=15
MAX_TIMEOUT=15

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

# 2015 review
MTB_26_BIKES_BASE="${URL}/bicicletas-26-pulgadas-mtb-573?p="
MTB_26_BIKES_PAGES="$(seq 1 3)"

bubic_get_page_outfile "${MTB_26_BIKES_BASE}" "${MTB_26_BIKES_PAGES}" mtb-26

MTB_27_BIKES_BASE="${URL}/mountain-bike-27-5-574?p="
MTB_27_BIKES_PAGES="$(seq 1 7)"

bubic_get_page_outfile "${MTB_27_BIKES_BASE}" "${MTB_27_BIKES_PAGES}" mtb-27

MTB_29_BIKES_BASE="${URL}/bicicletas-29-pulgadas-mtb-575?p="
MTB_29_BIKES_PAGES="$(seq 1 7)"

bubic_get_page_outfile "${MTB_29_BIKES_BASE}" "${MTB_29_BIKES_PAGES}" mtb-29

ROAD_BIKES_BASE="${URL}/bicicletas-de-carretera-571?p="
ROAD_BIKES_PAGES="$(seq 1 6)"

bubic_get_page_outfile "${ROAD_BIKES_BASE}" "${ROAD_BIKES_PAGES}" road

ROAD_TRIATLON_BIKES_BASE="${URL}/bicicletas-de-triatlon-415?p="
ROAD_TRIATLON_BIKES_PAGES="$(seq 1 2)"

bubic_get_page_outfile "${ROAD_TRIATLON_BIKES_BASE}" "${ROAD_TRIATLON_BIKES_PAGES}" road-triatlon

URBAN_ELECTRIC_BIKES_BASE="${URL}/bicicletas-electricas-71?p="
URBAN_ELECTRIC_BIKES_PAGES="$(seq 1 2)"

bubic_get_page_outfile "${URBAN_ELECTRIC_BIKES_BASE}" "${URBAN_ELECTRIC_BIKES_PAGES}" urban-electric

BMX_BIKES_BASE="${URL}/bicicletas-bmx-trial-y-freeride-594?p="
BMX_BIKES_PAGES="$(seq 1 2)"

bubic_get_page_outfile "${BMX_BIKES_BASE}" "${BMX_BIKES_PAGES}" bmx

URBAN_WALK_BIKES_BASE="${URL}/bicicletas-de-paseo-155?p="
URBAN_WALK_BIKES_PAGES="$(seq 1 2)"

bubic_get_page_outfile "${URBAN_WALK_BIKES_BASE}" "${URBAN_WALK_BIKES_PAGES}" urban-walk

URBAN_TREKKING_BIKES_BASE="${URL}/bicicletas-trekking-476?p="
URBAN_TREKKING_BIKES_PAGES="$(seq 1 3)"

bubic_get_page_outfile "${URBAN_TREKKING_BIKES_BASE}" "${URBAN_TREKKING_BIKES_PAGES}" urban-trekking

URBAN_FOLDING_BIKES_BASE="${URL}/bicicletas-plegables-158?p="
URBAN_FOLDING_BIKES_PAGES="$(seq 1 3)"

bubic_get_page_outfile "${URBAN_FOLDING_BIKES_BASE}" "${URBAN_FOLDING_BIKES_PAGES}" urban-folding

MTB_WOMAN_BIKES_BASE="${URL}/bicicletas-mujer-montana-576?p="
MTB_WOMAN_BIKES_PAGES="$(seq 1 2)"

bubic_get_page_outfile "${MTB_WOMAN_BIKES_BASE}" "${MTB_WOMAN_BIKES_PAGES}" mtb-woman

KIDS_BIKES_BASE="${URL}/bicicletas-para-ninos-352?p="
KIDS_BIKES_PAGES="$(seq 1 3)"

bubic_get_page_outfile "${KIDS_BIKES_BASE}" "${KIDS_BIKES_PAGES}" kids
