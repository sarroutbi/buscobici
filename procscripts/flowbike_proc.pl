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
use constant STORE => "FlowBike Store";
use constant ONLY_DOMAIN => "flowbikestore.com";
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
  my $trimmed_model_amp = $trimmed_model;
  $trimmed_model_amp =~ s/&/\\&/g;
  chomp($trimmed_model);
  my $clean_model = `bash -c 'source ./common_proc; \
bubic_clean "$trimmed_model"'`;
  my $model = $clean_model;
  chomp($model);

  # URL PARSING
  my $url_cmd = "grep \"$trimmed_model_amp\" $file -A10 | grep href | awk -F \"href=\" {'print \$2'} | awk -F '>' {'print \$1'} | head -1";
  my $url_all = `$url_cmd`;
  chomp($url_all);
  my $url = $url_all;
  if ($url eq "") {
      printf "\n\n\nurl empty:$url_cmd\n\n\n";
  }
  my $url_bs;
  $url_bs = $url;
  $url_bs =~ s/"/\\"/g;

  # PRICE PARSING
  my $price_cmd = sprintf("grep \"$trimmed_model_amp\" $file -A%s | grep 'euro' | sed -e 's/<[^>]*>//g' | egrep -E -o \"[0-9]{1,2}.{0,1}[0-9]{2,3},{0,1}[0-9]{0,2}\" | tail -1 | tr -d '.'", MAX_PRICE);
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

  #print "================================";
  #print "\nFILE:$file\n";
  #print "TRIMMED_MODEL_AMP:$trimmed_model_amp\n";
  #print "CLEAN_TRADEMARK:$clean_trademark\n";
  #print "CLEAN_MODEL:$clean_model\n";
  #print "CAMEL_TRADEMARK:$camel_trademark\n";
  #print "CAMEL_MODEL:$camel_model\n";
  #print "URL:$url\n";
  #print "URL_BS:$url_bs\n";
  #print "PRICE:$price\n";
  #print "STORE:$store\n";
  #print "TYPE:$type\n";
  #print "================================\n";

  dump_bash_bubic ($camel_model, $url_bs, $camel_trademark, $price, $store, $type);
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
  my $models_cmd = "cat $file | grep 'a href=' | grep '/bicicletas/' | grep 'Bicicleta' | grep '<br />' | grep -v img | sed -e 's/<[^>]*>//g'";
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

#### BMX ####
my @BMX_PAGES = `seq 1 1`;
my $BMX_FILE = "bmx";

chomp @BMX_PAGES;

process_file_pages($BMX_FILE, \@BMX_PAGES, "BMX");

#### ROAD ####
my @ROAD_PAGES = `seq 1 1`;
my $ROAD_FILE = "road";

chomp @ROAD_PAGES;

process_file_pages($ROAD_FILE, \@ROAD_PAGES, "ROAD");

#### ROAD_CICLOCROSS ####
my @ROAD_CICLOCROSS_PAGES = `seq 1 1`;
my $ROAD_CICLOCROSS_FILE = "road-ciclocross";

chomp @ROAD_CICLOCROSS_PAGES;

process_file_pages($ROAD_CICLOCROSS_FILE, \@ROAD_CICLOCROSS_PAGES, "ROAD_CICLOCROSS");

#### URBAN_CITY ####
my @URBAN_CITY_PAGES = `seq 1 1`;
my $URBAN_CITY_FILE = "urban-city";

chomp @URBAN_CITY_PAGES;

process_file_pages($URBAN_CITY_FILE, \@URBAN_CITY_PAGES, "URBAN_CITY");

#### URBAN_ELECTRIC ####
my @URBAN_ELECTRIC_PAGES = `seq 1 1`;
my $URBAN_ELECTRIC_FILE = "urban-electric";

chomp @URBAN_ELECTRIC_PAGES;

process_file_pages($URBAN_ELECTRIC_FILE, \@URBAN_ELECTRIC_PAGES, "URBAN_ELECTRIC");

#### URBAN_FIXIE ####
my @URBAN_FIXIE_PAGES = `seq 1 1`;
my $URBAN_FIXIE_FILE = "urban-fixie";

chomp @URBAN_FIXIE_PAGES;

process_file_pages($URBAN_FIXIE_FILE, \@URBAN_FIXIE_PAGES, "URBAN_FIXIE");

#### URBAN_FOLDING ####
my @URBAN_FOLDING_PAGES = `seq 1 1`;
my $URBAN_FOLDING_FILE = "urban-fixie";

chomp @URBAN_FOLDING_PAGES;

process_file_pages($URBAN_FOLDING_FILE, \@URBAN_FOLDING_PAGES, "URBAN_FOLDING");

#### MTB_DOUBLE ####
my @MTB_DOUBLE_PAGES = `seq 1 2`;
my $MTB_DOUBLE_FILE = "mtb-double";

chomp @MTB_DOUBLE_PAGES;

process_file_pages($MTB_DOUBLE_FILE, \@MTB_DOUBLE_PAGES, "MTB_DOUBLE");

#### MTB_27_5 ####
my @MTB_27_5_PAGES = `seq 1 2`;
my $MTB_27_5_FILE = "mtb-27-5";

chomp @MTB_27_5_PAGES;

process_file_pages($MTB_27_5_FILE, \@MTB_27_5_PAGES, "MTB_27_5");

#### MTB_29 ####
my @MTB_29_PAGES = `seq 1 2`;
my $MTB_29_FILE = "mtb-29";

chomp @MTB_29_PAGES;

process_file_pages($MTB_29_FILE, \@MTB_29_PAGES, "MTB_29");

#### MTB ####
my @MTB_PAGES = `seq 1 3`;
my $MTB_FILE = "mtb";

chomp @MTB_PAGES;

process_file_pages($MTB_FILE, \@MTB_PAGES, "MTB");

#### KIDS ####
my @KIDS_PAGES = `seq 1 1`;
my $KIDS_FILE = "kids";

chomp @KIDS_PAGES;

process_file_pages($KIDS_FILE, \@KIDS_PAGES, "KIDS");
