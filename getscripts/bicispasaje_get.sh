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
      wget --tries=${MAX_TRIES} --timeout=${MAX_TIMEOUT} "${BASE_URL}${page}" 
    done 
  fi
}

MTB_BIKES_ORBEA_26_MTB_BASE="${URL}/es/8-orbea-rígidas-26"
MTB_BIKES_CUBE_26_MTB_BASE="${URL}/es/9-cube-rígida-26"
MTB_BIKES_MMR_26_MTB_BASE="${URL}/es/151-mmr-rígida-26"
MTB_BIKES_ORBEA_29_MTB_BASE="${URL}/es/11-orbea-rígida-29er"
MTB_BIKES_CUBE_29_MTB_BASE="${URL}/es/14-cube-rígida-29er"
MTB_BIKES_MMR_29_MTB_BASE="${URL}/es/152-mmr-rígida-29er"
MTB_BIKES_ORBEA_DOUBLE_26_MTB_BASE="${URL}/es/18-orbea-doble-susp-26"
MTB_BIKES_CUBE_DOUBLE_26_MTB_BASE="${URL}/es/19-cube-doble-susp-26"
MTB_BIKES_ORBEA_DOUBLE_29_MTB_BASE="${URL}/es/28-orbea-doble-susp-29er"
MTB_BIKES_CUBE_DOUBLE_29_MTB_BASE="${URL}/es/23-cube-doble-susp-29er"
MTB_BIKES_ORBEA_ROAD_MTB_BASE="${URL}/es/33-orbea-carretera"
MTB_BIKES_CUBE_ROAD_MTB_BASE="${URL}/es/32-cube-carretera"
MTB_BIKES_ROAD_2012="${URL}/es/63-bicis-carretera-2012"
MTB_BIKES_ROAD_TRIATLON="${URL}/es/142-triatlon"
MTB_BIKES_KIDS="${URL}/es/34-infantiles"
MTB_BIKES_WOMAN="${URL}/es/122-dama"

get_pages "${MTB_BIKES_ORBEA_26_MTB_BASE}"
get_pages "${MTB_BIKES_CUBE_26_MTB_BASE}"
get_pages "${MTB_BIKES_MMR_26_MTB_BASE}"
get_pages "${MTB_BIKES_ORBEA_29_MTB_BASE}"
get_pages "${MTB_BIKES_CUBE_29_MTB_BASE}"
get_pages "${MTB_BIKES_MMR_29_MTB_BASE}"
get_pages "${MTB_BIKES_ORBEA_DOUBLE_26_MTB_BASE}"
get_pages "${MTB_BIKES_CUBE_DOUBLE_26_MTB_BASE}"
get_pages "${MTB_BIKES_ORBEA_DOUBLE_29_MTB_BASE}"
get_pages "${MTB_BIKES_CUBE_DOUBLE_29_MTB_BASE}"
get_pages "${MTB_BIKES_ORBEA_ROAD_MTB_BASE}"
get_pages "${MTB_BIKES_CUBE_ROAD_MTB_BASE}"
get_pages "${MTB_BIKES_ROAD_2012}"
get_pages "${MTB_BIKES_ROAD_TRIATLON}"
get_pages "${MTB_BIKES_KIDS}"
get_pages "${MTB_BIKES_WOMAN}"
