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
# Gil Bicicletas !
# URL: www.bicicletasgil.com
MAX_TRIES=10
MAX_TIMEOUT=10

ROAD_BIKES="http://www.bicicletasgil.com/comprar-bicicleta/bicicletas/carretera"
MTB_FIX_BIKES="http://www.bicicletasgil.com/comprar-bicicleta/bicicletas/mtb%20rigida"
MTB_DOUBLE_BIKES="http://www.bicicletasgil.com/comprar-bicicleta/bicicletas/mtb%20dobles"
MTB_TWENTYNINE_BIKES='http://www.bicicletasgil.com/comprar-bicicleta/bicicletas/mtb 29'
URBAN_BIKES="http://www.bicicletasgil.com/comprar-bicicleta/bicicletas/urbanas"
WOMAN_BIKES="http://www.bicicletasgil.com/comprar-bicicleta/bicicletas/mujer"
KID_BIKES="http://www.bicicletasgil.com/comprar-bicicleta/bicicletas/infantil"

wget --tries=${MAX_TRIES} --timeout=${MAX_TIMEOUT} "${ROAD_BIKES}"
wget --tries=${MAX_TRIES} --timeout=${MAX_TIMEOUT} "${MTB_FIX_BIKES}"
wget --tries=${MAX_TRIES} --timeout=${MAX_TIMEOUT} "${MTB_DOUBLE_BIKES}"
wget --tries=${MAX_TRIES} --timeout=${MAX_TIMEOUT} "${MTB_TWENTYNINE_BIKES}"
wget --tries=${MAX_TRIES} --timeout=${MAX_TIMEOUT} "${URBAN_BIKES}"
wget --tries=${MAX_TRIES} --timeout=${MAX_TIMEOUT} "${WOMAN_BIKES}"
wget --tries=${MAX_TRIES} --timeout=${MAX_TIMEOUT} "${KID_BIKES}"
