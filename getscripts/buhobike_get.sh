#!/bin/bash
#
# This script gets all the bicycles from
# Bicimania store !
# URL: www.bicimania.com
URL="www.buhobike.com"
ONLY_DOMAIN="buhobike.com"
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

MTB_BIKES_BASE="http://www.buhobike.com/bicicletas/rapida?op=188&_pagi_pg="
MTB_BIKES_PAGES=$(seq 1 35)

ROAD_BIKES_BASE="http://www.buhobike.com/bicicletas/rapida?op=288&_pagi_pg="
ROAD_BIKES_PAGES=$(seq 1 25)

TREKKING_BIKES_BASE="http://www.buhobike.com/bicicletas/rapida?op=388&_pagi_pg="
TREKKING_BIKES_PAGES=$(seq 1 15)

URBAN_BIKES_BASE="http://www.buhobike.com/bicicletas/rapida?op=488&_pagi_pg="
URBAN_BIKES_PAGES=$(seq 1 15)

BMX_BIKES_BASE="http://www.buhobike.com/bicicletas/rapida?op=588&_pagi_pg="
BMX_BIKES_PAGES=$(seq 1 15)

KIDS_BIKES_BASE="http://www.buhobike.com/bicicletas/rapida?op=688&_pagi_pg="
KIDS_BIKES_PAGES=$(seq 1 10)

get_page "${MTB_BIKES_BASE}" "${MTB_BIKES_PAGES}"
get_page "${ROAD_BIKES_BASE}" "${ROAD_BIKES_PAGES}"
get_page "${TREKKING_BIKES_BASE}" "${TREKKING_BIKES_PAGES}"
get_page "${URBAN_BIKES_BASE}" "${URBAN_BIKES_PAGES}"
get_page "${BMX_BIKES_BASE}" "${BMX_BIKES_PAGES}"
get_page "${KIDS_BIKES_BASE}" "${KIDS_BIKES_PAGES}"
