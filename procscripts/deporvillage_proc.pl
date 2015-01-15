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
use constant URL => "http://www.deporvillage.com";
use constant EXCLUDE => "-Rgif -Rpng -Rjpg";
use constant MAX_TRIES => 10;
use constant MAX_TIMEOUT => 10;
use constant OUTPUT_FILE => "output";
use constant MAX_PRICE => 30;
use constant STORE => "Depor Village";

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
  my $trademark;
  my $url;
  my $clean_trademark_model = `bash -c 'source ./common_proc; \
bubic_clean "$trimmed_trademark_model"'`;
  my $model = $clean_trademark_model;

  ($trademark) = split(' ', $clean_trademark_model, -1);
  $model =~ s/$trademark//g;
  $model =~ s/^\s+//;

  $trademark_model =~ s/^\s+//;
  if ($model eq "") {
    $model = $trademark;
  }

  chomp($trademark);
  chomp($model);

  # URL PARSING
  my $url_cmd = "grep '>$trademark_model<' $file | grep href | head -1";
  $url_all = `$url_cmd`;
  ($url_first, $url_no_html) = split('href=', $url_all, -1);
  ($url_no_dash, $url_later) = split(' ', $url_no_html, -1);
  chomp($url_no_dash);
  ($url_no_greater, $url_later) = split('>', $url_no_dash, -1);
  my $sub_url = $url_no_greater;
  $sub_url =~ s/"//g;
  my $sub_url2;
  if ($sub_url =~ m/\//) {
   $sub_url2 = URL . $sub_url;
  }
  else {
   $sub_url2 = URL . "/" . $sub_url;
  }
  $url = "\\\"" . $sub_url2 . "\\\"";

  # PRICE PARSING
  my $price_cmd = sprintf("cat $file | grep $sub_url -A%d | grep '<span class=\"price\">' | head -1 | sed -e 's/<[^>]*>//g'", MAX_PRICE);
  my $price = `$price_cmd`;
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
  #print "\nTRADEMARK_MODEL:$trademark_model\n";
  #print "TRADEMARK:$trademark\n";
  #print "MODEL:$model\n";
  #print "CAMEL_MODEL:$camel_model\n";
  #print "URL:$url\n";
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
  my $models_cmd = "cat $file | grep '<div class=\"nombre_list_top\"></div>' -A5 | grep 'a href' | sed -e 's/<[^>]*>//g'";
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

#### FOLDING ####
my @FOLDING_PAGES = `seq 1 3`;
my $FOLDING_FILE = "urban-folding";

chomp @FOLDING_PAGES;

process_file_pages($FOLDING_FILE, \@FOLDING_PAGES, "URBAN-FOLDING");

#### ELECTRIC ####
my @ELECTRIC_PAGES = `seq 1 3`;
my $ELECTRIC_FILE = "urban-electric";

chomp @ELECTRIC_PAGES;

process_file_pages($ELECTRIC_FILE, \@ELECTRIC_PAGES, "URBAN-ELECTRIC");

#### URBAN ####
my @URBAN_PAGES = `seq 1 6`;
my $URBAN_FILE = "urban-city";

chomp @URBAN_PAGES;

process_file_pages($URBAN_FILE, \@URBAN_PAGES, "URBAN");

#### MTB ####
my @MTB_PAGES = `seq 1 4`;
my $MTB_FILE = "mtb";

chomp @MTB_PAGES;

process_file_pages($MTB_FILE, \@MTB_PAGES, "MTB");

#### KIDS ####
my @KIDS_PAGES = `seq 1 7`;
my $KIDS_FILE = "kids";

chomp @KIDS_PAGES;

process_file_pages($KIDS_FILE, \@KIDS_PAGES, "KIDS");

#### BMX ####
my @BMX_PAGES = `seq 1 2`;
my $BMX_FILE = "kids";

chomp @BMX_PAGES;

process_file_pages($BMX_FILE, \@BMX_PAGES, "BMX");

