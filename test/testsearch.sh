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
# 
# GLOBAL CONFIGURATION VALUES:
#GLOBAL_URL="http://www.buscobici.com/bikesearch"
SEARCH_PHP="search.php"
ERROR_LOG_FILE="./errorurl.txt"
let COUNTER_URL=0
let ERROR_COUNTER=0
TMP_FILE=$(mktemp)

> "${ERROR_LOG_FILE}"
> "${TMP_FILE}"
rm -f "${SEARCH_PHP}"

function urltest()
{
  URL="$1"
  wget "${URL}" -O - -o /dev/null 2>&1 > /dev/null
  return $?
}

# Parse input
priceFrom=$1
priceTo=$2
type=$3
search=$4
GLOBAL_URL=$5

wget --post-data "priceFrom=${priceFrom}&priceTo=${priceTo}&type=${type}&search=${search}" "${GLOBAL_URL}/${SEARCH_PHP}" 

