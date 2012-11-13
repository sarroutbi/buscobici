#!/bin/bash
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
