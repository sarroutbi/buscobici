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
URL="www.evanscycles.com"
ONLY_DOMAIN="evanscycles.com"
EXCLUDE="-Rgif -Rpng -Rjpg"
MAX_TRIES=10
MAX_TIMEOUT=10

. ./common_get

#### ROAD ####
ROAD_BASE="${URL}/categories/bikes/road-bikes/f?page="
ROAD_PAGES="$(seq 0 10)"

bubic_get_page_outfile "${ROAD_BASE}" "${ROAD_PAGES}" road

#### MTB ####
MTB_DOUBLE_BASE="${URL}/categories/bikes/mountain-bikes/f/full-suspension?page="
MTB_DOUBLE_PAGES="$(seq 0 5)"

bubic_get_page_outfile "${MTB_DOUBLE_BASE}" "${MTB_DOUBLE_PAGES}" mtb-double

MTB_FIX_BASE="${URL}/categories/bikes/mountain-bikes/f/hardtail?page="
MTB_FIX_PAGES="$(seq 0 8)"

bubic_get_page_outfile "${MTB_FIX_BASE}" "${MTB_FIX_PAGES}" mtb-fix

MTB_FIX2_BASE="${URL}/categories/bikes/mountain-bikes/f/rigid"
MTB_FIX2_PAGES=

bubic_get_page_outfile "${MTB_FIX2_BASE}" "${MTB_FIX2_PAGES}" mtb-fix2

#### URBAN ####

HYBRID_BASE="${URL}/categories/bikes/hybrid-bikes/f?page="
HYBRID_PAGES="$(seq 0 10)"

bubic_get_page_outfile "${HYBRID_BASE}" "${HYBRID_PAGES}" hybrid

FOLDING_BASE="${URL}/categories/bikes/folding-bikes"
FOLDING_PAGES=""

bubic_get_page_outfile "${FOLDING_BASE}" "${FOLDING_PAGES}" folding

CYCLOCROSS_BASE="${URL}/categories/bikes/cyclocross-bikes/f?page="
CYCLOCROSS_PAGES="$(seq 0 3)"

bubic_get_page_outfile "${CYCLOCROSS_BASE}" "${CYCLOCROSS_PAGES}" cross

FIXIE_BASE="${URL}/categories/bikes/single-speed-fixed-gear-bikes"
FIXIE_PAGES=""

bubic_get_page_outfile "${FIXIE_BASE}" "${FIXIE_PAGES}" fixie

FIXIE_TRACK_BASE="${URL}/categories/bikes/track-bikes"
FIXIE_TRACK_PAGES=""

bubic_get_page_outfile "${FIXIE_TRACK_BASE}" "${FIXIE_TRACK_PAGES}" fixie-track

TOURING_BASE="${URL}/categories/bikes/touring-bikes"
TOURING_PAGES=""

bubic_get_page_outfile "${TOURING_BASE}" "${TOURING_PAGES}" touring

#### BMX ####
BMX_BASE="${URL}/categories/bikes/bmx-bikes/f?page="
BMX_PAGES="$(seq 0 5)"

bubic_get_page_outfile "${BMX_BASE}" "${BMX_PAGES}" bmx

#### KIDS ####
KIDS_BASE="${URL}/categories/bikes/kids-bikes/f?page="
KIDS_PAGES="$(seq 0 7)"

bubic_get_page_outfile "${KIDS_BASE}" "${KIDS_PAGES}" kids
