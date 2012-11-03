#!/bin/bash
test -z "${1}" && echo "Please, specify valid file" && exit 1

cat $1 | egrep -E "<a href[^>]*>" | awk -F "<td>" {'print $2'} | awk -F "</td>" {'print $1'} | sed -e 's/<a href="/[URL="/g' | sed -e 's!</a>![/URL]!g' | sed -e 's/>/]/g' | sed -e 's/ target="_blank"//g'
