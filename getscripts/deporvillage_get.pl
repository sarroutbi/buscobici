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
use constant URL => "http://www.deporvillage.com";
use constant EXCLUDE => "-Rgif -Rpng -Rjpg";
use constant MAX_TRIES => 10;
use constant MAX_TIMEOUT => 10;

#### FOLDING ####
my $FOLDING_BASE = URL . "/bicicletas-plegables?p=";
my @FOLDING_PAGES = `seq 1 3`;
my $FOLDING_FILE = "urban-folding";

chomp @FOLDING_PAGES;

bubicpl_get_page($FOLDING_BASE, \@FOLDING_PAGES, $FOLDING_FILE);

#### ELECTRIC ####
my $ELECTRIC_BASE = URL . "/bicicletas-electricas?p=";
my @ELECTRIC_PAGES = `seq 1 3`;
my $ELECTRIC_FILE = "urban-electric";

chomp @ELECTRIC_PAGES;

bubicpl_get_page($ELECTRIC_BASE, \@ELECTRIC_PAGES, $ELECTRIC_FILE);

#### URBAN ####
my $URBAN_BASE = URL . "/bicicletas-urbanas?p=";
my @URBAN_PAGES = `seq 1 6`;
my $URBAN_FILE = "urban-city";

chomp @URBAN_PAGES;

bubicpl_get_page($URBAN_BASE, \@URBAN_PAGES, $URBAN_FILE);

#### MTB ####
my $MTB_BASE = URL . "/bicicletas-mtb?p=";
my @MTB_PAGES = `seq 1 4`;
my $MTB_FILE = "mtb";

chomp @MTB_PAGES;

bubicpl_get_page($MTB_BASE, \@MTB_PAGES, $MTB_FILE);

#### KIDS ####
my $KIDS_BASE = URL . "/bicicletas-infantiles?p=";
my @KIDS_PAGES = `seq 1 7`;
my $KIDS_FILE = "kids";

chomp @KIDS_PAGES;

bubicpl_get_page($KIDS_BASE, \@KIDS_PAGES, $KIDS_FILE);

#### BMX ####
my $BMX_BASE = URL . "/bicicletas-bmx?p=";
my @BMX_PAGES = `seq 1 2`;
my $BMX_FILE = "bmx";

chomp @BMX_PAGES;

bubicpl_get_page($BMX_BASE, \@BMX_PAGES, $BMX_FILE);



