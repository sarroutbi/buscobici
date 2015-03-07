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
use constant ONLY_DOMAIN => "tiendaredblue.com";
use constant URL => "http://www." . ONLY_DOMAIN;
use constant EXCLUDE => "-Rgif -Rpng -Rjpg";
use constant MAX_TRIES => 10;
use constant MAX_TIMEOUT => 10;

#### MTB_26 ####
my $MTB_26_FIX_BASE = URL . "/286-mtb?p=";
my @MTB_26_FIX_PAGES = `seq 1 8`;
my $MTB_26_FIX_FILE = "mtb";

chomp @MTB_26_FIX_PAGES;

bubicpl_get_page($MTB_26_FIX_BASE, \@MTB_26_FIX_PAGES, $MTB_26_FIX_FILE);

#### ROAD ####
my $ROAD_BASE = URL . "/287-carretera?p=";
my @ROAD_PAGES = `seq 1 5`;
my $ROAD_FILE = "road";

chomp @ROAD_PAGES;

bubicpl_get_page($ROAD_BASE, \@ROAD_PAGES, $ROAD_FILE);

#### URBAN ####
my $URBAN_BASE = URL . "/288-urbana?p=";
my @URBAN_PAGES = `seq 1 2`;
my $URBAN_FILE = "urban";

chomp @URBAN_PAGES;

bubicpl_get_page($URBAN_BASE, \@URBAN_PAGES, $URBAN_FILE);



