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

get_page "${URL}/tiendaonline/164-lap-carretera-hombre?n=${MAX_BIKES_PAGE}"
get_page "${URL}/tiendaonline/165-lap-carretera-mujer?n=${MAX_BIKES_PAGE}"
get_page "${URL}/tiendaonline/166-lap-montana-hombre?n=${MAX_BIKES_PAGE}"
get_page "${URL}/tiendaonline/167-lap-montana-mujer?n=${MAX_BIKES_PAGE}"
get_page "${URL}/tiendaonline/168-bicicletas-hibridas-mujeres?n=${MAX_BIKES_PAGE}"
get_page "${URL}/tiendaonline/169-lap-urbanas?n=${MAX_BIKES_PAGE}"
get_page "${URL}/tiendaonline/171-x-country-maraton?n=${MAX_BIKES_PAGE}"
get_page "${URL}/tiendaonline/172-all-mountain-enduro?n=${MAX_BIKES_PAGE}"
get_page "${URL}/tiendaonline/173-over-ride-montana-lapierre?n=${MAX_BIKES_PAGE}"
get_page "${URL}/tiendaonline/174-orbea-montana-hombre?n=${MAX_BIKES_PAGE}"
get_page "${URL}/tiendaonline/176-orbea-carretera-hombre-2013?n=${MAX_BIKES_PAGE}"
get_page "${URL}/tiendaonline/177-orbea-carretera-mujer-2013?n=${MAX_BIKES_PAGE}"
get_page "${URL}/tiendaonline/178-orbea-hibridas-2013?n=${MAX_BIKES_PAGE}"
get_page "${URL}/tiendaonline/179-orbea-infantil-2013?n=${MAX_BIKES_PAGE}"
get_page "${URL}/tiendaonline/180-bicicletas-orbea-urbanas-2013?n=${MAX_BIKES_PAGE}"
get_page "${URL}/tiendaonline/182-bicicletas-orbea-2013-maraton?n=${MAX_BIKES_PAGE}"
get_page "${URL}/tiendaonline/183-bicicletas-orbea-2013-enduro?n=${MAX_BIKES_PAGE}"
get_page "${URL}/tiendaonline/186-hibridas-hombres?n=${MAX_BIKES_PAGE}"
get_page "${URL}/tiendaonline/187-hibridas-mujeres?n=${MAX_BIKES_PAGE}"
get_page "${URL}/tiendaonline/189-cannondale-2013?n=${MAX_BIKES_PAGE}"
get_page "${URL}/tiendaonline/191-bmc-2013-montana-hombre?n=${MAX_BIKES_PAGE}"
get_page "${URL}/tiendaonline/192-x-country-maraton-2013?n=${MAX_BIKES_PAGE}"
get_page "${URL}/tiendaonline/193-bmc-2013-carretera?n=${MAX_BIKES_PAGE}"
get_page "${URL}/tiendaonline/195-all-mountain?n=${MAX_BIKES_PAGE}"
get_page "${URL}/tiendaonline/197-bmc-2013-urbanas-fitness?n=${MAX_BIKES_PAGE}"
get_page "${URL}/tiendaonline/198-lapierre-bmx-dirt?n=${MAX_BIKES_PAGE}"
get_page "${URL}/tiendaonline/199-bicicletas-urbanas-hombres?n=${MAX_BIKES_PAGE}"
get_page "${URL}/tiendaonline/200-mujeres?n=${MAX_BIKES_PAGE}"
get_page "${URL}/tiendaonline/201-orbea-montana-mujer?n=${MAX_BIKES_PAGE}"
get_page "${URL}/tiendaonline/203-bicicleta-montana-hombre?n=${MAX_BIKES_PAGE}"
get_page "${URL}/tiendaonline/204-montana-mujer?n=${MAX_BIKES_PAGE}"
get_page "${URL}/tiendaonline/205-carretera?n=${MAX_BIKES_PAGE}"
get_page "${URL}/tiendaonline/206-urbanas?n=${MAX_BIKES_PAGE}"
get_page "${URL}/tiendaonline/207-sport-maraton?n=${MAX_BIKES_PAGE}"
get_page "${URL}/tiendaonline/208-all-enduro-cannondale?n=${MAX_BIKES_PAGE}"
get_page "${URL}/tiendaonline/209-over-mountain?n=${MAX_BIKES_PAGE}"
get_page "${URL}/tiendaonline/213-giant-carretera-hombre?n=${MAX_BIKES_PAGE}"
get_page "${URL}/tiendaonline/214-bicicletas-montana-hombre?n=${MAX_BIKES_PAGE}"
get_page "${URL}/tiendaonline/215-x-country-maraton?n=${MAX_BIKES_PAGE}"
get_page "${URL}/tiendaonline/216-bicicletas-descenso-giant?n=${MAX_BIKES_PAGE}"
get_page "${URL}/tiendaonline/217-bicicletas-montana-hombre-over-mountain?n=${MAX_BIKES_PAGE}"
get_page "${URL}/tiendaonline/218-bicicletas-ciudad-urbanas-hombres?n=${MAX_BIKES_PAGE}"
get_page "${URL}/tiendaonline/220-bicicletas-hibridas-madrid?n=${MAX_BIKES_PAGE}"
get_page "${URL}/tiendaonline/222-bicicletas-ciudad-urbanas-giant?n=${MAX_BIKES_PAGE}"
get_page "${URL}/tiendaonline/223-bicicletas-ciudad-urbanas-mujeres?n=${MAX_BIKES_PAGE}"
get_page "${URL}/tiendaonline/225-dahon-calidad-plegables?n=${MAX_BIKES_PAGE}"
get_page "${URL}/tiendaonline/226-carretera-mujer-2013?n=${MAX_BIKES_PAGE}"
get_page "${URL}/tiendaonline/227-competicion?n=${MAX_BIKES_PAGE}"
get_page "${URL}/tiendaonline/228-rendimiento?n=${MAX_BIKES_PAGE}"
get_page "${URL}/tiendaonline/229-ciclo-cross?n=${MAX_BIKES_PAGE}"
get_page "${URL}/tiendaonline/230-sport?n=${MAX_BIKES_PAGE}"
get_page "${URL}/tiendaonline/231-fitness?n=${MAX_BIKES_PAGE}"
get_page "${URL}/tiendaonline/232-bicicletas-ciudad-urbanas-mujeres?n=${MAX_BIKES_PAGE}"
get_page "${URL}/tiendaonline/233-bici-mujer-cross?n=${MAX_BIKES_PAGE}"
get_page "${URL}/tiendaonline/234-orca?n=${MAX_BIKES_PAGE}"
get_page "${URL}/tiendaonline/235-aqua?n=${MAX_BIKES_PAGE}"
get_page "${URL}/tiendaonline/236-onix?n=${MAX_BIKES_PAGE}"
get_page "${URL}/tiendaonline/237-terra-bicicletas-ciclocross?n=${MAX_BIKES_PAGE}"
get_page "${URL}/tiendaonline/238-ordu?n=${MAX_BIKES_PAGE}"
get_page "${URL}/tiendaonline/239-bicicleta-orca-mujer?n=${MAX_BIKES_PAGE}"
get_page "${URL}/tiendaonline/240-bicicleta-aqua-mujer?n=${MAX_BIKES_PAGE}"
get_page "${URL}/tiendaonline/241-bicicletas-orbea-montana?n=${MAX_BIKES_PAGE}"
get_page "${URL}/tiendaonline/242-bicicletas-orbea-montana?n=${MAX_BIKES_PAGE}"
get_page "${URL}/tiendaonline/243-bicicletas-sport-orbea?n=${MAX_BIKES_PAGE}"
get_page "${URL}/tiendaonline/245-bicicletas-ciudad-urbanas-orbea?n=${MAX_BIKES_PAGE}"
get_page "${URL}/tiendaonline/247-bicicletas-ciudad-urbanas-orbea-carpe?n=${MAX_BIKES_PAGE}"
get_page "${URL}/tiendaonline/249-bicicletas-ciudad-urbanas-orbea-dude?n=${MAX_BIKES_PAGE}"
get_page "${URL}/tiendaonline/251-bicicletas-ciudad-urbanas-orbea-boulevard?n=${MAX_BIKES_PAGE}"
get_page "${URL}/tiendaonline/255-bicicletas-carretera-fitness-orbea?n=${MAX_BIKES_PAGE}"
get_page "${URL}/tiendaonline/257-bicicletas-giant-montana-mujer?n=${MAX_BIKES_PAGE}"
get_page "${URL}/tiendaonline/258-ruedas-29?n=${MAX_BIKES_PAGE}"
get_page "${URL}/tiendaonline/259-bicis-29?n=${MAX_BIKES_PAGE}"
get_page "${URL}/tiendaonline/263-scalpel?n=${MAX_BIKES_PAGE}"
get_page "${URL}/tiendaonline/264-rz?n=${MAX_BIKES_PAGE}"
get_page "${URL}/tiendaonline/265-trail?n=${MAX_BIKES_PAGE}"
get_page "${URL}/tiendaonline/266-b?n=${MAX_BIKES_PAGE}"
get_page "${URL}/tiendaonline/267-caad?n=${MAX_BIKES_PAGE}"
get_page "${URL}/tiendaonline/268-supersix?n=${MAX_BIKES_PAGE}"
get_page "${URL}/tiendaonline/269-shinapse?n=${MAX_BIKES_PAGE}"
get_page "${URL}/tiendaonline/270-slice?n=${MAX_BIKES_PAGE}"
get_page "${URL}/tiendaonline/274-bicicletas-29er?n=${MAX_BIKES_PAGE}"
get_page "${URL}/tiendaonline/275-pro-race?n=${MAX_BIKES_PAGE}"
get_page "${URL}/tiendaonline/276-x-control?n=${MAX_BIKES_PAGE}"
get_page "${URL}/tiendaonline/277-x-flow?n=${MAX_BIKES_PAGE}"
get_page "${URL}/tiendaonline/278-raid?n=${MAX_BIKES_PAGE}"
get_page "${URL}/tiendaonline/279-xr?n=${MAX_BIKES_PAGE}"
get_page "${URL}/tiendaonline/280-zesty?n=${MAX_BIKES_PAGE}"
get_page "${URL}/tiendaonline/281-spicy?n=${MAX_BIKES_PAGE}"
get_page "${URL}/tiendaonline/286-b?n=${MAX_BIKES_PAGE}"
get_page "${URL}/tiendaonline/287-anthem?n=${MAX_BIKES_PAGE}"
get_page "${URL}/tiendaonline/288-bicicleta-montana-maraton?n=${MAX_BIKES_PAGE}"
get_page "${URL}/tiendaonline/289-trance?n=${MAX_BIKES_PAGE}"
get_page "${URL}/tiendaonline/290-talon?n=${MAX_BIKES_PAGE}"
get_page "${URL}/tiendaonline/291-revel?n=${MAX_BIKES_PAGE}"
get_page "${URL}/tiendaonline/292-b?n=${MAX_BIKES_PAGE}"
get_page "${URL}/tiendaonline/293-team-elite?n=${MAX_BIKES_PAGE}"
get_page "${URL}/tiendaonline/294-foustroke?n=${MAX_BIKES_PAGE}"
get_page "${URL}/tiendaonline/295-sport-elite?n=${MAX_BIKES_PAGE}"
get_page "${URL}/tiendaonline/296-speed-fox?n=${MAX_BIKES_PAGE}"
get_page "${URL}/tiendaonline/297-timemachine?n=${MAX_BIKES_PAGE}"
get_page "${URL}/tiendaonline/298-teammachine?n=${MAX_BIKES_PAGE}"
get_page "${URL}/tiendaonline/299-roadracer?n=${MAX_BIKES_PAGE}"
get_page "${URL}/tiendaonline/300-racemachine?n=${MAX_BIKES_PAGE}"
get_page "${URL}/tiendaonline/301-impec?n=${MAX_BIKES_PAGE}"
get_page "${URL}/tiendaonline/302-granfondo?n=${MAX_BIKES_PAGE}"
get_page "${URL}/tiendaonline/303-trance-29?n=${MAX_BIKES_PAGE}"
get_page "${URL}/tiendaonline/304-reign?n=${MAX_BIKES_PAGE}"
get_page "${URL}/tiendaonline/305-bicis-electricas?n=${MAX_BIKES_PAGE}"
get_page "${URL}/tiendaonline/306-defy?n=${MAX_BIKES_PAGE}"
get_page "${URL}/tiendaonline/307-tcr?n=${MAX_BIKES_PAGE}"
get_page "${URL}/tiendaonline/308-trinity?n=${MAX_BIKES_PAGE}"
get_page "${URL}/tiendaonline/309-flash?n=${MAX_BIKES_PAGE}"
get_page "${URL}/tiendaonline/310-superx?n=${MAX_BIKES_PAGE}"
get_page "${URL}/tiendaonline/311-plegables-orbea?n=${MAX_BIKES_PAGE}"
get_page "${URL}/tiendaonline/318-ofertas-2012-bicis-montana?n=${MAX_BIKES_PAGE}"
get_page "${URL}/tiendaonline/319-carretera-road-ofertas-bicicletas?n=${MAX_BIKES_PAGE}"
get_page "${URL}/tiendaonline/320-ofertas-2013-road?n=${MAX_BIKES_PAGE}"
get_page "${URL}/tiendaonline/321-ofertas-2013-mtb?n=${MAX_BIKES_PAGE}"
get_page "${URL}/tiendaonline/322-ofertas-2011-bicis-carretera?n=${MAX_BIKES_PAGE}"
get_page "${URL}/tiendaonline/323-bicis-montana-2011-en-oferta?n=${MAX_BIKES_PAGE}"
get_page "${URL}/tiendaonline/325-tm?n=${MAX_BIKES_PAGE}"
get_page "${URL}/tiendaonline/326-tmr?n=${MAX_BIKES_PAGE}"
get_page "${URL}/tiendaonline/331-plegables?n=${MAX_BIKES_PAGE}"
get_page "${URL}/tiendaonline/43-bicicletas?n=${MAX_BIKES_PAGE}"
