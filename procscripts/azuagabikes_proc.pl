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
use constant STORE => "Azuaga Bikes";
use constant ONLY_DOMAIN => "azuagabikes.com";
use constant URL => "http://www." . ONLY_DOMAIN;
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

sub dump_model {
  my $file = $_[0];
  my $model = $_[1];
  chomp($model);
  my $type = $_[2];
  my $store = $_[3];
  my $trimmed_model = $model;
  $trimmed_model =~ s/^\s+|\s+$//g;
  chomp($trimmed_model);
  my $clean_model = `bash -c 'source ./common_proc; \
bubic_clean "$trimmed_model"'`;
  my $model = $clean_model;
  chomp($model);

  # URL PARSING
  my $url_cmd = "grep \">$trimmed_model<\" $file -B10 | grep href | tail -1";
  my $url_all = `$url_cmd`;
  $url_all =~ s/^\s+|\s+$//g;
  $url_all =~ s/"//g;
  ($url_first, $url_no_html) = split('href=', $url_all, -1);
  ($url_no_dash, $url_later) = split('>', $url_no_html, -1);
  chomp($url_no_dash);
  my $url = "\"" . URL . "/" . $url_no_dash . "\"";
  my $url_no_bs;
  my $url_plane;
  $url =~ s/"/\\"/g;
  $url_no_bs = $url;
  $url_no_bs =~ s/\\"/"/g;

  # PRICE PARSING
  my $price_cmd = sprintf("grep -h -i \">$trimmed_model<\" $file -A%s | grep '<span class=\"price\">' -A2 | sed -e 's/<[^>]*>//g' | egrep -E -o \"[0-9]{0,1},{0,1}[0-9]{2,3}\.{0,1}[0-9]{0,2}\" | head -1 | tr -d ','", MAX_PRICE);
  my $price = `$price_cmd`;
  $price =~ s/^\s+|\s+$//g;
  chomp($price);
  $price =~ s/[^0-9,\.]//sg;
  $price =~ s/\./\,/sg;

  # TRADEMARK/MODEL processing
  my $clean_model_trademark = `bash -c 'source ./common_proc; bubic_clean "$model"'`;
  chomp($clean_model_trademark);
  ($clean_trademark) = split(' ', $clean_model_trademark, -1);
  chomp($clean_trademark);
  my $clean_model = $clean_model_trademark;
  $clean_model =~ s/$clean_trademark//g;
  chomp($clean_model);

  my $camel_trademark = `bash -c 'source ./common_proc; bubic_camel "$clean_trademark"'`;
  my $camel_model = `bash -c 'source ./common_proc; bubic_camel "$clean_model"'`;
  chomp($camel_trademark);
  chomp($camel_model);

  # TRADEMARK_PARSING

  #print "================================";
  #print "\nFILE:$file\n";
  #print "CLEAN_TRADEMARK:$clean_trademark\n";
  #print "CLEAN_MODEL:$clean_model\n";
  #print "CAMEL_TRADEMARK:$camel_trademark\n";
  #print "CAMEL_MODEL:$camel_model\n";
  #print "URL:$url\n";
  #print "URL_NO_BS:$url_no_bs\n";
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
  my $models_cmd = "cat $file | grep '<span class=\"pName\">' | grep -i -v zapatillas | sed -e 's/<[^>]*>//g'";
  my @models = `$models_cmd`;
  foreach my $model (@models) {
    chomp($model);
    dump_model($file, $model, $type, STORE);
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

#### MTB_26_FIX ####
my @MTB_26_FIX_PAGES = `seq 1 2`;
my $MTB_26_FIX_FILE = "mtb-26";

chomp @MTB_26_FIX_PAGES;

process_file_pages($MTB_26_FIX_FILE, \@MTB_26_FIX_PAGES, "MTB");

#### MTB_27_5_FIX ####
my @MTB_27_5_FIX_PAGES = `seq 1 2`;
my $MTB_27_5_FIX_FILE = "mtb-275";

chomp @MTB_27_5_FIX_PAGES;

process_file_pages($MTB_27_5_FIX_FILE, \@MTB_27_5_FIX_PAGES, "MTB-27-5");

#### MTB_29_FIX ####
my @MTB_29_FIX_PAGES = `seq 1 2`;
my $MTB_29_FIX_FILE = "mtb-29";

chomp @MTB_29_FIX_PAGES;

process_file_pages($MTB_29_FIX_FILE, \@MTB_29_FIX_PAGES, "MTB-29");

#### MTB_WOMAN_FIX ####
my @MTB_WOMAN_FIX_PAGES = `seq 1 2`;
my $MTB_WOMAN_FIX_FILE = "mtb-woman";

chomp @MTB_WOMAN_FIX_PAGES;

process_file_pages($MTB_WOMAN_FIX_FILE, \@MTB_WOMAN_FIX_PAGES, "MTB-WOMAN");

#### MTB_DOUBLE ####
my @MTB_DOUBLE_PAGES = `seq 1 2`;
my $MTB_DOUBLE_FILE = "mtb-enduro";

chomp @MTB_DOUBLE_PAGES;

process_file_pages($MTB_DOUBLE_FILE, \@MTB_DOUBLE_PAGES, "MTB-DOUBLE");

#### KIDS ####
my @KIDS_PAGES = `seq 1 2`;
my $KIDS_FILE = "kids";

chomp @KIDS_PAGES;

process_file_pages($KIDS_FILE, \@KIDS_PAGES, "KIDS");

#### ROAD ####
my @ROAD_PAGES = `seq 1 2`;
my $ROAD_FILE = "road";

chomp @ROAD_PAGES;

process_file_pages($ROAD_FILE, \@ROAD_PAGES, "ROAD");

#### DIRT ####
my @DIRT_PAGES = `seq 1 2`;
my $DIRT_FILE = "urban-dirt";

chomp @DIRT_PAGES;

process_file_pages($DIRT_FILE, \@DIRT_PAGES, "BMX");

#### URBAN_TREKKING ####
my @URBAN_TREKKING_PAGES = `seq 1 2`;
my $URBAN_TREKKING_FILE = "urban-trekking";

chomp @URBAN_TREKKING_PAGES;

process_file_pages($URBAN_TREKKING_FILE, \@URBAN_TREKKING_PAGES, "URBAN-TREKKING");

#### URBAN_TREKKING ####
my @URBAN_PAGES = `seq 1 2`;
my $URBAN_FILE = "urban-trekking";

chomp @URBAN_PAGES;

process_file_pages($URBAN_FILE, \@URBAN_PAGES, "URBAN");

