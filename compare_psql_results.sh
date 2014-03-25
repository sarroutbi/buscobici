#!/bin/bash
function exit_error() {
  echo
  echo "$1"
  echo
  exit $2
}

test -z $1 && exit_error "Please, provide source comparison directory" 1
test -z $2 && exit_error "Please, provide destination comparison directory" 1
test -d $1 || exit_error "Directory:[${1}] does not exist" 1
test -d $2 || exit_error "Directory:[${2}] does not exist" 1
ls $1/psql* >/dev/null || exit_error "Directory:[${1}] does not contain psql files" 1
ls $2/psql* >/dev/null || exit_error "Directory:[${2}] does not contain psql files" 1

for psql_file in $(ls $1/psql*); 
do
  DST_PSQL_FILE=$(echo $psql_file | sed s@${1}@${2}@g)
  test -f ${DST_PSQL_FILE}
  if [ $? -eq 0 ];
  then
    echo "=========================================================="
    echo "$(basename ${psql_file}):"
    echo -n "${1}:"
    wc -l ${psql_file} | awk {'print $1'}
    echo -n "${2}:"
    wc -l $(echo $psql_file | sed s@${1}@${2}@g) | awk {'print $1'}
    echo "=========================================================="
  fi
done
echo -n "TOTAL results in [${1}]: "
let LAST_TOTAL=$(wc -l ${1}/psql* | tail -1 | awk {'print $1'} | tr -d ' ')
echo $LAST_TOTAL
echo -n "TOTAL results in [${2}]: "
let NEW_TOTAL=$(wc -l ${2}/psql* | tail -1 | awk {'print $1'} | tr -d ' ')
let difference=$(($NEW_TOTAL - $LAST_TOTAL))
if [ $difference -gt 0 ];
then
  echo "$NEW_TOTAL (+$difference)"
else
  echo "$NEW_TOTAL ($difference)"
fi
