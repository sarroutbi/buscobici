/**
 * Copyright © 2012-2013 Sergio Arroutbi Braojos <sarroutbi@gmail.com>
 * 
 * Permission to use, copy, modify, and/or distribute this software 
 * for any purpose with or without fee is hereby granted, provided that 
 * the above copyright notice and this permission notice appear in all copies.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES 
 * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY 
 * AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, 
 * INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM 
 * LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, 
 * NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE 
 * OR PERFORMANCE OF THIS SOFTWARE.
 **/

#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include "HtmlGetter.h"
#include "HtmlParser.h"

const char* DEFAULT_FILE = "/tmp/file.html";
const bool  DEFAULT_DUMP = false;

void usage(const char* argv, int8_t err)
{
  fprintf(stderr, "\n");
  fprintf(stderr, "%s -u \"url\" -p \"post_data\" [-o]\n", argv);
  fprintf(stderr, "\n");
  exit(err);
}

void stderr_error(const char* argv, const char* err, int8_t ret)
{
  fprintf(stderr, "\n");
  fprintf(stderr, "%s", err);
  fprintf(stderr, "\n");
  usage(argv, ret);
}

int main(int argc, char** argv)
{
  char    dumpFile[FILENAME_MAX] = "";
  char    url     [MAX_URL] = "";
  char    post    [MAX_URL] = "";
  bool    dump = DEFAULT_DUMP;
  char*   dumpFile_p = NULL;
  int8_t  c = 0;
  uint8_t opterr = 0;
     
  while ((c = getopt (argc, argv, "of:u:p:")) != -1)
  {
    switch (c)
    {
      case 'o':
        dump = true;
        break;
      case 'u':
        strncpy(url, optarg, MAX_URL);
        break;
      case 'f':
        strncpy(dumpFile, optarg, FILENAME_MAX);
        break;
      case 'p':
        strncpy(post, optarg, MAX_URL);
        break;
      case '?':
        if (optopt == 'c')
          fprintf (stderr, "Option -%c requires an argument.\n", optopt);
        else 
          fprintf (stderr, "Unknown option `-%c'.\n", optopt);
      default:
        usage (argv[0], 1);
    }
  } 
  if (!strlen(url))
  {
    stderr_error(argv[0], "Please provide a URL \n", 1);
  }
  else if(!strlen(post))
  {
    stderr_error(argv[0], "Please provide the data to post\n", 1);
  }
  else
  {
    HtmlGetter hg(url, post);

    if (strlen(dumpFile)) 
      dumpFile_p = dumpFile;
    else 
      dumpFile_p = const_cast<char*>(DEFAULT_FILE);

    if(hg.DumpHtml(dumpFile_p))
    {
      fprintf(stderr, "Error Dumping Html File\n");
    }
    else
    {
      HtmlParser hp(dumpFile_p);
      if(hp.parse())
      {
        fprintf(stderr, "Error Parsing Html File\n");
      }
      else if(dump)
      {
        hp.logList();
      }
      return 0;
    }
  }
  return 1;
}
