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

function against() {
  FILES=""
  if [ "${3}" == "1" ];
  then
    for file in $(ls -1 $2/psql*);
    do
      bnfile=$(basename $file)
      ls $1/${bnfile} 1>/dev/null 2>/dev/null || FILES="${FILES} ${file}" 
    done
  else
    FILES=$(ls -1 $1/psql*)
  fi
  for psql_file in ${FILES};
  do
    if [ "${3}" == "1" ]; then
      TARGET_FILE=$(echo $psql_file | sed s@${2}@${1}@g)
      DST_PSQL_FILE=${psql_file}
    else
      TARGET_FILE=${psql_file}
      DST_PSQL_FILE=$(echo $psql_file | sed s@${1}@${2}@g)
    fi
    echo "=========================================================="
    echo "$(basename ${TARGET_FILE}):"
    echo -n "${1}:"
    test -f ${TARGET_FILE}
    if [ $? -eq 0 ];
    then
      OLD_COUNT=$(wc -l ${TARGET_FILE} | awk {'print $1'})
      echo ${OLD_COUNT}
    else
      OLD_COUNT=0
      echo "0"
    fi
    echo -n "${2}:"
    test -f ${DST_PSQL_FILE}
    if [ $? -eq 0 ];
    then
      NEW_COUNT=$(wc -l $(echo ${TARGET_FILE} | sed s@${1}@${2}@g) | awk {'print $1'})
      let difference=$(($NEW_COUNT - $OLD_COUNT))
      if [ $difference -gt 0 ];
      then
        printf "$NEW_COUNT (+${difference})\n"
      else 
        printf "$NEW_COUNT (${difference})\n"
      fi
    else
      echo "0"
    fi
    echo "=========================================================="
  done
}

against ${1} ${2} ""
against ${1} ${2} "1" // Analyze only those in 2, not in 1
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
