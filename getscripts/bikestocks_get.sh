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
MAX_TRIES=15
MAX_TIMEOUT=15

function get_page()
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

# 2015 models
MTB_26_2015_BIKES_BASE="http://www.bikestocks.es/b2c/index.php?page=pp_productos.php&tbusq=1&ref=2015-26&md=0&pagact="
MTB_26_2015_BIKES_PAGES=$(seq 1 2)

MTB_27_5_CARBON_2015_BIKES_BASE="http://www.bikestocks.es/b2c/index.php?page=pp_productos.php&tbusq=1&ref=2015-27%2C5-carbono&md=0&pagact="
MTB_27_5_CARBON_2015_BIKES_PAGES=$(seq 1 2)

MTB_27_5_DOUBLE_2015_BIKES_BASE="http://www.bikestocks.es/b2c/index.php?page=pp_productos.php&tbusq=1&ref=2015-27%2C5-dobles&md=0&pagact="
MTB_27_5_DOUBLE_2015_BIKES_PAGES=$(seq 1 3)

MTB_27_5_FRONT_2015_BIKES_BASE="http://www.bikestocks.es/b2c/index.php?page=pp_productos.php&tbusq=1&ref=2015-27.5-rigidas&md=0&pagact="
MTB_27_5_FRONT_2015_BIKES_PAGES=$(seq 1 6)

MTB_29_CARBON_2015_BIKES_BASE="http://www.bikestocks.es/b2c/index.php?page=pp_productos.php&tbusq=1&ref=2015-29-carbono&md=0&pagact="
MTB_29_CARBON_2015_BIKES_PAGES=$(seq 1 2)

MTB_29_DOUBLE_2015_BIKES_BASE="http://www.bikestocks.es/b2c/index.php?page=pp_productos.php&tbusq=1&ref=2015-29-dobles&md=0&pagact="
MTB_29_DOUBLE_2015_BIKES_PAGES=$(seq 1 3)

MTB_29_FRONT_2015_BIKES_BASE="http://www.bikestocks.es/b2c/index.php?page=pp_productos.php&tbusq=1&ref=2015-29-rigidas&md=0&pagact="
MTB_29_FRONT_2015_BIKES_PAGES=$(seq 1 5)

#2015 mtb kids
MTB_KIDS_2015_BIKES_BASE="http://www.bikestocks.es/b2c/index.php?page=pp_productos.php&tbusq=1&ref=Junior2015&md=0&pagact="
MTB_KIDS_2015_BIKES_PAGES=$(seq 1 2)

#2014 mtb
MTB_26_FIX_2014_BIKES_BASE="http://www.bikestocks.es/b2c/index.php?page=pp_productos.php&tbusq=1&ref=rigidas201426&md=0&pagact="
MTB_26_FIX_2014_BIKES_PAGES=$(seq 1 4)

MTB_26_DOUBLE_2014_BIKES_BASE="http://www.bikestocks.es/b2c/index.php?page=pp_productos.php&tbusq=1&ref=Doblesuspension201426&md=0&pagact="
MTB_26_DOUBLE_2014_BIKES_PAGES=$(seq 1 3)

MTB_27_5_FIX_2014_BIKES_BASE="http://www.bikestocks.es/b2c/index.php?page=pp_productos.php&tbusq=1&ref=rigidas201427%2C5&md=0&pagact="
MTB_27_5_FIX_2014_BIKES_PAGES=$(seq 1 4)

MTB_27_5_DOUBLE_2014_BIKES_BASE="http://www.bikestocks.es/b2c/index.php?page=pp_productos.php&tbusq=1&ref=Doblesuspension201427%2C5&md=0&pagact="
MTB_27_5_DOUBLE_2014_BIKES_PAGES=$(seq 1 2)

MTB_29_FIX_2014_BIKES_BASE="http://www.bikestocks.es/b2c/index.php?page=pp_productos.php&tbusq=1&ref=rigidas201429&md=0&pagact="
MTB_29_FIX_2014_BIKES_PAGES=$(seq 1 7)

MTB_29_DOUBLE_2014_BIKES_BASE="http://www.bikestocks.es/b2c/index.php?page=pp_productos.php&tbusq=1&ref=Doblesuspension201429&md=0&pagact="
MTB_29_DOUBLE_2014_BIKES_PAGES=$(seq 1 3)

#2014 mtb kids
MTB_KIDS_2014_BIKES_BASE="http://www.bikestocks.es/b2c/index.php?page=pp_productos.php&tbusq=1&ref=Junior2014&md=0&pagact="
MTB_KIDS_2014_BIKES_PAGES=$(seq 1 2)

#2014 woman
MTB_WOMAN_2014_BIKES_BASE="http://www.bikestocks.es/b2c/index.php?page=pp_productos.php&tbusq=1&ref=mujer2014&md=0&pagact="
MTB_WOMAN_2014_BIKES_PAGES=$(seq 1 3)

#2015 road
ROAD_2015_BIKES_BASE="http://www.bikestocks.es/b2c/index.php?page=pp_productos.php&tbusq=1&md=0&ref=carretera2015&pagact="
ROAD_2015_BIKES_PAGES=$(seq 1 2)

#2014 road
ROAD_2014_BIKES_BASE="http://www.bikestocks.es/b2c/index.php?page=pp_productos.php&tbusq=1&md=0&ref=carretera2014&pagact="
ROAD_2014_BIKES_PAGES=$(seq 1 10)

#2014 BMX
BMX_2014_BIKES_BASE="http://www.bikestocks.es/b2c/index.php?page=pp_productos.php&tbusq=1&md=0&ref=Trial%2FBMX%2FFreeride2014&pagact="
BMX_2014_BIKES_PAGES=$(seq 1 4)

#2014 Trekking
TREKKING_2014_BIKES_BASE="http://www.bikestocks.es/b2c/index.php?page=pp_productos.php&tbusq=1&md=0&ref=Trekking+2014&pagact="
TREKKING_2014_BIKES_PAGES=$(seq 1 6)

#2013 City
CITY_2013_BIKES_BASE="http://www.bikestocks.es/b2c/index.php?page=pp_productos.php&tbusq=1&md=0&ref=PASEO%2FCITY+2013&pagact="
CITY_2013_BIKES_PAGES=$(seq 1 6)

#2013 FOLDING
FOLDING_2013_BIKES_BASE="http://www.bikestocks.es/b2c/index.php?page=pp_productos.php&tbusq=1&md=0&ref=PLEGABLES&pagact="
FOLDING_2013_BIKES_PAGES=$(seq 1 5)

#JUNIOR 2013
JUNIOR_2013_BIKES_BASE="http://www.bikestocks.es/b2c/index.php?page=pp_productos.php&tbusq=1&md=0&ref=Junior&pagact="
JUNIOR_2013_BIKES_PAGES=$(seq 1 3)

#2013 mtb
MTB_WOMAN_2013_BIKES_BASE="http://www.bikestocks.es/b2c/index.php?page=pp_productos.php&md=1&tbusq=1&codf=527&pagact="
MTB_WOMAN_2013_BIKES_PAGES=$(seq 1 5)

MTB_KIDS_2013_BIKES_BASE="http://www.bikestocks.es/b2c/index.php?page=pp_productos.php&md=1&tbusq=1&codf=528&pagact="
MTB_KIDS_2013_BIKES_PAGES=$(seq 1 5)

MTB_2013_BIKES_BASE="http://www.bikestocks.es/b2c/index.php?page=pp_productos.php&md=1&tbusq=1&codf=499&pagact="
MTB_2013_BIKES_PAGES=$(seq 1 20)

MTB_2012_BIKES_BASE="http://www.bikestocks.es/b2c/index.php?page=pp_productos.php&md=1&tbusq=1&codf=338&pagact="
MTB_2012_BIKES_PAGES=$(seq 1 5)

ROAD_2012_BIKES_BASE="http://www.bikestocks.es/b2c/index.php?page=pp_productos.php&md=1&tbusq=1&codf=196&pagact="
ROAD_2012_BIKES_PAGES=$(seq 1 10)

ROAD_2013_BIKES_BASE="http://www.bikestocks.es/b2c/index.php?page=pp_productos.php&md=1&tbusq=1&codf=533&pagact="
ROAD_2013_BIKES_PAGES=$(seq 1 20)

TREKKING_2012_BIKES_BASE="http://www.bikestocks.es/b2c/index.php?page=pp_productos.php&md=1&tbusq=1&codf=370&pagact="
TREKKING_2012_BIKES_PAGES=$(seq 1 2)

TREKKING_2013_BIKES_BASE="http://www.bikestocks.es/b2c/index.php?page=pp_productos.php&md=1&tbusq=1&codf=476&pagact="
TREKKING_2013_BIKES_PAGES=$(seq 1 10)

URBAN_2012_BIKES_BASE="http://www.bikestocks.es/b2c/index.php?page=pp_productos.php&md=1&tbusq=1&codf=368&pagact="
URBAN_2012_BIKES_PAGES=$(seq 1 5)

URBAN_2013_BIKES_BASE="http://www.bikestocks.es/b2c/index.php?page=pp_productos.php&md=1&tbusq=1&codf=155&pagact="
URBAN_2013_BIKES_PAGES=$(seq 1 10)

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

get_page "${MTB_26_2015_BIKES_BASE}" "${MTB_26_2015_BIKES_PAGES}"
get_page "${MTB_27_5_CARBON_2015_BIKES_BASE}" "${MTB_27_5_CARBON_2015_BIKES_PAGES}"
get_page "${MTB_27_5_DOUBLE_2015_BIKES_BASE}" "${MTB_27_5_DOUBLE_2015_BIKES_PAGES}"
get_page "${MTB_27_5_FRONT_2015_BIKES_BASE}" "${MTB_27_5_FRONT_2015_BIKES_PAGES}"
get_page "${MTB_29_CARBON_2015_BIKES_BASE}" "${MTB_29_CARBON_2015_BIKES_PAGES}"
get_page "${MTB_29_DOUBLE_2015_BIKES_BASE}" "${MTB_29_DOUBLE_2015_BIKES_PAGES}"
get_page "${MTB_29_FRONT_2015_BIKES_BASE}" "${MTB_29_FRONT_2015_BIKES_PAGES}"
get_page "${MTB_KIDS_2015_BIKES_BASE}" "${MTB_KIDS_2015_BIKES_PAGES}"
get_page "${MTB_26_FIX_2014_BIKES_BASE}" "${MTB_26_FIX_2014_BIKES_PAGES}"
get_page "${MTB_26_DOUBLE_2014_BIKES_BASE}" "${MTB_26_DOUBLE_2014_BIKES_PAGES}"
get_page "${MTB_27_5_FIX_2014_BIKES_BASE}" "${MTB_27_5_FIX_2014_BIKES_PAGES}"
get_page "${MTB_27_5_DOUBLE_2014_BIKES_BASE}" "${MTB_27_5_DOUBLE_2014_BIKES_PAGES}"
get_page "${MTB_29_FIX_2014_BIKES_BASE}" "${MTB_29_FIX_2014_BIKES_PAGES}"
get_page "${MTB_29_DOUBLE_2014_BIKES_BASE}" "${MTB_29_DOUBLE_2014_BIKES_PAGES}"
get_page "${MTB_KIDS_2014_BIKES_BASE}" "${MTB_KIDS_2014_BIKES_PAGES}"
get_page "${MTB_WOMAN_2014_BIKES_BASE}" "${MTB_WOMAN_2014_BIKES_PAGES}"
get_page "${ROAD_2015_BIKES_BASE}" "${ROAD_2015_BIKES_PAGES}"
get_page "${ROAD_2014_BIKES_BASE}" "${ROAD_2014_BIKES_PAGES}"
get_page "${BMX_2014_BIKES_BASE}" "${BMX_2014_BIKES_PAGES}"
get_page "${TREKKING_2014_BIKES_BASE}" "${TREKKING_2014_BIKES_PAGES}"
get_page "${CITY_2013_BIKES_BASE}" "${CITY_2013_BIKES_PAGES}"
get_page "${FOLDING_2013_BIKES_BASE}" "${FOLDING_2013_BIKES_PAGES}"
get_page "${JUNIOR_2013_BIKES_BASE}" "${JUNIOR_2013_BIKES_PAGES}"
get_page "${MTB_WOMAN_2013_BIKES_BASE}" "${MTB_WOMAN_2013_BIKES_PAGES}"
get_page "${MTB_KIDS_2013_BIKES_BASE}" "${MTB_KIDS_2013_BIKES_PAGES}"
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

