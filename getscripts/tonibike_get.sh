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
URL="www.ventabicicletas.es"
ONLY_DOMAIN="ventabicicletas.es"
EXCLUDE="-Rgif -Rpng -Rjpg"
MAX_TRIES=10
MAX_TIMEOUT=10

. ./common_get

#### BMX ####
BMX_BASE="${URL}/bicicletas-bmx-8"
BMX_PAGES=""

bubic_get_page_outfile "${BMX_BASE}" "${BMX_PAGES}" bmx

#### ROAD ####
ROAD_BASE="${URL}/bicicletas-de-carretera-7"
ROAD_PAGES=""

bubic_get_page_outfile "${ROAD_BASE}" "${ROAD_PAGES}" road

#### ROAD CICLOCROSS ####
ROAD_CICLOCROSS_BASE="${URL}/bicicletas-ciclocross-86"
ROAD_CICLOCROSS_PAGES=""

bubic_get_page_outfile "${ROAD_CICLOCROSS_BASE}" "${ROAD_CICLOCROSS_PAGES}" road-ciclocross

#### MTB ELECTRIC ####
MTB_ELECTRIC_BASE="${URL}/bicicletas-electricas-104"
MTB_ELECTRIC_PAGES=""

bubic_get_page_outfile "${MTB_ELECTRIC_BASE}" "${MTB_ELECTRIC_PAGES}" mtb-electric

#### MTB DOUBLE ####
MTB_DOUBLE_BASE="${URL}/bicicletas-enduro-121"
MTB_DOUBLE_PAGES=""

bubic_get_page_outfile "${MTB_DOUBLE_BASE}" "${MTB_DOUBLE_PAGES}" mtb-double

#### KIDS ####
KIDS_BASE="${URL}/bicicletas-infantiles-12?p="
KIDS_PAGES="$(seq 1 3)"

bubic_get_page_outfile "${KIDS_BASE}" "${KIDS_PAGES}" kids

#### MTB ####
MTB_BASE="${URL}/venta-mountain-bike-bicicletas-de-montana-6?p="
MTB_PAGES="$(seq 1 5)"

echo "Getting:${MTB_BASE}"
bubic_get_page_outfile "${MTB_BASE}" "${MTB_PAGES}" mtb

#### ROAD WOMAN ####
ROAD_WOMAN_BASE="${URL}/bicicletas-mujer-carretera-84"
ROAD_WOMAN_PAGES=""

bubic_get_page_outfile "${ROAD_WOMAN_BASE}" "${ROAD_WOMAN_PAGES}" road-woman

#### MTB WOMAN ####
MTB_WOMAN_BASE="${URL}/bicicletas-mujer-montana-85"
MTB_WOMAN_PAGES=""

bubic_get_page_outfile "${MTB_WOMAN_BASE}" "${MTB_WOMAN_PAGES}" mtb-woman

#### URBAN WOMAN ####
URBAN_WOMAN_BASE="${URL}/bicicletas-mujer-paseo-83"
URBAN_WOMAN_PAGES=""

bubic_get_page_outfile "${URBAN_WOMAN_BASE}" "${URBAN_WOMAN_PAGES}" urban-woman

#### ROAD_TRIATLON ####
ROAD_TRIATLON_BASE="${URL}/bicicletas-triatlon-14"
ROAD_TRIATLON_PAGES=""

bubic_get_page_outfile "${ROAD_TRIATLON_BASE}" "${ROAD_TRIATLON_PAGES}" road-triatlon
