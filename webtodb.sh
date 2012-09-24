#!/bin/bash
#
# This script receives:
#
# 1 - The configuration file containing the entries
#     It must contain entries like:
#     ...
#     [7.6 FX WSD]
#     SUBURL="http://www.mammoth.es/producto/bicicletas/trek/76-fx-wsd"
#     TRADEMARK=Trek
#     PRICE=1099,00€
#     STORE=Mammoth 
#
#     The script will attempt to get this entries, and insert them on 
