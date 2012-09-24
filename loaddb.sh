#!/bin/bash
test -f ${1} || exit 1
psql --username postgres --password -h 192.168.0.40 -f ${1} bikesearch;
