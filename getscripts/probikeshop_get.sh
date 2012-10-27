#!/bin/bash
#
# This script gets all the bicycles from
# Probikeshop store !
# URL: www.probikeshop.es
URL="http://www.probikeshop.es"
ONLY_DOMAIN="probikeshop.es"
EXCLUDE="-Rgif -Rpng -Rjpg"

function get_page()
{
  BASE_URL="$1"
  PAGES="$2"
  if [ "${PAGES}" = "" ];
  then
    echo "GETTING PAGE=>${BASE_URL}<="
    wget "${BASE_URL}" 
  else
    for page in ${PAGES};
    do
    echo "GETTING PAGE=>${BASE_URL}${page}<="
      wget "${BASE_URL}${page}" 
    done 
  fi
}


MTB_BIKES_BASE="${URL}/mtb/bicicletas-c517.html?page="
MTB_BIKES_PAGES="$(seq 1 5)"

MTB_WOMAN_BASE="${URL}/mujer/bicicletas-c640.html"

ROAD_BIKES_BASE="${URL}/carretera/bicicletas-c616.html"

BMX_BIKES_BASE="${URL}/bmx/bicicletas-bmx-c673.html?page="
BMX_BIKES_PAGES="$(seq 1 10)"

KIDS00_BIKES_BASE="${URL}/ninos/bicicletas-ninos-bicis-ninos-de-12-a-18-c739.html"
KIDS01_BIKES_BASE="${URL}/ninos/bicicletas-ninos-c692.html"
KIDS02_BIKES_BASE="${URL}/ninos/bicicletas-ninos-bicis-sin-pedales-c693.html"
KIDS03_BIKES_BASE="${URL}/ninos/bicicletas-ninos-cuatriciclos-c696.html"
KIDS04_BIKES_BASE="${URL}/ninos/bicicletas-ninos-triciclos-c697.html"

get_page "${MTB_BIKES_BASE}" "${MTB_BIKES_PAGES}"
get_page "${MTB_WOMAN_BASE}"
get_page "${ROAD_BIKES_BASE}" 
get_page "${BMX_BIKES_BASE}" "${BMX_BIKES_PAGES}"
get_page "${KIDS00_BIKES_BASE}"
get_page "${KIDS01_BIKES_BASE}"
get_page "${KIDS02_BIKES_BASE}"
get_page "${KIDS03_BIKES_BASE}"
get_page "${KIDS04_BIKES_BASE}"