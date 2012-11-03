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

MTB_DOUBLE_BASE="${URL}/productos2.asp?id=1&p="
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

BMX_TRIAL_BIKES_BASE="${URL}/productos2.asp?id=32"

get_page "${MTB_DOWNBIKES_BASE}"       "${MTB_DOWNBIKES_PAGES}"
get_page "${MTB_BIKES_BASE}"           "${MTB_BIKES_PAGES}"            
get_page "${MTB_DOUBLE_BASE}"          "${MTB_DOUBLE_PAGES}"          
get_page "${MTB_29_BIKES_BASE}"        "${MTB_29_BIKES_PAGES}"        
get_page "${MTB_FREERIDE_BIKES_BASE}"  "${MTB_FREERIDE_BIKES_PAGES}"
get_page "${ROAD_BIKES_BASE}"          "${ROAD_BIKES_PAGES}"          
get_page "${ROAD_CARBON_BIKES_BASE}"   "${ROAD_CARBON_BIKES_PAGES}"   
get_page "${ROAD_TRIATLON_BIKES_BASE}" "${ROAD_TRIATLON_BIKES_PAGES}" 
get_page "${URBAN_BIKES_BASE}"         "${URBAN_BIKES_PAGES}"         
get_page "${TREKKING_BIKES_BASE}"      "${TREKKING_BIKES_PAGES}"      
get_page "${FOLDING_BIKES_BASE}"       "${FOLDING_BIKES_PAGES}"       
get_page "${ELECTRIC_BIKES_BASE}"      "${ELECTRIC_BIKES_PAGES}"      
get_page "${KIDS00_BIKES_BASE}"        "${KIDS00_BIKES_PAGES}"        
get_page "${KIDS01_BIKES_BASE}"        "${KIDS01_BIKES_PAGES}"        
get_page "${KIDS02_BIKES_BASE}"        "${KIDS02_BIKES_PAGES}"        
get_page "${KIDS03_BIKES_BASE}"        "${KIDS03_BIKES_PAGES}"        
get_page "${KIDS04_BIKES_BASE}"        "${KIDS04_BIKES_PAGES}"        
get_page "${KIDS05_BIKES_BASE}"        "${KIDS05_BIKES_PAGES}"        
get_page "${TRICYCLE_BIKES_BASE}"      "${TRICYCLE_BIKES_PAGES}"      
get_page "${BMX_BIKES_BASE}"           "${BMX_BIKES_PAGES}"           
get_page "${BMX_FREESTYLE_BIKES_BASE}" "${BMX_FREESTYLE_BIKES_PAGES}" 
get_page "${BMX_TRIAL_BIKES_BASE}"     "${BMX_TRIAL_BIKES_PAGES}"
