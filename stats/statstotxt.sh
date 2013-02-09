#!/bin/bash
#
# Copyright © 2012-2013 Sergio Arroutbi Braojos <sarroutbi@gmail.com>
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
TYPES="MTB ROAD BMX URBAN KIDS" 
./statsdb.py -p postgres123 -S 'nummodels' -s 'all'    | sort -t"," -n -k2 > stats_models.txt
./statsdb.py -p postgres123 -S 'meanprice' -s 'all'    | sort -t"," -n -k2 > stats_meanprice.txt
./statsdb.py -p postgres123 -S 'modelsbytype' -s 'all' | sort -t"," -n -k7 > stats_models_type.txt
./statsdb.py -p postgres123 -S 'modelsbypricerange' -s 'all' | sort -t"," -n -k11 > stats_models_pricerange.txt

for type in ${TYPES}; 
do
  ./statsdb.py -S 'nummodels' -e ${type} -s 'all' -ppostgres123 | sort -t"," -n -k2 > stats_models_${type}.txt
done
