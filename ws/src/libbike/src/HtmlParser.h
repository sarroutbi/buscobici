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

#ifndef __HTML_PARSER_H__
#define __HTML_PARSER_H__

#include <stdint.h>
#include <stdlib.h>

#include "Bike.h"

class HtmlParser
{
public:
          HtmlParser  ();
          HtmlParser  (const char* file);
         ~HtmlParser  ();
  void    setFile     (const char* file);
  uint8_t parse       ();
  uint8_t parse       (const char* file);
  void    logList     ();

  const BikeList & getList       ();
  uint8_t          dummyBikeFill (Bike* bike);

private:
  uint8_t parseABike (const char* htmlPiece, uint32_t htmlPieceSize, Bike* bike);

  char _file[FILENAME_MAX];
  BikeList _bikeList;
};
#endif // __HTML_PARSER_H__
