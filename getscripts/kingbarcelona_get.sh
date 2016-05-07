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
# Biciescapa store !
#
URL="www.kingbarcelona.com"
ONLY_DOMAIN="kingbarcelona.com"
MAX_TRIES=10
MAX_TIMEOUT=10

. ./common_get

MTB_FIX_29_BIKES_BASE="${URL}/es/rigida-29-aluminio-c-644_646.html?page="
MTB_FIX_29_BIKES_PAGES="$(seq 1 1)"

MTB_FIX_29_CARBON_BIKES_BASE="${URL}/es/rigida-29-carbono-c-644_645.html?page="
MTB_FIX_29_CARBON_BIKES_PAGES="$(seq 1 2)"

MTB_FIX_275_BIKES_BASE="${URL}/es/rigida-275-aluminio-c-644_648.html?page="
MTB_FIX_275_BIKES_PAGES="$(seq 1 1)"

MTB_FIX_275_CARBON_BIKES_BASE="${URL}/es/rigida-275-carbono-c-644_647.html?page="
MTB_FIX_275_CARBON_BIKES_PAGES="$(seq 1 1)"

URBAN_ELECTRIC_BIKES_BASE="${URL}/es/ebikes-c-644_656.html?page="
URBAN_ELECTRIC_BIKES_PAGES="$(seq 1 1)"

MTB_DOUBLE_29_BIKES_BASE="${URL}/es/doble-suspension-29-aluminio-c-644_650.html?page="
MTB_DOUBLE_29_BIKES_PAGES="$(seq 1 1)"

MTB_DOUBLE_29_CARBON_BIKES_BASE="${URL}/es/doble-suspension-29-carbono-c-644_649.html?page="
MTB_DOUBLE_29_CARBON_BIKES_PAGES="$(seq 1 1)"

MTB_DOUBLE_275_BIKES_BASE="${URL}/es/doble-suspension-275-aluminio-c-644_652.html?page="
MTB_DOUBLE_275_BIKES_PAGES="$(seq 1 1)"

MTB_DOUBLE_275_CARBON_BIKES_BASE="${URL}/es/doble-suspension-275-carbono-c-644_651.html?page="
MTB_DOUBLE_275_CARBON_BIKES_PAGES="$(seq 1 1)"

ROAD_BIKES_BASE="${URL}/es/carretera-c-644_653.html?page="
ROAD_BIKES_PAGES="$(seq 1 2)"

ROAD_DISC_BIKES_BASE="${URL}/es/carretera-disco-c-644_654.html?page="
ROAD_DISC_BIKES_PAGES="$(seq 1 1)"

ROAD_CICLOCROSS_BIKES_BASE="${URL}/es/ciclo-cross-c-644_658.html?page="
ROAD_CICLOCROSS_BIKES_PAGES="$(seq 1 1)"

URBAN_BIKES_BASE="${URL}/es/trekking-touring-c-644_673.html?page="
URBAN_BIKES_PAGES="$(seq 1 1)"

URBAN_FOLDING_BIKES_BASE="${URL}/es/plegable-c-644_678.html?page="
URBAN_FOLDING_BIKES_PAGES="$(seq 1 1)"

URBAN_FAT_BIKES_BASE="${URL}/es/fatbike-c-644_659.html?page="
URBAN_FAT_BIKES_PAGES="$(seq 1 1)"

KIDS_BIKES_BASE="${URL}/es/bicicletas-infantiles-c-644_655.html?page="
KIDS_BIKES_PAGES="$(seq 1 1)"

KIDS_BTT_BIKES_BASE="${URL}/es/bicicletas-26-c-644_675.html?page="
KIDS_BTT_BIKES_PAGES="$(seq 1 1)"

bubic_get_page_outfile "${MTB_FIX_29_BIKES_BASE}" "${MTB_FIX_29_BIKES_PAGES}" mtb-fix-29
bubic_get_page_outfile "${MTB_FIX_29_CARBON_BIKES_BASE}" "${MTB_FIX_29_CARBON_BIKES_PAGES}" mtb-fix-29-carbon
bubic_get_page_outfile "${MTB_FIX_275_BIKES_BASE}" "${MTB_FIX_275_BIKES_PAGES}" mtb-fix-275
bubic_get_page_outfile "${MTB_FIX_275_CARBON_BIKES_BASE}" "${MTB_FIX_275_CARBON_BIKES_PAGES}" mtb-fix-275-carbon
bubic_get_page_outfile "${MTB_DOUBLE_29_BIKES_BASE}" "${MTB_DOUBLE_29_BIKES_PAGES}" mtb-double-29
bubic_get_page_outfile "${MTB_DOUBLE_29_CARBON_BIKES_BASE}" "${MTB_DOUBLE_29_CARBON_BIKES_PAGES}" mtb-double-29-carbon
bubic_get_page_outfile "${MTB_DOUBLE_275_BIKES_BASE}" "${MTB_DOUBLE_275_BIKES_PAGES}" mtb-double-275
bubic_get_page_outfile "${MTB_DOUBLE_275_CARBON_BIKES_BASE}" "${MTB_DOUBLE_275_CARBON_BIKES_PAGES}" mtb-double-275-carbon
bubic_get_page_outfile "${ROAD_BIKES_BASE}" "${ROAD_BIKES_PAGES}" road
bubic_get_page_outfile "${ROAD_DISC_BIKES_BASE}" "${ROAD_DISC_BIKES_PAGES}" road-disc
bubic_get_page_outfile "${ROAD_CICLOCROSS_BIKES_BASE}" "${ROAD_CICLOCROSS_BIKES_PAGES}" road-ciclocross
bubic_get_page_outfile "${URBAN_ELECTRIC_BIKES_BASE}" "${URBAN_ELECTRIC_BIKES_PAGES}" urban-electric
bubic_get_page_outfile "${URBAN_BIKES_BASE}" "${URBAN_BIKES_PAGES}" urban
bubic_get_page_outfile "${URBAN_FOLDING_BIKES_BASE}" "${URBAN_FOLDING_BIKES_PAGES}" urban-folding
bubic_get_page_outfile "${URBAN_FAT_BIKES_BASE}" "${URBAN_FAT_BIKES_PAGES}" urban-fat
bubic_get_page_outfile "${KIDS_BIKES_BASE}" "${KIDS_BIKES_PAGES}" kids
bubic_get_page_outfile "${KIDS_BTT_BIKES_BASE}" "${KIDS_BTT_BIKES_PAGES}" kids-btt
