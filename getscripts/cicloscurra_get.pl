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
use constant URL => "http://www.cicloscurra.com";
use constant ONLY_DOMAIN => "cicloscurra.com";
use constant EXCLUDE => "-Rgif -Rpng -Rjpg";
use constant MAX_TRIES => 10;
use constant MAX_TIMEOUT => 10;

#### MTB ####
my $MTB_FIX_BASE = URL . "/es/5-suspension-delantera?p=";
my @MTB_FIX_PAGES = `seq 1 3`;
my $MTB_FIX_FILE = "mtb";

chomp @MTB_FIX_PAGES;

bubicpl_get_page($MTB_FIX_BASE, \@MTB_FIX_PAGES, $MTB_FIX_FILE);

#### MTB DOUBLE ####
my $MTB_DOUBLE_BASE = URL . "/es/7-doble-suspension?p=";
my @MTB_DOUBLE_PAGES = `seq 1 3`;
my $MTB_DOUBLE_FILE = "mtb-double";

chomp @MTB_DOUBLE_PAGES;

bubicpl_get_page($MTB_DOUBLE_BASE, \@MTB_DOUBLE_PAGES, $MTB_DOUBLE_FILE);

#### ROAD ####
my $ROAD_BASE = URL . "/es/8-carretera?p=";
my @ROAD_PAGES = `seq 1 2`;
my $ROAD_FILE = "road";

chomp @ROAD_PAGES;

bubicpl_get_page($ROAD_BASE, \@ROAD_PAGES, $ROAD_FILE);

#### ROAD-TRIATLON ####
my $ROAD_TRIATLON_BASE = URL . "/es/12-triatlon?p=";
my @ROAD_TRIATLON_PAGES = `seq 1 2`;
my $ROAD_TRIATLON_FILE = "road-triatlon";

bubicpl_get_page($ROAD_TRIATLON_BASE, \@ROAD_TRIATLON_PAGES, $ROAD_TRIATLON_FILE);

#### URBAN ####
my $URBAN_BASE = URL . "/es/13-paseo-urban-trekking?p=";
my @URBAN_PAGES = `seq 1 2`;
my $URBAN_FILE = "urban";

chomp @URBAN_PAGES;

bubicpl_get_page($URBAN_BASE, \@URBAN_PAGES, $URBAN_FILE);

#### URBAN_ELECTRIC ####
my $URBAN_ELECTRIC_BASE = URL . "/es/18-electricas?p=";
my @URBAN_ELECTRIC_PAGES = `seq 1 2`;
my $URBAN_ELECTRIC_FILE = "urban-electric";

chomp @URBAN_ELECTRIC_PAGES;

bubicpl_get_page($URBAN_ELECTRIC_BASE, \@URBAN_ELECTRIC_PAGES, $URBAN_ELECTRIC_FILE);

#### URBAN_FOLDING ####
my $URBAN_FOLDING_BASE = URL . "/es/20-plegables";
my @URBAN_FOLDING_PAGES;
my $URBAN_FOLDING_FILE = "urban-folding";

chomp @URBAN_FOLDING_PAGES;

bubicpl_get_page($URBAN_FOLDING_BASE, \@URBAN_FOLDING_PAGES, $URBAN_FOLDING_FILE);

#### BMX ####
my $BMX_BASE = URL . "/es/17-trial-bmx-fixie-dirt-street?p=";
my @BMX_PAGES = `seq 1 2`;
my $BMX_FILE = "bmx";

chomp @BMX_PAGES;

bubicpl_get_page($BMX_BASE, \@BMX_PAGES, $BMX_FILE);

#### KIDS ####
my $KIDS_BASE = URL . "/es/19-kids-junior?p=";
my @KIDS_PAGES = `seq 1 2`;
my $KIDS_FILE = "kids";

chomp @KIDS_PAGES;

bubicpl_get_page($KIDS_BASE, \@KIDS_PAGES, $KIDS_FILE);
