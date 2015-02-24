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
use constant ONLY_DOMAIN => "azuagabikes.com";
use constant URL => "http://www." . ONLY_DOMAIN;
use constant EXCLUDE => "-Rgif -Rpng -Rjpg";
use constant MAX_TRIES => 10;
use constant MAX_TIMEOUT => 10;

#### MTB_26 ####
my $MTB_26_FIX_BASE = URL . "/es/list/category/mtb_26&p=";
my @MTB_26_FIX_PAGES = `seq 1 2`;
my $MTB_26_FIX_FILE = "mtb-26";

chomp @MTB_26_FIX_PAGES;

bubicpl_get_page($MTB_26_FIX_BASE, \@MTB_26_FIX_PAGES, $MTB_26_FIX_FILE);

#### MTB_27_5 ####
my $MTB_27_5_FIX_BASE = URL . "/es/list/category/mtb_275&p=";
my @MTB_27_5_FIX_PAGES = `seq 1 2`;
my $MTB_27_5_FIX_FILE = "mtb-275";

chomp @MTB_27_5_FIX_PAGES;

bubicpl_get_page($MTB_27_5_FIX_BASE, \@MTB_27_5_FIX_PAGES, $MTB_27_5_FIX_FILE);

#### MTB_29 ####
my $MTB_29_FIX_BASE = URL . "/es/list/category/bicicletas_mtb&p=";
my @MTB_29_FIX_PAGES = `seq 1 2`;
my $MTB_29_FIX_FILE = "mtb-29";

chomp @MTB_29_FIX_PAGES;

bubicpl_get_page($MTB_29_FIX_BASE, \@MTB_29_FIX_PAGES, $MTB_29_FIX_FILE);

#### MTB_WOMAN ####
my $MTB_WOMAN_FIX_BASE = URL . "/es/list/category/bicicleta_mtb_chicas&p=";
my @MTB_WOMAN_FIX_PAGES = `seq 1 2`;
my $MTB_WOMAN_FIX_FILE = "mtb-woman";

chomp @MTB_WOMAN_FIX_PAGES;

bubicpl_get_page($MTB_WOMAN_FIX_BASE, \@MTB_WOMAN_FIX_PAGES, $MTB_WOMAN_FIX_FILE);

#### MTB_DOUBLE ####
my $MTB_DOUBLE_BASE = URL . "/es/list/category/bicicletas_enduro&p=";
my @MTB_DOUBLE_PAGES = `seq 1 2`;
my $MTB_DOUBLE_FILE = "mtb-enduro";

chomp @MTB_DOUBLE_PAGES;

bubicpl_get_page($MTB_DOUBLE_BASE, \@MTB_DOUBLE_PAGES, $MTB_DOUBLE_FILE);

#### KIDS ####
my $KIDS_BASE = URL . "/es/list/category/bicicletas_infantiles&p=";
my @KIDS_PAGES = `seq 1 2`;
my $KIDS_FILE = "kids";

chomp @KIDS_PAGES;

bubicpl_get_page($KIDS_BASE, \@KIDS_PAGES, $KIDS_FILE);

#### ROAD ####
my $ROAD_BASE = URL . "/es/list/category/bicicletas_carretera&p=";
my @ROAD_PAGES = `seq 1 2`;
my $ROAD_FILE = "road";

chomp @ROAD_PAGES;

bubicpl_get_page($ROAD_BASE, \@ROAD_PAGES, $ROAD_FILE);

#### DIRT ####
my $DIRT_BASE = URL . "/es/list/category/bicicletas_dirt-street&p=";
my @DIRT_PAGES = `seq 1 2`;
my $DIRT_FILE = "urban-dirt";

chomp @DIRT_PAGES;

bubicpl_get_page($DIRT_BASE, \@DIRT_PAGES, $DIRT_FILE);

#### URBAN_TREKKING ####
my $URBAN_TREKKING_BASE = URL . "/es/list/category/bicciletas_trekking&p=";
my @URBAN_TREKKING_PAGES = `seq 1 2`;
my $URBAN_TREKKING_FILE = "urban-trekking";

chomp @URBAN_TREKKING_PAGES;

bubicpl_get_page($URBAN_TREKKING_BASE, \@URBAN_TREKKING_PAGES, $URBAN_TREKKING_FILE);

#### URBAN_CITY ####
my $URBAN_CITY_BASE = URL . "/es/list/category/bicicletas_city&p=";
my @URBAN_CITY_PAGES = `seq 1 2`;
my $URBAN_CITY_FILE = "urban-city";

chomp @URBAN_CITY_PAGES;

bubicpl_get_page($URBAN_CITY_BASE, \@URBAN_CITY_PAGES, $URBAN_CITY_FILE);



