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
use constant DEF_MAX_TRIES => 10;
use constant DEF_MAX_TIMEOUT => 10;

sub bubicpl_get_page
{
  my $base_url = $_[0];
  my @pages = @{$_[1]};
  my $outfile = $_[2];
  my $max_tries = $_[3];
  my $max_timeout = $_[4];
  my $torify = $_[5];
  my $torify_cmd = "";
  my $cmd = "";
  if (not defined $max_tries or $max_tries eq "") {
    $max_tries = DEF_MAX_TRIES;
  }
  if (not defined $max_timeout or $max_timeout eq "") {
    $max_timeout = DEF_MAX_TIMEOUT;
  }
  if ($torify == 1) {
    $torify_cmd = "torify"
  }
  my $num = scalar(@_);

  system("sleep 1");
  if (scalar(@pages) eq 0) {
    $cmd = "$torify_cmd wget --no-check-certificate -w5 --random-wait -e robots=off -U 'mozilla'" .
      "--tries=$max_tries --timeout=$max_timeout \"$base_url\"";
    if(defined $outfile and $outfile ne "") {
      $cmd .= " -O $outfile";
    }
    `$cmd`;
  }
  else {
    foreach my $page (@pages) {
      $cmd = "$torify_cmd wget --no-check-certificate -w5 --random-wait -e robots=off -U 'mozilla'" .
        "--tries=$max_tries --timeout=$max_timeout \"$base_url$page\"";
      if(defined $outfile and $outfile ne "") {
        $cmd .= " -O $outfile-$page";
      }
      `$cmd`;
    }
  }
}

sub bubicpl_get_url_phantomjs
{
  my $base_url = $_[0];
  my $outfile = $_[1];
  my $phantom_js_file = `mktemp`;
  chomp($phantom_js_file);
  my $phantom_js_string = <<"END";
var url = '$base_url';
var page = require('webpage').create();

page.onLoadStarted = function () {
};

page.onLoadFinished = function (status) {
    console.log(page.content);
    phantom.exit();
};

page.open(url);
END
  #printf "JS STRING:=>$phantom_js_string<=\n";
  #printf "JS FILE:=>$phantom_js_file<=\n";
  #printf "OUTFILE:=>$outfile<=\n";
  open(my $fh, '>', $phantom_js_file);
  print $fh $phantom_js_string;
  close $fh;
  `phantomjs $phantom_js_file > $outfile`;
  unlink $phantom_js_file;
}

sub bubicpl_get_page_js
{
  my $base_url = $_[0];
  my @pages = @{$_[1]};
  my $outfile = $_[2];
  my $cmd = "";

  if (scalar(@pages) eq 0) {
    bubicpl_get_url_phantomjs ($base_url, $outfile);
  }
  else {
    foreach my $page (@pages) {
      my $urlpage = $base_url . "$page";
      my $outfilepage = $outfile . "-" . "$page";
      bubicpl_get_url_phantomjs ($urlpage, $outfilepage);
    }
  }
}

1;
