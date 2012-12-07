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
# This script allows to clean those directories that exist on a certain configuration file
#
# 
CONF_FILE=./webget.conf
OUTPUT_DIR_CONF_LINE=OutputDir

test -z "${1}" || CONF_FILE="$1"

test -f ${CONF_FILE} || echo "configuration file does not exist" 

for dir in $(cat "${CONF_FILE}" | grep -v ^# | grep OutputDir | cut -d '=' -f2);
do
  echo -n "Erasing ${dir} ... "
  rm -r ${dir} 2>/dev/null 1>/dev/null && echo "[OK]" || echo "[FAIL]"
done

