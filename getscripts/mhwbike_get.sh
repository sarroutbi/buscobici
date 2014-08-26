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
URL="www.mhw-bike.es"
ONLY_DOMAIN="mhw-bike.es"
EXCLUDE="-Rgif -Rpng -Rjpg"
MAX_TRIES=10
MAX_TIMEOUT=10

. ./common_get

#### MTB RIGID ####
MTB_RIGID_BASE="${URL}/bicicletas/rgidas/?p="
MTB_RIGID_PAGES="$(seq 1 3)"

bubic_get_page_outfile "${MTB_RIGID_BASE}" "${MTB_RIGID_PAGES}" mtb-rigid

#### MTB DOUBLE ####
MTB_DOUBLE_BASE="${URL}/bicicletas/doble-suspensin/?p="
MTB_DOUBLE_PAGES="$(seq 1 4)"

bubic_get_page_outfile "${MTB_DOUBLE_BASE}" "${MTB_DOUBLE_PAGES}" mtb-double

#### MTB RIGID 29 ####
MTB_RIGID_29_BASE="${URL}/bicicletas/rigidas-29er/?p="
MTB_RIGID_29_PAGES="$(seq 1 4)"

bubic_get_page_outfile "${MTB_RIGID_29_BASE}" "${MTB_RIGID_29_PAGES}" mtb-29

#### MTB DOUBLE 29 (round 2) ####
MTB_DOUBLE2_29_BASE="${URL}/bicicletas/29er/?p="
MTB_DOUBLE2_29_PAGES="$(seq 1 3)"

bubic_get_page_outfile "${MTB_DOUBLE2_29_BASE}" "${MTB_DOUBLE2_29_PAGES}" mtb-double2-29

#### DIRT/BMX ####
DIRT_BMX_BASE="${URL}/bicicletas/dirt-bmx/?p="
DIRT_BMX_PAGES="1"

bubic_get_page_outfile "${DIRT_BMX_BASE}" "${DIRT_BMX_PAGES}" dirt-bmx

#### MTB WOMAN ####
MTB_WOMAN_BASE="${URL}/bicicletas/para-mujer/?p="
MTB_WOMAN_PAGES="$(seq 1 3)"

bubic_get_page_outfile "${MTB_WOMAN_BASE}" "${MTB_WOMAN_PAGES}" mtb-woman

#### URBAN CROSS ####
URBAN_CROSS_BASE="${URL}/bicicletas/cross/?p="
URBAN_CROSS_PAGES="$(seq 1 4)"

bubic_get_page_outfile "${URBAN_CROSS_BASE}" "${URBAN_CROSS_PAGES}" urban-cross

#### URBAN WALK ####
URBAN_WALK_BASE="${URL}/bicicletas/paseo/?p="
URBAN_WALK_PAGES="$(seq 1 3)"

bubic_get_page_outfile "${URBAN_WALK_BASE}" "${URBAN_WALK_PAGES}" urban-walk

#### URBAN FITNESS ####
URBAN_FITNESS_BASE="${URL}/bicicletas/paseo/?p="
URBAN_FITNESS_PAGES="1"

bubic_get_page_outfile "${URBAN_FITNESS_BASE}" "${URBAN_FITNESS_PAGES}" urban-fitness

#### ROAD ####
ROAD_BASE="${URL}/bicicletas/carretera/?p="
ROAD_PAGES="$(seq 1 3)"

bubic_get_page_outfile "${ROAD_BASE}" "${ROAD_PAGES}" road

#### ROAD_WOMAN ####
ROAD_WOMAN_BASE="${URL}/bicicletas/mujer/?p="
ROAD_WOMAN_PAGES="1"

bubic_get_page_outfile "${ROAD_WOMAN_BASE}" "${ROAD_WOMAN_PAGES}" road-woman

#### ROAD_TRIATLON ####
ROAD_TRIATLON_BASE="${URL}/bicicletas/triatln/?p="
ROAD_TRIATLON_PAGES="1"

bubic_get_page_outfile "${ROAD_TRIATLON_BASE}" "${ROAD_TRIATLON_PAGES}" road-triatlon

#### ROAD_CICLOCROSS ####
ROAD_CICLOCROSS_BASE="${URL}/bicicletas/ciclocross/?p="
ROAD_CICLOCROSS_PAGES="1"

bubic_get_page_outfile "${ROAD_CICLOCROSS_BASE}" "${ROAD_CICLOCROSS_PAGES}" road-ciclocross

#### KIDS ####
KIDS_BASE="${URL}/bicicletas/nio/?p="
KIDS_PAGES="$(seq 1 4)"

bubic_get_page_outfile "${KIDS_BASE}" "${KIDS_PAGES}" kids

########################### SALE MODELS ###########################
#### MTB RIGID ####
MTB_RIGID_BASE="${URL}/ofertas/rgidas/?p="
MTB_RIGID_PAGES="$(seq 1 5)"

bubic_get_page_outfile "${MTB_RIGID_BASE}" "${MTB_RIGID_PAGES}" mtb-rigid-sale

#### MTB DOUBLE ####
MTB_DOUBLE_BASE="${URL}/ofertas/doble-suspensin/?p="
MTB_DOUBLE_PAGES="$(seq 1 5)"

bubic_get_page_outfile "${MTB_DOUBLE_BASE}" "${MTB_DOUBLE_PAGES}" mtb-double-sale

#### MTB RIGID 29 ####
MTB_RIGID_29_BASE="${URL}/ofertas/29er/?p="
MTB_RIGID_29_PAGES="$(seq 1 5)"
bubic_get_page_outfile "${MTB_RIGID_29_BASE}" "${MTB_RIGID_29_PAGES}" mtb-29-sale

#### DIRT/BMX ####
DIRT_BMX_BASE="${URL}/ofertas/dirt-bmx/?p="
DIRT_BMX_PAGES="$(seq 1 2)"

bubic_get_page_outfile "${DIRT_BMX_BASE}" "${DIRT_BMX_PAGES}" dirt-bmx-sale

#### MTB WOMAN ####
MTB_WOMAN_BASE="${URL}/ofertas/para-mujer/?p="
MTB_WOMAN_PAGES="$(seq 1 5)"

bubic_get_page_outfile "${MTB_WOMAN_BASE}" "${MTB_WOMAN_PAGES}" mtb-woman-sale

#### URBAN CROSS ####
URBAN_CROSS_BASE="${URL}/ofertas/cross/?p="
URBAN_CROSS_PAGES="$(seq 1 5)"

bubic_get_page_outfile "${URBAN_CROSS_BASE}" "${URBAN_CROSS_PAGES}" urban-cross-sale

#### URBAN WALK ####
URBAN_WALK_BASE="${URL}/ofertas/paseo/?p="
URBAN_WALK_PAGES="$(seq 1 5)"

bubic_get_page_outfile "${URBAN_WALK_BASE}" "${URBAN_WALK_PAGES}" urban-walk-sale

#### URBAN FITNESS ####
URBAN_FITNESS_BASE="${URL}/ofertas/paseo/?p="
URBAN_FITNESS_PAGES="$(seq 1 2)"

bubic_get_page_outfile "${URBAN_FITNESS_BASE}" "${URBAN_FITNESS_PAGES}" urban-fitness-sale

#### ROAD ####
ROAD_BASE="${URL}/ofertas/carretera/?p="
ROAD_PAGES="$(seq 1 5)"

bubic_get_page_outfile "${ROAD_BASE}" "${ROAD_PAGES}" road-sale

#### ROAD_WOMAN ####
ROAD_WOMAN_BASE="${URL}/ofertas/mujer/?p="
ROAD_WOMAN_PAGES="$(seq 1 2)"

bubic_get_page_outfile "${ROAD_WOMAN_BASE}" "${ROAD_WOMAN_PAGES}" road-woman-sale

#### ROAD_TRIATLON ####
ROAD_TRIATLON_BASE="${URL}/ofertas/triatln/?p="
ROAD_TRIATLON_PAGES="$(seq 1 2)"

bubic_get_page_outfile "${ROAD_TRIATLON_BASE}" "${ROAD_TRIATLON_PAGES}" road-triatlon-sale

#### ROAD_CICLOCROSS ####
ROAD_CICLOCROSS_BASE="${URL}/ofertas/ciclocross/?p="
ROAD_CICLOCROSS_PAGES="$(seq 1 2)"

bubic_get_page_outfile "${ROAD_CICLOCROSS_BASE}" "${ROAD_CICLOCROSS_PAGES}" road-ciclocross-sale

#### KIDS ####
KIDS_BASE="${URL}/ofertas/nio/?p="
KIDS_PAGES="$(seq 1 5)"

bubic_get_page_outfile "${KIDS_BASE}" "${KIDS_PAGES}" kids-sale




