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
# This script receives:
# 1 - The config file result of parsing a web
# 2 - The psql file
# and compares its entries to check for inconsistencies
 
TMP_FILE=$(mktemp)
counter=0
cat $1 | grep "\[*\]" > ${TMP_FILE}
let counter=$(cat ${TMP_FILE} | wc -l)
let counter2=$(wc -l $2 | awk {'print $1'})
compare=${counter}
[ ${counter2} -ge ${compare} ]  && let compare=${counter2}

echo "COMPARING:${compare} lines"
let counter=0
while [ ${counter} -ne ${compare} ];
do
  line1=$(head -${counter} ${TMP_FILE} | tail -1)
  line2=$(head -${counter} $2 | tail -1 | awk -F "(" {'print $2'} | awk -F "," {'print $1'})
  echo "${line1}<=>${line2}"
  let counter=$counter+1
done
> ${TMP_FILE}
