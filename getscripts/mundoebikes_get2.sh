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
# Biciescapa store !
#
URL="www.mundoebikes.es"
ONLY_DOMAIN="mundoebikes.es"
MAX_TRIES=10
MAX_TIMEOUT=10

. ./common_get

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

### BMX ###
BMX_BIKES_BASE="${URL}/10-bicicletas-bmx?p="
BMX_BIKES_PAGES="$(seq 1 3)"

### ROAD ###
ROAD_BIKES_BASE="${URL}/21-bicicletas-ruta?p="
ROAD_BIKES_PAGES="$(seq 1 5)"

ROAD_TRIATLON_BASE="${URL}/22-bicicletas-contrarreloj?p="
ROAD_TRIATLON_PAGES="$(seq 1 3)"

### URBAN ###
URBAN_RETRO_BASE="${URL}/31-bicicletas-clásicas?p="
URBAN_RETRO_PAGES="$(seq 1 9)"

URBAN_CITY_BASE="${URL}/33-bicicletas-paseo?p="
URBAN_CITY_PAGES="$(seq 1 9)"

URBAN_CRUISER_BASE="${URL}/34-bicicletas-playeras-cruisers?p="
URBAN_CRUISER_PAGES="$(seq 1 6)"

URBAN_FOLDING_BIKES_BASE="${URL}/35-bicicletas-plegables?p="
URBAN_FOLDING_BIKES_PAGES="$(seq 1 4)"

URBAN_FIXIE_BASE="${URL}/32-bicicletas-fixed?p="
URBAN_FIXIE_PAGES="$(seq 1 3)"

URBAN_ELECTRIC_BIKES_BASE="${URL}/51-bicicletas-eléctricas-ciudad?p="
URBAN_ELECTRIC_BIKES_PAGES="$(seq 1 4)"

URBAN_EFOLDING_BIKES_BASE="${URL}/53-bicicletas-eléctricas-plegables?p="
URBAN_EFOLDING_BIKES_PAGES="$(seq 1 4)"

URBAN_TREKKING_BASE="${URL}/100-bicicletas-trekking?p="
URBAN_TREKKING_PAGES="$(seq 1 3)"

URBAN_WORK_BASE="${URL}/110-bicicletas-de-carga?p="
URBAN_WORK_PAGES="$(seq 1 3)"

### MTB ###
MTB_BIKES_BASE="${URL}/81-bicicletas-montaña-adultos?p="
MTB_BIKES_PAGES="$(seq 1 16)"

MTB_ELECTRIC_BIKES_BASE="${URL}/52-bicicletas-electricas-deportivas?p="
MTB_ELECTRIC_BIKES_PAGES="$(seq 1 3)"

### KIDS ###
KIDS_BIKES_BASE="${URL}/120-bicicletas-infantiles?p="
KIDS_BIKES_PAGES="$(seq 1 7)"

KIDS_MTB_BIKES_BASE="${URL}/82-bicicletas-montaña-junior?p="
KIDS_MTB_BIKES_PAGES="$(seq 1 6)"

### BMX ###
bubic_get_page_outfile "${BMX_BIKES_BASE}"     "${BMX_BIKES_PAGES}"     bmx

### ROAD ###
bubic_get_page_outfile "${ROAD_BIKES_BASE}"    "${ROAD_BIKES_PAGES}"    road
bubic_get_page_outfile "${ROAD_TRIATLON_BASE}" "${ROAD_TRIATLON_PAGES}" road-triatlon

### URBAN ###
bubic_get_page_outfile "${URBAN_RETRO_BASE}"   "${URBAN_RETRO_PAGES}" urban-retro
bubic_get_page_outfile "${URBAN_CITY_BASE}"    "${URBAN_CITY_PAGES}"  urban-city
bubic_get_page_outfile "${URBAN_CRUISER_BASE}" "${URBAN_CRUISER_PAGES}" urban-cruiser
bubic_get_page_outfile "${URBAN_FOLDING_BIKES_BASE}" "${URBAN_FOLDING_BIKES_PAGES}" urban-folding
bubic_get_page_outfile "${URBAN_FIXIE_BASE}"   "${URBAN_FIXIE_PAGES}" urban-fixie
bubic_get_page_outfile "${URBAN_ELECTRIC_BIKES_BASE}" "${URBAN_ELECTRIC_BIKES_PAGES}" urban-electric
bubic_get_page_outfile "${URBAN_EFOLDING_BIKES_BASE}" "${URBAN_EFOLDING_BIKES_PAGES}" urban-folding-electric
bubic_get_page_outfile "${URBAN_TREKKING_BASE}" "${URBAN_TREKKING_PAGES}" urban-trekking
bubic_get_page_outfile "${URBAN_WORK_BASE}" "${URBAN_WORK_PAGES}" urban-work

### MTB
bubic_get_page_outfile "${MTB_BIKES_BASE}" "${MTB_BIKES_PAGES}" mtb
bubic_get_page_outfile "${MTB_ELECTRIC_BIKES_BASE}" "${MTB_ELECTRIC_BIKES_PAGES}" mtb-electric

### KIDS
bubic_get_page_outfile "${KIDS_BIKES_BASE}" "${KIDS_BIKES_PAGES}" kids
bubic_get_page_outfile "${KIDS_MTB_BIKES_BASE}" "${KIDS_MTB_BIKES_PAGES}" kids-mtb
