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
