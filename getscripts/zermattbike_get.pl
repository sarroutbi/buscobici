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

#### ADVENTURE ####
my $ADVENTURE_BASE = URL . "/categoria-producto/bicicletas/aventura/page/";
my @ADVENTURE_PAGES = `seq 1 2`;
my $ADVENTURE_FILE = "road-trekking";

bubicpl_get_page($ADVENTURE_BASE, \@ADVENTURE_PAGES, $ADVENTURE_FILE, 10, 10, 1);

#### BMX ####
my $BMX_BASE = URL . "/categoria-producto/bicicletas/bmxcampillo/page/";
my @BMX_PAGES = `seq 1 2`;
my $BMX_FILE = "bmx";

bubicpl_get_page($BMX_BASE, \@BMX_PAGES, $BMX_FILE, 10, 10, 1);

#### ROAD_TRIATLON ####
my $ROAD_TRIATLON_BASE = URL . "/categoria-producto/bicicletas/triatlon-carretera/page/";
my @ROAD_TRIATLON_PAGES = `seq 1 2`;
my $ROAD_TRIATLON_FILE = "road-triatlon";

chomp @ROAD_TRIATLON_PAGES;

bubicpl_get_page($ROAD_TRIATLON_BASE, \@ROAD_TRIATLON_PAGES, $ROAD_TRIATLON_FILE, 10, 10, 1);

#### ROAD ####
my $ROAD_BASE = URL . "/categoria-producto/bicicletas/carretera/page/";
my @ROAD_PAGES = `seq 1 7`;
my $ROAD_FILE = "road";

chomp @ROAD_PAGES;

bubicpl_get_page($ROAD_BASE, \@ROAD_PAGES, $ROAD_FILE, 10, 10, 1);

#### CICLOCROSS ####
my $CICLOCROSS_BASE = URL . "/categoria-producto/bicicletas/ciclocross/page/";
my @CICLOCROSS_PAGES = `seq 1 2`;
my $CICLOCROSS_FILE = "road-ciclocross";

chomp @CICLOCROSS_PAGES;

bubicpl_get_page($CICLOCROSS_BASE, \@CICLOCROSS_PAGES, $CICLOCROSS_FILE, 10, 10, 1);

#### ELECTRIC ####
my $ELECTRIC_BASE = URL . "/categoria-producto/bicicletas/electricas/page/";
my @ELECTRIC_PAGES = `seq 1 2`;
my $ELECTRIC_FILE = "electric";

chomp @ELECTRIC_PAGES;

bubicpl_get_page($ELECTRIC_BASE, \@ELECTRIC_PAGES, $ELECTRIC_FILE, 10, 10, 1);

#### TREKKING ####
my $TREKKING_BASE = URL . "/categoria-producto/bicicletas/electricas/page/";
my @TREKKING_PAGES = `seq 1 2`;
my $TREKKING_FILE = "trekking";

bubicpl_get_page($TREKKING_BASE, \@TREKKING_PAGES, $TREKKING_FILE, 10, 10, 1);

#### MTB ####
my $MTB_BASE = URL . "/categoria-producto/bicicletas/montana/page/";
my @MTB_PAGES = `seq 1 7`;
my $MTB_FILE = "mtb";

chomp @MTB_PAGES;

bubicpl_get_page($MTB_BASE, \@MTB_PAGES, $MTB_FILE, 10, 10, 1);

#### FOLDING ####
my $FOLDING_BASE = URL . "/categoria-producto/bicicletas/plegables/page/";
my @FOLDING_PAGES = `seq 1 2`;
my $FOLDING_FILE = "urban-folding";

chomp @FOLDING_PAGES;

bubicpl_get_page($FOLDING_BASE, \@FOLDING_PAGES, $FOLDING_FILE, 10, 10, 1);

#### URBAN ####
my $URBAN_BASE = URL . "/categoria-producto/bicicletas/urbana/page/";
my @URBAN_PAGES = `seq 1 2`;
my $URBAN_FILE = "urban";

chomp @URBAN_PAGES;

bubicpl_get_page($URBAN_BASE, \@URBAN_PAGES, $URBAN_FILE, 10, 10, 1);

#### URBAN_WALK ####
my $URBAN_WALK_BASE = URL . "/categoria-producto/bicicletas/multi-uso/page/";
my @URBAN_WALK_PAGES = `seq 1 2`;
my $URBAN_WALK_FILE = "urban-walk";

chomp @URBAN_WALK_PAGES;

bubicpl_get_page($URBAN_WALK_BASE, \@URBAN_WALK_PAGES, $URBAN_WALK_FILE, 10, 10, 1);

#### MTB-DOWNHILL ####
my $MTB_DOWNHILL_BASE = URL . "/categoria-producto/bicicletas/montana/descenso/page/";
my @MTB_DOWNHILL_PAGES = `seq 1 2`;
my $MTB_DOWNHILL_FILE = "mtb-downhill";

bubicpl_get_page($MTB_DOWNHILL_BASE, \@MTB_DOWNHILL_PAGES, $MTB_DOWNHILL_FILE, 10, 10, 1);

#### KIDS ####
my $KIDS_BASE = URL . "/categoria-producto/bicicletas/montana/nino-nina/page/";
my @KIDS_PAGES = `seq 1 2`;
my $KIDS_FILE = "kids";

bubicpl_get_page($KIDS_BASE, \@KIDS_PAGES, $KIDS_FILE, 10, 10, 1);
