#!/bin/bash
#
# Copyright © 2012-2015 Sergio Arroutbi Braojos <sarroutbi@gmail.com>
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
# Calmera store !
URL="www.ciclosnico.com"
ONLY_DOMAIN="ciclosnico.com"
MAX_TRIES=10
MAX_TIMEOUT=10

. ./common_get

ROAD_BIKES_BASE="${URL}/shop/17-carretera?p="
ROAD_BIKES_PAGES="$(seq 1 7)"

MTB_BIKES_BASE="${URL}/shop/87-rigidas?p="
MTB_BIKES_PAGES="$(seq 1 14)"

MTB_DOUBLE_BIKES_BASE="${URL}/shop/90-doble-suspension?p="
MTB_DOUBLE_BIKES_PAGES="$(seq 1 6)"

URBAN_BIKES_BASE="${URL}/shop/19-urbanas"
URBAN_BIKES_PAGES=""

KIDS_BIKES_BASE="${URL}/shop/20-infantilesjunior?p="
KIDS_BIKES_PAGES="$(seq 1 5)"

BMX_BIKES_BASE="${URL}/shop/70-bmx"
BMX_BIKES_PAGES=""

bubic_get_page_outfile "${ROAD_BIKES_BASE}"  "${ROAD_BIKES_PAGES}" road
bubic_get_page_outfile "${MTB_BIKES_BASE}"   "${MTB_BIKES_PAGES}"  mtb-fix
bubic_get_page_outfile "${MTB_DOUBLE_BIKES_BASE}" "${MTB_DOUBLE_BIKES_PAGES}" mtb-double
bubic_get_page_outfile "${URBAN_BIKES_BASE}" "${URBAN_BIKES_PAGES}" urban
bubic_get_page_outfile "${KIDS_BIKES_BASE}"  "${KIDS_BIKES_PAGES}"  kids
#bubic_get_page_outfile "${BMX_BIKES_BASE}"   "${BMX_BIKES_PAGES}"   bmx
