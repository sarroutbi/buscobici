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

#ifndef __HTML_GETTER_H__
#define __HTML_GETTER_H__

#include <stdint.h>
#include <stdlib.h>

const uint16_t MAX_CURL_URL=512;

class HtmlGetter
{
public:
  HtmlGetter ();
  HtmlGetter (char* url = NULL);
  HtmlGetter (char* url = NULL, char* post = NULL);
 ~HtmlGetter ();
  uint8_t DumpHtml (char* outFile);
private:
  char _url[MAX_CURL_URL];
  char _post[MAX_CURL_URL];
};
#endif // __HTML_GETTER_H__
