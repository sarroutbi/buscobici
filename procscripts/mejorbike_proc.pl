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
require "CommonProc.pl";
use constant STORE => "Mejor Bike";
use constant URL => "http://www." . ONLY_DOMAIN;
use constant ONLY_DOMAIN => "mejorbike.es";
use constant EXCLUDE => "-Rgif -Rpng -Rjpg";
use constant MAX_TRIES => 10;
use constant MAX_TIMEOUT => 10;
use constant OUTPUT_FILE => "output";
use constant MAX_PRICE => 20;

my $TRADEMARK_KEY="TRADEMARK";
my $SUBURL_KEY="SUBURL";
my $STORE_KEY="STORE";
my $PRICE_KEY="PRICE";
my $KIND_KEY="KIND";

sub dump_model {
  my $file = $_[0];
  my $model_html = $_[1];
  chomp($model_html);
  my $type = $_[2];
  my $store = $_[3];
  my $trimmed_model_html = $model_html;
  my $discard;
  my $trimmed_model;
  ($discard, $trimmed_model) = split('>', $model_html, -1);
  ($trimmed_model, $discard) = split('<', $trimmed_model, -1);
  chomp($trimmed_model);
  my $trademark;
  ($trademark, $trimmed_model) = split(' ', $trimmed_model, 2);
  my $url;
  my $clean_model = `bash -c 'source ./common_proc; \
bubic_clean "$trimmed_model"'`;
  my $model = $clean_model;
  chomp($model);

  # URL PARSING
  $url_all = $model_html;
  ($url_first, $url_no_html) = split('href=', $url_all, -1);
  ($url_no_dash, $url_later) = split(' ', $url_no_html, -1);
  chomp($url_no_dash);
  my $url = $url_no_dash;
  my $url_no_bs;
  my $url_plane;
  $url =~ s/"/\\"/g;
  $url_no_bs = $url;
  $url_no_bs =~ s/\\"/"/g;

  # PRICE PARSING
  my $price;
  ($discard, $price) = split('product-price">', $model_html, 2);
  ($price, $discard) = split('<', $price, 2);

  $price =~ s/^\s+|\s+$//g;
  chomp($price);
  $price =~ s/[^0-9,\,]//sg;

  # TRADEMARK/MODEL processing
  my $clean_trademark = `bash -c 'source ./common_proc; bubic_clean "$trademark"'`;
  my $clean_model = `bash -c 'source ./common_proc; bubic_clean "$model"'`;
  chomp($clean_trademark);
  chomp($clean_model);
  my $camel_trademark = `bash -c 'source ./common_proc; bubic_camel "$clean_trademark"'`;
  my $camel_model = `bash -c 'source ./common_proc; bubic_camel "$clean_model"'`;
  chomp($camel_trademark);
  chomp($camel_model);
  #print "================================";
  #print "\nFILE:$file\n";
  #print "MODEL_HTML:$trimmed_model_html\n";
  #print "TRIMMED_MODEL:$trimmed_model\n";
  #print "TRADEMARK:$trademark\n";
  #print "MODEL:$model\n";
  #print "CAMEL_MODEL:$camel_model\n";
  #print "URL:$url\n";
  #print "URL_NO_BS:$url_no_bs\n";
  #print "CAMEL_TRADEMARK:$camel_trademark\n";
  #print "PRICE:$price\n";
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
  my $models_cmd = "cat $file | sed -e 's\@<a class=\"product-name\"@\\n<a class=\"product-name\"\@g' | grep '<div class=\"button-container\">' | sed -e 's\@<div class=\"button-container\">\@\\n<div class=\"button-container\">\@g'| grep '<a class=\"product-name\"'";
  my @models = `$models_cmd`;
  foreach my $model_html (@models) {
    chomp($model_html);
    dump_model($file, $model_html, $type, STORE);
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

#### BMX ####
my @BMX_FIX_PAGES = `seq 1 2`;
my $BMX_FIX_FILE = "bmx";

chomp @BMX_FIX_PAGES;

process_file_pages($BMX_FIX_FILE, \@BMX_FIX_PAGES, "BMX");

#### BMX_DIRT ####
my @BMX_DIRT_FIX_PAGES = `seq 1 2`;
my $BMX_DIRT_FIX_FILE = "bmx-dirt";

chomp @BMX_DIRT_FIX_PAGES;

process_file_pages($BMX_DIRT_FIX_FILE, \@BMX_DIRT_FIX_PAGES, "BMX-DIRT");

#### MTB_26_FIX ####
my @MTB_26_FIX_PAGES = `seq 1 2`;
my $MTB_26_FIX_FILE = "mtb-26-fix";

chomp @MTB_26_FIX_PAGES;

process_file_pages($MTB_26_FIX_FILE, \@MTB_26_FIX_PAGES, "MTB-26");

#### MTB_27_5_FIX ####
my @MTB_27_5_FIX_PAGES = `seq 1 2`;
my $MTB_27_5_FIX_FILE = "mtb-27_5-fix";

chomp @MTB_27_5_FIX_PAGES;

process_file_pages($MTB_27_5_FIX_FILE, \@MTB_27_5_FIX_PAGES, "MTB-27-5");

#### MTB_27_5_PLUS_FIX ####
my @MTB_27_5_PLUS_FIX_PAGES = `seq 1 2`;
my $MTB_27_5_PLUS_FIX_FILE = "mtb-27_5_PLUS-fix";

chomp @MTB_27_5_PLUS_FIX_PAGES;

process_file_pages($MTB_27_5_PLUS_FIX_FILE, \@MTB_27_5_PLUS_FIX_PAGES, "MTB-27-5");

#### MTB_29_FIX ####
my @MTB_29_FIX_PAGES = `seq 1 3`;
my $MTB_29_FIX_FILE = "mtb-29-fix";

chomp @MTB_29_FIX_PAGES;

process_file_pages($MTB_29_FIX_FILE, \@MTB_29_FIX_PAGES, "MTB-29");

#### MTB_WOMAN_FIX ####
my @MTB_WOMAN_FIX_PAGES = `seq 1 2`;
my $MTB_WOMAN_FIX_FILE = "mtb-woman-fix";

chomp @MTB_WOMAN_FIX_PAGES;

process_file_pages($MTB_WOMAN_FIX_FILE, \@MTB_WOMAN_FIX_PAGES, "MTB-WOMAN");

#### KIDS_MTB_FIX ####
my @KIDS_MTB_FIX_PAGES = `seq 1 2`;
my $KIDS_MTB_FIX_FILE = "kids-mtb";

chomp @KIDS_MTB_FIX_PAGES;

process_file_pages($KIDS_MTB_FIX_FILE, \@KIDS_MTB_FIX_PAGES, "KIDS-MTB");

#### URBAN_FITNESS_FIX ####
my @URBAN_FITNESS_FIX_PAGES = `seq 1 2`;
my $URBAN_FITNESS_FIX_FILE = "urban-fitness";

chomp @URBAN_FITNESS_FIX_PAGES;

process_file_pages($URBAN_FITNESS_FIX_FILE, \@URBAN_FITNESS_FIX_PAGES, "URBAN");

#### MTB_TRAIL_FIX ####
my @MTB_TRAIL_FIX_PAGES = `seq 1 2`;
my $MTB_TRAIL_FIX_FILE = "mtb-trail-fix";

chomp @MTB_TRAIL_FIX_PAGES;

process_file_pages($MTB_TRAIL_FIX_FILE, \@MTB_TRAIL_FIX_PAGES, "MTB");

#### MTB_HARD_TRAIL_FIX ####
my @MTB_HARD_TRAIL_FIX_PAGES = `seq 1 2`;
my $MTB_HARD_TRAIL_FIX_FILE = "mtb-hard-trail-fix";

chomp @MTB_HARD_TRAIL_FIX_PAGES;

process_file_pages($MTB_HARD_TRAIL_FIX_FILE, \@MTB_HARD_TRAIL_FIX_PAGES, "MTB");

#### MTB_DOUBLE ####
my @MTB_DOUBLE_PAGES = `seq 1 4`;
my $MTB_DOUBLE_FILE = "mtb-double";

chomp @MTB_DOUBLE_PAGES;

process_file_pages($MTB_DOUBLE_FILE, \@MTB_DOUBLE_PAGES, "MTB-DOUBLE");

#### ROAD ####
my @ROAD_PAGES = `seq 1 2`;
my $ROAD_FILE = "road";

chomp @ROAD_PAGES;

process_file_pages($ROAD_FILE, \@ROAD_PAGES, "ROAD");

#### ROAD_CICLOCROSS ####
my @ROAD_CICLOCROSS_PAGES = `seq 1 2`;
my $ROAD_CICLOCROSS_FILE = "road-ciclocross";

chomp @ROAD_CICLOCROSS_PAGES;

process_file_pages($ROAD_CICLOCROSS_FILE, \@ROAD_CICLOCROSS_PAGES, "ROAD-CICLOCROSS");

#### MTB_ELECTRIC ####
my @MTB_ELECTRIC_PAGES = `seq 1 2`;
my $MTB_ELECTRIC_FILE = "mtb-woman";

chomp @MTB_ELECTRIC_PAGES;

process_file_pages($MTB_ELECTRIC_FILE, \@MTB_ELECTRIC_PAGES, "MTB-ELECTRIC");

#### MTB_WOMAN ####
my @MTB_WOMAN_PAGES = `seq 1 2`;
my $MTB_WOMAN_FILE = "mtb-woman";

chomp @MTB_WOMAN_PAGES;

process_file_pages($MTB_WOMAN_FILE, \@MTB_WOMAN_PAGES, "MTB-WOMAN");

#### KIDS ####
my @KIDS_PAGES = `seq 1 2`;
my $KIDS_FILE = "kids";

chomp @KIDS_PAGES;

process_file_pages($KIDS_FILE, \@KIDS_PAGES, "KIDS");
