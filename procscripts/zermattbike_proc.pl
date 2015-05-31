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

  # MODEL PARSING
  my $model_parsing_cmd = "echo '$search_model' | sed -e 's!<h3>!\\n<h3>!g'" .
"| sed -e 's!</h3>!</h3>\\n!g' | grep h3 | sed -e 's!<[^>]*>!!g'";
  my $model = `$model_parsing_cmd`;
  chomp($model);
  my $trademark_cmd = "echo '$model' | awk {'print \$1'}";
  my $trademark = `$trademark_cmd`;
  chomp($trademark);

  # URL PARSING
  my $url_parsing_cmd = "echo '$search_model' | sed -e 's!<a href!\\n<a href!g'" .
"| sed -e 's!</a>!</a>\\n!g' | grep '<a href' | awk -F '=' {'print \$2'} | awk -F '>' {'print \$1'}";
  my $url = `$url_parsing_cmd`;
  $url =~ s/"/\\"/g; 
  chomp($url);
  
  # PRICE PARSING
  my $price_parsing_cmd = "echo '$search_model' | sed -e 's!<span class!\\n<span class!g'" .
"| sed -e 's!</span>!</span>\\n!g' | egrep -E -o \"[0-9]{1,2}.{0,1}[0-9]{2,3},{1}[0-9]{0,2}\" | tail -1 | tr -d '.'";
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
  #print "MODEL_SEARCH_CMD:$search_model\n";
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
  my $models_cmd = "cat $file | sed -e 's!<li!\\n<li!g' | grep '^<li' | grep h3";
  my @models = `$models_cmd`;

  foreach my $trade_model (@models) {
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
my @ROAD_PAGES = `seq 1 2`;
my $ROAD_FILE = "road";

chomp @ROAD_PAGES;

process_file_pages($ROAD_FILE, \@ROAD_PAGES, "ROAD");

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
my @MTB_PAGES = `seq 1 2`;
my $MTB_FILE = "mtb";

chomp @MTB_PAGES;

process_file_pages($MTB_FILE, \@MTB_PAGES, "MTB");

#### FOLDING ####
my @FOLDING_PAGES = `seq 1 2`;
my $FOLDING_FILE = "urban-folding";

chomp @FOLDING_PAGES;

process_file_pages($FOLDING_FILE, \@FOLDING_PAGES, "URBAN-FOLDING");

#### MTB-DOWNHILL ####
my $MTB_DOWNHILL_PAGES = `seq 1 2`;
my $MTB_DOWNHILL_FILE = "mtb-downhill";

process_file_pages($MTB_DOWNHILL_FILE, \@MTB_DOWNHILL_PAGES, "MTB-DOWNHILL");

#### KIDS ####
my @KIDS_PAGES = `seq 1 2`;
my $KIDS_FILE = "kids";

process_file_pages($KIDS_FILE, \@KIDS_PAGES, "KIDS");
