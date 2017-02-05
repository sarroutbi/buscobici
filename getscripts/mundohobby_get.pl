#!/usr/bin/perl
#
# Copyright © 2012-2017 Sergio Arroutbi Braojos <sarroutbi@gmail.com>
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
use constant ONLY_DOMAIN => "bicicletasmundohobby.com";
use constant URL => "http://www." . ONLY_DOMAIN;
use constant EXCLUDE => "-Rgif -Rpng -Rjpg";
use constant MAX_TRIES => 10;
use constant MAX_TIMEOUT => 10;

#### MTB ####
my $MTB_FIX_BASE = URL . "/es/7-bicicletas-mtb?p=";
my @MTB_FIX_PAGES = `seq 1 16`;
my $MTB_FIX_FILE = "mtb";

chomp @MTB_FIX_PAGES;

bubicpl_get_page($MTB_FIX_BASE, \@MTB_FIX_PAGES, $MTB_FIX_FILE);

#### MTB DOUBLE ####
my $MTB_DOUBLE_BASE = URL . "/es/119-bicicletas-mtb-dobles?p=";
my @MTB_DOUBLE_PAGES = `seq 1 6`;
my $MTB_DOUBLE_FILE = "mtbdouble";

chomp @MTB_DOUBLE_PAGES;

bubicpl_get_page($MTB_DOUBLE_BASE, \@MTB_DOUBLE_PAGES, $MTB_DOUBLE_FILE);

#### ROAD ####
my $ROAD_BASE = URL . "/es/8-bicicletas-carretera?p=";
my @ROAD_PAGES = `seq 1 11`;
my $ROAD_FILE = "road";

chomp @ROAD_PAGES;

bubicpl_get_page($ROAD_BASE, \@ROAD_PAGES, $ROAD_FILE);

