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
use constant URL => "http://tienda.bikearena.es";
use constant ONLY_DOMAIN => "tienda.bikearena.es";
use constant EXCLUDE => "-Rgif -Rpng -Rjpg";
use constant MAX_TRIES => 10;
use constant MAX_TIMEOUT => 10;

#### GIANT_MTB ####
my $GIANT_MTB_BASE = URL . "/66-montana?p=";
my @GIANT_MTB_PAGES = `seq 1 3`;
my $GIANT_MTB_FILE = "mtb-giant";

chomp @GIANT_MTB_PAGES;

bubicpl_get_page($GIANT_MTB_BASE, \@GIANT_MTB_PAGES, $GIANT_MTB_FILE);

#### GIANT_ROAD ####
my $GIANT_ROAD_BASE = URL . "/67-carretera?p=";
my @GIANT_ROAD_PAGES = `seq 1 3`;
my $GIANT_ROAD_FILE = "road-giant";

chomp @GIANT_ROAD_PAGES;

bubicpl_get_page($GIANT_ROAD_BASE, \@GIANT_ROAD_PAGES, $GIANT_ROAD_FILE);

#### GIANT_URBAN ####
my $GIANT_URBAN_BASE = URL . "/68-multiuso-urbanas-mixtas?p=";
my @GIANT_URBAN_PAGES = `seq 1 2`;
my $GIANT_URBAN_FILE = "urban-giant";

chomp @GIANT_URBAN_PAGES;

bubicpl_get_page($GIANT_URBAN_BASE, \@GIANT_URBAN_PAGES, $GIANT_URBAN_FILE);

#### GIANT_KIDS ####
my $GIANT_KIDS_BASE = URL . "/70ninosas?p=";
my @GIANT_KIDS_PAGES = `seq 1 2`;
my $GIANT_KIDS_FILE = "kids-giant";

chomp @GIANT_KIDS_PAGES;

bubicpl_get_page($GIANT_KIDS_BASE, \@GIANT_KIDS_PAGES, $GIANT_KIDS_FILE);

#### LIV_MTB ####
my $LIV_MTB_BASE = URL . "/249-montana?p=";
my @LIV_MTB_PAGES = `seq 1 2`;
my $LIV_MTB_FILE = "mtb-liv";

chomp @LIV_MTB_PAGES;

bubicpl_get_page($LIV_MTB_BASE, \@LIV_MTB_PAGES, $LIV_MTB_FILE);

#### LIV_ROAD ####
my $LIV_ROAD_BASE = URL . "/252-carretera?p=";
my @LIV_ROAD_PAGES = `seq 1 2`;
my $LIV_ROAD_FILE = "road-liv";

chomp @LIV_ROAD_PAGES;

bubicpl_get_page($LIV_ROAD_BASE, \@LIV_ROAD_PAGES, $LIV_ROAD_FILE);

#### LIV_URBAN ####
my $LIV_URBAN_BASE = URL . "/255-multiuso-urbanas-mixtas?p=";
my @LIV_URBAN_PAGES = `seq 1 2`;
my $LIV_URBAN_FILE = "urban-liv";

chomp @LIV_URBAN_PAGES;

bubicpl_get_page($LIV_URBAN_BASE, \@LIV_URBAN_PAGES, $LIV_URBAN_FILE);

#### SPECIALIZED_MTB ####
my $SPECIALIZED_MTB_BASE = URL . "/71-montana?p=";
my @SPECIALIZED_MTB_PAGES = `seq 1 4`;
my $SPECIALIZED_MTB_FILE = "mtb-specialized";

chomp @SPECIALIZED_MTB_PAGES;

bubicpl_get_page($SPECIALIZED_MTB_BASE, \@SPECIALIZED_MTB_PAGES, $SPECIALIZED_MTB_FILE);

#### SPECIALIZED_ROAD ####
my $SPECIALIZED_ROAD_BASE = URL . "/72-carretera?p=";
my @SPECIALIZED_ROAD_PAGES = `seq 1 4`;
my $SPECIALIZED_ROAD_FILE = "road-specialized";

chomp @SPECIALIZED_ROAD_PAGES;

bubicpl_get_page($SPECIALIZED_ROAD_BASE, \@SPECIALIZED_ROAD_PAGES, $SPECIALIZED_ROAD_FILE);

#### SPECIALIZED_URBAN ####
my $SPECIALIZED_URBAN_BASE = URL . "/73-multiuso?p=";
my @SPECIALIZED_URBAN_PAGES = `seq 1 2`;
my $SPECIALIZED_URBAN_FILE = "urban-specialized";

chomp @SPECIALIZED_URBAN_PAGES;

bubicpl_get_page($SPECIALIZED_URBAN_BASE, \@SPECIALIZED_URBAN_PAGES, $SPECIALIZED_URBAN_FILE);

#### SPECIALIZED_WOMAN ####
my $SPECIALIZED_WOMAN_BASE = URL . "/74-mujer?p=";
my @SPECIALIZED_WOMAN_PAGES = `seq 1 3`;
my $SPECIALIZED_WOMAN_FILE = "woman-specialized";

chomp @SPECIALIZED_WOMAN_PAGES;

bubicpl_get_page($SPECIALIZED_WOMAN_BASE, \@SPECIALIZED_WOMAN_PAGES, $SPECIALIZED_WOMAN_FILE);

#### SPECIALIZED_KIDS ####
my $SPECIALIZED_KIDS_BASE = URL . "/75-ninosas?p=";
my @SPECIALIZED_KIDS_PAGES = `seq 1 2`;
my $SPECIALIZED_KIDS_FILE = "kids-specialized";

chomp @SPECIALIZED_KIDS_PAGES;

bubicpl_get_page($SPECIALIZED_KIDS_BASE, \@SPECIALIZED_KIDS_PAGES, $SPECIALIZED_KIDS_FILE);
#### SPECIALIZED_BMX ####
my $SPECIALIZED_BMX_BASE = URL . "/195-campilloskate-parkcalle?p=";
my @SPECIALIZED_BMX_PAGES = `seq 1 2`;
my $SPECIALIZED_BMX_FILE = "bmx-specialized";

chomp @SPECIALIZED_BMX_PAGES;

bubicpl_get_page($SPECIALIZED_BMX_BASE, \@SPECIALIZED_BMX_PAGES, $SPECIALIZED_BMX_FILE);


#### CONOR_MTB ####
my $CONOR_MTB_BASE = URL . "/82-montana?p=";
my @CONOR_MTB_PAGES = `seq 1 3`;
my $CONOR_MTB_FILE = "mtb-conor";

chomp @CONOR_MTB_PAGES;

bubicpl_get_page($CONOR_MTB_BASE, \@CONOR_MTB_PAGES, $CONOR_MTB_FILE);

#### CONOR_ROAD ####
my $CONOR_ROAD_BASE = URL . "/89-carretera?p=";
my @CONOR_ROAD_PAGES = `seq 1 2`;
my $CONOR_ROAD_FILE = "road-conor";

chomp @CONOR_ROAD_PAGES;

bubicpl_get_page($CONOR_ROAD_BASE, \@CONOR_ROAD_PAGES, $CONOR_ROAD_FILE);

#### CONOR_WOMAN ####
my $CONOR_WOMAN_BASE = URL . "/86-mujer?p=";
my @CONOR_WOMAN_PAGES = `seq 1 3`;
my $CONOR_WOMAN_FILE = "woman-specialized";

chomp @CONOR_WOMAN_PAGES;

bubicpl_get_page($CONOR_WOMAN_BASE, \@CONOR_WOMAN_PAGES, $CONOR_WOMAN_FILE);

#### CONOR_KIDS ####
my $CONOR_KIDS_BASE = URL . "/90-ninosas?p=";
my @CONOR_KIDS_PAGES = `seq 1 2`;
my $CONOR_KIDS_FILE = "kids-conor";

chomp @CONOR_KIDS_PAGES;

bubicpl_get_page($CONOR_KIDS_BASE, \@CONOR_KIDS_PAGES, $CONOR_KIDS_FILE);

#### CONOR_URBAN ####
my $CONOR_URBAN_BASE = URL . "/265-urban?p=";
my @CONOR_URBAN_PAGES = `seq 1 2`;
my $CONOR_URBAN_FILE = "urban-conor";

chomp @CONOR_URBAN_PAGES;

bubicpl_get_page($CONOR_URBAN_BASE, \@CONOR_URBAN_PAGES, $CONOR_URBAN_FILE);

#### URBAN_ELECTRIC ####
my $URBAN_ELECTRIC_BASE = URL . "/256-electricas-?p=";
my @URBAN_ELECTRIC_PAGES = `seq 1 2`;
my $URBAN_ELECTRIC_FILE = "urban-electric";

chomp @URBAN_ELECTRIC_PAGES;

bubicpl_get_page($URBAN_ELECTRIC_BASE, \@URBAN_ELECTRIC_PAGES, $URBAN_ELECTRIC_FILE);

