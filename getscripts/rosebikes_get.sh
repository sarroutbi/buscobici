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
URL="www.rosebikes.es"
ONLY_DOMAIN="rosebikes.es"
EXCLUDE="-Rgif -Rpng -Rjpg"
MAX_TRIES=10
MAX_TIMEOUT=10

. ./common_get

#### ROAD ####
ROAD_BASE="${URL}/productos/bicicletas/bici-de-carretera/?page="
ROAD_PAGES="$(seq 1 3)"

bubic_get_page_outfile "${ROAD_BASE}" "${ROAD_PAGES}" road

#### MTB ####
MTB_BASE="${URL}/productos/bicicletas/mtb/?page="
MTB_PAGES="$(seq 1 2)"

bubic_get_page_outfile "${MTB_BASE}" "${MTB_PAGES}" mtb

#### FITNESS ####
FITNESS_BASE="${URL}/productos/bicicletas/fitness/?page="
FITNESS_PAGES="$(seq 1 2)"

bubic_get_page_outfile "${FITNESS_BASE}" "${FITNESS_PAGES}" fitness

#### URBAN ####
URBAN_BASE="${URL}/productos/bicicletas/viaje-trekking-y-city-bikes/?page="
URBAN_PAGES="$(seq 1 2)"

bubic_get_page_outfile "${URBAN_BASE}" "${URBAN_PAGES}" urban
