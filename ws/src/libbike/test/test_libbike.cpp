/**
 * Copyright © 2012-2013 Sergio Arroutbi Braojos <sarroutbi@gmail.com>
 * 
 * Permission to use, copy, modify, and/or distribute this software 
 * for any purpose with or without fee is hereby granted, provided that 
 * the above copyright notice and this permission notice appear in all copies.
 * 
 * THE SOFTWARE IS PROVIDED âAS ISâ AND THE AUTHOR DISCLAIMS ALL WARRANTIES 
 * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY 
 * AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, 
 * INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM 
 * LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, 
 * NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE 
 * OR PERFORMANCE OF THIS SOFTWARE.
 **/

#include <stdlib.h>
#include <stdio.h>
#include "HtmlGetter.h"
#include "HtmlParser.h"

#define DEFAULT_FILE "/tmp/file.html"

int main(int argc, char* argv[])
{
  char* dumpFile = NULL;

  if ((argc<2) || (!argv[1]))
  {
    fprintf(stderr, "Please provide a URL \n");
  }
  else if((argc<3) || (!argv[2]))
  {
    fprintf(stderr, "Please provide the data to post\n");
  }
  else
  {
    HtmlGetter hg(argv[1], argv[2]);

    if ((argc > 3) && argv[3]) 
      dumpFile = argv[3];
    else 
      dumpFile = DEFAULT_FILE;

    if(hg.DumpHtml(dumpFile))
    {
      fprintf(stderr, "Error Dumping Html File\n");
    }
    else
    {
      HtmlParser hp(dumpFile);
      if(hp.parse())
      {
        fprintf(stderr, "Error Parsing Html File\n");
      }
      else
      {
        hp.logList();
      }
      return 0;
    }
  }
  return 1;
}
