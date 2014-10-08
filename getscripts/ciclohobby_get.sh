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
URL="www.ciclohobby.es"
ONLY_DOMAIN="ciclohobby.es"
EXCLUDE="-Rgif -Rpng -Rjpg"
MAX_TRIES=10
MAX_TIMEOUT=10

. ./common_get

#### ROAD ####
ROAD_BASE="${URL}/es/8-carretera?p="
ROAD_PAGES="$(seq 1 12)"

bubic_get_page_outfile "${ROAD_BASE}" "${ROAD_PAGES}" road

#### MTB ####
MTB_BASE="${URL}/es/9-mtb?p="
MTB_PAGES="$(seq 1 20)"

bubic_get_page_outfile "${MTB_BASE}" "${MTB_PAGES}" mtb

#### ROAD CICLOCROSS ####
ROAD_CICLOCROSS_BASE="${URL}/es/10-ciclocross?p="
ROAD_CICLOCROSS_PAGES="1"

bubic_get_page_outfile "${ROAD_CICLOCROSS_BASE}" "${ROAD_CICLOCROSS_PAGES}" road-ciclocross

#### URBAN ####
URBAN_BASE="${URL}/es/231-urban?p="
URBAN_PAGES="1"

bubic_get_page_outfile "${URBAN_BASE}" "${URBAN_PAGES}" urban

#### URBAN HYBRID ####
URBAN_HYBRID_BASE="${URL}/es/127-hibridas?p="
URBAN_HYBRID_PAGES="1"

bubic_get_page_outfile "${URBAN_HYBRID_BASE}" "${URBAN_HYBRID_PAGES}" urban-hybrid

#### URBAN FITNESS ####
URBAN_FITNESS_BASE="${URL}/es/129-fitness?p="
URBAN_FITNESS_PAGES="$(seq 1 3)"

bubic_get_page_outfile "${URBAN_FITNESS_BASE}" "${URBAN_FITNESS_PAGES}" urban-fitness

#### URBAN ELECTRIC ####
URBAN_ELECTRIC_BASE="${URL}/es/134-electrica?p="
URBAN_ELECTRIC_PAGES="$(seq 1 4)"

bubic_get_page_outfile "${URBAN_ELECTRIC_BASE}" "${URBAN_ELECTRIC_PAGES}" urban-electric

#### KIDS ####
KIDS_BASE="${URL}/es/136-ninos?p="
KIDS_PAGES="$(seq 1 4)"

bubic_get_page_outfile "${KIDS_BASE}" "${KIDS_PAGES}" kids

#### BMX ####
BMX_BASE="${URL}/es/229-bmx?p="
BMX_PAGES="1"

bubic_get_page_outfile "${BMX_BASE}" "${BMX_PAGES}" bmx

#### BMX_DUAL ####
BMX_DUAL_BASE="${URL}/es/229-bmx?p="
BMX_DUAL_PAGES="1"

bubic_get_page_outfile "${BMX_DUAL_BASE}" "${BMX_DUAL_PAGES}" bmx-dual



