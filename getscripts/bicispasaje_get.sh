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
URL="www.bicispasaje.es"
ONLY_DOMAIN="bicispasaje.es"
MAX_TRIES=10
MAX_TIMEOUT=10

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

MTB_BIKES_ORBEA_26_MTB_BASE="${URL}/orbea-2013/orbea-mtb-26.html"
MTB_BIKES_CUBE_26_MTB_BASE="${URL}/cube-2013/cube_mtb.html"
MTB_BIKES_ORBEA_29_MTB_BASE="${URL}/orbea-2013/orbea-mtb-29.html"
MTB_BIKES_CUBE_29_MTB_BASE="${URL}/cube-2013/cube_mtb_29_er.html"
MTB_BIKES_ORBEA_DOUBLE_26_MTB_BASE="${URL}/orbea-2013/orbea-doble-suspension-2013.html"
MTB_BIKES_CUBE_DOUBLE_26_MTB_BASE="${URL}/cube-2013/cube-doble-suspension-26.html"
MTB_BIKES_ORBEA_DOUBLE_29_MTB_BASE="${URL}/orbea-2013/orbea-doble-suspension-29er.html"
MTB_BIKES_CUBE_DOUBLE_29_MTB_BASE="${URL}/cube-2013/cube-doble-suspension-29er.html"
MTB_BIKES_ORBEA_ROAD_MTB_BASE="${URL}/orbea-2013/orbea-carretera.html"
MTB_BIKES_CUBE_ROAD_MTB_BASE="${URL}/cube-2013/cube-carretera.html"
MTB_BIKES_CUBE_2012_MTB_BASE="${URL}/cube-2012/cube-liquidacion-2012.html"
MTB_BIKES_LAPIERRE_2012_MTB_BASE="${URL}/lapierre-2012/mtb-lapierre.html"
MTB_BIKES_ORBEA_2012_MTB_BASE="${URL}/orbea-2012/liquidacion-2012-orbea.html"

get_pages "${MTB_BIKES_ORBEA_26_MTB_BASE}"
get_pages "${MTB_BIKES_CUBE_26_MTB_BASE}"
get_pages "${MTB_BIKES_ORBEA_29_MTB_BASE}"
get_pages "${MTB_BIKES_CUBE_29_MTB_BASE}"
get_pages "${MTB_BIKES_ORBEA_DOUBLE_26_MTB_BASE}"
get_pages "${MTB_BIKES_CUBE_DOUBLE_26_MTB_BASE}"
get_pages "${MTB_BIKES_ORBEA_DOUBLE_29_MTB_BASE}"
get_pages "${MTB_BIKES_CUBE_DOUBLE_29_MTB_BASE}"
get_pages "${MTB_BIKES_ORBEA_ROAD_MTB_BASE}"
get_pages "${MTB_BIKES_CUBE_ROAD_MTB_BASE}"
get_pages "${MTB_BIKES_CUBE_2012_MTB_BASE}"
get_pages "${MTB_BIKES_LAPIERRE_2012_MTB_BASE}"
get_pages "${MTB_BIKES_ORBEA_2012_MTB_BASE}"
