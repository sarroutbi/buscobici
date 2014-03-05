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
URL="www.mundoebikes.es"
ONLY_DOMAIN="mundoebikes.es"
MAX_TRIES=10
MAX_TIMEOUT=10

function get_page()
{
  BASE_URL="$1"
  PAGES="$2"
  sleep 5
  if [ "${PAGES}" = "" ];
  then
    wget -w5 --random-wait -e robots=off -U 'mozilla' \
      --tries=${MAX_TRIES} --timeout=${MAX_TIMEOUT} "${BASE_URL}" 
  else
    for page in ${PAGES};
    do
      wget -w6 --random-wait -e robots=off -U 'mozilla' \
        --tries=${MAX_TRIES} --timeout=${MAX_TIMEOUT} "${BASE_URL}${page}" 
    done 
  fi
}

BMX_BIKES_BASE="${URL}/bicicletas-bmx-freestyle"
BMX_BIKES_PAGES=""

ROAD_BIKES_BASE="${URL}/bicicletas-de-carretera?limit=20&limitstart="
ROAD_BIKES_PAGES="0 20 40"

ROAD_TRIATLON_BASE="${URL}/bicicletas-triatlon-contrarreloj"
ROAD_TRIATLON_PAGES=""

URBAN_ELECTRIC_BIKES_BASE="${URL}/bicicletas-electricas-deportivas?limit=20&limitstart="
URBAN_ELECTRIC_BIKES_PAGES="0 20"

URBAN_FOLDING_BIKES_BASE="${URL}/bicicletas-ciudad-paseo-urbanas-plegables"
URBAN_FOLDING_BIKES_PAGES=""

URBAN_EFOLDING_BIKES_BASE="${URL}/bicicletas-electricas-plegables"
URBAN_EFOLDING_BIKES_PAGES=""

URBAN_EBIKES_BASE="${URL}/bicicletas-electricas-urbanas?limit=20&limitstart="
URBAN_EBIKES_PAGES="0 20 40"

URBAN_FIXIE_BASE="${URL}/bicicletas-fixed-and-single-speed"
URBAN_FIXIE_PAGES=""

URBAN_CRUISER_BASE="${URL}/bicicletas-cruisers"
URBAN_CRUISER_PAGES=""

URBAN_TREKKING_BASE="${URL}/bicicletas-trekking?limit=20&limitstart="
URBAN_TREKKING_PAGES="0 20 40"

URBAN_CITY_BASE="${URL}/bicicletas-ciudad-paseo-urbanas?limit=20&limitstart="
URBAN_CITY_PAGES="0 20 40 60"

MTB29_BIKES_BASE="${URL}/bicicletas-mtb-29r?limit=20&limitstart="
MTB29_BIKES_PAGES="0 20"

MTB_ALU_BIKES_BASE="${URL}/bicicletas-mtb-aluminio?limit=20&limitstart="
MTB_ALU_BIKES_PAGES="0 20 40 60 80 100"

MTB_CAR_BIKES_BASE="${URL}/bicicletas-mtb-carbono"
MTB_CAR_BIKES_PAGES=""

MTB_DOUBLE_BIKES_BASE="${URL}/bicicletas-mtb-doble-susp?limit=20&limitstart="
MTB_DOUBLE_BIKES_PAGES=""

KIDS_BIKES_BASE="${URL}/bicicletas-infantiles?limit=20&limitstart="
KIDS_BIKES_PAGES="0 20 40 60"

KIDS_MTB_BIKES_BASE="${URL}/bicicletas-mtb-junior?limit=20&limitstart="
KIDS_MTB_BIKES_PAGES="0 20 40"

get_page "${BMX_BIKES_BASE}"                    "${BMX_BIKES_PAGES}"
get_page "${ROAD_BIKES_BASE}"                   "${ROAD_BIKES_PAGES}"
get_page "${ROAD_TRIATLON_BASE}"                "${ROAD_TRIATLON_PAGES}"
get_page "${URBAN_ELECTRIC_BIKES_BASE}"         "${URBAN_ELECTRIC_BIKES_PAGES}"
get_page "${URBAN_FOLDING_BIKES_BASE}"          "${URBAN_FOLDING_BIKES_PAGES}"
get_page "${URBAN_EFOLDING_BIKES_BASE}"         "${URBAN_EFOLDING_BIKES_PAGES}"
get_page "${URBAN_EBIKES_BASE}"                 "${URBAN_EBIKES_PAGES}"
get_page "${URBAN_FIXIE_BASE}"                  "${URBAN_FIXIE_PAGES}"
get_page "${URBAN_CRUISER_BASE}"                "${URBAN_CRUISER_PAGES}"
get_page "${URBAN_TREKKING_BASE}"               "${URBAN_TREKKING_PAGES}"
get_page "${URBAN_CITY_BASE}"                   "${URBAN_CITY_PAGES}"
get_page "${MTB29_BIKES_BASE}"                  "${MTB29_BIKES_PAGES}"
get_page "${MTB_ALU_BIKES_BASE}"                "${MTB_ALU_BIKES_PAGES}"
get_page "${MTB_CAR_BIKES_BASE}"                "${MTB_CAR_BIKES_PAGES}"
get_page "${MTB_DOUBLE_BIKES_BASE}"             "${MTB_DOUBLE_BIKES_PAGES}"
get_page "${KIDS_BIKES_BASE}"                   "${KIDS_BIKES_PAGES}"
get_page "${KIDS_MTB_BIKES_BASE}"               "${KIDS_MTB_BIKES_PAGES}"

