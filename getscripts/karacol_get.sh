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
URL="www.karacol.es"
ONLY_DOMAIN="karacol.es"
EXCLUDE="-Rgif -Rpng -Rjpg"
MAX_TRIES=10
MAX_TIMEOUT=10

. ./common_get

#### Add kids first, to stay in the first
#### dumped results and avoid being generated
#### with different KIND

#### KIDS ####
KIDS_ROAD_BASE="${URL}/catalogo/seccion/BICICLETAS/Carretera/Ni%C3%B1o?page="
KIDS_ROAD_PAGES="1"

bubic_get_page_outfile "${KIDS_ROAD_BASE}" "${KIDS_ROAD_PAGES}" kids-road

KIDS_MTB_BASE="${URL}/catalogo/seccion/BICICLETAS/MTB/Ni%C3%B1o?page="
KIDS_MTB_PAGES="$(seq 1 4)"

bubic_get_page_outfile "${KIDS_MTB_BASE}" "${KIDS_MTB_PAGES}" kids-mtb

#### BMX ####
BMX_BASE="${URL}/catalogo/seccion/BICICLETAS/Bmx?page="
BMX_PAGES="$(seq 1 3)"
bubic_get_page_outfile "${BMX_BASE}" "${BMX_PAGES}" bmx

#### ROAD ####
ROAD_BASE="${URL}/catalogo/seccion/BICICLETAS/Carretera?page="
ROAD_PAGES="$(seq 1 8)"

bubic_get_page_outfile "${ROAD_BASE}" "${ROAD_PAGES}" road

#### URBAN ####
URBAN_BASE="${URL}/catalogo/seccion/BICICLETAS/Ciudad?page="
URBAN_PAGES="$(seq 1 6)"

bubic_get_page_outfile "${URBAN_BASE}" "${URBAN_PAGES}" urban

#### MTB ####
MTB_BASE="${URL}/catalogo/seccion/BICICLETAS/MTB?page="
MTB_PAGES="$(seq 1 10)"

bubic_get_page_outfile "${MTB_BASE}" "${MTB_PAGES}" mtb

#### MTB DOUBLE ####
MTB_DOUBLE_BASE="${URL}/catalogo/seccion/BICICLETAS/MTB%20Doble?page="
MTB_DOUBLE_PAGES="$(seq 1 7)"

bubic_get_page_outfile "${MTB_DOUBLE_BASE}" "${MTB_DOUBLE_PAGES}" mtb-double
