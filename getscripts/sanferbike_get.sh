#!/bin/bash
#
# This script gets all the bicycles from
# Bicimania store !
# URL: www.bicimania.com
URL_LAPIERRE="http://www.sanferbike.com/lapierre.asp"
URL_GIANT="http://www.sanferbike.com/giant.asp"  
URL_ORBEA="http://www.sanferbike.com/orbea.asp"
URL_CANNONDATE="http://www.sanferbike.com/cannondale.asp"
URL_BMC="http://www.sanferbike.com/bmc.asp"
URL_29="http://www.sanferbike.com/29.asp"
URL_TRIATLON="http://www.sanferbike.com/triatlon.asp#bicicletas"
URL_WOMAN="http://www.sanferbike.com/ellas.asp"

wget ${URL_LAPIERRE}
wget ${URL_GIANT}
wget ${URL_ORBEA}
wget ${URL_CANNONDATE}
wget ${URL_BMC}
wget ${URL_29}
wget ${URL_TRIATLON}
wget ${URL_WOMAN}
