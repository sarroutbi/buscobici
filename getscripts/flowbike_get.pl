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
use constant URL => "http://www.flowbikestore.com/bicicletas";
use constant EXCLUDE => "-Rgif -Rpng -Rjpg";
use constant MAX_TRIES => 10;
use constant MAX_TIMEOUT => 10;

#### BMX ####
my $BMX_BASE = URL . "/bicicleta-bmx?page=";
my @BMX_PAGES = `seq 1 1`;
my $BMX_FILE = "bmx";

chomp @BMX_PAGES;

bubicpl_get_page($BMX_BASE, \@BMX_PAGES, $BMX_FILE);

#### ROAD ####
my $ROAD_BASE = URL . "/bicicleta-carretera?page=";
my @ROAD_PAGES = `seq 1 1`;
my $ROAD_FILE = "road";

chomp @ROAD_PAGES;

bubicpl_get_page($ROAD_BASE, \@ROAD_PAGES, $ROAD_FILE);

#### ROAD_CICLOCROSS ####
my $ROAD_CICLOCROSS_BASE = URL . "/bicicletas-ciclocross?page=";
my @ROAD_CICLOCROSS_PAGES = `seq 1 1`;
my $ROAD_CICLOCROSS_FILE = "road-ciclocross";

chomp @ROAD_CICLOCROSS_PAGES;

bubicpl_get_page($ROAD_CICLOCROSS_BASE, \@ROAD_CICLOCROSS_PAGES, $ROAD_CICLOCROSS_FILE);

#### URBAN_CITY ####
my $URBAN_CITY_BASE = URL . "/bicicletas-de-paseo?page=";
my @URBAN_CITY_PAGES = `seq 1 1`;
my $URBAN_CITY_FILE = "urban-city";

chomp @URBAN_CITY_PAGES;

bubicpl_get_page($URBAN_CITY_BASE, \@URBAN_CITY_PAGES, $URBAN_CITY_FILE);

#### URBAN_ELECTRIC ####
my $URBAN_ELECTRIC_BASE = URL . "/bicicletas-electricas?page=";
my @URBAN_ELECTRIC_PAGES = `seq 1 1`;
my $URBAN_ELECTRIC_FILE = "urban-electric";

chomp @URBAN_ELECTRIC_PAGES;

bubicpl_get_page($URBAN_ELECTRIC_BASE, \@URBAN_ELECTRIC_PAGES, $URBAN_ELECTRIC_FILE);

#### URBAN_FIXIE ####
my $URBAN_FIXIE_BASE = URL . "/bicicletas-fixie?page=";
my @URBAN_FIXIE_PAGES = `seq 1 1`;
my $URBAN_FIXIE_FILE = "urban-fixie";

chomp @URBAN_FIXIE_PAGES;

bubicpl_get_page($URBAN_FIXIE_BASE, \@URBAN_FIXIE_PAGES, $URBAN_FIXIE_FILE);

#### URBAN_FOLDING ####
my $URBAN_FOLDING_BASE = URL . "/plegables?page=";
my @URBAN_FOLDING_PAGES = `seq 1 1`;
my $URBAN_FOLDING_FILE = "urban-folding";

chomp @URBAN_FOLDING_PAGES;

bubicpl_get_page($URBAN_FOLDING_BASE, \@URBAN_FOLDING_PAGES, $URBAN_FOLDING_FILE);

#### MTB_DOUBLE ####
my $MTB_DOUBLE_BASE = URL . "/doble-suspension?page=";
my @MTB_DOUBLE_PAGES = `seq 1 2`;
my $MTB_DOUBLE_FILE = "mtb-double";

chomp @MTB_DOUBLE_PAGES;

bubicpl_get_page($MTB_DOUBLE_BASE, \@MTB_DOUBLE_PAGES, $MTB_DOUBLE_FILE);

#### MTB_27_5 ####
my $MTB_27_5_BASE = URL . "/mtb-27-5-650b?page=";
my @MTB_27_5_PAGES = `seq 1 2`;
my $MTB_27_5_FILE = "mtb-27-5";

chomp @MTB_27_5_PAGES;

bubicpl_get_page($MTB_27_5_BASE, \@MTB_27_5_PAGES, $MTB_27_5_FILE);

#### MTB_29 ####
my $MTB_29_BASE = URL . "/mtb-29?page=";
my @MTB_29_PAGES = `seq 1 3`;
my $MTB_29_FILE = "mtb-29";

chomp @MTB_29_PAGES;

bubicpl_get_page($MTB_29_BASE, \@MTB_29_PAGES, $MTB_29_FILE);

#### MTB  ####
my $MTB_BASE = URL . "/rigidas-mtb?page=";
my @MTB_PAGES = `seq 1 3`;
my $MTB_FILE = "mtb";

chomp @MTB_PAGES;

bubicpl_get_page($MTB_BASE, \@MTB_PAGES, $MTB_FILE);

#### KIDS ####
my $KIDS_BASE = URL . "/ninos?page=";
my @KIDS_PAGES = `seq 1 1`;
my $KIDS_FILE = "kids";

chomp @KIDS_PAGES;

bubicpl_get_page($KIDS_BASE, \@KIDS_PAGES, $KIDS_FILE);
