#!/bin/bash
#
# This script gets all the bicycles from
# Mammoth store !

OUTPUT_FILE=bicimania.txt
URL="www.mammoth.es"
URL_BASE=http://www.mammoth.es/catalogo/bicicletas?page=
EXCLUDE="-Rgif -Rpng -Rjpg -Rcss"
PAGE_BASE="bicicletas?page="
#EXCLUDE="-Ahtml"
#ONLY_DOMAIN="bicimania.com"
#HOST_ONLY="-D${ONLY_DOMAIN}"

pages="$(seq 1 13)"
for page in ${pages}
do
  echo
  echo "wget ${EXCLUDE} ${HOST_ONLY} ${URL_BASE}${page}"
  echo
  wget ${EXCLUDE} ${HOST_ONLY} ${URL_BASE}${page}
done
