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
use constant STORE => "Zermatt";
use constant URL => "http://www.zermattbike.es";
use constant ONLY_DOMAIN => "zermattbike.es";
use constant EXCLUDE => "-Rgif -Rpng -Rjpg";
use constant MAX_TRIES => 10;
use constant MAX_TIMEOUT => 10;
use constant OUTPUT_FILE => "output";
use constant MAX_PRICE => 30;

my $TRADEMARK_KEY="TRADEMARK";
my $SUBURL_KEY="SUBURL";
my $STORE_KEY="STORE";
my $PRICE_KEY="PRICE";
my $KIND_KEY="KIND";

sub dump_model {
  my $file = $_[0];
  my $search_model = $_[1];
  my $type = $_[2];
  my $store = $_[3];

  chomp($type);
  chomp($store);

  $search_model =~ s/<//;
  $search_model =~ s/>//;

  # MODEL PARSING
  my $trademark_cmd = "echo '$search_model' | awk {'print \$1'}";
  my $trademark = `$trademark_cmd`;
  chomp($trademark);
  my $model = $search_model;
  $model =~ s/$trademark//g;

  # URL PARSING
  my $url_parsing_cmd = "grep '$search_model' $file -B10 | grep producto | tail -1 | egrep -E -o \"\\\"http[s]{0,1}://[^ ]* \" -A10 ";
  my $url = `$url_parsing_cmd`;
  $url =~ s/"/\\"/g; 
  chomp($url);
  
  # PRICE PARSING
  my $price_parsing_cmd = "grep '$search_model' $file -A10 | sed -e 's!<[^>]*>!!g' | sed -e 's!euro;!euro\\n!g' | egrep -E \"[0-9]{0,2}\.{0,1}[0-9]{3},{0,1}[0-9]{0,2}\" -o | tail -1 | tr -d '.' | tr -d ' '";
  my $price = `$price_parsing_cmd`;
  chomp($price);

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
  #print "\nTRADEMARK:$trademark\n";
  #print "TRADEMARK_CMD:$trademark_cmd\n";
  #print "MODEL_SEARCH:$search_model\n";
  #print "MODEL_PARSING_CMD:$model_parsing_cmd\n";
  #print "URL_PARSING_CMD:$url_parsing_cmd\n";
  #print "PRICE_PARSING_CMD:$price_parsing_cmd\n";
  #print "MODEL:$model\n";
  #print "TYPE:$type\n";
  #print "CLEAN_TRADEMARK:$clean_trademark\n";
  #print "CLEAN_MODEL:$clean_model\n";
  #print "CAMEL_TRADEMARK:$camel_trademark\n";
  #print "CAMEL_MODEL:$camel_model\n";
  #print "URL:$url\n";
  #print "STORE:$store\n";
  #print "PRICE:$price\n";
  #print "================================\n";
  #print "\n";
  dump_bash_bubic ($camel_model, $url, $camel_trademark, $price, $store, $type);
}

sub process_file {
  my $file = $_[0];
  chomp ($file);
  my $type = $_[1];
  chomp ($type);
  if ($file eq "") {
    return 1;
  }
  elsif ($type eq "") {
    return 1;
  }
  my $models_cmd = "cat $file | grep '<h3 itemprop=\"name\"'";
  my @models = `$models_cmd`;

  foreach my $trade_model (@models) {
    chomp($trade_model);
    my $html_trade_model = "<" . $trade_model . ">";
    my $trade_model_cmd = "echo \"$html_trade_model\" | sed -e 's!<[^>]*>!!g'";
    $trade_model = `$trade_model_cmd`;
    chomp($trade_model);
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

#### BMX ####
my @BMX_PAGES = `seq 1 2`;
my $BMX_FILE = "bmx";

process_file_pages($BMX_FILE, \@BMX_PAGES, "BMX");

#### ROAD ####
my @ROAD_PAGES = `seq 1 7`;
my $ROAD_FILE = "road";

chomp @ROAD_PAGES;

process_file_pages($ROAD_FILE, \@ROAD_PAGES, "ROAD");

#### ROAD_TRIATLON ####
my @ROAD_TRIATLON_PAGES = `seq 1 2`;
my $ROAD_TRIATLON_FILE = "road-triatlon";

chomp @ROAD_TRIATLON_PAGES;

process_file_pages($ROAD_TRIATLON_FILE, \@ROAD_TRIATLON_PAGES, "ROAD-TRIATLON");

#### CICLOCROSS ####
my @ROAD_CICLOCROSS_PAGES = `seq 1 2`;
my $ROAD_CICLOCROSS_FILE = "road-ciclocross";

chomp @ROAD_CICLOCROSS_PAGES;

process_file_pages($ROAD_CICLOCROSS_FILE, \@ROAD_CICLOCROSS_PAGES, "ROAD-CICLOCROSS");

#### ELECTRIC ####
my @ELECTRIC_PAGES = `seq 1 2`;
my $ELECTRIC_FILE = "electric";

chomp @ELECTRIC_PAGES;

process_file_pages($ELECTRIC_FILE, \@ELECTRIC_PAGES, "URBAN-ELECTRIC");

#### TREKKING ####
my @TREKKING_PAGES = `seq 1 2`;
my $TREKKING_FILE = "trekking";

process_file_pages($TREKKING_FILE, \@TREKKING_PAGES, "ROAD-TREKKING");

#### MTB ####
my @MTB_PAGES = `seq 1 7`;
my $MTB_FILE = "mtb";

chomp @MTB_PAGES;

process_file_pages($MTB_FILE, \@MTB_PAGES, "MTB");

#### FOLDING ####
my @FOLDING_PAGES = `seq 1 2`;
my $FOLDING_FILE = "urban-folding";

chomp @FOLDING_PAGES;

process_file_pages($FOLDING_FILE, \@FOLDING_PAGES, "URBAN-FOLDING");

#### URBAN ####
my @URBAN_PAGES = `seq 1 2`;
my $URBAN_FILE = "urban";

chomp @URBAN_PAGES;

process_file_pages($URBAN_FILE, \@URBAN_PAGES, "URBAN");

#### URBAN_WALK ####
my @URBAN_WALK_PAGES = `seq 1 2`;
my $URBAN_WALK_FILE = "urban-walk";

chomp @URBAN_WALK_PAGES;

process_file_pages($URBAN_WALK_FILE, \@URBAN_WALK_PAGES, "URBAN");

#### MTB-DOWNHILL ####
my $MTB_DOWNHILL_PAGES = `seq 1 2`;
my $MTB_DOWNHILL_FILE = "mtb-downhill";

process_file_pages($MTB_DOWNHILL_FILE, \@MTB_DOWNHILL_PAGES, "MTB-DOWNHILL");

#### KIDS ####
my @KIDS_PAGES = `seq 1 2`;
my $KIDS_FILE = "kids";

process_file_pages($KIDS_FILE, \@KIDS_PAGES, "KIDS");
