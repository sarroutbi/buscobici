#!/bin/bash
#
# This script gets all the bicycles from
# Calmera store !
URL="www.probike.com"
ONLY_DOMAIN="probike.com"
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


ROAD_BIKES_BASE="${URL}/bicicletas/carretera.html?p=1"
ROAD_BIKES_PAGES="$(seq 1 3)"

BMX_BIKES_BASE="${URL}/bicicletas/free-dh.html"

KIDS_BIKES_BASE="${URL}/bicicletas/infantil.html"

MTB_BIKES_BASE="${URL}/bicicletas/mtb.html?p="
MTB_BIKES_PAGES=$(seq 1 8)

URBAN_BIKES_BASE="${URL}/bicicletas/urbana.html?p="
URBAN_BIKES_PAGES=$(seq 1 3)

get_pages "${ROAD_BIKES_BASE}"  "${ROAD_BIKES_PAGES}"
get_pages "${BMX_BIKES_BASE}"   "${BMX_BIKES_PAGES}"
get_pages "${KIDS_BIKES_BASE}"  "${KIDS_BIKES_PAGES}"
get_pages "${MTB_BIKES_BASE}"   "${MTB_BIKES_PAGES}"
get_pages "${URBAN_BIKES_BASE}" "${URBAN_BIKES_PAGES}"
