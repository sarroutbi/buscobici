#!/bin/bash
#
# This script gets all the bicycles from
# Bicimania store !
# URL: www.bicimania.com
OUTPUT_FILE=bicimania.txt
URL_RIGIDAS=http://www.bicicletasgil.com/comprar-bicicleta/bicicletas/mtb%20rigida
wget ${URL_RIGIDAS}
cat ./"mtb rigida" | grep "<a id=" | grep Content
rm ./"mtb rigida"
