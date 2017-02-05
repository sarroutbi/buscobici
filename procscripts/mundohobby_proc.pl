#!/usr/bin/perl
#
# Copyright © 2012-2017 Sergio Arroutbi Braojos <sarroutbi _at_ gmail.com>
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
use constant STORE => "MundoHobby";
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
  chomp($search_model);

  $search_model =~ s/^\s+|\s+$//g;

  # URL PARSING
  my $url_parsing_cmd = "grep '>$search_model<' $file | head -1 | awk -F 'a href=' {'print \$2'} | awk {'print \$1'}";
  my $url = `$url_parsing_cmd`;
  $url =~ s/"/\\"/g; 
  chomp($url);
  
  # PRICE PARSING
  my $price_parsing_cmd = "grep '$search_model' $file -A10 | sed -e 's!<[^>]*>!!g' | sed -e 's!euro;!euro\\n!g' | egrep -E \"[0-9]{0,2}\.{0,1}[0-9]{3},{0,1}[0-9]{0,2}\" -o | tail -1 | tr -d '.' | tr -d ' '";
  my $price = `$price_parsing_cmd`;
  chomp($price);
  $price =~ s/^\s+|\s+$//g;

  # TRADEMARK/MODEL processing
  $search_model =~ s!\"!''!g;
  my $clean_search_model = `bash -c 'source ./common_proc; bubic_clean "$search_model"'`;
  chomp($clean_search_model);
  $clean_search_model =~ s!\"!''"!g;
  my ($clean_trademark, $clean_model) = split (" ", $clean_search_model, 2);
  $clean_model =~ s!\"!\''!g;
  $clean_trademark =~ s!\"!''!g;
  $clean_model =~ s/^\xa0//g;
  $clean_trademark =~ s/^\xa0//g;
  $clean_model =~ s/\xa0/ /g;
  $clean_trademark =~ s/\xa0/ /g;
  $clean_model =~ s/^\s+|\s+$//g;
  $clean_trademark =~ s/^\s+|\s+$//g;
  chomp($clean_trademark);
  chomp($clean_model);

  my $camel_trademark = `bash -c 'source ./common_proc; bubic_camel "$clean_trademark"'`;
  my $camel_model = `bash -c 'source ./common_proc; bubic_camel "$clean_model"'`;
  chomp($camel_trademark);
  chomp($camel_model);
  $camel_trademark=~s/^\xa0//g;
  $camel_model=~s/^\xa0//g;
  $camel_trademark=~s/\xa0/ /g;
  $camel_model=~s/\xa0/ /g;
  chomp($camel_trademark);
  chomp($camel_model);

  #print "================================\n";
  #print "FILE:$file\n";
  #print "SEARCH_MODEL:$search_model\n";
  #print "CLEAN_SEARCH_MODEL:$clean_search_model\n";
  #print "CLEAN_TRADEMARK:$clean_trademark\n";
  #print "CLEAN_MODEL:$clean_model\n";
  #print "CAMEL_TRADEMARK_CMD:$camel_trademark_cmd\n";
  #print "CAMEL_MODEL_CMD:$camel_model_cmd\n";
  #print "CAMEL_TRADEMARK:$camel_trademark\n";
  #print "CAMEL_MODEL:$camel_model\n";
  #print "TYPE:$type\n";
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
  my $models_cmd = "grep '<p class=\"product_desc\"' $file | sed -e 's!<[^>]*>!!g'";
  my @models = `$models_cmd`;
  chomp @models;

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

#### MTB ####
my @MTB_PAGES = `seq 1 16`;
my $MTB_FILE = "mtb";

chomp @MTB_PAGES;

process_file_pages($MTB_FILE, \@MTB_PAGES, "MTB");

#### MTB-DOUBLE ####
my @MTB_DOUBLE_PAGES = `seq 1 6`;
my $MTB_DOUBLE_FILE = "mtbdouble";

chomp @MTB_DOUBLE_PAGES;

process_file_pages($MTB_DOUBLE_FILE, \@MTB_DOUBLE_PAGES, "MTB-DOUBLE");

#### ROAD ####
my @ROAD_PAGES = `seq 1 11`;
my $ROAD_FILE = "road";

chomp @ROAD_PAGES;

process_file_pages($ROAD_FILE, \@ROAD_PAGES, "ROAD");
