#!/bin/bash
#
# This script gets all the bicycles from
# Bicimania store !
# URL: www.bicimania.com
URL="www.bicimarket.com"
ONLY_DOMAIN="bicimarket.com"
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

MTB_29_BIKES_BASE="${URL}/Bicicletas-29-pulgadas-c20380.html"
MTB_29_BIKES_PAGES=""

ELECTRIC_BIKES_BASE="${URL}/Bicicletas-Bicicleta-Electrica-c20130.html"
ELECTRIC_BIKES_PAGES=""

TRIAL_BIKES_BASE="${URL}/Bicicletas-BikeTrial-c20131.html"
TRIAL_BIKES_PAGES=""

BMX_BIKES_BASE="${URL}/Bicicletas-BMX-c20249.html"
BMX_BIKES_PAGES=

ROAD_BIKES_BASE="${URL}/Bicicletas-Carretera-c10020.html"
ROAD_BIKES_PAGES=""

CICLOCROSS_BIKES_BASE="${URL}/Bicicletas-Ciclocross-c20270.html"
CICLOCROSS_BIKES_PAGES=""

MTB_XC_BIKES_BASE="${URL}/Bicicletas-Cross-country-c1010.html"
MTB_XC_BIKES_PAGES=""

DIRT_BIKES_BASE="${URL}/Bicicletas-Dirt-c20303.html"
DIRT_BIKES_PAGES=$""

DOUBLE_FREERIDE_BIKES_BASE="${URL}/Bicicletas-Doble-Freeride-DH-c20164.html"
DOUBLE_FREERIDE_BIKES_PAGES=""

MTB_DOUBLE_BIKES_BASE="${URL}/Bicicletas-Doble-XC-Enduro-c20075.html"
MTB_DOUBLE_BIKES_PAGES=""

FIXIE_BIKES_BASE="${URL}/Bicicletas-Fixed-c20306.html"
FIXIE_BIKES_PAGES=""

HYBRID_BIKES_BASE="${URL}/Bicicletas-Hibrida-c10050.html"
HYBRID_BIKES_PAGES=""

JUNIOR_BIKES_BASE="${URL}/Bicicletas-Infantil-c20177.html"
JUNIOR_BIKES_PAGES=""

LADY_BIKES_BASE="${URL}/Bicicletas-Lady-c20253.html"
LADY_BIKES_PAGES=""

FOLDING_BIKES_BASE="${URL}/Bicicletas-Plegable-c10070.html"
FOLDING_BIKES_PAGES=""

TRIATLON_BIKES_BASE="${URL}/Bicicletas-Triatlon-c20376.html"
TRIATLON_BIKES_PAGES=""

URBAN_BIKES_BASE="${URL}/Bicicletas-Urbanas-c10030.html"
URBAN_BIKES_PAGES=""

get_page "${MTB_29_BIKES_BASE}"
get_page "${ELECTRIC_BIKES_BASE}"
get_page "${TRIAL_BIKES_BASE}"
get_page "${BMX_BIKES_BASE}"
get_page "${ROAD_BIKES_BASE}"
get_page "${CICLOCROSS_BIKES_BASE}"
get_page "${MTB_XC_BIKES_BASE}"
get_page "${DIRT_BIKES_BASE}"
get_page "${DOUBLE_FREERIDE_BIKES_BASE}"
get_page "${MTB_DOUBLE_BIKES_BASE}"
get_page "${FIXIE_BIKES_BASE}"
get_page "${HYBRID_BIKES_BASE}"
get_page "${JUNIOR_BIKES_BASE}"
get_page "${LADY_BIKES_BASE}"
get_page "${FOLDING_BIKES_BASE}"
get_page "${TRIATLON_BIKES_BASE}"
get_page "${URBAN_BIKES_BASE}"