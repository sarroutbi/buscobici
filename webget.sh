#!/bin/bash
# 
# CONFIGURATION:
#
GET_CONFIG=./webget.conf
CONFIGS=""
TMP_CONFIGS_FILE=/tmp/configs
TEMP=
TMP_DIR_FILE=$(mktemp)
TMP_SCRIPT_FILE=$(mktemp)
TMP_PSCRIPT_FILE=$(mktemp)
TMP_CONFIGS_FILE=$(mktemp)
TMP_SUFFIX_FILE=$(mktemp)
SCRIPT_CONFIG_LINE=SiteScriptGetter
PSCRIPT_CONFIG_LINE=SiteScriptProcessor
DIR_CONFIG_LINE=OutputDir
SUFFIX_CONFIG_LINE=Suffix
OUTPUT_FILE=output
PSQL_FILE_PREFIX=psql
RESULTS_DIR=RESULTS

# Param 1 - The Line
# Param 2 - The Key
# Out     - The Value
function getValueWithKey()
{
  echo "$1" | grep $2 > /dev/null
  if [ $? -eq 0 ];
  then
    value=$(echo $1 | awk -F '=' {'print $2'})
    echo $value
    return 0
  fi
  return 1
}

function allSectionContent()
{
  let show_content=0
  #echo "============================================"
  cat ${GET_CONFIG} | while read line;
  do
   echo $line | grep "\[*\]" > /dev/null
   if [ $? -eq 0 ];
   then 
     section=$(echo ${line} | tr -d '\[' | tr -d '\]')
     if [ "${section}" = "$*" ];
     then 
       let show_content=1
     else
       let show_content=0
     fi
   elif [ $show_content -eq 1 ];
   then
     echo ${line}
   fi
  done
  #echo "============================================"
}

# 1 - Read all configs:
cat ${GET_CONFIG} | while read line;
do
  echo $line | grep "\[*\]" > /dev/null
  if [ $? -eq 0 ]; then
    config=$(echo ${line} | tr -d '\[' | tr -d '\]')
    CONFIG_PREV=${CONFIGS}
    CONFIG_NOW="${config} "
    export CONFIGS=${CONFIG_PREV}${CONFIG_NOW}
    echo "${CONFIGS}" > ${TMP_CONFIGS_FILE}
  fi
done 

# 2 - For each config
for conf in $(cat "${TMP_CONFIGS_FILE}");
do
  allSectionContent ${conf} | while read sectionLine
  do
    VAR=$(getValueWithKey $sectionLine ${SCRIPT_CONFIG_LINE})
    if [ $? -eq 0 ];
    then
      SCRIPT=${VAR}
      echo ${SCRIPT} > ${TMP_SCRIPT_FILE}
    fi
    VAR2=$(getValueWithKey $sectionLine ${DIR_CONFIG_LINE})
    if [ $? -eq 0 ];
    then
      DIR=${VAR2}
      echo ${DIR} > ${TMP_DIR_FILE}
    fi
    VAR3=$(getValueWithKey $sectionLine ${PSCRIPT_CONFIG_LINE})
    if [ $? -eq 0 ];
    then
      DIR=${VAR3}
      echo ${DIR} > ${TMP_PSCRIPT_FILE}
    fi
    VAR4=$(getValueWithKey $sectionLine ${SUFFIX_CONFIG_LINE})
    if [ $? -eq 0 ];
    then
      SUFFIX=${VAR4}
      echo ${SUFFIX} > ${TMP_SUFFIX_FILE}
    fi
    if [ -s ${TMP_SCRIPT_FILE}  ];
    then 
      if [ -s ${TMP_PSCRIPT_FILE} ];
      then
        if [ -s ${TMP_DIR_FILE} ];
        then
          if [ -s ${TMP_SUFFIX_FILE} ];
          then
            DATE=$(date +%Y%m%d)
            echo "====================================="
            PSCRIPT_FILE=$(cat ${TMP_PSCRIPT_FILE})
            SCRIPT_FILE=$(cat ${TMP_SCRIPT_FILE})
            SCRIPT_DIR=$(cat ${TMP_DIR_FILE})
            SUFFIX=$(cat ${TMP_SUFFIX_FILE})
            echo "PSCRIPT_FILE=${PSCRIPT_FILE}"
            echo "SCRIPT_FILE=${SCRIPT_FILE}"
            echo "SCRIPT_DIR=${SCRIPT_DIR}"
            echo "SUFFIX_FILE=${SUFFIX}"
            echo "====================================="
            mkdir -p ${SCRIPT_DIR}
            cp ${SCRIPT_FILE} ${SCRIPT_DIR}
            cp ${PSCRIPT_FILE} ${SCRIPT_DIR}
            pushd ${SCRIPT_DIR} > /dev/null 
            ./$(basename ${SCRIPT_FILE})
            ./$(basename ${PSCRIPT_FILE})
            popd > /dev/null
            mkdir -p ${RESULTS_DIR}/${DATE}
            cp ${SCRIPT_DIR}/${OUTPUT_FILE} ${RESULTS_DIR}/${DATE}/${OUTPUT_FILE}-${SUFFIX}
            ./webtodb.sh ${RESULTS_DIR}/${DATE}/${OUTPUT_FILE}-${SUFFIX} > ${RESULTS_DIR}/${DATE}/${PSQL_FILE_PREFIX}-${SUFFIX}
            > ${TMP_SCRIPT_FILE}
            > ${TMP_PSCRIPT_FILE}
            > ${TMP_DIR_FILE}
            > ${TMP_SUFFIX_FILE}
          fi
        fi
      fi
    fi
  done
done 

rm ${TMP_CONFIGS_FILE}
rm ${TMP_DIR_FILE}
rm ${TMP_SCRIPT_FILE}
rm ${TMP_PSCRIPT_FILE}
rm ${TMP_SUFFIX_FILE}
