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

get_page "${URL}/tiendaonline/164-lap-carretera-hombre?{MAX_BIKES_BASE}"
get_page "${URL}/tiendaonline/165-lap-carretera-mujer?{MAX_BIKES_BASE}"
get_page "${URL}/tiendaonline/166-lap-montana-hombre?{MAX_BIKES_BASE}"
get_page "${URL}/tiendaonline/167-lap-montana-mujer?{MAX_BIKES_BASE}"
get_page "${URL}/tiendaonline/168-bicicletas-hibridas-mujeres?{MAX_BIKES_BASE}"
get_page "${URL}/tiendaonline/169-lap-urbanas?{MAX_BIKES_BASE}"
get_page "${URL}/tiendaonline/171-x-country-maraton?{MAX_BIKES_BASE}"
get_page "${URL}/tiendaonline/172-all-mountain-enduro?{MAX_BIKES_BASE}"
get_page "${URL}/tiendaonline/173-over-ride-montana-lapierre?{MAX_BIKES_BASE}"
get_page "${URL}/tiendaonline/174-orbea-montana-hombre?{MAX_BIKES_BASE}"
get_page "${URL}/tiendaonline/176-orbea-carretera-hombre-2013?{MAX_BIKES_BASE}"
get_page "${URL}/tiendaonline/177-orbea-carretera-mujer-2013?{MAX_BIKES_BASE}"
get_page "${URL}/tiendaonline/178-orbea-hibridas-2013?{MAX_BIKES_BASE}"
get_page "${URL}/tiendaonline/179-orbea-infantil-2013?{MAX_BIKES_BASE}"
get_page "${URL}/tiendaonline/180-bicicletas-orbea-urbanas-2013?{MAX_BIKES_BASE}"
get_page "${URL}/tiendaonline/182-bicicletas-orbea-2013-maraton?{MAX_BIKES_BASE}"
get_page "${URL}/tiendaonline/183-bicicletas-orbea-2013-enduro?{MAX_BIKES_BASE}"
get_page "${URL}/tiendaonline/186-hibridas-hombres?{MAX_BIKES_BASE}"
get_page "${URL}/tiendaonline/187-hibridas-mujeres?{MAX_BIKES_BASE}"
get_page "${URL}/tiendaonline/189-cannondale-2013?{MAX_BIKES_BASE}"
get_page "${URL}/tiendaonline/191-bmc-2013-montana-hombre?{MAX_BIKES_BASE}"
get_page "${URL}/tiendaonline/192-x-country-maraton-2013?{MAX_BIKES_BASE}"
get_page "${URL}/tiendaonline/193-bmc-2013-carretera?{MAX_BIKES_BASE}"
get_page "${URL}/tiendaonline/195-all-mountain?{MAX_BIKES_BASE}"
get_page "${URL}/tiendaonline/197-bmc-2013-urbanas-fitness?{MAX_BIKES_BASE}"
get_page "${URL}/tiendaonline/198-lapierre-bmx-dirt?{MAX_BIKES_BASE}"
get_page "${URL}/tiendaonline/199-bicicletas-urbanas-hombres?{MAX_BIKES_BASE}"
get_page "${URL}/tiendaonline/200-mujeres?{MAX_BIKES_BASE}"
get_page "${URL}/tiendaonline/201-orbea-montana-mujer?{MAX_BIKES_BASE}"
get_page "${URL}/tiendaonline/203-bicicleta-montana-hombre?{MAX_BIKES_BASE}"
get_page "${URL}/tiendaonline/204-montana-mujer?{MAX_BIKES_BASE}"
get_page "${URL}/tiendaonline/205-carretera?{MAX_BIKES_BASE}"
get_page "${URL}/tiendaonline/206-urbanas?{MAX_BIKES_BASE}"
get_page "${URL}/tiendaonline/207-sport-maraton?{MAX_BIKES_BASE}"
get_page "${URL}/tiendaonline/208-all-enduro-cannondale?{MAX_BIKES_BASE}"
get_page "${URL}/tiendaonline/209-over-mountain?{MAX_BIKES_BASE}"
get_page "${URL}/tiendaonline/213-giant-carretera-hombre?{MAX_BIKES_BASE}"
get_page "${URL}/tiendaonline/214-bicicletas-montana-hombre?{MAX_BIKES_BASE}"
get_page "${URL}/tiendaonline/215-x-country-maraton?{MAX_BIKES_BASE}"
get_page "${URL}/tiendaonline/216-bicicletas-descenso-giant?{MAX_BIKES_BASE}"
get_page "${URL}/tiendaonline/217-bicicletas-montana-hombre-over-mountain?{MAX_BIKES_BASE}"
get_page "${URL}/tiendaonline/218-bicicletas-ciudad-urbanas-hombres?{MAX_BIKES_BASE}"
get_page "${URL}/tiendaonline/220-bicicletas-hibridas-madrid?{MAX_BIKES_BASE}"
get_page "${URL}/tiendaonline/222-bicicletas-ciudad-urbanas-giant?{MAX_BIKES_BASE}"
get_page "${URL}/tiendaonline/223-bicicletas-ciudad-urbanas-mujeres?{MAX_BIKES_BASE}"
get_page "${URL}/tiendaonline/225-dahon-calidad-plegables?{MAX_BIKES_BASE}"
get_page "${URL}/tiendaonline/226-carretera-mujer-2013?{MAX_BIKES_BASE}"
get_page "${URL}/tiendaonline/227-competicion?{MAX_BIKES_BASE}"
get_page "${URL}/tiendaonline/228-rendimiento?{MAX_BIKES_BASE}"
get_page "${URL}/tiendaonline/229-ciclo-cross?{MAX_BIKES_BASE}"
get_page "${URL}/tiendaonline/230-sport?{MAX_BIKES_BASE}"
get_page "${URL}/tiendaonline/231-fitness?{MAX_BIKES_BASE}"
get_page "${URL}/tiendaonline/232-bicicletas-ciudad-urbanas-mujeres?{MAX_BIKES_BASE}"
get_page "${URL}/tiendaonline/233-bici-mujer-cross?{MAX_BIKES_BASE}"
get_page "${URL}/tiendaonline/234-orca?{MAX_BIKES_BASE}"
get_page "${URL}/tiendaonline/235-aqua?{MAX_BIKES_BASE}"
get_page "${URL}/tiendaonline/236-onix?{MAX_BIKES_BASE}"
get_page "${URL}/tiendaonline/237-terra-bicicletas-ciclocross?{MAX_BIKES_BASE}"
get_page "${URL}/tiendaonline/238-ordu?{MAX_BIKES_BASE}"
get_page "${URL}/tiendaonline/239-bicicleta-orca-mujer?{MAX_BIKES_BASE}"
get_page "${URL}/tiendaonline/240-bicicleta-aqua-mujer?{MAX_BIKES_BASE}"
get_page "${URL}/tiendaonline/241-bicicletas-orbea-montana?{MAX_BIKES_BASE}"
get_page "${URL}/tiendaonline/242-bicicletas-orbea-montana?{MAX_BIKES_BASE}"
get_page "${URL}/tiendaonline/243-bicicletas-sport-orbea?{MAX_BIKES_BASE}"
get_page "${URL}/tiendaonline/245-bicicletas-ciudad-urbanas-orbea?{MAX_BIKES_BASE}"
get_page "${URL}/tiendaonline/247-bicicletas-ciudad-urbanas-orbea-carpe?{MAX_BIKES_BASE}"
get_page "${URL}/tiendaonline/249-bicicletas-ciudad-urbanas-orbea-dude?{MAX_BIKES_BASE}"
get_page "${URL}/tiendaonline/251-bicicletas-ciudad-urbanas-orbea-boulevard?{MAX_BIKES_BASE}"
get_page "${URL}/tiendaonline/255-bicicletas-carretera-fitness-orbea?{MAX_BIKES_BASE}"
get_page "${URL}/tiendaonline/257-bicicletas-giant-montana-mujer?{MAX_BIKES_BASE}"
get_page "${URL}/tiendaonline/258-ruedas-29?{MAX_BIKES_BASE}"
get_page "${URL}/tiendaonline/259-bicis-29?{MAX_BIKES_BASE}"
get_page "${URL}/tiendaonline/263-scalpel?{MAX_BIKES_BASE}"
get_page "${URL}/tiendaonline/264-rz?{MAX_BIKES_BASE}"
get_page "${URL}/tiendaonline/265-trail?{MAX_BIKES_BASE}"
get_page "${URL}/tiendaonline/266-b?{MAX_BIKES_BASE}"
get_page "${URL}/tiendaonline/267-caad?{MAX_BIKES_BASE}"
get_page "${URL}/tiendaonline/268-supersix?{MAX_BIKES_BASE}"
get_page "${URL}/tiendaonline/269-shinapse?{MAX_BIKES_BASE}"
get_page "${URL}/tiendaonline/270-slice?{MAX_BIKES_BASE}"
get_page "${URL}/tiendaonline/274-bicicletas-29er?{MAX_BIKES_BASE}"
get_page "${URL}/tiendaonline/275-pro-race?{MAX_BIKES_BASE}"
get_page "${URL}/tiendaonline/276-x-control?{MAX_BIKES_BASE}"
get_page "${URL}/tiendaonline/277-x-flow?{MAX_BIKES_BASE}"
get_page "${URL}/tiendaonline/278-raid?{MAX_BIKES_BASE}"
get_page "${URL}/tiendaonline/279-xr?{MAX_BIKES_BASE}"
get_page "${URL}/tiendaonline/280-zesty?{MAX_BIKES_BASE}"
get_page "${URL}/tiendaonline/281-spicy?{MAX_BIKES_BASE}"
get_page "${URL}/tiendaonline/286-b?{MAX_BIKES_BASE}"
get_page "${URL}/tiendaonline/287-anthem?{MAX_BIKES_BASE}"
get_page "${URL}/tiendaonline/288-bicicleta-montana-maraton?{MAX_BIKES_BASE}"
get_page "${URL}/tiendaonline/289-trance?{MAX_BIKES_BASE}"
get_page "${URL}/tiendaonline/290-talon?{MAX_BIKES_BASE}"
get_page "${URL}/tiendaonline/291-revel?{MAX_BIKES_BASE}"
get_page "${URL}/tiendaonline/292-b?{MAX_BIKES_BASE}"
get_page "${URL}/tiendaonline/293-team-elite?{MAX_BIKES_BASE}"
get_page "${URL}/tiendaonline/294-foustroke?{MAX_BIKES_BASE}"
get_page "${URL}/tiendaonline/295-sport-elite?{MAX_BIKES_BASE}"
get_page "${URL}/tiendaonline/296-speed-fox?{MAX_BIKES_BASE}"
get_page "${URL}/tiendaonline/297-timemachine?{MAX_BIKES_BASE}"
get_page "${URL}/tiendaonline/298-teammachine?{MAX_BIKES_BASE}"
get_page "${URL}/tiendaonline/299-roadracer?{MAX_BIKES_BASE}"
get_page "${URL}/tiendaonline/300-racemachine?{MAX_BIKES_BASE}"
get_page "${URL}/tiendaonline/301-impec?{MAX_BIKES_BASE}"
get_page "${URL}/tiendaonline/302-granfondo?{MAX_BIKES_BASE}"
get_page "${URL}/tiendaonline/303-trance-29?{MAX_BIKES_BASE}"
get_page "${URL}/tiendaonline/304-reign?{MAX_BIKES_BASE}"
get_page "${URL}/tiendaonline/305-bicis-electricas?{MAX_BIKES_BASE}"
get_page "${URL}/tiendaonline/306-defy?{MAX_BIKES_BASE}"
get_page "${URL}/tiendaonline/307-tcr?{MAX_BIKES_BASE}"
get_page "${URL}/tiendaonline/308-trinity?{MAX_BIKES_BASE}"
get_page "${URL}/tiendaonline/309-flash?{MAX_BIKES_BASE}"
get_page "${URL}/tiendaonline/310-superx?{MAX_BIKES_BASE}"
get_page "${URL}/tiendaonline/311-plegables-orbea?{MAX_BIKES_BASE}"
get_page "${URL}/tiendaonline/318-ofertas-2012-bicis-montana?{MAX_BIKES_BASE}"
get_page "${URL}/tiendaonline/319-carretera-road-ofertas-bicicletas?{MAX_BIKES_BASE}"
get_page "${URL}/tiendaonline/320-ofertas-2013-road?{MAX_BIKES_BASE}"
get_page "${URL}/tiendaonline/321-ofertas-2013-mtb?{MAX_BIKES_BASE}"
get_page "${URL}/tiendaonline/322-ofertas-2011-bicis-carretera?{MAX_BIKES_BASE}"
get_page "${URL}/tiendaonline/323-bicis-montana-2011-en-oferta?{MAX_BIKES_BASE}"
get_page "${URL}/tiendaonline/325-tm?{MAX_BIKES_BASE}"
get_page "${URL}/tiendaonline/326-tmr?{MAX_BIKES_BASE}"
get_page "${URL}/tiendaonline/331-plegables?{MAX_BIKES_BASE}"
get_page "${URL}/tiendaonline/43-bicicletas?{MAX_BIKES_BASE}"
