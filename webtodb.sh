#!/bin/bash
#
# This script receives:
#
# 1 - The configuration file containing the entries.
#     It must contain entries like:
#     ...
#     [7.6 FX WSD]
#     SUBURL="http://www.mammoth.es/producto/bicicletas/trek/76-fx-wsd"
#     TRADEMARK=Trek
#     PRICE=1099,00
#     STORE=Mammoth 
#     KIND=MTB
#
#     The script will attempt to get this entries, and insert them on 
#     the databases, in sentences like:
#
#     INSERT INTO bikes VALUES ('7.6 FX WSD', 'Trek', 'Mammoth', 'http://www.mammoth.es/producto/bicicletas/trek/76-fx-wsd', 'MTB', '1099.00');
#

DATABASE=bikesearch
TABLE=bikes
QUERY_STR="INSERT INTO bikes VALUES ('%s', '%s', '%s', '%s', '%s', '%s');

