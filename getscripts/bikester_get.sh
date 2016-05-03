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
URL="www.bikester.es"
ONLY_DOMAIN="bikester.es"
MAX_TRIES=15
MAX_TIMEOUT=20

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

MTB_FIX_BIKES_BASE="${URL}/bicicletas/bicicletas-de-montana.html?page="
MTB_FIX_BIKES_PAGES="$(seq 0 15)"

MTB_DOUBLE_BIKES_BASE="${URL}/bicicletas/bicicletas-doble-suspension.html?page="
MTB_DOUBLE_BIKES_PAGES="$(seq 0 15)"

MTB_29_BIKES_BASE="${URL}/bicicletas/bicicletas-29-pulgadas.html?page="
MTB_29_BIKES_PAGES="$(seq 0 3)"

KIDS_BIKES_BASE="${URL}/bicicletas/bicicletas-para-ninos.html?page="
KIDS_BIKES_PAGES="$(seq 0 10)"

BTT_KIDS_BIKES_BASE="${URL}/bicicletas/bicicletas-juveniles-bicicletas-todo-terreno.html?page="
BTT_KIDS_BIKES_PAGES="$(seq 0 1)"

BTT_JUNIOR_BIKES_BASE="${URL}/bicicletas/bicicletas-junior.html?page="
BTT_JUNIOR_BIKES_PAGES="$(seq 0 3)"

BMX_BIKES_BASE="${URL}/bicicletas/bmx.html?page="
BMX_BIKES_PAGES="$(seq 0 5)"

ROAD_BIKES_BASE="${URL}/bicicletas/bicicletas-de-carretera.html?page="
ROAD_BIKES_PAGES="$(seq 0 10)"

ROAD_CICLOCROSS_BIKES_BASE="${URL}/bicicletas/bicicletas-fitness-bicicletas-ciclocross.html"
ROAD_CICLOCROSS_BIKES_PAGES=""

URBAN_XC_BIKES_BASE="${URL}/bicicletas/bicicletas-xc-.html?page="
URBAN_XC_BIKES_PAGES="$(seq 0 3)"

URBAN_SINGLE_BIKES_BASE="${URL}/bicicletas/bicicletas-single-speed.html"
URBAN_SINGLE_BIKES_PAGES=""

URBAN_WALK_BIKES_BASE="${URL}/bicicletas/bicicleta-de-paseo.html?page="
URBAN_WALK_BIKES_PAGES="$(seq 0 5)"

URBAN_FOLDING_BIKES_BASE="${URL}/bicicletas/bicicletas-plegables-.html?page="
URBAN_FOLDING_BIKES_PAGES="$(seq 0 3)"

URBAN_FOLDING2_BIKES_BASE="${URL}/bicicletas/bicicletas-plegables.html?page="
URBAN_FOLDING2_BIKES_PAGES="$(seq 0 3)"

URBAN_RETRO_BIKES_BASE="${URL}/bicicletas/cruiser-retro/cruiser.html?page="
URBAN_RETRO_BIKES_PAGES="$(seq 0 2)"

URBAN_CRUISER_BIKES_BASE="${URL}/bicicletas/cruiser.html?page="
URBAN_CRUISER_BIKES_PAGES="$(seq 0 3)"

URBAN_ELECT_BIKES_BASE="${URL}/bicicletas/bicicletas-electricas-pedelec.html?page="
URBAN_ELECT_BIKES_PAGES="$(seq 0 5)"

URBAN_ELECT2_BIKES_BASE="${URL}/bicicletas/bicicletas-electricas.html?page="
URBAN_ELECT2_BIKES_PAGES="$(seq 0 5)"

URBAN_RAW_BIKES_BASE="${URL}/bicicletas/bicicletas-urbanas.html?page="
URBAN_RAW_BIKES_PAGES="$(seq 0 2)"

URBAN_TREKKING_BIKES_BASE="${URL}/bicicletas/bicicletas-trekking.html?page="
URBAN_TREKKING_BIKES_PAGES="$(seq 0 5)"

URBAN_HYBRID_BIKES_BASE="${URL}/bicicletas/bicicletas-hibridas.html?page="
URBAN_HYBRID_BIKES_PAGES="$(seq 0 5)"

#MAP_BIKES_BASE="${URL}/mapa-del-sitio/mapa-del-sitio-bicicletas.html"
MAP_BIKES_BASE="${URL}/sitemap/category/81208"
MAP_BIKES_PAGES=""

get_page "${MAP_BIKES_BASE}" "${MAP_BIKES_PAGES}"
