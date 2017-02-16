#!/usr/bin/perl
#
# Copyright © 2012-2015 Sergio Arroutbi Braojos <sarroutbi@gmail.com>
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
require "CommonGet.pl";
use constant URL => "https://www.newbornriders.com";
use constant ONLY_DOMAIN => "newbornriders.com";
use constant EXCLUDE => "-Rgif -Rpng -Rjpg";
use constant MAX_TRIES => 10;
use constant MAX_TIMEOUT => 10;

#### KIDS ####
my $KIDS_BASE = URL . "/comprar-bicicleta-para-ninos.html?p=";
my @KIDS_PAGES = `seq 1 7`;
my $KIDS_FILE = "kids";

chomp @KIDS_PAGES;

bubicpl_get_page($KIDS_BASE, \@KIDS_PAGES, $KIDS_FILE);
