#!/bin/bash
#
# This script gets all the bicycles from
# Bicimania store !
# URL: www.bicimania.com
URL="www.bikeos.com"
ONLY_DOMAIN="bikeos.com"
EXCLUDE="-Rgif -Rpng -Rjpg"

function get_page()
{
  BASE_URL="$1"
  PAGES="$2"
  if [ "${PAGES}" = "" ];
  then
    wget "${BASE_URL}" 
  else
    for page in ${PAGES};
    do
      wget "${BASE_URL}${page}" 
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

FOLDING_BIKES_BASE="${URL}/index.php/bicicletas/plegables.html?p="
FOLDING_BIKES_PAGES="$(seq 1 5)"

ELECTRIC_BIKES_BASE="${URL}/index.php/bicicletas/electricas.html?p="
ELECTRIC_BIKES_PAGES="$(seq 1 20)"

KIDS_BIKES_BASE="${URL}/index.php/bicicletas/infantil.html?p="
KIDS_BIKES_PAGES="$(seq 1 10)"

get_page "${ROAD_BIKES_BASE}" "${ROAD_BIKES_PAGES}"
get_page "${MTB_BIKES_BASE}" "${MTB_BIKES_PAGES}"
get_page "${BMX_BIKES_BASE}" "${BMX_BIKES_PAGES}"
get_page "${TREKKING_OUTLET_BIKES_BASE}" "${TREKKING_OUTLET_BIKES_PAGES}"
get_page "${TREKKING_2012_BIKES_BASE}" "${TREKKING_2012_BIKES_PAGES}"
get_page "${TREKKING_2013_BIKES_BASE}" "${TREKKING_2013_BIKES_PAGES}"
get_page "${FOLDING_BIKES_BASE}" "${FOLDING_BIKES_PAGES}"
get_page "${ELECTRIC_BIKES_BASE}" "${ELECTRIC_BIKES_PAGES}"
get_page "${KIDS_BIKES_BASE}" "${KIDS_BIKES_PAGES}"
