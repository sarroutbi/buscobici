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
use constant ONLY_DOMAIN => "mejorbike.es";
use constant URL => "http://www." . ONLY_DOMAIN . "/";
use constant EXCLUDE => "-Rgif -Rpng -Rjpg";
use constant MAX_TRIES => 10;
use constant MAX_TIMEOUT => 10;

#### BMX ####
my $BMX_FIX_BASE = URL . "23-bmx?p=";
my @BMX_FIX_PAGES = `seq 1 2`;
my $BMX_FIX_FILE = "bmx";

chomp @BMX_FIX_PAGES;

bubicpl_get_page($BMX_FIX_BASE, \@BMX_FIX_PAGES, $BMX_FIX_FILE);

#### BMX_DIRT ####
my $BMX_DIRT_FIX_BASE = URL . "24-dirt-street?p=";
my @BMX_DIRT_FIX_PAGES = `seq 1 2`;
my $BMX_DIRT_FIX_FILE = "bmx-dirt";

chomp @BMX_DIRT_FIX_PAGES;

bubicpl_get_page($BMX_DIRT_FIX_BASE, \@BMX_DIRT_FIX_PAGES, $BMX_DIRT_FIX_FILE);

#### MTB_26_FIX ####
my $MTB_26_FIX_BASE = URL . "83-mtb-26?p=";
my @MTB_26_FIX_PAGES = `seq 1 2`;
my $MTB_26_FIX_FILE = "mtb-26-fix";

chomp @MTB_26_FIX_PAGES;

bubicpl_get_page($MTB_26_FIX_BASE, \@MTB_26_FIX_PAGES, $MTB_26_FIX_FILE);

#### MTB_27_5_FIX ####
my $MTB_27_5_FIX_BASE = URL . "26-mtb-275?p=";
my @MTB_27_5_FIX_PAGES = `seq 1 2`;
my $MTB_27_5_FIX_FILE = "mtb-27_5-fix";

chomp @MTB_27_5_FIX_PAGES;

bubicpl_get_page($MTB_27_5_FIX_BASE, \@MTB_27_5_FIX_PAGES, $MTB_27_5_FIX_FILE);

#### MTB_27_5_PLUS_FIX ####
my $MTB_27_5_PLUS_FIX_BASE = URL . "104-mtb-275?p=";
my @MTB_27_5_PLUS_FIX_PAGES = `seq 1 2`;
my $MTB_27_5_PLUS_FIX_FILE = "mtb-27_5_PLUS-fix";

chomp @MTB_27_5_PLUS_FIX_PAGES;

bubicpl_get_page($MTB_27_5_PLUS_FIX_BASE, \@MTB_27_5_PLUS_FIX_PAGES, $MTB_27_5_PLUS_FIX_FILE);

#### MTB_29_FIX ####
my $MTB_29_FIX_BASE = URL . "25-mtb-29er?p=";
my @MTB_29_FIX_PAGES = `seq 1 3`;
my $MTB_29_FIX_FILE = "mtb-29-fix";

chomp @MTB_29_FIX_PAGES;

bubicpl_get_page($MTB_29_FIX_BASE, \@MTB_29_FIX_PAGES, $MTB_29_FIX_FILE);

#### MTB_WOMAN_FIX ####
my $MTB_WOMAN_FIX_BASE = URL . "27-mujer?p=";
my @MTB_WOMAN_FIX_PAGES = `seq 1 2`;
my $MTB_WOMAN_FIX_FILE = "mtb-woman-fix";

chomp @MTB_WOMAN_FIX_PAGES;

bubicpl_get_page($MTB_WOMAN_FIX_BASE, \@MTB_WOMAN_FIX_PAGES, $MTB_WOMAN_FIX_FILE);

#### KIDS_MTB_FIX ####
my $KIDS_MTB_FIX_BASE = URL . "28-junior?p=";
my @KIDS_MTB_FIX_PAGES = `seq 1 2`;
my $KIDS_MTB_FIX_FILE = "kids-mtb";

chomp @KIDS_MTB_FIX_PAGES;

bubicpl_get_page($KIDS_MTB_FIX_BASE, \@KIDS_MTB_FIX_PAGES, $KIDS_MTB_FIX_FILE);

#### URBAN_FITNESS_FIX ####
my $URBAN_FITNESS_FIX_BASE = URL . "/tienda/category.php?id_category=74?p=";
my @URBAN_FITNESS_FIX_PAGES = `seq 1 2`;
my $URBAN_FITNESS_FIX_FILE = "urban-fitness";

chomp @URBAN_FITNESS_FIX_PAGES;

bubicpl_get_page($URBAN_FITNESS_FIX_BASE, \@URBAN_FITNESS_FIX_PAGES, $URBAN_FITNESS_FIX_FILE);

#### MTB_TRAIL_FIX ####
my $MTB_TRAIL_FIX_BASE = URL . "30-trail?p=";
my @MTB_TRAIL_FIX_PAGES = `seq 1 2`;
my $MTB_TRAIL_FIX_FILE = "mtb-trail-fix";

chomp @MTB_TRAIL_FIX_PAGES;

bubicpl_get_page($MTB_TRAIL_FIX_BASE, \@MTB_TRAIL_FIX_PAGES, $MTB_TRAIL_FIX_FILE);

#### MTB_HARD_TRAIL_FIX ####
my $MTB_HARD_TRAIL_FIX_BASE = URL . "31-am-hardtail?p=";
my @MTB_HARD_TRAIL_FIX_PAGES = `seq 1 2`;
my $MTB_HARD_TRAIL_FIX_FILE = "mtb-hard-trail-fix";

chomp @MTB_HARD_TRAIL_FIX_PAGES;

bubicpl_get_page($MTB_HARD_TRAIL_FIX_BASE, \@MTB_HARD_TRAIL_FIX_PAGES, $MTB_HARD_TRAIL_FIX_FILE);

#### MTB_DOUBLE ####
my $MTB_DOUBLE_BASE = URL . "16-doble-suspension?p=";
my @MTB_DOUBLE_PAGES = `seq 1 4`;
my $MTB_DOUBLE_FILE = "mtb-double";

chomp @MTB_DOUBLE_PAGES;

bubicpl_get_page($MTB_DOUBLE_BASE, \@MTB_DOUBLE_PAGES, $MTB_DOUBLE_FILE);

#### ROAD ####
my $ROAD_BASE = URL . "17-carretera?p=";
my @ROAD_PAGES = `seq 1 2`;
my $ROAD_FILE = "road";

chomp @ROAD_PAGES;

bubicpl_get_page($ROAD_BASE, \@ROAD_PAGES, $ROAD_FILE);

#### ROAD_CICLOCROSS ####
my $ROAD_CICLOCROSS_BASE = URL . "19-cyclo-cross?p=";
my @ROAD_CICLOCROSS_PAGES = `seq 1 2`;
my $ROAD_CICLOCROSS_FILE = "road-ciclocross";

chomp @ROAD_CICLOCROSS_PAGES;

bubicpl_get_page($ROAD_CICLOCROSS_BASE, \@ROAD_CICLOCROSS_PAGES, $ROAD_CICLOCROSS_FILE);

#### MTB_ELECTRIC ####
my $MTB_ELECTRIC_BASE = URL . "91-bicicletas-electricas?p=";
my @MTB_ELECTRIC_PAGES = `seq 1 2`;
my $MTB_ELECTRIC_FILE = "mtb-electric";

chomp @MTB_ELECTRIC_PAGES;

bubicpl_get_page($MTB_ELECTRIC_BASE, \@MTB_ELECTRIC_PAGES, $MTB_ELECTRIC_FILE);

#### MTB_WOMAN ####
my $MTB_WOMAN_BASE = URL . "21-mujer?p=";
my @MTB_WOMAN_PAGES = `seq 1 2`;
my $MTB_WOMAN_FILE = "mtb-woman";

chomp @MTB_WOMAN_PAGES;

bubicpl_get_page($MTB_WOMAN_BASE, \@MTB_WOMAN_PAGES, $MTB_WOMAN_FILE);

#### KIDS ####
my $KIDS_BASE = URL . "22-ninos?p=";
my @KIDS_PAGES = `seq 1 2`;
my $KIDS_FILE = "kids";

chomp @KIDS_PAGES;

bubicpl_get_page($KIDS_BASE, \@KIDS_PAGES, $KIDS_FILE);

