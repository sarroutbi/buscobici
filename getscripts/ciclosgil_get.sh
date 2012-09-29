#!/bin/bash
#
# This script gets all the bicycles from
# Gil Bicicletas !
# URL: www.bicicletasgil.com
ROAD_BIKES="http://www.bicicletasgil.com/comprar-bicicleta/bicicletas/carretera"
MTB_FIX_BIKES="http://www.bicicletasgil.com/comprar-bicicleta/bicicletas/mtb%20rigida"
MTB_DOUBLE_BIKES="http://www.bicicletasgil.com/comprar-bicicleta/bicicletas/mtb%20dobles"
MTB_TWENTYNINE_BIKES='http://www.bicicletasgil.com/comprar-bicicleta/bicicletas/mtb 29'
URBAN_BIKES="http://www.bicicletasgil.com/comprar-bicicleta/bicicletas/urbanas"
WOMAN_BIKES="http://www.bicicletasgil.com/comprar-bicicleta/bicicletas/mujer"
KID_BIKES="http://www.bicicletasgil.com/comprar-bicicleta/bicicletas/infantil"
wget "${ROAD_BIKES}"
wget "${MTB_FIX_BIKES}"
wget "${MTB_DOUBLE_BIKES}"
wget "${MTB_TWENTYNINE_BIKES}"
wget "${URBAN_BIKES}"
wget "${WOMAN_BIKES}"
wget "${KID_BIKES}"
