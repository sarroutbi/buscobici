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
use constant STORE => "New Born Riders";
use constant URL => "https://www.newbornriders.com";
use constant ONLY_DOMAIN => "newbornriders.com";
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

sub get_trademark_with_url {
  my $url = $_[0];
  my $cmd = "wget --no-check-certificate -o /dev/null -O - $url | grep 'Fabricante:' | awk -F 'Fabricante: ' {'print \$2'} | awk -F '.' {'print \$1'}";
  my $trademark = `$cmd`;
  return $trademark;
} 

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
  my $model = $trademark_model;

  # URL PARSING
  my $url_cmd = "cat $file | grep \"$trademark_model\" | grep href";
  $url_all = `$url_cmd`;
  ($url_first, $url_no_html) = split('href=', $url_all, -1);
  ($url_no_dash, $url_later) = split(' ', $url_no_html, -1);
  chomp($url_no_dash);
  my $url = $url_no_dash;
  $url =~ s/"/\\"/g;

  # MODEL PARSING
  $trademark = get_trademark_with_url($url_no_dash);
  $trademark =~ s/\n//g;
  $model =~ s/$trademark//g;

  if ($model eq "") {
    $model = $trademark;
  }

  chomp($trademark);
  chomp($model);

  # PRICE PARSING
  my $price_cmd = sprintf("cat $file | grep -C%d \"$trademark_model\" " .
"| grep '<span class=\"price\">' | head -1 | sed -e 's/<[^>]*>//g'", MAX_PRICE);
  my $price = `$price_cmd`;

  if ($price eq "") {
      $price_cmd = sprintf("cat $file | grep -C%d \"$trademark_model\" " .
                           "| grep '<span class=\"price\" >' -A2 | sed -e 's/<[^>]*>//g'" .
                           "| egrep -E -o \"[0-9]{2,4},{0,1}[0-9]{0,2}\" | head -1",
                           MAX_PRICE);
      $price = `$price_cmd`;
  }
  chomp($price);
  $price =~ s/[^0-9,\,]//sg;

  chomp($price);
  $price =~ s/[^0-9,\,]//sg;

  # TRADEMARK/MODEL processing
  my $clean_trademark = $trademark;
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
  my $models_cmd = "cat $file | grep '<h2 class=\"product-name\">' | sed -e 's/<[^>]*>//g'";
  my @models = `$models_cmd`;
  foreach my $trade_model (@models) {
    chomp($trade_model);
    $trade_model =~ s/^\s+|\s+$//g;
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

#### KIDS ####
my @KIDS_PAGES = `seq 1 4`;
my $KIDS_FILE = "kids";

chomp @KIDS_PAGES;

process_file_pages($KIDS_FILE, \@KIDS_PAGES, "KIDS");
