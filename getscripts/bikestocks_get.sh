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
# Bicimania store !
# URL: www.bicimania.com
URL="www.bikestocks.es"
ONLY_DOMAIN="bikestocks.es"
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

MTB_2013_BIKES_BASE="http://www.bikestocks.es/b2c/index.php?page=pp_productos.php&md=1&tbusq=1&codf=499&pagact="
MTB_2013_BIKES_PAGES=$(seq 1 20)

MTB_2012_BIKES_BASE="http://www.bikestocks.es/b2c/index.php?page=pp_productos.php&md=1&tbusq=1&codf=338&pagact="
MTB_2012_BIKES_PAGES=$(seq 1 13)

ROAD_2012_BIKES_BASE="http://www.bikestocks.es/b2c/index.php?page=pp_productos.php&md=1&tbusq=1&codf=196&pagact="
ROAD_2012_BIKES_PAGES=$(seq 1 10)

ROAD_2013_BIKES_BASE="http://www.bikestocks.es/b2c/index.php?page=pp_productos.php&md=1&tbusq=1&codf=533&pagact="
ROAD_2013_BIKES_PAGES=$(seq 1 15)

TREKKING_2012_BIKES_BASE="http://www.bikestocks.es/b2c/index.php?page=pp_productos.php&md=1&tbusq=1&codf=370&pagact="
TREKKING_2012_BIKES_PAGES=$(seq 1 2)

TREKKING_2013_BIKES_BASE="http://www.bikestocks.es/b2c/index.php?page=pp_productos.php&md=1&tbusq=1&codf=476&pagact="
TREKKING_2013_BIKES_PAGES=$(seq 1 3)

URBAN_2012_BIKES_BASE="http://www.bikestocks.es/b2c/index.php?page=pp_productos.php&md=1&tbusq=1&codf=368&pagact="
URBAN_2012_BIKES_PAGES=$(seq 1 10)

URBAN_2013_BIKES_BASE="http://www.bikestocks.es/b2c/index.php?page=pp_productos.php&md=1&tbusq=1&codf=155&pagact="
URBAN_2013_BIKES_PAGES=$(seq 1 5)

FOLDING_BIKES_BASE="http://www.bikestocks.es/b2c/index.php?page=pp_productos.php&md=1&tbusq=1&codf=158&pagact="
FOLDING_BIKES_PAGES=$(seq 1 5)

ELECTRIC_BIKES_BASE="http://www.bikestocks.es/b2c/index.php?page=pp_productos.php&md=1&tbusq=1&codf=71&pagact="
ELECTRIC_BIKES_PAGES=$(seq 1 5)

BMX_2012_BIKES_BASE="http://www.bikestocks.es/b2c/index.php?page=pp_productos.php&md=1&tbusq=1&codf=281&pagact="
BMX_2012_BIKES_PAGES=$(seq 1 5)

BMX_2013_BIKES_BASE="http://www.bikestocks.es/b2c/index.php?page=pp_productos.php&md=1&tbusq=1&codf=541&pagact="
BMX_2013_BIKES_PAGES=$(seq 1 5)

JUNIOR_BIKES_BASE="http://www.bikestocks.es/b2c/index.php?page=pp_productos.php&md=1&tbusq=1&codf=352&pagact="
JUNIOR_BIKES_PAGES=$(seq 1 5)

TRIATLON_BIKES_BASE="http://www.bikestocks.es/b2c/index.php?page=pp_productos.php&md=1&tbusq=1&codf=415&pagact="
TRIATLON_BIKES_PAGES=$(seq 1 5)

MTB_DOUBLE_OUTLET_BIKES_BASE="http://www.bikestocks.es/b2c/index.php?page=pp_productos.php&tbusq=1&ref=Bicis-doble-suspension&md=1"
MTB_FIX_OUTLET_BIKES_BASE="http://www.bikestocks.es/b2c/index.php?page=pp_productos.php&tbusq=1&ref=Bicis-rigidas&md=1"

get_page "${MTB_2013_BIKES_BASE}" "${MTB_2013_BIKES_PAGES}"
get_page "${MTB_2012_BIKES_BASE}" "${MTB_2012_BIKES_PAGES}"

get_page "${ROAD_2013_BIKES_BASE}" "${ROAD_2013_BIKES_PAGES}"
get_page "${ROAD_2012_BIKES_BASE}" "${ROAD_2012_BIKES_PAGES}"

get_page "${TREKKING_2013_BIKES_BASE}" "${TREKKING_2013_BIKES_PAGES}"
get_page "${TREKKING_2012_BIKES_BASE}" "${TREKKING_2012_BIKES_PAGES}"

get_page "${URBAN_2012_BIKES_BASE}" "${URBAN_2012_BIKES_PAGES}"
get_page "${URBAN_2013_BIKES_BASE}" "${URBAN_2013_BIKES_PAGES}"

get_page "${FOLDING_BIKES_BASE}" "${FOLDING_BIKES_PAGES}"

get_page "${ELECTRIC_BIKES_BASE}" "${ELECTRIC_BIKES_PAGES}"

get_page "${BMX_2012_BIKES_BASE}" "${BMX_2012_BIKES_PAGES}"
get_page "${BMX_2013_BIKES_BASE}" "${BMX_2013_BIKES_PAGES}"

get_page "${JUNIOR_BIKES_BASE}" "${JUNIOR_BIKES_PAGES}"

get_page "${TRIATLON_BIKES_BASE}" "${TRIATLON_BIKES_PAGES}"

get_page "${MTB_DOUBLE_OUTLET_BIKES_BASE}" ""

get_page "${MTB_FIX_OUTLET_BIKES_BASE}" ""

