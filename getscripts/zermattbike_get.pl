#!/usr/bin/perl
#
# Copyright © 2012-2014 Sergio Arroutbi Braojos <sarroutbi@gmail.com>
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
use constant URL => "http://www.zermattbike.es";
use constant ONLY_DOMAIN => "zermattbike.es";
use constant EXCLUDE => "-Rgif -Rpng -Rjpg";
use constant MAX_TRIES => 10;
use constant MAX_TIMEOUT => 10;

#### ELECTRIC ####
my $ELECTRIC_BASE = URL . "/productos/39-electricas.html?pag=";
my @ELECTRIC_PAGES = `seq 1 4`;
my $ELECTRIC_FILE = "electric";

chomp @ELECTRIC_PAGES;

bubicpl_get_page($ELECTRIC_BASE, \@ELECTRIC_PAGES, $ELECTRIC_FILE);

#### ROAD ####
my $ROAD_BASE = URL . "/productos/41-bicicletas-carretera.html?pag=";
my @ROAD_PAGES = `seq 1 10`;
my $ROAD_FILE = "road";

chomp @ROAD_PAGES;

bubicpl_get_page($ROAD_BASE, \@ROAD_PAGES, $ROAD_FILE);

#### TREKKING ####
my $TREKKING_BASE = URL . "/productos/42-bicicletas-caminos.html";
my @TREKKING_PAGES;
my $TREKKING_FILE = "trekking";

bubicpl_get_page($TREKKING_BASE, \@TREKKING_PAGES, $TREKKING_FILE);

#### MTB ####
my $MTB_BASE = URL . "/productos/43-bicicletas-mtb.html?pag=";
my @MTB_PAGES = `seq 1 17`;
my $MTB_FILE = "mtb";

chomp @MTB_PAGES;

bubicpl_get_page($MTB_BASE, \@MTB_PAGES, $MTB_FILE);

#### FOLDING ####
my $FOLDING_BASE = URL . "/productos/44-bicicletas-plegables.html?pag=";
my @FOLDING_PAGES = `seq 1 4`;
my $FOLDING_FILE = "urban-folding";

chomp @FOLDING_PAGES;

bubicpl_get_page($FOLDING_BASE, \@FOLDING_PAGES, $FOLDING_FILE);

#### CICLOCROSS ####
my $CICLOCROSS_BASE = URL . "/productos/46-ciclocross.html?pag=";
my @CICLOCROSS_PAGES = `seq 1 3`;
my $CICLOCROSS_FILE = "road-ciclocross";

chomp @CICLOCROSS_PAGES;

bubicpl_get_page($CICLOCROSS_BASE, \@CICLOCROSS_PAGES, $CICLOCROSS_FILE);

#### MTB-DOWNHILL ####
my $MTB_DOWNHILL_BASE = URL . "/productos/47-descenso.html";
my @MTB_DOWNHILL_PAGES;
my $MTB_DOWNHILL_FILE = "mtb-downhill";

bubicpl_get_page($MTB_DOWNHILL_BASE, \@MTB_DOWNHILL_PAGES, $MTB_DOWNHILL_FILE);

#### URBAN-FATBOY ####
my $URBAN_FATBOY_BASE = URL . "/productos/48-fatboy.html";
my @URBAN_FATBOY_PAGES;
my $URBAN_FATBOY_FILE = "urban-fatboy";

bubicpl_get_page($URBAN_FATBOY_BASE, \@URBAN_FATBOY_PAGES, $URBAN_FATBOY_FILE);

#### BMX ####
my $BMX_BASE = URL . "/productos/49-four-cross.html";
my @BMX_PAGES;
my $BMX_FILE = "bmx";

bubicpl_get_page($BMX_BASE, \@BMX_PAGES, $BMX_FILE);

#### KIDS ####
my $KIDS_BASE = URL . "/productos/50-ninos.html";
my @KIDS_PAGES;
my $KIDS_FILE = "kids";

bubicpl_get_page($KIDS_BASE, \@KIDS_PAGES, $KIDS_FILE);

#### ROAD-CLAY ####
my $ROAD_CLAY_BASE = URL . "/productos/51-pista.html";
my @ROAD_CLAY_PAGES;
my $ROAD_CLAY_FILE = "road-clay";

bubicpl_get_page($ROAD_CLAY_BASE, \@ROAD_CLAY_PAGES, $ROAD_CLAY_FILE);

#### ROAD-TRIATLON ####
my $ROAD_TRIATLON_BASE = URL . "/productos/52-triatlon.html";
my @ROAD_TRIATLON_PAGES;
my $ROAD_TRIATLON_FILE = "road-triatlon";

bubicpl_get_page($ROAD_TRIATLON_BASE, \@ROAD_TRIATLON_PAGES, $ROAD_TRIATLON_FILE);

#### URBAN ####
my $URBAN_BASE = URL . "/productos/53-urbana.html?pag=";
my @URBAN_PAGES = `seq 1 3`;
my $URBAN_FILE = "urban";

chomp @URBAN_PAGES;

bubicpl_get_page($URBAN_BASE, \@URBAN_PAGES, $URBAN_FILE);
