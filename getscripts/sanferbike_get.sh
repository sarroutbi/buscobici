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
# This script gets all the bicycles from
# Biciescapa store !
#
URL="www.sanferbike.com"
ONLY_DOMAIN="sanferbike.com"
MAX_TRIES=10
MAX_TIMEOUT=10
MAX_BIKES_PAGE=200

function get_page()
{
  BASE_URL="$1"
  PAGES="$2"
  if [ "${PAGES}" = "" ];
  then
    wget --tries=${MAX_TRIES} --timeout=${MAX_TIMEOUT} "${BASE_URL}" 
  else
    for page in ${PAGES};
    do
      wget --tries=${MAX_TRIES} --timeout=${MAX_TIMEOUT} "${BASE_URL}${page}" 
    done 
  fi
}

get_page	"${URL}/tiendaonline/153-bicicletas?n=${MAX_BIKES_PAGE}"                              
get_page	"${URL}/tiendaonline/189-cannondale-2013?n=${MAX_BIKES_PAGE}" 
get_page	"${URL}/tiendaonline/203-bicicleta-montana-hombre?n=${MAX_BIKES_PAGE}" 
get_page	"${URL}/tiendaonline/207-sport-maraton?n=${MAX_BIKES_PAGE}" 
get_page	"${URL}/tiendaonline/265-trail?n=${MAX_BIKES_PAGE}" 
get_page	"${URL}/tiendaonline/263-scalpel?n=${MAX_BIKES_PAGE}" 
get_page	"${URL}/tiendaonline/309-flash?n=${MAX_BIKES_PAGE}" 
get_page	"${URL}/tiendaonline/264-rz?n=${MAX_BIKES_PAGE}" 
get_page	"${URL}/tiendaonline/266-b?n=${MAX_BIKES_PAGE}" 
get_page	"${URL}/tiendaonline/208-all-enduro-cannondale?n=${MAX_BIKES_PAGE}" 
get_page	"${URL}/tiendaonline/209-over-mountain?n=${MAX_BIKES_PAGE}" 
get_page	"${URL}/tiendaonline/204-montana-mujer?n=${MAX_BIKES_PAGE}" 
get_page	"${URL}/tiendaonline/205-carretera?n=${MAX_BIKES_PAGE}" 
get_page	"${URL}/tiendaonline/267-caad?n=${MAX_BIKES_PAGE}" 
get_page	"${URL}/tiendaonline/269-shinapse?n=${MAX_BIKES_PAGE}" 
get_page	"${URL}/tiendaonline/268-supersix?n=${MAX_BIKES_PAGE}" 
get_page	"${URL}/tiendaonline/270-slice?n=${MAX_BIKES_PAGE}" 
get_page	"${URL}/tiendaonline/310-superx?n=${MAX_BIKES_PAGE}" 
get_page	"${URL}/tiendaonline/226-carretera-mujer-2013?n=${MAX_BIKES_PAGE}" 
get_page	"${URL}/tiendaonline/206-urbanas?n=${MAX_BIKES_PAGE}" 
get_page	"${URL}/tiendaonline/163-bicicletas-lapierre-2013?n=${MAX_BIKES_PAGE}" 
get_page	"${URL}/tiendaonline/166-lap-montana-hombre?n=${MAX_BIKES_PAGE}" 
get_page	"${URL}/tiendaonline/171-x-country-maraton?n=${MAX_BIKES_PAGE}" 
get_page	"${URL}/tiendaonline/172-all-mountain-enduro?n=${MAX_BIKES_PAGE}" 
get_page	"${URL}/tiendaonline/173-over-ride-montana-lapierre?n=${MAX_BIKES_PAGE}"
get_page	"${URL}/tiendaonline/278-raid?n=${MAX_BIKES_PAGE}" 
get_page	"${URL}/tiendaonline/275-pro-race?n=${MAX_BIKES_PAGE}" 
get_page	"${URL}/tiendaonline/276-x-control?n=${MAX_BIKES_PAGE}" 
get_page	"${URL}/tiendaonline/279-xr?n=${MAX_BIKES_PAGE}" 
get_page	"${URL}/tiendaonline/277-x-flow?n=${MAX_BIKES_PAGE}" 
get_page	"${URL}/tiendaonline/274-bicicletas-29er?n=${MAX_BIKES_PAGE}" 
get_page	"${URL}/tiendaonline/280-zesty?n=${MAX_BIKES_PAGE}" 
get_page	"${URL}/tiendaonline/43-bicicletas?n=${MAX_BIKES_PAGE}" 
get_page	"${URL}/tiendaonline/323-bicis-montana-2011-en-oferta?n=${MAX_BIKES_PAGE}" 
get_page	"${URL}/tiendaonline/322-ofertas-2011-bicis-carretera?n=${MAX_BIKES_PAGE}" 
get_page	"${URL}/tiendaonline/318-ofertas-2012-bicis-montana?n=${MAX_BIKES_PAGE}" 
get_page	"${URL}/tiendaonline/319-carretera-road-ofertas-bicicletas?n=${MAX_BIKES_PAGE}" 
get_page	"${URL}/tiendaonline/321-ofertas-2013-mtb?n=${MAX_BIKES_PAGE}" 
get_page	"${URL}/tiendaonline/320-ofertas-2013-road?n=${MAX_BIKES_PAGE}"                  

