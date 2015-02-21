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
test -z ${1} && exit 1

for file in truncscripts/*sh; 
do
  cd truncscripts > /dev/null
  ./$(basename ${file})
  cd - > /dev/null
done

for file in ${1}/psql*; 
do 
  ./loaddb.sh ./${file}
done

for file in postscripts/*; 
do 
  ./${file}
done

psql --username postgres -h localhost -c "DELETE FROM bikes where KIND = '-';" bikesearch;
psql --username postgres -h localhost -c "INSERT INTO last VALUES('${1}', now())" bikesearch;
psql --username postgres -h localhost -c "DELETE FROM bikes where TRADEMARK = 'Bolsa';" bikesearch;
psql --username postgres -h localhost -c "DELETE FROM bikes where TRADEMARK = 'Soporte';" bikesearch;
psql --username postgres -h localhost -c "DELETE FROM bikes where TRADEMARK = 'Cadena';" bikesearch;
psql --username postgres -h localhost -c "DELETE FROM bikes where TRADEMARK = 'Culotte';" bikesearch;
psql --username postgres -h localhost -c "DELETE FROM bikes where TRADEMARK = 'Kit';" bikesearch;
psql --username postgres -h localhost -c "DELETE FROM bikes where TRADEMARK = 'Luz';" bikesearch;
psql --username postgres -h localhost -c "DELETE FROM bikes where TRADEMARK = 'Tija';" bikesearch;
psql --username postgres -h localhost -c "DELETE FROM bikes where TRADEMARK = 'Gorra%';" bikesearch;
psql --username postgres -h localhost -c "DELETE FROM bikes where TRADEMARK = 'Pedal%';" bikesearch;
