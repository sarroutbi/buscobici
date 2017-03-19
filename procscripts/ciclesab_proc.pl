#!/usr/bin/perl
#
# Copyright © 2017 Sergio Arroutbi Braojos <sarroutbi at gmail.com>
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
use constant ONLY_DOMAIN => "ciclesab.com";
use constant URL => "http://" . ONLY_DOMAIN;
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

sub dump_model 
{
  my $file = $_[0];
  my $model_html = $_[1];
  chomp($model_html);
  my $type = $_[2];
  my $store = $_[3];
  my $model_trademark = $model_html;
  my $discard;
  my $model;
  my $trademark;
  my $clean_model;
  my $clean_trademark;
  $model_trademark =~ s|<.+?>||g;
  $model_trademark =~ s@^\s+|\s+$@@g;

  my $clean_model_trademark = `bash -c 'source ./common_proc; \
bubic_clean "$model_trademark"'`;
  $clean_model_trademark =~ s/^\s+|\s+$//g;

  ($clean_trademark, $clean_model) = split(' ', $clean_model_trademark, 2);

  # URL PARSING
  my $url;
  ($discard, $url) = split('href=', $model_html, -1);
  ($url, $discard) = split(' ', $url, -1);

  # PRICE PARSING
  my $price;
  $price=`grep -A10 \"$model_trademark\" \"$file\" | grep '<span class=\"price\"' | sed -e 's|^[ \t]*||g'`;
  $price =~ s|<.+?>||g;
  $price =~ s/^\s+|\s+$//g;
  chomp($price);
  $price =~ s/[^0-9,\,]//sg;

  # TRADEMARK/MODEL processing
  chomp($clean_trademark);
  chomp($clean_model);
  my $camel_trademark = `bash -c 'source ./common_proc; bubic_camel "$clean_trademark"'`;
  my $camel_model = `bash -c 'source ./common_proc; bubic_camel "$clean_model"'`;
  chomp($camel_trademark);
  chomp($camel_model);
  #print "================================";
  #print "\nFILE:$file\n";
  #print "MODEL_HTML:$model_html\n";
  #print "CLEAN_MODEL_TRADEMARK:$clean_model_trademark\n";
  #print "CLEAN_TRADEMARK:$clean_trademark\n";
  #print "CLEAN_MODEL:$clean_model\n";
  #print "CAMEL_TRADEMARK:$camel_trademark\n";
  #print "CAMEL_MODEL:$camel_model\n";
  #print "URL:$url\n";
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
  my $models_cmd = "cat $file | grep '<a class=\"product_link\"'";
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

#### URBAN_FIX ####
my @URBAN_FIX_PAGES = `seq 1 5`;
my $URBAN_FIX_FILE = "urban";

chomp @URBAN_FIX_PAGES;

process_file_pages($URBAN_FIX_FILE, \@URBAN_FIX_PAGES, "URBAN");

#### URBAN_ELECTRIC_FIX ####
my @URBAN_ELECTRIC_FIX_PAGES = `seq 1 5`;
my $URBAN_ELECTRIC_FIX_FILE = "urban-electric";

chomp @URBAN_ELECTRIC_FIX_PAGES;

process_file_pages($URBAN_ELECTRIC_FIX_FILE, \@URBAN_ELECTRIC_FIX_PAGES, "URBAN-ELECTRIC");

#### URBAN_HYBRID_FIX ####
my @URBAN_HYBRID_FIX_PAGES = `seq 1 5`;
my $URBAN_HYBRID_FIX_FILE = "urban-hybrid";

chomp @URBAN_HYBRID_FIX_PAGES;

process_file_pages($URBAN_HYBRID_FIX_FILE, \@URBAN_HYBRID_FIX_PAGES, "URBAN-HYBRID");

#### URBAN_FOLDING_FIX ####
my @URBAN_FOLDING_FIX_PAGES = `seq 1 4`;
my $URBAN_FOLDING_FIX_FILE = "urban-folding";

chomp @URBAN_FOLDING_FIX_PAGES;

process_file_pages($URBAN_FOLDING_FIX_FILE, \@URBAN_FOLDING_FIX_PAGES, "URBAN-FOLDING");

#### KIDS ####
my @KIDS_PAGES = `seq 1 5`;
my $KIDS_FILE = "kids";

chomp @KIDS_PAGES;

process_file_pages($KIDS_FILE, \@KIDS_PAGES, "KIDS");

#### ROAD ####
my @ROAD_PAGES = `seq 1 12`;
my $ROAD_FILE = "road";

chomp @ROAD_PAGES;

process_file_pages($ROAD_FILE, \@ROAD_PAGES, "ROAD");

#### ROAD_WOMAN ####
my @ROAD_WOMAN_PAGES = `seq 1 2`;
my $ROAD_WOMAN_FILE = "road-woman";

chomp @ROAD_WOMAN_PAGES;

process_file_pages($ROAD_WOMAN_FILE, \@ROAD_WOMAN_PAGES, "ROAD-WOMAN");

#### MTB_29_FIX ####
my @MTB_29_FIX_PAGES = `seq 1 11`;
my $MTB_29_FIX_FILE = "mtb-29-fix";

chomp @MTB_29_FIX_PAGES;

process_file_pages($MTB_29_FIX_FILE, \@MTB_29_FIX_PAGES, "MTB-29");

#### MTB_27_5_FIX ####
my @MTB_27_5_FIX_PAGES = `seq 1 8`;
my $MTB_27_5_FIX_FILE = "mtb-27_5-fix";

chomp @MTB_27_5_FIX_PAGES;

process_file_pages($MTB_27_5_FIX_FILE, \@MTB_27_5_FIX_PAGES, "MTB-27-5");

#### MTB_DOUBLE ####
my @MTB_DOUBLE_PAGES = `seq 1 4`;
my $MTB_DOUBLE_FILE = "mtb-double";

chomp @MTB_DOUBLE_PAGES;

process_file_pages($MTB_DOUBLE_FILE, \@MTB_DOUBLE_PAGES, "MTB-DOUBLE");

#### MTB_WOMAN_FIX ####
my @MTB_WOMAN_FIX_PAGES = `seq 1 2`;
my $MTB_WOMAN_FIX_FILE = "mtb-woman-fix";

chomp @MTB_WOMAN_FIX_PAGES;

process_file_pages($MTB_WOMAN_FIX_FILE, \@MTB_WOMAN_FIX_PAGES, "MTB-WOMAN");

#### MTB_FIX ####
my @MTB_FIX_PAGES = `seq 1 11`;
my $MTB_FIX_FILE = "mtb-fix";

chomp @MTB_FIX_PAGES;

process_file_pages($MTB_FIX_FILE, \@MTB_FIX_PAGES, "MTB");
