#!/bin/bash
#
# This script gets all the bicycles from
# Calmera store !
URL="www.chainreactioncycles.com"
ONLY_DOMAIN="www.chainreactioncycles.com"

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


MTB_BIKES_BASE="${URL}/tienda/category.php?id_category=32&p="
MTB_BIKES_PAGES="$(seq 1 5)"

ROAD_BIKES_BASE="${URL}/tienda/category.php?id_category=31&p="
ROAD_BIKES_PAGES="$(seq 1)"

URBAN_BIKES_BASE="${URL}/tienda/category.php?id_category=33&p="
URBAN_BIKES_PAGES="$(seq 1)"

KIDS_BIKES_BASE="${URL}/tienda/category.php?id_category=34&p="
KIDS_BIKES_PAGES="$(seq 1)"

BMX_BIKES_BASE="${URL}/tienda/category.php?id_category=35&p="
BMX_BIKES_PAGES="$(seq 1)"

get_page "${ROAD_BIKES_BASE}"  "${ROAD_BIKES_PAGES}"
get_page "${MTB_BIKES_BASE}"   "${MTB_BIKES_PAGES}"
get_page "${URBAN_BIKES_BASE}" "${URBAN_BIKES_PAGES}"
get_page "${KIDS_BIKES_BASE}"  "${KIDS_BIKES_PAGES}"
get_page "${BMX_BIKES_BASE}"   "${BMX_BIKES_PAGES}"
