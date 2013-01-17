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
#This script takes a link result file and generates 
#the code in BB syntax
# 
test -z "${1}" && echo "Please, specify valid file" && exit 1

#cat $1 | egrep -E "<a href[^>]*>" | awk -F "<td>" {'print $2'} | awk -F "</td>" {'print $1'} | sed -e 's/<a href="/[URL]/g' | sed -e 's!</a>!!g' | tr -d '"' | sed -e 's!target=_blank![/URL]!g' | awk -F '[URL]' {'print $1"[/URL]"'}
#cat $1 | egrep -E "<a href[^>]*>" | awk -F "<td>" {'print $2'} | awk -F "</td>" {'print $1'} | sed -e 's/<a href="/[URL]/g' | sed -e 's!</a>!!g' | tr -d '"' | sed -e 's!target=_blank![/URL]!g' | awk -F '[/URL]' {'print $1"[/URL]"'}
cat $1 | egrep -E "<a href[^>]*>" | awk -F "<td>" {'print $2'} | awk -F "</td>" {'print $1'} | sed -e 's/<a href="/[URL]/g' | sed -e 's!</a>!!g' | tr -d '"' | sed -e 's!target=_blank![/URL]!g' | awk -F '\\[/URL]' {'print $1"[/URL]"'}

