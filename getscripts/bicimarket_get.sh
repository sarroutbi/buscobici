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
URL="www.bicimarket.com"
ONLY_DOMAIN="bicimarket.com"
EXCLUDE="-Rgif -Rpng -Rjpg"
MAX_TRIES=20
MAX_TIMEOUT=30

. ./common_get

MTB_26_BIKES_BASE="${URL}/Bicicletas-MTB-26-c20526.html?page="
MTB_26_BIKES_PAGES="$(seq 1 3)"

MTB_27_5_BIKES_BASE="${URL}/Bicicletas-27-5-pulgadas-c20527.html?page="
MTB_27_5_BIKES_PAGES="$(seq 1 7)"

MTB_29_BIKES_BASE="${URL}/Bicicletas-MTB-29-c20528.html?page="
MTB_29_BIKES_PAGES="$(seq 1 6)"

MTB_WOMAN_BIKES_BASE="${URL}/Bicicletas-Mujer-c20441.html"
MTB_WOMAN_BIKES_PAGES=""

ROAD_BIKES_BASE="${URL}/Bicicletas-Carretera-c20433.html?page="
ROAD_BIKES_PAGES="$(seq 1 5)"

KIDS_BIKES_BASE="${URL}/Bicicletas-Infantil-c20434.html?page="
KIDS_BIKES_PAGES="$(seq 1 4)"

URBAN_BIKES_BASE="${URL}/Bicicletas-Urbanas-c20435.html?page="
URBAN_BIKES_PAGES="$(seq 1 3)"

URBAN_TREKKING_BIKES_BASE="${URL}/Bicicletas-Hibridas-Trekking-c20624.html"
URBAN_TREKKING_BIKES_PAGES=""

URBAN_FOLDING_BIKES_BASE="${URL}/Bicicletas-Hibridas-Trekking-c20438.html?page="
URBAN_FOLDING_BIKES_PAGES="$(seq 1 3)"

URBAN_ELECTRIC_BIKES_BASE="${URL}/Bicicletas-Bicicleta-Electrica-c20440.html"
URBAN_ELECTRIC_BIKES_PAGES=""

ROAD_TRIATLON_BIKES_BASE="${URL}/Bicicletas-Triatlon-c20439.html"
ROAD_TRIATLON_BIKES_PAGES=""

BMX_BIKES_BASE="${URL}/Bicicletas-BMX-c20436.html"
BMX_BIKES_PAGES=

CICLOCROSS_BIKES_BASE="${URL}/Bicicletas-Ciclocross-c20437.html"
CICLOCROSS_BIKES_PAGES=""

bubic_get_page_outfile "${MTB_26_BIKES_BASE}" "${MTB_26_BIKES_PAGES}" mtb-26
bubic_get_page_outfile "${MTB_27_5_BIKES_BASE}" "${MTB_27_5_BIKES_PAGES}" mtb-27-5
bubic_get_page_outfile "${MTB_29_BIKES_BASE}" "${MTB_29_BIKES_PAGES}" mtb-29
bubic_get_page_outfile "${MTB_WOMAN_BIKES_BASE}" "${MTB_WOMAN_BIKES_PAGES}" mtb-woman
bubic_get_page_outfile "${ROAD_BIKES_BASE}" "${ROAD_BIKES_PAGES}" road
bubic_get_page_outfile "${KIDS_BIKES_BASE}" "${KIDS_BIKES_PAGES}" kids
bubic_get_page_outfile "${URBAN_BIKES_BASE}" "${URBAN_BIKES_PAGES}" urban
bubic_get_page_outfile "${URBAN_TREKKING_BIKES_BASE}" "${URBAN_TREKKING_BIKES_PAGES}" urban-trekking
bubic_get_page_outfile "${URBAN_FOLDING_BIKES_BASE}" "${URBAN_FOLDING_BIKES_PAGES}" urban-folding
bubic_get_page_outfile "${URBAN_ELECTRIC_BIKES_BASE}" "${URBAN_ELECTRIC_BIKES_PAGES}" urban-electric
bubic_get_page_outfile "${ROAD_TRIATLON_BIKES_BASE}" "${ROAD_TRIATLON_BIKES_PAGES}" road-triatlon
bubic_get_page_outfile "${BMX_BIKES_BASE}" "${BMX_BIKES_PAGES}" bmx
bubic_get_page_outfile "${CICLOCROSS_BIKES_BASE}" "${CICLOCROSS_BIKES_PAGES}" road-ciclocross
