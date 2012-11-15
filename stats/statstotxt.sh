#!/bin/bash
./statsdb.py -p postgres123 -s 'all' | sort -t"," -n -k2 > stats_models.txt
