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
require "CommonGet.pl";
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
  my $trademark_model = $_[1];
  my $type = $_[2];
  my $store = $_[3];
  my $trimmed_trademark_model = $trademark_model;
  $trimmed_trademark_model =~ s/^\s+|\s+$//g;
  my @trade_model = split(/\s+/, $trimmed_trademark_model);
  my $model_search_trademark = sprintf('>%s<', $trimmed_trademark_model);
  my $search_trademark_cmd = "grep \"$model_search_trademark\" $file -A10 | grep alt";
  my $search_trademark = `$search_trademark_cmd`;
  ($search_first, $search_sec) = split('alt=', $search_trademark, -1);
  my @trademark_all = split(' ', $search_sec);
  my $trademark = $trademark_all[0];
  $trademark =~ s/"//g;
  my $model;
  my $url;

  foreach my $elem (@trade_model) {
    if ($elem ne $trademark) {
      $model .= "$elem ";
    }
  }
  if ($model eq "") {
    $model = $trademark;
  }

  # URL PARSING
  my $url_cmd = "grep \"$trimmed_trademark_model\" $file | grep href";
  $url_all = `$url_cmd`;
  ($url_first, $url_no_html) = split('href=', $url_all, -1);
  ($url_no_dash, $url_later) = split(' ', $url_no_html, -1);
  chomp($url_no_dash);
  my $url = $url_no_dash;
  $url =~ s/"/\\"/g;

  # PRICE PARSING
  my $price_cmd = sprintf("grep -A%d \"$trimmed_trademark_model\" $file " .
"| grep 'itemprop=\"price\"' | tail -1", MAX_PRICE);
  my $price_html = `$price_cmd`;
  if ($price_html eq "") {
    $price_cmd = sprintf("grep -A%d \"$trimmed_trademark_model\" $file " .
"| grep '<strike>' | tail -1", MAX_PRICE);
    $price_html = `$price_cmd`;
  }
  $price_html =~ s/<.+?>//sg;
  $price_html =~ s/\s+//sg;
  my $price = $price_html;
  $price =~ s/\.//sg;
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
  #print "\nTRADEMARK:$trademark\n";
  #print "MODEL_SEARCH_TRADEMARK:$model_search_trademark\n";
  #print "MODEL_SEARCH_CMD:$search_trademark_cmd\n";
  #print "SEARCH FIRST:$search_first\n";
  #print "SEARCH SEC:$search_sec\n";
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

sub dump_bash_bubic {
  my $camel_model = $_[0];
  my $url = $_[1];
  my $camel_trademark = $_[2];
  my $price = $_[3];
  my $store = $_[4];
  my $type  = $_[5];

  my $dump_command = sprintf("bash -c 'source ./common_proc; " .
"SUBURL_KEY=$SUBURL_KEY " .
"TRADEMARK_KEY=$TRADEMARK_KEY " .
"PRICE_KEY=$PRICE_KEY " .
"STORE_KEY=$STORE_KEY " .
"KIND_KEY=$KIND_KEY " .
"bubic_dump_bike \"$camel_model\" \"$url\" \"$camel_trademark\" $price " .
"$store $type' >> %s",
      OUTPUT_FILE);
  #print "Executing command:=>$dump_command<=\n";
  `$dump_command`;
}

sub process_file {
  my $file = $_[0];
  my $type = $_[1];
  my @models = `cat $file | grep '<h5>' | sed -e 's/<[^>]*>//g'`;
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

#### ELECTRIC ####
my @ELECTRIC_PAGES = `seq 1 4`;
my $ELECTRIC_FILE = "electric";

chomp @ELECTRIC_PAGES;

process_file_pages($ELECTRIC_FILE, \@ELECTRIC_PAGES, "URBAN-ELECTRIC");

#### ROAD ####
my @ROAD_PAGES = `seq 1 10`;
my $ROAD_FILE = "road";

chomp @ROAD_PAGES;

process_file_pages($ROAD_FILE, \@ROAD_PAGES, "ROAD");

#### TREKKING ####
my @TREKKING_PAGES;
my $TREKKING_FILE = "trekking";

process_file_pages($TREKKING_FILE, \@TREKKING_PAGES, "ROAD-TREKKING");

#### MTB ####
my @MTB_PAGES = `seq 1 17`;
my $MTB_FILE = "mtb";

chomp @MTB_PAGES;

process_file_pages($MTB_FILE, \@MTB_PAGES, "MTB");

#### FOLDING ####
my @FOLDING_PAGES = `seq 1 4`;
my $FOLDING_FILE = "urban-folding";

chomp @FOLDING_PAGES;

process_file_pages($ELECTRIC_FILE, \@ELECTRIC_PAGES, "URBAN-ELECTRIC");

#### CICLOCROSS ####
my $CICLOCROSS_BASE = URL . "/productos/46-ciclocross.html?pag=";
my $CICLOCROSS_FILE = "road-ciclocross";

chomp @CICLOCROSS_PAGES;

process_file_pages($ROAD-CICLOCROSS_FILE, \@ROAD-CICLOCROSS_PAGES, "ROAD-CICLOCROSS");

#### MTB-DOWNHILL ####
my $MTB_DOWNHILL_BASE = URL . "/productos/47-descenso.html";
my $MTB_DOWNHILL_FILE = "mtb-downhill";

process_file_pages($MTB_DOWNHILL_FILE, \@MTB_DOWNHILL_PAGES, "MTB-DOWNHILL");

#### URBAN-FATBOY ####
my @URBAN_FATBOY_PAGES;
my $URBAN_FATBOY_FILE = "urban-fatboy";

process_file_pages($FATBOY_FILE, \@FATBOY_PAGES, "URBAN-FATBOY");

#### BMX ####
my @BMX_PAGES;
my $BMX_FILE = "bmx";

process_file_pages($BMX_FILE, \@BMX_PAGES, "BMX");

#### KIDS ####
my @KIDS_PAGES;
my $KIDS_FILE = "kids";

process_file_pages($KIDS_FILE, \@KIDS_PAGES, "KIDS");

#### ROAD-CLAY ####
my @ROAD_CLAY_PAGES;
my $ROAD_CLAY_FILE = "road-clay";

process_file_pages($ROAD_CLAY_FILE, \@ROAD_CLAY_PAGES, "ROAD-PISTA");

#### ROAD-TRIATLON ####
my @ROAD_TRIATLON_PAGES;
my $ROAD_TRIATLON_FILE = "road-triatlon";

process_file_pages($ROAD_TRIATLON_FILE, \@ROAD_TRIATLON_PAGES, "ROAD_TRIATLON");

#### URBAN ####
my @URBAN_PAGES = `seq 1 3`;
my $URBAN_FILE = "urban";

chomp @URBAN_PAGES;

process_file_pages($URBAN_FILE, \@URBAN_PAGES, "URBAN");
