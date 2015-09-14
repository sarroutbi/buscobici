#!/bin/bash
#
# Copyright © 2014 Sergio Arroutbi Braojos <sarroutbi@gmail.com>
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
URL="www.labicicleta.net"
ONLY_DOMAIN=$(echo ${URL} | sed -e 's/www\.//g')
EXCLUDE="-Rgif -Rpng -Rjpg"
MAX_TRIES=10
MAX_TIMEOUT=10

. ./common_get

#### MTB ####
MTB_BASE="${URL}/bicicletas/mtb.html?p="
MTB_PAGES="$(seq 1 10)"

bubic_get_page_outfile "${MTB_BASE}" "${MTB_PAGES}" mtb

#### ROAD ####
ROAD_BASE="${URL}/bicicletas/carretera.html?p="
ROAD_PAGES="$(seq 1 3)"

bubic_get_page_outfile "${ROAD_BASE}" "${ROAD_PAGES}" road

#### BMX ####
BMX_BASE="${URL}/bicicletas/bmx.html?p="
BMX_PAGES="$(seq 1 3)"

bubic_get_page_outfile "${BMX_BASE}" "${BMX_PAGES}" bmx

#### KIDS ####
KIDS_BASE="${URL}/bicicletas/ni-o.html?p="
KIDS_PAGES="$(seq 1 3)"

bubic_get_page_outfile "${KIDS_BASE}" "${KIDS_PAGES}" kids

#### URBAN ####
URBAN_BASE="${URL}/bicicletas/urbana.html?p="
URBAN_PAGES="$(seq 1 3)"

bubic_get_page_outfile "${URBAN_BASE}" "${URBAN_PAGES}" urban

#### ROAD-TRIATHLON ####
ROAD_TRIATHLON_BASE="${URL}/bicicletas/triathlon-crono.html"
ROAD_TRIATHLON_PAGES=""

bubic_get_page_outfile "${ROAD_TRIATHLON_BASE}" "${ROAD_TRIATHLON_PAGES}" road-triathlon

#### ROAD_CICLOCROSS ####
ROAD_CICLOCROSS_BASE="${URL}/bicicletas/ciclocross.html"
ROAD_CICLOCROSS_PAGES=""

bubic_get_page_outfile "${ROAD_CICLOCROSS_BASE}" "${ROAD_CICLOCROSS_PAGES}" road-ciclocross

#### URBAN-ELECTRIC ####
URBAN_ELECTRIC_BASE="${URL}/bicicletas/electricas.html"
URBAN_ELECTRIC_PAGES=""

bubic_get_page_outfile "${URBAN_ELECTRIC_BASE}" "${URBAN_ELECTRIC_PAGES}" urban-electric
