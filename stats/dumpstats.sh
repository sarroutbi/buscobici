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
echo -n "Generating statistics text files ... "
./statstotxt.sh
echo -n "[OK]"
let counter=1
let total=$(ls plot*|wc -w)
echo
for plotter in plot*;
do
  echo -n -e "Generating graphic : $counter/$total\r"
  let counter=$counter+1
  ./${plotter}
done
echo
echo -n "Generating pdf from graphics ... "
./generate_statspdf.sh 2>/dev/null 1>/dev/null
echo -n "[OK]"
echo
#rm *txt
rm *.log
rm *.aux
