#!/bin/bash
test -z ${1} && exit 1
test -f ${1} || exit 1
psql --username postgres -h 192.168.0.40 -f ${1} bikesearch;
