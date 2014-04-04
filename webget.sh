#!/bin/bash
#
# Copyright © 2012-2014 Sergio Arroutbi Braojos <sarroutbi@gmail.com>
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
# CONFIGURATION:
#
GET_CONFIG=./webget.conf
CONFIGS=""
TMP_CONFIGS_FILE=/tmp/configs
TEMP=
COMMON_PROC=procscripts/common_proc
COMMON_GET=getscripts/common_get
TMP_DIR_FILE=$(mktemp)
TMP_SCRIPT_FILE=$(mktemp)
TMP_PSCRIPT_FILE=$(mktemp)
TMP_COOKIES_FILE=$(mktemp)
TMP_CONFIGS_FILE=$(mktemp)
TMP_SUFFIX_FILE=$(mktemp)
SCRIPT_CONFIG_LINE=SiteScriptGetter
PSCRIPT_CONFIG_LINE=SiteScriptProcessor
COOKIES_CONFIG_LINE=SiteScriptCookies
DIR_CONFIG_LINE=OutputDir
SUFFIX_CONFIG_LINE=Suffix
OUTPUT_FILE=output
PSQL_FILE_PREFIX=psql
RESULTS_DIR=RESULTS
DATE=$(date +%Y%m%d)
TEST_DIR=test
DDBB_UPDATE_FILE=dbupdate.txt
MY_DIR=$(dirname $0)
cd ${MY_DIR}

####### Options specified ######
# Checkout configuration file (take from repository), 1=>Checkout:
OPT_CHECKOUT=0
OPT_VERBOSE=0

function usage() 
{
  test -z "${1}" && EXIT=1 || EXIT=0 
  echo ""
  echo "$0:"
  echo "          $0 [-c] [-v] [-h]"
  echo ""
  echo "-c: checkout configuration file, discarding local changes"
  echo "-v: verbose mode"
  echo "-h: usage details"
  echo ""
  exit ${EXIT}
}

function getparams() 
{
  while getopts "cvh" opt;
  do
    case $opt in
      c)
        OPT_CHECKOUT=1
        ;;
      v)
        OPT_VERBOSE=$OPTARG
        ;;
      h)
        usage $0
        ;;
    esac
  done
}

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
  cat ${GET_CONFIG} | grep -v ^# | while read line;
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

function checkout() 
{
  test -z "${OPT_CHECKOUT}" && return 0
  if [ "${OPT_CHECKOUT}" == "1" ];
  then
    echo "Checking out configuration file: [${GET_CONFIG}] ..."
    git checkout ${GET_CONFIG}
  fi
}

getparams $*
checkout ${OPT_CHECKOUT}

> ${DDBB_UPDATE_FILE}
./cleandirs.sh
mkdir -p ${RESULTS_DIR}/${DATE}

# 1 - Read all configs:
cat ${GET_CONFIG} | grep -v ^# | while read line;
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
    VAR5=$(getValueWithKey $sectionLine ${COOKIES_CONFIG_LINE})
    if [ $? -eq 0 ];
    then
      SUFFIX=${VAR5}
      echo ${SUFFIX} > ${TMP_COOKIES_FILE}
    fi
    if [ -s ${TMP_SCRIPT_FILE}  ];
    then 
      if [ -s ${TMP_PSCRIPT_FILE} ];
      then
        if [ -s ${TMP_DIR_FILE} ];
        then
          if [ -s ${TMP_SUFFIX_FILE} ];
          then
            echo "====================================="
            PSCRIPT_FILE=$(cat ${TMP_PSCRIPT_FILE})
            SCRIPT_FILE=$(cat ${TMP_SCRIPT_FILE})
            SCRIPT_DIR=$(cat ${TMP_DIR_FILE})
            COOKIES_FILE=$(cat ${TMP_COOKIES_FILE})
            SUFFIX=$(cat ${TMP_SUFFIX_FILE})
            echo "PSCRIPT_FILE=${PSCRIPT_FILE}"
            echo "SCRIPT_FILE=${SCRIPT_FILE}"
            echo "COOKIES_FILE=${COOKIES_FILE}"
            echo "SCRIPT_DIR=${SCRIPT_DIR}"
            echo "SUFFIX_FILE=${SUFFIX}"
            echo "====================================="
            mkdir -p ${SCRIPT_DIR}
            cp ${SCRIPT_FILE} ${SCRIPT_DIR}
            cp ${PSCRIPT_FILE} ${SCRIPT_DIR}
            cp ${COOKIES_FILE} ${SCRIPT_DIR}
            cp ${COMMON_PROC} ${SCRIPT_DIR}
            cp ${COMMON_GET} ${SCRIPT_DIR}
            pushd ${SCRIPT_DIR} > /dev/null 
            ./$(basename ${SCRIPT_FILE})
            ./$(basename ${PSCRIPT_FILE})
            popd > /dev/null
            cp ${SCRIPT_DIR}/${OUTPUT_FILE} ${RESULTS_DIR}/${DATE}/${OUTPUT_FILE}-${SUFFIX}
            ./webtodb.sh ${RESULTS_DIR}/${DATE}/${OUTPUT_FILE}-${SUFFIX} > ${RESULTS_DIR}/${DATE}/${PSQL_FILE_PREFIX}-${SUFFIX}
            pushd ${TEST_DIR} > /dev/null
            ./checkpsql.sh ../${RESULTS_DIR}/${DATE}/${PSQL_FILE_PREFIX}-${SUFFIX}
            if [ $? -eq 0 ]; 
            then
              echo "DDBB should be updated with file:=>${RESULTS_DIR}/${DATE}/${PSQL_FILE_PREFIX}-${SUFFIX}<=" >> ../${DDBB_UPDATE_FILE}
            else
              echo "DDBB should NEVER, EVER, be updated with file:=>${RESULTS_DIR}/${DATE}/${PSQL_FILE_PREFIX}-${SUFFIX}<=" >> ../${DDBB_UPDATE_FILE}
            fi
            popd > /dev/null   
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
rm ${TMP_COOKIES_FILE}
rm ${TMP_SUFFIX_FILE}
