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

ELECTRIC_BIKES_BASE="${URL}/Bicicletas-Bicicleta-Electrica-c20130.html"
ELECTRIC_BIKES_PAGES=""

TRIAL_BIKES_BASE="${URL}/Bicicletas-BikeTrial-c20131.html"
TRIAL_BIKES_PAGES=""

BMX_BIKES_BASE="${URL}/Bicicletas-BMX-c20249.html"
BMX_BIKES_PAGES=

ROAD_BIKES_BASE="${URL}/Bicicletas-Carretera-c10020.html"
ROAD_BIKES_PAGES=""

CICLOCROSS_BIKES_BASE="${URL}/Bicicletas-Ciclocross-c20270.html"
CICLOCROSS_BIKES_PAGES=""

CRUISERS_BIKES_BASE="${URL}/Bicicletas-Cruisers-c20397.html"
CRUISERS_BIKES_PAGES=""

DOUBLE_FREERIDE_BIKES_BASE="${URL}/Bicicletas-Doble-Freeride-DH-c20164.html"
DOUBLE_FREERIDE_BIKES_PAGES=""

DIRT_BIKES_BASE="${URL}/Bicicletas-Dirt-c20303.html"
DIRT_BIKES_PAGES=""

#DOUBLE
MTB_26_ENDURO_BASE="${URL}/Bicicletas-Enduro-AM-26-c200075.html"    
MTB_26_ENDURO_PAGES=""

#DOUBLE
MTB_27_ENDURO_BASE="${URL}/Bicicletas-Enduro-AM-27-5-c20400.html"    
MTB_27_ENDURO_PAGES=""

#DOUBLE
MTB_29_ENDURO_BASE="${URL}/Bicicletas-Enduro-AM-29-c20404.html"
MTB_29_ENDURO_PAGES=""

FIXIE_BIKES_BASE="${URL}/Bicicletas-Fixed-c20306.html"
FIXIE_BIKES_PAGES=""

HYBRID_BIKES_BASE="${URL}/Bicicletas-Hibrida-c10050.html"
HYBRID_BIKES_PAGES=""

KIDS_BIKES_BASE="${URL}/Bicicletas-Infantil-c20177.html"
KIDS_BIKES_PAGES=""

JUNIOR_BIKES_BASE="${URL}/Bicicletas-Junior-c20391.html"
JUNIOR_BIKES_PAGES=""

LADY_BIKES_BASE="${URL}/Bicicletas-Lady-c20253.html"
LADY_BIKES_PAGES=""

MTB_27_5_BIKES_BASE="${URL}/Bicicletas-27-5-pulgadas-c20400.html"
MTB_27_5_BIKES_PAGES=""

MTB_29_BIKES_BASE="${URL}/Bicicletas-29-pulgadas-c20380.html"
MTB_29_BIKES_PAGES=""

MTB_XC_BIKES_BASE="${URL}/Bicicletas-Cross-country-c1010.html"
MTB_XC_BIKES_PAGES=""

MTB_DOUBLE_BIKES_BASE="${URL}/Bicicletas-Doble-XC-Enduro-c20075.html"
MTB_DOUBLE_BIKES_PAGES=""

VELO_BIKES_BASE="${URL}/Bicicletas-Pista-c20396.html"
VELO_BIKES_PAGES=""

FOLDING_BIKES_BASE="${URL}/Bicicletas-Plegable-c10070.html"
FOLDING_BIKES_PAGES=""

TRIATLON_BIKES_BASE="${URL}/Bicicletas-Triatlon-c20376.html"
TRIATLON_BIKES_PAGES=""

URBAN_BIKES_BASE="${URL}/Bicicletas-Urbanas-c10030.html"
URBAN_BIKES_PAGES=""

#FIX
MTB_XC_26_BASE="${URL}/Bicicletas-MTB-XC-26-c1010.html"
MTB_XC_26_PAGES=""

#DOUBLE
MTB_XC_27_5_DOUBLE_BASE="${URL}/Bicicletas-MTB-XC-Doble-27-5-c20405.html"
MTB_XC_27_5_DOUBLE_PAGES=""

#DOUBLE
MTB_XC_29_DOUBLE_BASE="${URL}/Bicicletas-MTB-XC-Doble-29-c20403.html"
MTB_XC_29_DOUBLE_PAGES=""

#FIX
MTB_XC_27_5_FIX_BASE="${URL}/Bicicletas-MTB-XC-Rigida-27-5-c20402.html"
MTB_XC_27_5_FIX_PAGES=""

#MTB-29
MTB_XC_29_FIX_BASE="${URL}/Bicicletas-MTB-XC-Rigida-29-c20380.html"
MTB_XC_29_FIX_PAGES=""

####2014 Review
ROAD_2014_BIKES_BASE="${URL}/Bicicletas-Carretera-c20433.html?page="
ROAD_2014_BIKES_PAGES="$(seq 1 4)"

ELECTRIC_2014_BIKES_BASE="${URL}/Bicicletas-Electricas-c20440.html?page="
ELECTRIC_2014_BIKES_PAGES="$(seq 1 2)"

URBAN_2014_BIKES_BASE="${URL}/Bicicletas-Urbanas-c20435.html?page="
URBAN_2014_BIKES_PAGES="$(seq 1 4)"

ROAD_TRIATLON_2014_BIKES_BASE="${URL}/Bicicletas-Triatlon-c20439.html?page="
ROAD_TRIATLON_2014_BIKES_PAGES="$(seq 1 2)"

ROAD_CICLOCROSS_2014_BIKES_BASE="${URL}/Bicicletas-Ciclocross-c20437.html?page="
ROAD_CICLOCROSS_2014_BIKES_PAGES="$(seq 1 2)"

MTB_2014_BIKES_BASE="${URL}/Bicicletas-MTB-26-c20526.html?page="
MTB_2014_BIKES_PAGES="$(seq 1 2)"

MTB_27_5_2014_BIKES_BASE="${URL}/Bicicletas-MTB-27-5-c20527.html?page="
MTB_27_5_2014_BIKES_PAGES="$(seq 1 4)"

MTB_29_2014_BIKES_BASE="${URL}/Bicicletas-MTB-29-c20528.html?page="
MTB_29_2014_BIKES_PAGES="$(seq 1 5)"

KIDS_2014_BIKES_BASE="${URL}/Bicicletas-Infantiles-Junior-c20434.html?page="
KIDS_2014_BIKES_PAGES="$(seq 1 3)"

BMX_2014_BIKES_BASE="${URL}/Bicicletas-BMX-c20436.html?page="
BMX_2014_BIKES_PAGES="$(seq 1 2)"

FOLDING_2014_BIKES_BASE="${URL}/Bicicletas-Plegables-c20438.html?page="
FOLDING_2014_BIKES_PAGES="$(seq 1 2)"

bubic_get_page_outfile "${ROAD_2014_BIKES_BASE}" "${ROAD_2014_BIKES_PAGES}" road
bubic_get_page_outfile "${ELECTRIC_2014_BIKES_BASE}" "${ELECTRIC_2014_BIKES_PAGES}" electric
bubic_get_page_outfile "${URBAN_2014_BIKES_BASE}" "${URBAN_2014_BIKES_PAGES}" urban
bubic_get_page_outfile "${ROAD_TRIATLON_2014_BIKES_BASE}" "${ROAD_TRIATLON_2014_BIKES_PAGES}" road-triatlon
bubic_get_page_outfile "${ROAD_CICLOCROSS_2014_BIKES_BASE}" "${ROAD_CICLOCROSS_2014_BIKES_PAGES}" road-ciclocross
bubic_get_page_outfile "${MTB_2014_BIKES_BASE}" "${MTB_2014_BIKES_PAGES}" mtb
bubic_get_page_outfile "${MTB_27_5_2014_BIKES_BASE}" "${MTB_27_5_2014_BIKES_PAGES}" mtb-27-5
bubic_get_page_outfile "${MTB_29_2014_BIKES_BASE}" "${MTB_29_2014_BIKES_PAGES}" mtb-29
bubic_get_page_outfile "${KIDS_2014_BIKES_BASE}" "${KIDS_2014_BIKES_PAGES}" kids
bubic_get_page_outfile "${BMX_2014_BIKES_BASE}" "${BMX_2014_BIKES_PAGES}" bmx
bubic_get_page_outfile "${FOLDING_2014_BIKES_BASE}" "${FOLDING_2014_BIKES_PAGES}" urban-folding
