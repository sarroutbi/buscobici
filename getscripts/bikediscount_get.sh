#!/bin/bash
#
# Copyright © 2012-2014 Sergio Arroutbi Braojos <sarroutbi@gmail.com>
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
URL="www.bike-discount.de"
ONLY_DOMAIN="bike-discount.de"
EXCLUDE="-Rgif -Rpng -Rjpg"
MAX_TRIES=10
MAX_TIMEOUT=10

function get_page()
{
  BASE_URL="$1"
  PAGES="$2"
  FILE="$3"

  if [ "${PAGES}" = "" ];
  then
    wget --tries=${MAX_TRIES} --timeout=${MAX_TIMEOUT} "${BASE_URL}" -O"${FILE}"
  else
    for page in ${PAGES};
    do
      wget --tries=${MAX_TRIES} --timeout=${MAX_TIMEOUT} "${BASE_URL}/p-${page}" -O"${FILE}-p${page}"
    done
  fi
}

#### ROAD ####
ROAD_BIKES_ALUM_BASE="${URL}/es/shop/bici-de-carrera-aluminio-110"
ROAD_BIKES_ALUM_PAGES="$(seq 0 5)"

ROAD_BIKES_CARBON_BASE="${URL}/es/shop/bici-de-carrera-carbono-111"
ROAD_BIKES_CARBON_PAGES="$(seq 0 5)"

ROAD_BIKES_WOMAN_BASE="${URL}/es/shop/bici-de-carrera-mujer-114"
ROAD_BIKES_WOMAN_PAGES="$(seq 0 1)"

ROAD_BIKES_TRIATLON_BASE="${URL}/es/shop/triatl-n-bici-30"
ROAD_BIKES_TRIATLON_PAGES="$(seq 0 1)"

ROAD_BIKES_CYCLOCROSS_BASE="${URL}/es/shop/cyclocross-40"
ROAD_BIKES_CYCLOCROSS_PAGES="$(seq 0 3)"

get_page "${ROAD_BIKES_ALUM_BASE}" "${ROAD_BIKES_ALUM_PAGES}" road-alum
get_page "${ROAD_BIKES_CARBON_BASE}" "${ROAD_BIKES_CARBON_PAGES}" road-carbon
get_page "${ROAD_BIKES_WOMAN_BASE}" "${ROAD_BIKES_WOMAN_PAGES}" road-woman
get_page "${ROAD_BIKES_TRIATLON_BASE}" "${ROAD_BIKES_TRIATLON_PAGES}" road-triatlon
get_page "${ROAD_BIKES_CYCLOCROSS_BASE}" "${ROAD_BIKES_CYCLOCROSS_PAGES}" road-cyclocross

#### MTB ####
MTB_26_BIKES_BASE="${URL}/es/shop/hardtail-26-116"
MTB_26_BIKES_PAGES="$(seq 0 5)"

MTB_275_BIKES_BASE="${URL}/es/shop/hardtail-27%2C5-6198"
MTB_275_BIKES_PAGES="$(seq 0 5)"

MTB_29_BIKES_BASE="${URL}/es/shop/hardtail-29-117"
MTB_29_BIKES_PAGES="$(seq 0 5)"

MTB_WOMAN_BIKES_BASE="${URL}/es/shop/hardtail-mujer-119"
MTB_WOMAN_BIKES_PAGES="$(seq 0 5)"

MTB_DOUBLE_26_BIKES_BASE="${URL}/es/shop/fullsuspension-26-26"
MTB_DOUBLE_26_BIKES_PAGES="$(seq 0 5)"

MTB_DOUBLE_275_BIKES_BASE="${URL}/es/shop/fullsuspension-27%2C5-7243"
MTB_DOUBLE_275_BIKES_PAGES="$(seq 0 5)"

MTB_DOUBLE_29_BIKES_BASE="${URL}/es/shop/fullsuspension-29-153"
MTB_DOUBLE_29_BIKES_PAGES="$(seq 0 5)"

MTB_DOUBLE_WOMAN_BIKES_BASE="${URL}/es/shop/full-suspension-mujer-155"
MTB_DOUBLE_WOMAN_BIKES_PAGES="$(seq 0 2)"

MTB_DOUBLE_DIRT_BIKES_BASE="${URL}/es/shop/dirtbike-7631"
MTB_DOUBLE_DIRT_BIKES_PAGES="$(seq 0 2)"

MTB_ELECTRIC_BIKES_BASE="${URL}/es/shop/e-bike-hardtail-4507"
MTB_ELECTRIC_BIKES_PAGES="$(seq 0 1)"

MTB_DOUBLE_ELECTRIC_BIKES_BASE="${URL}/es/shop/e-bike-fully-4505"
MTB_DOUBLE_ELECTRIC_BIKES_PAGES="$(seq 0 1)"

get_page "${MTB_26_BIKES_BASE}" "${MTB_26_BIKES_PAGES}" mtbfix-26
get_page "${MTB_275_BIKES_BASE}" "${MTB_275_BIKES_PAGES}" mtbfix-275
get_page "${MTB_29_BIKES_BASE}" "${MTB_29_BIKES_PAGES}" mtbfix-29
get_page "${MTB_WOMAN_BIKES_BASE}" "${MTB_WOMAN_BIKES_PAGES}" mtbfix-woman

get_page "${MTB_DOUBLE_26_BIKES_BASE}" "${MTB_DOUBLE_26_BIKES_PAGES}" mtb-double-26
get_page "${MTB_DOUBLE_275_BIKES_BASE}" "${MTB_DOUBLE_275_BIKES_PAGES}" mtb-double-275
get_page "${MTB_DOUBLE_29_BIKES_BASE}" "${MTB_DOUBLE_29_BIKES_PAGES}" mtb-double-29
get_page "${MTB_DOUBLE_WOMAN_BIKES_BASE}" "${MTB_DOUBLE_29_BIKES_PAGES}" mtb-double-woman
get_page "${MTB_DOUBLE_DIRT_BIKES_BASE}" "${MTB_DOUBLE_DIRT_BIKES_PAGES}" mtb-double-dirt

get_page "${MTB_ELECTRIC_BIKES_BASE}" "${MTB_ELECTRIC_BIKES_PAGES}" mtbfix-electric
get_page "${MTB_DOUBLE_ELECTRIC_BIKES_BASE}" "${MTB_DOUBLE_ELECTRIC_BIKES_PAGES}" mtb-double-electric

#### URBAN ####
URBAN_TREKKING_BIKES_BASE="${URL}/es/shop/bicicletas-trekking-24"
URBAN_TREKKING_BIKES_PAGES="$(seq 0 6)"

URBAN_TREKKING_WOMAN_BIKES_BASE="${URL}/es/shop/bicicletas-trekking-mujer-914"
URBAN_TREKKING_WOMAN_BIKES_PAGES="$(seq 0 6)"

URBAN_BIKES_BASE="${URL}/es/shop/bicis-urbanas-42"
URBAN_BIKES_PAGES="$(seq 0 1)"

URBAN_CRUISERS_BASE="${URL}/es/shop/cruisers-35"
URBAN_CRUISERS_PAGES="$(seq 0 1)"

URBAN_FIXIE_BASE="${URL}/es/shop/monomarcha-pista-37"
URBAN_FIXIE_PAGES="$(seq 0 1)"

URBAN_FITNESS_BIKES_BASE="${URL}/es/shop/bicicletas-fitness-27"
URBAN_FITNESS_BIKES_PAGES="$(seq 0 2)"

URBAN_FITNESS_WOMAN_BIKES_BASE="${URL}/es/shop/bicicletas-fitness-mujer-918"
URBAN_FITNESS_WOMAN_BIKES_PAGES="$(seq 0 1)"

URBAN_CROSSBIKES_BIKES_BASE="${URL}/es/shop/crossbikes-29"
URBAN_CROSSBIKES_BIKES_PAGES="$(seq 0 3)"

URBAN_CROSSBIKES_WOMAN_BIKES_BASE="${URL}/es/shop/crossbikes-mujer-916"
URBAN_CROSSBIKES_WOMAN_BIKES_PAGES="$(seq 0 3)"

URBAN_ELECTRIC_BIKES_BASE="${URL}/es/shop/e-bikes-trekking-4504"
URBAN_ELECTRIC_BIKES_PAGES="$(seq 0 3)"

URBAN_ELECTRIC_WOMAN_BIKES_BASE="${URL}/es/shop/e-bikes-trekking-mujer-8561"
URBAN_ELECTRIC_WOMAN_BIKES_PAGES="$(seq 0 3)"

get_page "${URBAN_TREKKING_BIKES_BASE}" "${URBAN_TREKKING_BIKES_PAGES}" urban-trekking
get_page "${URBAN_TREKKING_WOMAN_BIKES_BASE}" "${URBAN_TREKKING_WOMAN_BIKES_PAGES}" urban-trekking-woman
get_page "${URBAN_BIKES_BASE}" "${URBAN_BIKES_PAGES}" urban
get_page "${URBAN_CRUISERS_BASE}" "${URBAN_CRUISERS_PAGES}" urban-cruisers
get_page "${URBAN_FIXIE_BASE}" "${URBAN_FIXIE_PAGES}" urban-fixies
get_page "${URBAN_FITNESS_BIKES_BASE}" "${URBAN_FITNESS_BIKES_PAGES}" urban-fitness
get_page "${URBAN_FITNESS_WOMAN_BIKES_BASE}" "${URBAN_FITNESS_WOMAN_BIKES_PAGES}" urban-fitness-woman
get_page "${URBAN_CROSSBIKES_BIKES_BASE}" "${URBAN_CROSSBIKES_BIKES_PAGES}" urban-crossbikes
get_page "${URBAN_CROSSBIKES_WOMAN_BIKES_BASE}" "${URBAN_CROSSBIKES_WOMAN_BIKES_PAGES}" urban-crossbikes-woman
get_page "${URBAN_ELECTRIC_BIKES_BASE}" "${URBAN_ELECTRIC_BIKES_PAGES}" urban-electric
get_page "${URBAN_ELECTRIC_WOMAN_BIKES_BASE}" "${URBAN_ELECTRIC_WOMAN_BIKES_PAGES}" urban-electric-woman

#### BMX ####
BMX_BIKES_BASE="${URL}/es/shop/bicis-bmx-36"
BMX_BIKES_PAGES="$(seq 0 2)"
get_page "${BMX_BIKES_BASE}" "${BMX_BIKES_PAGES}" bmx

#### KIDS ####
KIDS_BIKES_BASE="${URL}/es/shop/bicicletas-para-ni-os-6671"
KIDS_BIKES_PAGES="$(seq 0 7)"
get_page "${KIDS_BIKES_BASE}" "${KIDS_BIKES_PAGES}" kids

