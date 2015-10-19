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
use constant URL => "http://www.elmotorista.es";
use constant ONLY_DOMAIN => "www.elmotorista.es";
use constant EXCLUDE => "-Rgif -Rpng -Rjpg";
use constant MAX_TRIES => 10;
use constant MAX_TIMEOUT => 10;
use constant URL2_ROAD => "#loadshop.php?cc=BIC&c1=30&c2=&o=IM&r=24&d=undefined&h=undefined&s=S&c=undefined&t1=undefined&t2=undefined&f=&t=undefined&b=&m=undefined&p=";
use constant URL2_TRIATHLON => "#loadshop.php?cc=BIC&c1=71&c2=&o=IM&r=24&d=undefined&h=undefined&s=S&c=undefined&t1=undefined&t2=undefined&f=&t=undefined&b=&m=undefined&p=";
use constant URL2_BMX => "#loadshop.php?cc=BIC&c1=34&c2=&o=IM&r=24&d=undefined&h=undefined&s=S&c=undefined&t1=undefined&t2=undefined&f=&t=undefined&b=&m=undefined&p=";
use constant URL2_MTB => "#loadshop.php?cc=BIC&c1=31&c2=&o=IM&r=24&d=undefined&h=undefined&s=S&c=undefined&t1=undefined&t2=undefined&f=&t=undefined&b=&m=undefined&p=";
use constant URL2_URBAN_HYBRID => "#loadshop.php?cc=BIC&c1=146&c2=&o=IM&r=24&d=undefined&h=undefined&s=S&c=undefined&t1=undefined&t2=undefined&f=&t=undefined&b=&m=undefined&p=";
use constant URL2_URBAN_WALK => "#loadshop.php?cc=BIC&c1=32&c2=&o=IM&r=24&d=undefined&h=undefined&s=S&c=undefined&t1=undefined&t2=undefined&f=&t=undefined&b=&m=undefined&p=";
use constant URL2_KIDS => "#loadshop.php?cc=BIC&c1=33&c2=&o=IM&r=24&d=undefined&h=undefined&s=S&c=undefined&t1=undefined&t2=undefined&f=&t=undefined&b=&m=undefined&p=";
use constant URL2_URBAN_FOLDING => "#loadshop.php?cc=BIC&c1=38&c2=&o=IM&r=24&d=undefined&h=undefined&s=S&c=undefined&t1=undefined&t2=undefined&f=&t=undefined&b=&m=undefined&p=";
use constant URL2_URBAN_ELECTRIC => "#loadshop.php?cc=BIC&c1=37&c2=&o=IM&r=24&d=undefined&h=undefined&s=S&c=undefined&t1=undefined&t2=undefined&f=&t=undefined&b=&m=undefined&p=";

#### ROAD ####
my $ROAD_BASE = URL . "/bicicletas/bicicletas-carretera?p=";
my @ROAD_PAGES = `seq 1 4`;
my $ROAD_FILE = "road";

chomp @ROAD_PAGES;

bubicpl_get_page_js($ROAD_BASE, \@ROAD_PAGES, $ROAD_FILE);

#### ROAD-TRIATHLON ####
my $ROAD_TRIATHLON_BASE = URL . "/bicicletas/bicicletas-triatlon?p=";
my @ROAD_TRIATHLON_PAGES = `seq 1 2`;
my $ROAD_TRIATHLON_FILE = "road-triathlon";

chomp @ROAD_TRIATHLON_PAGES;

bubicpl_get_page_js($ROAD_TRIATHLON_BASE, \@ROAD_TRIATHLON_PAGES, $ROAD_TRIATHLON_FILE);

#### BMX ####
my $BMX_BASE = URL . "/bicicletas/bmx?p=";
my @BMX_PAGES = `seq 1 2`;
my $BMX_FILE = "bmx";

chomp @BMX_PAGES;

bubicpl_get_page_js($BMX_BASE, \@BMX_PAGES, $BMX_FILE);

#### MTB ####
my $MTB_BASE = URL . "/bicicletas/bicicletas-montana?p=";
my @MTB_PAGES = `seq 1 5`;
my $MTB_FILE = "mtb";

chomp @MTB_PAGES;

bubicpl_get_page_js($MTB_BASE, \@MTB_PAGES, $MTB_FILE);

#### URBAN_HYBRID ####
my $URBAN_HYBRID_BASE = URL . "/bicicletas/bicicletas-hibridas?p=";
my @URBAN_HYBRID_PAGES = `seq 1 2`;
my $URBAN_HYBRID_FILE = "urban-hybrid";

chomp @URBAN_HYBRID_PAGES;

bubicpl_get_page_js($URBAN_HYBRID_BASE, \@URBAN_HYBRID_PAGES, $URBAN_HYBRID_FILE);

#### URBAN_WALK ####
my $URBAN_WALK_BASE = URL . "/bicicletas/bicicletas-paseo?p=";
my @URBAN_WALK_PAGES = `seq 1 3`;
my $URBAN_WALK_FILE = "urban-walk";

chomp @URBAN_WALK_PAGES;

bubicpl_get_page_js($URBAN_WALK_BASE, \@URBAN_WALK_PAGES, $URBAN_WALK_FILE);

#### KIDS ####
my $KIDS_BASE = URL . "/bicicletas/bicicletas-infantiles?p=";
my @KIDS_PAGES = `seq 1 3`;
my $KIDS_FILE = "kids";

chomp @KIDS_PAGES;

bubicpl_get_page_js($KIDS_BASE, \@KIDS_PAGES, $KIDS_FILE);

#### URBAN_FOLDING ####
my $URBAN_FOLDING_BASE = URL . "/bicicletas/bicicleta-plegable?p=";
my @URBAN_FOLDING_PAGES = `seq 1 2`;
my $URBAN_FOLDING_FILE = "urban-folding";

chomp @URBAN_FOLDING_PAGES;

bubicpl_get_page_js($URBAN_FOLDING_BASE, \@URBAN_FOLDING_PAGES, $URBAN_FOLDING_FILE);

#### URBAN_ELECTRIC ####
my $URBAN_ELECTRIC_BASE = URL . "/bicicletas/bicicletas-electricas?p=";
my @URBAN_ELECTRIC_PAGES = `seq 1 2`;
my $URBAN_ELECTRIC_FILE = "urban-electric";

chomp @URBAN_ELECTRIC_PAGES;

bubicpl_get_page_js($URBAN_ELECTRIC_BASE, \@URBAN_ELECTRIC_PAGES, $URBAN_ELECTRIC_FILE);
