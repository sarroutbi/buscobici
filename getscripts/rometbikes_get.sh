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
URL="rometbikes.com"
ONLY_DOMAIN="rometbikes.com"
EXCLUDE="-Rgif -Rpng -Rjpg"
MAX_TRIES=10
MAX_TIMEOUT=10

. ./common_get

#### Add kids first, to stay in the first
#### dumped results and avoid being generated
#### with different KIND

#### KIDS ####
KIDS_MTB_BASE="${URL}/19-mtb-junior?p="
KIDS_MTB_PAGES="1"

bubic_get_page_outfile "${KIDS_MTB_BASE}" "${KIDS_MTB_PAGES}" kids-mtb

#### KIDS-YOUNG ####
KIDS_YOUNG_BASE="${URL}/10-adolescente-24?p="
KIDS_YOUNG_PAGES="1"

bubic_get_page_outfile "${KIDS_YOUNG_BASE}" "${KIDS_YOUNG_PAGES}" kids-young

#### MTB ####
MTB_BASE="${URL}/6-mtb?p="
MTB_PAGES="$(seq 1 5)"

bubic_get_page_outfile "${MTB_BASE}" "${MTB_PAGES}" mtb

#### URBAN ####
URBAN_BASE="${URL}/7-bicicletas-urbanas?p="
URBAN_PAGES="$(seq 1 3)"

bubic_get_page_outfile "${URBAN_BASE}" "${URBAN_PAGES}" urban

#### TREKKING ####
TREKKING_BASE="${URL}/8-bicicletas-trekking?p="
TREKKING_PAGES="$(seq 1 3)"

bubic_get_page_outfile "${TREKKING_BASE}" "${TREKKING_PAGES}" trekking

#### ROAD ####
ROAD_BASE="${URL}/9-bicicletas-de-carretera?p="
ROAD_PAGES="1"

bubic_get_page_outfile "${ROAD_BASE}" "${ROAD_PAGES}" road
