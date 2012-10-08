#!/bin/bash
psql --username postgres --password -h 192.168.0.40 -f ${1} bikesearch
