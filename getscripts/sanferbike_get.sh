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
