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
use constant STORE => "Red Blue";
use constant ONLY_DOMAIN => "tiendaredblue.com";
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
  my $url_cmd = "grep \"$trimmed_model_amp\" $file -A10 | grep href | awk -F \"href=\" {'print \$2'} | awk {'print \$1'} | head -1";
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
  my $price_cmd = sprintf("grep \"$trimmed_model_amp\" $file -A%s | grep '<span class=\"price\">' -A2 | egrep -E -o \"[0-9]{1,2}.{0,1}[0-9]{2,3},{0,1}[0-9]{0,2}\" | head -1 | tr -d '.'", MAX_PRICE);
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
  my $models_cmd = "cat $file | grep '<div class=\"product-list-product-details\">' -A5 | sed -e 's/>\\n/>/g' | sed -e 's!\\n\<!\<!g' | sed -e 's/<[^>]*>//g' | grep [A-Z,a-z]";
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

#### MTB ####
my @MTB_PAGES = `seq 1 8`;
my $MTB_FILE = "mtb";

chomp @MTB_PAGES;

process_file_pages($MTB_FILE, \@MTB_PAGES, "MTB");

#### ROAD ####
my @ROAD_PAGES = `seq 1 2`;
my $ROAD_FILE = "road";

chomp @ROAD_PAGES;

process_file_pages($ROAD_FILE, \@ROAD_PAGES, "ROAD");

#### URBAN ####
my @URBAN_PAGES = `seq 1 2`;
my $URBAN_FILE = "urban";

chomp @URBAN_PAGES;

process_file_pages($URBAN_FILE, \@URBAN_PAGES, "URBAN");

