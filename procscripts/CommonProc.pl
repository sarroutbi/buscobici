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
my $TRADEMARK_KEY="TRADEMARK";
my $SUBURL_KEY="SUBURL";
my $STORE_KEY="STORE";
my $PRICE_KEY="PRICE";
my $KIND_KEY="KIND";

sub dump_bash_bubic {
  my $camel_model = $_[0];
  my $url = $_[1];
  my $camel_trademark = $_[2];
  my $price = $_[3];
  my $store = $_[4];
  my $type  = $_[5];

  if ($camel_model eq "" || $url eq "" || $camel_trademark eq "" ||
      $price eq "" || $store eq "" || $type eq "") {
    return 0;
  }

  #printf "\nCAMEL_MODEL:$camel_model\n" ;
  #printf "CAMEL_TRADEMARK:$camel_trademark\n" ;
  #printf "URL:$url\n" ;
  #printf "PRICE:$price\n" ;
  #printf "STORE:$store\n" ;
  #printf "TYPE:$type\n" ;

  my $dump_command = sprintf("bash -c 'source ./common_proc; " .
"SUBURL_KEY=$SUBURL_KEY " .
"TRADEMARK_KEY=$TRADEMARK_KEY " .
"PRICE_KEY=$PRICE_KEY " .
"STORE_KEY=$STORE_KEY " .
"KIND_KEY=$KIND_KEY " .
"bubic_dump_bike \"$camel_model\" \"$url\" \"$camel_trademark\" $price " .
"\"$store\" \"$type\"' >> %s",
      OUTPUT_FILE);
  #print "Executing command:=>$dump_command<=\n";
  `$dump_command`;
  return 0;
}
