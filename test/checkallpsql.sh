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
function error()
{
  echo "$1"
  exit $2
}

DIR=.
PREFIX=psql-
test -z "${1}" || DIR="${1}"
test -z "${2}" || PREFIX="${2}"

test -d "${DIR}" || error "Dir ${DIR} does not exist" 1

echo "======================================="
for file in $(ls ${DIR}/${PREFIX}*); 
do
  echo
  echo -n "File:$file"
  ./checkpsql.sh $file
  ok=$?
  echo -n "RESULT:" 
  if [ $ok -eq 0 ]; then
    echo "[OK]"
  else
    echo "[FAIL]"
  fi 
done
echo "======================================="
