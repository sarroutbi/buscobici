#!/bin/bash
#
# This script gets all the bicycles from
# Bicimania store !
# URL: www.bicimania.com
OUTPUT_FILE=bicimania.txt
URL="www.bicimania.com"
ONLY_DOMAIN="bicimania.com"
EXCLUDE="-Rgif -Rpng -Rjpg"
#EXCLUDE="-Ahtml"
#HOST_ONLY="-D${ONLY_DOMAIN}"

echo
echo "wget -r ${EXCLUDE} ${HOST_ONLY} ${URL}"
echo
wget -r ${EXCLUDE} ${HOST_ONLY} ${URL}
