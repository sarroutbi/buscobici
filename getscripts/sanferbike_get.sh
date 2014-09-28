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

. ./common_get

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

#2014 third review (LIV)
bubic_get_page_outfile "${URL}/tiendaonline/20009-liv-montaa?n=${MAX_BIKES_PAGE}" "" 20009-liv-montaa?n=${MAX_BIKES_PAGE}
bubic_get_page_outfile "${URL}/tiendaonline/20008-liv-carretera?n=${MAX_BIKES_PAGE}" "" 20008-liv-carretera?n=${MAX_BIKES_PAGE}
bubic_get_page_outfile "${URL}/tiendaonline/20010-liv-paseourban?n=${MAX_BIKES_PAGE}" "" 20010-liv-paseourban?n=${MAX_BIKES_PAGE}

# 2014 second review
# Cannondale 
bubic_get_page_outfile "${URL}/tiendaonline/464-bicicletas-cannondale-montana?n=${MAX_BIKES_PAGE}" "" 464-bicicletas-cannondale-montana?n=${MAX_BIKES_PAGE}
bubic_get_page_outfile "${URL}/tiendaonline/465-montana-mujer-cannondale?n=${MAX_BIKES_PAGE}" "" 465-montana-mujer-cannondale?n=${MAX_BIKES_PAGE}
bubic_get_page_outfile "${URL}/tiendaonline/462-carretera-hombre-cannondale?n=${MAX_BIKES_PAGE}" "" 462-carretera-hombre-cannondale?n=${MAX_BIKES_PAGE}
bubic_get_page_outfile "${URL}/tiendaonline/458-carretera-mujer?n=${MAX_BIKES_PAGE}" "" 458-carretera-mujer?n=${MAX_BIKES_PAGE}
bubic_get_page_outfile "${URL}/tiendaonline/478-urbanas-cannondale?n=${MAX_BIKES_PAGE}" "" 478-urbanas-cannondale?n=${MAX_BIKES_PAGE}
bubic_get_page_outfile "${URL}/tiendaonline/479-cannondale-para-ninos?n=${MAX_BIKES_PAGE}" "" 479-cannondale-para-ninos?n=${MAX_BIKES_PAGE}
bubic_get_page_outfile "${URL}/tiendaonline/527-electricas-cannondale?n=${MAX_BIKES_PAGE}" "" 527-electricas-cannondale?n=${MAX_BIKES_PAGE}

# Orbea
bubic_get_page_outfile "${URL}/tiendaonline/409-orbea-mtb?n=${MAX_BIKES_PAGE}" "" 409-orbea-mtb?n=${MAX_BIKES_PAGE}
bubic_get_page_outfile "${URL}/tiendaonline/482-montana-mujer?n=${MAX_BIKES_PAGE}" "" 482-montana-mujer?n=${MAX_BIKES_PAGE}
bubic_get_page_outfile "${URL}/tiendaonline/406-orbea-road?n=${MAX_BIKES_PAGE}" "" 406-orbea-road?n=${MAX_BIKES_PAGE}
bubic_get_page_outfile "${URL}/tiendaonline/412-urban?n=${MAX_BIKES_PAGE}" "" 412-urban?n=${MAX_BIKES_PAGE}
bubic_get_page_outfile "${URL}/tiendaonline/410-all-use?n=${MAX_BIKES_PAGE}" "" 410-all-use?n=${MAX_BIKES_PAGE}
bubic_get_page_outfile "${URL}/tiendaonline/405-nuevas-orbea-mx?n=${MAX_BIKES_PAGE}" "" 405-nuevas-orbea-mx?n=${MAX_BIKES_PAGE}

# Giant
bubic_get_page_outfile "${URL}/tiendaonline/537-montaña-hombre-giant?n=${MAX_BIKES_PAGE}" "" 537-montaña-hombre-giant?n=${MAX_BIKES_PAGE}
bubic_get_page_outfile "${URL}/tiendaonline/538-montaña-mujer-giant?n=${MAX_BIKES_PAGE}" "" 538-montaña-mujer-giant?n=${MAX_BIKES_PAGE}
bubic_get_page_outfile "${URL}/tiendaonline/539-carretera-hombre-giant?n=${MAX_BIKES_PAGE}" "" 539-carretera-hombre-giant?n=${MAX_BIKES_PAGE}
bubic_get_page_outfile "${URL}/tiendaonline/540-carretera-mujer-giant?n=${MAX_BIKES_PAGE}" "" 540-carretera-mujer-giant?n=${MAX_BIKES_PAGE}
bubic_get_page_outfile "${URL}/tiendaonline/541-urbanas-giant?n=${MAX_BIKES_PAGE}" "" 541-urbanas-giant?n=${MAX_BIKES_PAGE}
bubic_get_page_outfile "${URL}/tiendaonline/550-h?n=${MAX_BIKES_PAGE}" "" 550-h?n=${MAX_BIKES_PAGE}
bubic_get_page_outfile "${URL}/tiendaonline/536-ninos-giant?n=${MAX_BIKES_PAGE}" "" 536-ninos-giant?n=${MAX_BIKES_PAGE}

# Bmc
bubic_get_page_outfile "${URL}/tiendaonline/365-nuevas-bmc-carretera?n=${MAX_BIKES_PAGE}" "" 365-nuevas-bmc-carretera?n=${MAX_BIKES_PAGE}
bubic_get_page_outfile "${URL}/tiendaonline/373-nuevas-bmc-montana?n=${MAX_BIKES_PAGE}" "" 373-nuevas-bmc-montana?n=${MAX_BIKES_PAGE}
bubic_get_page_outfile "${URL}/tiendaonline/376-urbanas-bmc?n=${MAX_BIKES_PAGE}" "" 376-urbanas-bmc?n=${MAX_BIKES_PAGE}

# outlet
bubic_get_page_outfile "${URL}/tiendaonline/20002-ofertas-road?n=${MAX_BIKES_PAGE}" "" 20002-ofertas-road?n=${MAX_BIKES_PAGE}
bubic_get_page_outfile "${URL}/tiendaonline/20001-ofertas-mtb?n=${MAX_BIKES_PAGE}" "" 20001-ofertas-mtb?n=${MAX_BIKES_PAGE}

# folding
bubic_get_page_outfile "${URL}/tiendaonline/528-bicis-plegables?n=${MAX_BIKES_PAGE}" "" 528-bicis-plegables?n=${MAX_BIKES_PAGE}

# electric
bubic_get_page_outfile "${URL}/tiendaonline/305-bicis-electricas?n=${MAX_BIKES_PAGE}" "" 305-bicis-electricas?n=${MAX_BIKES_PAGE}
