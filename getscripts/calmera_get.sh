#!/bin/bash
#
# This script gets all the bicycles from
# Calmera store !
URL="www.calmera.es"
ONLY_DOMAIN="calmera.es"
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


MTB_BIKES_BASE="${URL}/productos2.asp?id=25&p="
MTB_BIKES_PAGES="$(seq 1 5)"

MTB_DOUBLE_BASE="${URL}/productos2.asp?id=1&p=2"
MTB_DOUBLE_PAGES="$(seq 1 1)"

MTB_29_BIKES_BASE="${URL}/productos2.asp?id=60&p="
MTB_29_BIKES_PAGES="$(seq 1 3)"

MTB_FREERIDE_BIKES_BASE="${URL}/productos2.asp?id=4"

ROAD_BIKES_BASE="${URL}/productos2.asp?id=5&p="
ROAD_BIKES_PAGES="$(seq 1 3)"

ROAD_CARBON_BIKES_BASE="${URL}/productos2.asp?id=6&p="
ROAD_CARBON_BIKES_PAGES="$(seq 1 10)"

ROAD_TRIATLON_BIKES_BASE="${URL}/productos2.asp?id=7&p="
ROAD_TRIATLON_BIKES_PAGES="$(seq 1 10)"

URBAN_BIKES_BASE="${URL}/productos2.asp?id=29&p="
URBAN_BIKES_PAGES="$(seq 1 10)"

TREKKING_BIKES_BASE="${URL}/productos2.asp?id=27&p="
TREKKING_BIKES_PAGES="$(seq 1 5)"

FOLDING_BIKES_BASE="${URL}/productos2.asp?id=13&p="
FOLDING_BIKES_PAGES="$(seq 1 5)"

ELECTRIC_BIKES_BASE="${URL}/productos2.asp?id=57&p="

KIDS00_BIKES_BASE="${URL}/productos2.asp?id=17"
KIDS01_BIKES_BASE="${URL}/productos2.asp?id=18"
KIDS02_BIKES_BASE="${URL}/productos2.asp?id=19"
KIDS03_BIKES_BASE="${URL}/productos2.asp?id=20"
KIDS04_BIKES_BASE="${URL}/productos2.asp?id=21"
KIDS05_BIKES_BASE="${URL}/productos2.asp?id=30"

TRICYCLE_BIKES_BASE="${URL}/productos2.asp?id=15"

BMX_BIKES_BASE="${URL}/productos2.asp?id=22&p="
BMX_BIKES_PAGES="$(seq 1 3)"

BMX_FREESTYLE_BIKES_BASE="${URL}/productos2.asp?id=31"

BMX_TRIAL_BIKES_BASE="${URL}/productos2.asp?id=31"

get_page "${MTB_DOWNBIKES_BASE}" "${MTB_DOWNBIKES_PAGES}"
