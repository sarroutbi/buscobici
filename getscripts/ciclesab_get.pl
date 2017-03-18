#!/usr/bin/perl
#
# Copyright © 2012-2017 Sergio Arroutbi Braojos <sarroutbi at gmail.com>
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
use constant ONLY_DOMAIN => "ciclesab.com";
use constant URL => "http://" . ONLY_DOMAIN . "/";
use constant EXCLUDE => "-Rgif -Rpng -Rjpg";
use constant MAX_TRIES => 10;
use constant MAX_TIMEOUT => 10;

#### BMX ####
my $BMX_FIX_BASE = URL . "425-cicloturismo-bicicletas-bmx-trial?p=";
my @BMX_FIX_PAGES = `seq 1 2`;
my $BMX_FIX_FILE = "bmx";

chomp @BMX_FIX_PAGES;

bubicpl_get_page($BMX_FIX_BASE, \@BMX_FIX_PAGES, $BMX_FIX_FILE);

#### URBAN_FIX ####
my $URBAN_FIX_BASE = URL . "895-ciclturismo-bicicletas-ciudad?p=";
my @URBAN_FIX_PAGES = `seq 1 5`;
my $URBAN_FIX_FILE = "urban";

chomp @URBAN_FIX_PAGES;

bubicpl_get_page($URBAN_FIX_BASE, \@URBAN_FIX_PAGES, $URBAN_FIX_FILE);

#### URBAN_ELECTRIC_FIX ####
my $URBAN_ELECTRIC_FIX_BASE = URL . "423-ciclturismo-bicicletas-electricas?p=";
my @URBAN_ELECTRIC_FIX_PAGES = `seq 1 5`;
my $URBAN_ELECTRIC_FIX_FILE = "urban-electric";

chomp @URBAN_ELECTRIC_FIX_PAGES;

bubicpl_get_page($URBAN_ELECTRIC_FIX_BASE, \@URBAN_ELECTRIC_FIX_PAGES, $URBAN_ELECTRIC_FIX_FILE);

#### URBAN_HYBRID_FIX ####
my $URBAN_HYBRID_FIX_BASE = URL . "421-ciclturismo-bicicletas-hibridas?p=";
my @URBAN_HYBRID_FIX_PAGES = `seq 1 5`;
my $URBAN_HYBRID_FIX_FILE = "urban-hybrid";

chomp @URBAN_HYBRID_FIX_PAGES;

bubicpl_get_page($URBAN_HYBRID_FIX_BASE, \@URBAN_HYBRID_FIX_PAGES, $URBAN_HYBRID_FIX_FILE);

#### URBAN_FOLDING_FIX ####
my $URBAN_FOLDING_FIX_BASE = URL . "422-ciclturismo-bicicletas-plegables?p=";
my @URBAN_FOLDING_FIX_PAGES = `seq 1 4`;
my $URBAN_FOLDING_FIX_FILE = "urban-folding";

chomp @URBAN_FOLDING_FIX_PAGES;

bubicpl_get_page($URBAN_FOLDING_FIX_BASE, \@URBAN_FOLDING_FIX_PAGES, $URBAN_FOLDING_FIX_FILE);

#### KIDS ####
my $KIDS_BASE = URL . "424-cicloturismo-bicicletas-infantil?p=";
my @KIDS_PAGES = `seq 1 5`;
my $KIDS_FILE = "kids";

chomp @KIDS_PAGES;

bubicpl_get_page($KIDS_BASE, \@KIDS_PAGES, $KIDS_FILE);

#### ROAD ####
my $ROAD_BASE = URL . "101-carretera-bicicletas?p=";
my @ROAD_PAGES = `seq 1 12`;
my $ROAD_FILE = "road";

chomp @ROAD_PAGES;

bubicpl_get_page($ROAD_BASE, \@ROAD_PAGES, $ROAD_FILE);

#### ROAD_WOMAN ####
my $ROAD_WOMAN_BASE = URL . "101-carretera-bicicletas?p=";
my @ROAD_WOMAN_PAGES = `seq 1 2`;
my $ROAD_WOMAN_FILE = "road-woman";

chomp @ROAD_WOMAN_PAGES;

bubicpl_get_page($ROAD_WOMAN_BASE, \@ROAD_WOMAN_PAGES, $ROAD_WOMAN_FILE);

#### MTB_29_FIX ####
my $MTB_29_FIX_BASE = URL . "224-montana-bicicletas-29?p=";
my @MTB_29_FIX_PAGES = `seq 1 11`;
my $MTB_29_FIX_FILE = "mtb-29-fix";

chomp @MTB_29_FIX_PAGES;

bubicpl_get_page($MTB_29_FIX_BASE, \@MTB_29_FIX_PAGES, $MTB_29_FIX_FILE);

#### MTB_27_5_FIX ####
my $MTB_27_5_FIX_BASE = URL . "225-montana-bicicletas-27-5?p=";
my @MTB_27_5_FIX_PAGES = `seq 1 8`;
my $MTB_27_5_FIX_FILE = "mtb-27_5-fix";

chomp @MTB_27_5_FIX_PAGES;

bubicpl_get_page($MTB_27_5_FIX_BASE, \@MTB_27_5_FIX_PAGES, $MTB_27_5_FIX_FILE);

#### MTB_DOUBLE ####
my $MTB_DOUBLE_BASE = URL . "112-montana-bicicletas-doble-suspension?p=";
my @MTB_DOUBLE_PAGES = `seq 1 9`;
my $MTB_DOUBLE_FILE = "mtb-double";

chomp @MTB_DOUBLE_PAGES;

bubicpl_get_page($MTB_DOUBLE_BASE, \@MTB_DOUBLE_PAGES, $MTB_DOUBLE_FILE);

#### MTB_WOMAN_FIX ####
my $MTB_WOMAN_FIX_BASE = URL . "767-montana-bicicletas-mujer?p=";
my @MTB_WOMAN_FIX_PAGES = `seq 1 4`;
my $MTB_WOMAN_FIX_FILE = "mtb-woman-fix";

chomp @MTB_WOMAN_FIX_PAGES;

bubicpl_get_page($MTB_WOMAN_FIX_BASE, \@MTB_WOMAN_FIX_PAGES, $MTB_WOMAN_FIX_FILE);

#### MTB_FIX ####
my $MTB_FIX_BASE = URL . "113-montana-bicicletas-rigidas?p=";
my @MTB_FIX_PAGES = `seq 1 11`;
my $MTB_FIX_FILE = "mtb-fix";

chomp @MTB_FIX_PAGES;

bubicpl_get_page($MTB_FIX_BASE, \@MTB_FIX_PAGES, $MTB_FIX_FILE);
