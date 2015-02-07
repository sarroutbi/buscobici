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
require "CommonProc.pl";
use constant STORE => "Bike Arena";
use constant URL => "http://tienda.bikearena.es";
use constant ONLY_DOMAIN => "tienda.bikearena.es";
use constant EXCLUDE => "-Rgif -Rpng -Rjpg";
use constant MAX_TRIES => 10;
use constant MAX_TIMEOUT => 10;
use constant OUTPUT_FILE => "output";
use constant MAX_PRICE => 2;

my $TRADEMARK_KEY="TRADEMARK";
my $SUBURL_KEY="SUBURL";
my $STORE_KEY="STORE";
my $PRICE_KEY="PRICE";
my $KIND_KEY="KIND";

sub get_trademark {
  my $trademark_model = $_[0];
  my $trademark = "";
  ($trademark) = split(' ', $trademark_model, -1);
  return $trademark;
} 

sub dump_model {
  my $file = $_[0];
  my $trademark_model_orig = $_[1];
  my $trademark_model = $trademark_model_orig;
  $trademark_model =~ s/\.\.\.//g;
  $trademark_dot = $trademark_model;
  $trademark_dot =~ s/"/\\"/g;
  my $type = $_[2];
  my $store = $_[3];
  my $trimmed_trademark_model = $trademark_dot;
  $trimmed_trademark_model =~ s/^\s+|\s+$//g;
  my $trademark;
  my $url;
  my $clean_trademark_model = `bash -c 'source ./common_proc; \
bubic_clean "$trimmed_trademark_model"'`;
  my $model = $trademark_dot;

  # URL PARSING
  my $url_cmd = "cat $file | sed -e 's!</a>!</a>\\n!g' | grep '>$trademark_dot<' | grep href | awk -F '>' {'print $1'}";
  $url_all = `$url_cmd`;
  ($url_first, $url_no_html) = split('href=', $url_all, -1);
  ($url_no_dash, $url_later) = split(' ', $url_no_html, -1);
  chomp($url_no_dash);
  my $url_wrong = $url_no_dash;
  $url_wrong =~ s/"/\\"/g;
  my $url = "";
  ($url) = split('>', $url_wrong, -1);

  # MODEL PARSING
  $trademark = get_trademark($trademark_dot);
  $trademark =~ s/\n//g;
  $model =~ s/$trademark//g;

  if ($model eq "") {
    $model = $trademark;
  }

  chomp($trademark);
  chomp($model);

  # PRICE PARSING
  my $price_cmd = sprintf("cat $file | sed -e 's!</a>!</a>\\n!g' | grep '>$trademark_dot<' -A%s | sed -e 's!<span class=\"price\"!\\n<span class=\"price\"!g' | sed -e 's!</span>!</span>\\n!g' | grep ^'<span class=\"price\"' | sed -e 's/<[^>]*>//g' | egrep -E \"[0-9]\" | head -1", MAX_PRICE);
  my $price = `$price_cmd`;

  chomp($price);
  $price =~ s/[^0-9,\,]//sg;

  if ($price eq "") {
    my $price_cmd = sprintf("cat $file | sed -e 's!</a>!</a>\\n!g' | grep '>$trademark_orig<' -A%s | sed -e 's!<span class=\"price\"!\\n<span class=\"price\"!g' | sed -e 's!</span>!</span>\\n!g' | grep ^'<span class=\"price\"' | sed -e 's/<[^>]*>//g' | egrep -E \"[0-9]\" | head -1", MAX_PRICE);
    $price = `$price_cmd`;
  }

  if ($price eq "") {
    my $price_cmd = sprintf("cat $file | sed -e 's!</a>!</a>\\n!g' | grep '$trademark_dot' -A%s | sed -e 's!<span class=\"price\"!\\n<span class=\"price\"!g' | sed -e 's!</span>!</span>\\n!g' | grep ^'<span class=\"price\"' | sed -e 's/<[^>]*>//g' | egrep -E \"[0-9]\" | head -1", MAX_PRICE);
    $price = `$price_cmd`;
  }

  if ($price eq "") {
    my $price_cmd = sprintf("cat $file | sed -e 's!</a>!</a>\\n!g' | grep '$trademark_orig' -A%s | sed -e 's!<span class=\"price\"!\\n<span class=\"price\"!g' | sed -e 's!</span>!</span>\\n!g' | grep ^'<span class=\"price\"' | sed -e 's/<[^>]*>//g' | egrep -E \"[0-9]\" | head -1", MAX_PRICE);
    $price = `$price_cmd`;
  }

  if ($price eq "") {
    my $price_cmd =sprintf("cat $file | sed -e 's!</a>!</a>\n!g' | grep '$trademark_orig' -A%s | sed -e 's!<span class=\"price\"!\\n<span class=\"price\"!g' | sed -e 's!</span>!</span>\\n!g' | grep ^'</h2><div class=\"productlist-area\">' | egrep -E '[0-9]{0,1} {0,1}[0-9]{1,3},{1}[0-9]{1,2}' -o | tr -d ' '", MAX_PRICE);
    $price = `$price_cmd`;
  }

  # TRADEMARK/MODEL processing
  chomp($trademark);
  chomp($model);
  my $camel_trademark = `bash -c 'source ./common_proc; bubic_camel "$trademark" 2>/dev/null' `;
  my $camel_model = `bash -c 'source ./common_proc; bubic_camel "$model" 2>/dev/null'`;
  $camel_model =~ s/"/\\"/g;
  chomp($camel_trademark);
  chomp($camel_model);

  #print "================================";
  #print "\nTRADEMARK_MODEL:$trademark_model\n";
  #print "TRADEMARK_DOT:$trademark_dot\n";
  #print "TRADEMARK:$trademark\n";
  #print "CAMEL_TRADEMARK:$camel_trademark\n";
  #print "MODEL:$model\n";
  #print "CAMEL_MODEL:$camel_model\n";
  #print "URL:$url\n";
  #print "CAMEL_TRADEMARK:$camel_trademark\n";
  #print "PRICE:=>$price<=\n";
  #print "STORE:$store\n";
  #print "TYPE:$type\n";
  #print "================================\n";
  dump_bash_bubic ($camel_model, $url, $camel_trademark, $price, $store, $type);
}

sub process_file {
  my $file = $_[0];
  my $type = $_[1];
  if ($file eq "") {
    return 1;
  }
  elsif ($type eq "") {
    return 1;
  }
  my $models_cmd = "cat $file | sed -e 's!</a>!</a>\\\n!g' | grep ^'<h2 class=\"product-name\">' | sed -e 's/<[^>]*>//g'";
  my @models = `$models_cmd`;
  foreach my $trade_model (@models) {
    chomp($trade_model);
    $trade_model =~ s/^\s+|\s+$//g;
    dump_model($file, $trade_model, $type, STORE);
  }
}

sub process_file_pages {
  my $file = $_[0];
  my @pages = @{$_[1]};
  my $type = $_[2];
  if (scalar(@pages) eq 0) {
    process_file($file, $type);
  }
  else {
    foreach my $page (@pages) {
      my $outfile = $file . "-" . $page;
      process_file($outfile, $type);
    }
  }
}

my $del_cmd = sprintf(">%s", OUTPUT_FILE);
`$del_cmd`;

#### GIANT_MTB ####
my @GIANT_MTB_PAGES = `seq 1 3`;
my $GIANT_MTB_FILE = "mtb-giant";

chomp @GIANT_MTB_PAGES;

process_file_pages($GIANT_MTB_FILE, \@GIANT_MTB_PAGES, "MTB");

#### GIANT_ROAD ####
my @GIANT_ROAD_PAGES = `seq 1 3`;
my $GIANT_ROAD_FILE = "road-giant";

chomp @GIANT_ROAD_PAGES;

process_file_pages($GIANT_ROAD_FILE, \@GIANT_ROAD_PAGES, "ROAD");

#### GIANT_URBAN ####
my @GIANT_URBAN_PAGES = `seq 1 2`;
my $GIANT_URBAN_FILE = "urban-giant";

chomp @GIANT_URBAN_PAGES;

process_file_pages($GIANT_URBAN_FILE, \@GIANT_URBAN_PAGES, "URBAN");

#### GIANT_KIDS ####
my @GIANT_KIDS_PAGES = `seq 1 2`;
my $GIANT_KIDS_FILE = "kids-giant";

chomp @GIANT_KIDS_PAGES;

process_file_pages($GIANT_KIDS_FILE, \@GIANT_KIDS_PAGES, "KIDS");

#### LIV_MTB ####
my @LIV_MTB_PAGES = `seq 1 2`;
my $LIV_MTB_FILE = "mtb-liv";

chomp @LIV_MTB_PAGES;

process_file_pages($LIV_MTB_FILE, \@LIV_MTB_PAGES, "MTB");

#### LIV_ROAD ####
my @LIV_ROAD_PAGES = `seq 1 2`;
my $LIV_ROAD_FILE = "road-liv";

chomp @LIV_ROAD_PAGES;

process_file_pages($LIV_ROAD_FILE, \@LIV_ROAD_PAGES, "ROAD");

#### LIV_URBAN ####
my @LIV_URBAN_PAGES = `seq 1 2`;
my $LIV_URBAN_FILE = "urban-liv";

chomp @LIV_URBAN_PAGES;

process_file_pages($LIV_URBAN_FILE, \@LIV_URBAN_PAGES, "URBAN");

#### SPECIALIZED_MTB ####
my @SPECIALIZED_MTB_PAGES = `seq 1 4`;
my $SPECIALIZED_MTB_FILE = "mtb-specialized";

chomp @SPECIALIZED_MTB_PAGES;

process_file_pages($SPECIALIZED_MTB_FILE, \@SPECIALIZED_MTB_PAGES, "MTB");

#### SPECIALIZED_ROAD ####
my @SPECIALIZED_ROAD_PAGES = `seq 1 4`;
my $SPECIALIZED_ROAD_FILE = "road-specialized";

chomp @SPECIALIZED_ROAD_PAGES;

process_file_pages($SPECIALIZED_ROAD_FILE, \@SPECIALIZED_ROAD_PAGES, "ROAD");

#### SPECIALIZED_URBAN ####
my @SPECIALIZED_URBAN_PAGES = `seq 1 2`;
my $SPECIALIZED_URBAN_FILE = "urban-specialized";

chomp @SPECIALIZED_URBAN_PAGES;

process_file_pages($SPECIALIZED_URBAN_FILE, \@SPECIALIZED_URBAN_PAGES, "URBAN");

#### SPECIALIZED_WOMAN ####
my @SPECIALIZED_WOMAN_PAGES = `seq 1 3`;
my $SPECIALIZED_WOMAN_FILE = "woman-specialized";

chomp @SPECIALIZED_WOMAN_PAGES;

process_file_pages($SPECIALIZED_WOMAN_FILE, \@SPECIALIZED_WOMAN_PAGES, "MTB-WOMAN");

#### SPECIALIZED_KIDS ####
my @SPECIALIZED_KIDS_PAGES = `seq 1 2`;
my $SPECIALIZED_KIDS_FILE = "kids-specialized";

chomp @SPECIALIZED_KIDS_PAGES;

process_file_pages($SPECIALIZED_KIDS_FILE, \@SPECIALIZED_KIDS_PAGES, "KIDS");
#### SPECIALIZED_BMX ####
my @SPECIALIZED_BMX_PAGES = `seq 1 2`;
my $SPECIALIZED_BMX_FILE = "bmx-specialized";

chomp @SPECIALIZED_BMX_PAGES;

process_file_pages($SPECIALIZED_BMX_FILE, \@SPECIALIZED_BMX_PAGES, "BMX");

#### CONOR_MTB ####
my @CONOR_MTB_PAGES = `seq 1 3`;
my $CONOR_MTB_FILE = "mtb-conor";

chomp @CONOR_MTB_PAGES;

process_file_pages($CONOR_MTB_FILE, \@CONOR_MTB_PAGES, "MTB");

#### CONOR_ROAD ####
my @CONOR_ROAD_PAGES = `seq 1 2`;
my $CONOR_ROAD_FILE = "road-conor";

chomp @CONOR_ROAD_PAGES;

process_file_pages($CONOR_ROAD_FILE, \@CONOR_ROAD_PAGES, "ROAD-WOMAN");

#### CONOR_WOMAN ####
my @CONOR_WOMAN_PAGES = `seq 1 3`;
my $CONOR_WOMAN_FILE = "woman-specialized";

chomp @CONOR_WOMAN_PAGES;

process_file_pages($CONOR_WOMAN_FILE, \@CONOR_WOMAN_PAGES, "MTB-WOMAN");

#### CONOR_KIDS ####
my @CONOR_KIDS_PAGES = `seq 1 2`;
my $CONOR_KIDS_FILE = "kids-conor";

chomp @CONOR_KIDS_PAGES;

process_file_pages($CONOR_KIDS_FILE, \@CONOR_KIDS_PAGES, "KIDS");

#### CONOR_URBAN ####
my @CONOR_URBAN_PAGES = `seq 1 2`;
my $CONOR_URBAN_FILE = "urban-conor";

chomp @CONOR_URBAN_PAGES;

process_file_pages($CONOR_URBAN_FILE, \@CONOR_URBAN_PAGES, "URBAN");

#### URBAN_ELECTRIC ####
my @URBAN_ELECTRIC_PAGES = `seq 1 2`;
my $URBAN_ELECTRIC_FILE = "urban-electric";

chomp @URBAN_ELECTRIC_PAGES;

process_file_pages($URBAN_ELECTRIC_FILE, \@URBAN_ELECTRIC_PAGES, "URBAN-ELECTRIC");

