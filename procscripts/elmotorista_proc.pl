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
use constant STORE => "El Motorista";
use constant URL => "http://www.elmotorista.es";
use constant ONLY_DOMAIN => "elmotorista.es";
use constant EXCLUDE => "-Rgif -Rpng -Rjpg";
use constant MAX_TRIES => 10;
use constant MAX_TIMEOUT => 10;
use constant OUTPUT_FILE => "output";
use constant MAX_PRICE => 10;

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
  my $type = $_[2];
  my $store = $_[3];
  my $trademark;
  my $url;
  my $trademark_model = $trademark_model_orig;
  $trademark_model =~ s/"/\\\"/g;
  my $clean_trademark_model = `bash -c 'source ./common_proc; \
bubic_clean "$trademark_model"'`;
  $clean_trademark_model =~ s/^\s+//g;
  chomp($clean_trademark_model);

  # URL PARSING
  my $url_cmd = "cat $file | grep '$trademark_model_orig' -C5 | grep href";
  $url_all = `$url_cmd`;
  ($url_first, $url_no_html) = split('href=', $url_all, -1);
  ($url_no_dash, $url_later) = split('>', $url_no_html, -1);
  chomp($url_no_dash);
  $url_no_dash =~ s/\"//g;
  my $final_url; 
  if ($url_no_dash ne "") {
      $final_url = "\\\"" . URL . "$url_no_dash" . "\\\"";
  }

  # MODEL PARSING
  $trademark = get_trademark($clean_trademark_model);
  $trademark =~ s/\n//g;
  $model = $clean_trademark_model;
  $model =~ s/$trademark//g;

  if ($model eq "") {
    $model = $trademark;
  }

  chomp($trademark);
  chomp($model);

  $model =~ s/^\s+//g;
  $model =~ s/"/\\\"/g;

  # PRICE PARSING
  my $price_cmd = sprintf("cat $file | grep '$trademark_model' -A%s | grep '<div class=\"PrecioLista\"' | sed -e 's/<[^>]*>//g' | egrep -E -o \"[0-9]{0,2}.{0,1}[0-9]{3},{0,1}[0-9]{0,2}\" | head -1", MAX_PRICE);
  my $price = `$price_cmd`;

  if ($price eq "") {
    $price_cmd = sprintf("cat $file | grep '$trademark_model' -A%s | grep '<div class=\"ItemShopPagar\"' | sed -e 's/<[^>]*>//g' | egrep -E -o \"[0-9]{0,2}.{0,1}[0-9]{3},{0,1}[0-9]{0,2}\" | head -1", MAX_PRICE);
    $price = `$price_cmd`;
  }

  if ($price eq "") {
    $price_cmd = sprintf("cat $file | grep '$trademark_model' -A%s | grep '<span class=\"ItemShopPagar' | sed -e 's/<[^>]*>//g' | egrep -E -o \"[0-9]{0,2}.{0,1}[0-9]{3},{0,1}[0-9]{0,2}\" | head -1", MAX_PRICE);
    $price = `$price_cmd`;
  }

  chomp($price);
  $price =~ s/[^0-9,\,]//sg;

  #print "================================\n";
  #print "FILE:$file\n";
  #print "TRADEMARK_MODEL:$trademark_model\n";
  #print "TRADEMARK_MODEL_CLEAN:$clean_trademark_model\n";
  #print "TRADEMARK:$trademark\n";
  #print "MODEL:$model\n";
  #print "URL:$final_url\n";
  #print "PRICE:=>$price<=\n";
  #print "price_cmd:$price_cmd\n";
  #print "STORE:$store\n";
  #print "TYPE:$type\n";
  #print "================================\n";
  dump_bash_bubic ($model, $final_url, $trademark, $price, $store, $type);
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
  my $models_cmd = "cat $file | grep '<h2 class=\"ItemShopDesc\" title=\"' | sed -e 's/<[^>]*>//g'";
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

#### ROAD ####
my @ROAD_PAGES = `seq 1 4`;
my $ROAD_FILE = "road";

chomp @ROAD_PAGES;

process_file_pages($ROAD_FILE, \@ROAD_PAGES, "ROAD");

#### ROAD_TRIATHLON ####
my @ROAD_TRIATHLON_PAGES = `seq 1 2`;
my $ROAD_TRIATHLON_FILE = "road-triathlon";

chomp @ROAD_TRIATHLON_PAGES;

process_file_pages($ROAD_TRIATHLON_FILE, \@ROAD_TRIATHLON_PAGES, "ROAD-TRIATHLON");

#### BMX ####
my @BMX_PAGES = `seq 1 2`;
my $BMX_FILE = "bmx";

chomp @BMX_PAGES;

process_file_pages($BMX_FILE, \@BMX_PAGES, "BMX");

#### MTB ####
my @MTB_PAGES = `seq 1 5`;
my $MTB_FILE = "mtb";

chomp @MTB_PAGES;

process_file_pages($MTB_FILE, \@MTB_PAGES, "MTB");

#### URBAN_HYBRID ####
my @URBAN_HYBRID_PAGES = `seq 1 2`;
my $URBAN_HYBRID_FILE = "urban-hybrid";

chomp @URBAN_HYBRID_PAGES;

process_file_pages($URBAN_HYBRID_FILE, \@URBAN_HYBRID_PAGES, "URBAN-HYBRID");

#### URBAN_WALK ####
my @URBAN_WALK_PAGES = `seq 1 3`;
my $URBAN_WALK_FILE = "urban-walk";

chomp @URBAN_WALK_PAGES;

process_file_pages($URBAN_WALK_FILE, \@URBAN_WALK_PAGES, "URBAN");

#### KIDS ####
my @KIDS_PAGES = `seq 1 3`;
my $KIDS_FILE = "kids";

chomp @KIDS_PAGES;

process_file_pages($KIDS_FILE, \@KIDS_PAGES, "KIDS");

#### URBAN_FOLDING ####
my @URBAN_FOLDING_PAGES = `seq 1 2`;
my $URBAN_FOLDING_FILE = "urban-folding";

chomp @URBAN_FOLDING_PAGES;

process_file_pages($URBAN_FOLDING_FILE, \@URBAN_FOLDING_PAGES, "URBAN-FOLDING");

#### URBAN_ELECTRIC ####
my @URBAN_ELECTRIC_PAGES = `seq 1 2`;
my $URBAN_ELECTRIC_FILE = "urban-electric";

chomp @URBAN_ELECTRIC_PAGES;

process_file_pages($URBAN_ELECTRIC_FILE, \@URBAN_ELECTRIC_PAGES, "URBAN-ELECTRIC");
