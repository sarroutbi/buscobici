#!/bin/bash
#
# This script allows to clean those directories that exist on a certain configuration file
#
# 
CONF_FILE=./webget.conf
OUTPUT_DIR_CONF_LINE=OutputDir

test -z "${1}" || CONF_FILE="$1"

test -f ${CONF_FILE} || echo "configuration file does not exist" 

for dir in $(cat "${CONF_FILE}" | grep OutputDir | cut -d '=' -f2);
do
  echo -n "Erasing ${dir} ... "
  rm -r ${dir} 2>/dev/null 1>/dev/null && echo "[OK]" || echo "[FAIL]"
done

