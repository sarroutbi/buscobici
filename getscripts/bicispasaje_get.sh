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
# Calmera store !
URL="preciosbicicletas.es"
ONLY_DOMAIN="preciosbicicletas.es"
MAX_TRIES=15
MAX_TIMEOUT=15

function get_pages()
{
  BASE_URL="$1"
  PAGES="$2"
  if [ "${PAGES}" = "" ];
  then
    wget --tries=${MAX_TRIES} --timeout=${MAX_TIMEOUT} "${BASE_URL}" 
  else
    for page in ${PAGES};
    do
      wget --tries=${MAX_TRIES} --timeout=${MAX_TIMEOUT} "${BASE_URL}?p=${page}"
    done 
  fi
}

MTB_BIKES_26_BASE="${URL}/es/7-mtb-rígidas"
MTB_BIKES_27_5_BASE="${URL}/es/158-mtb-rígida-275"
MTB_BIKES_27_5_PAGES="$(seq 1 3)"
MTB_BIKES_29_BASE="${URL}/es/10-mtb-rígida-29er"
MTB_BIKES_29_PAGES="$(seq 1 3)"
MTB_BIKES_DOUBLE_26_BASE="${URL}/es/17-doble-susp-26"
MTB_BIKES_DOUBLE_27_5_BASE="${URL}/es/164-doble-susp-275-"
MTB_BIKES_DOUBLE_29_BASE="${URL}/es/21-doble-susp-29er"
MTB_2013_BIKES_BASE="${URL}/es/64-bicis-mtb-2013"
ROAD_BIKES_BASE="${URL}/es/31-carretera"
ROAD_BIKES_PAGES="$(seq 1 4)"
ROAD_2013_BIKES_BASE="${URL}/es/63-bicis-carretera-2013"
ROAD_TRIATLON_BIKES_BASE="${URL}/es/142-triatlón"
KIDS_BIKES_BASE="${URL}/es/34-infantiles"
WOMAN_BIKES_BASE="${URL}/es/122-dama"
URBAN_BIKES_BASE="${URL}/es/153-trekking-ciudad"
URBAN_2013_BIKES_BASE="${URL}/es/178-trekking-ciudad"

get_pages "${MTB_BIKES_26_BASE}"
get_pages "${MTB_BIKES_27_5_BASE}" "${MTB_BIKES_27_5_PAGES}"
get_pages "${MTB_BIKES_29_BASE}" "${MTB_BIKES_29_PAGES}"
get_pages "${MTB_BIKES_DOUBLE_26_BASE}"
get_pages "${MTB_BIKES_DOUBLE_27_5_BASE}"
get_pages "${MTB_BIKES_DOUBLE_29_BASE}"
get_pages "${MTB_2013_BIKES_BASE}"
get_pages "${ROAD_BIKES_BASE}" "${ROAD_BIKES_PAGES}"
get_pages "${ROAD_TRIATLON_BIKES_BASE}"
get_pages "${ROAD_2013_BIKES_BASE}"
get_pages "${KIDS_BIKES_BASE}"
get_pages "${WOMAN_BIKES_BASE}"
get_pages "${URBAN_BIKES_BASE}"
get_pages "${URBAN_2013_BIKES_BASE}"
