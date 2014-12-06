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
  my $cmd = "";
  if (not defined $max_tries or $max_tries eq "") {
    $max_tries = DEF_MAX_TRIES;
  }
  if (not defined $max_timeout or $max_timeout eq "") {
    $max_timeout = DEF_MAX_TIMEOUT;
  }
  my $num = scalar(@_);

  system("sleep 1");
  if (scalar(@pages) eq 0) {
    $cmd = "wget -w5 --random-wait -e robots=off -U 'mozilla'" .
      "--tries=$max_tries --timeout=$max_timeout \"$base_url\"";
    if(defined $outfile and $outfile ne "") {
      $cmd .= " -O $outfile";
    }
    `$cmd`;
  }
  else {
    foreach my $page (@pages) {
      $cmd = "wget -w5 --random-wait -e robots=off -U 'mozilla'" .
        "--tries=$max_tries --timeout=$max_timeout \"$base_url$page\"";
      if(defined $outfile and $outfile ne "") {
        $cmd .= " -O $outfile-$page";
      }
      `$cmd`;
    }
  }
}
1;
