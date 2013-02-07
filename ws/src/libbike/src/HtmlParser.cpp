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
#include <stdint.h>
#include <stdio.h>
#include <string.h>
#include <list>
#include <iostream>

#include "HtmlParser.h"

using namespace std;

HtmlParser::HtmlParser ()
{
  memset(_file, 0, FILENAME_MAX);
}

HtmlParser::HtmlParser (const char* file)
{
  setFile(file);
}

void HtmlParser::setFile(const char* file)
{
  if(file)
    strncpy(_file, file, FILENAME_MAX);
}

HtmlParser::~HtmlParser ()
{
  _bikeList.clear();
}

uint8_t HtmlParser::dummyBikeFill (Bike* bike)
{
  if(bike)
    bike->set("Specialized", "2013", "http://test.com/test-url", "Specialized 2013", 999.12345, BIKE_TYPE_MTB);
}

uint8_t HtmlParser::parseABike (const char* htmlPiece, uint32_t htmlPieceSize, Bike* bike)
{
  uint8_t err = 0;
  /* Each html piece of each bike is of the type: */
  /* <tr>
   *   <td> Trademark </td>
   *   <td> Model </td>
   *   <td> Type  </td>
   *   <td> Price  </td>
   *   <td><a href="http://url.com/the_url">URL TEXT</a></td>
   * </tr>
   */

  if(bike)
  {
    dummyBikeFill(bike);
  }
  else
  {
    err = 1;         
  }
  return err;
}

void HtmlParser:: logList ()
{  
  BikeList::iterator i; 

  for(i = _bikeList.begin(); i != _bikeList.end(); ++i)
    (*i).log();
}

uint8_t HtmlParser::parse ()
{
  uint8_t err = 0;
  Bike b;
  Bike b2;
  parseABike(NULL, 0, &b);
  parseABike(NULL, 0, &b2);
  _bikeList.push_front(b);
  _bikeList.push_front(b2);
  return err;
}

uint8_t HtmlParser::parse (const char* file)
{
  uint8_t err = 1;
  if(file)
  {
    setFile(file);
    err = parse();
  }
  return err;
}

const BikeList & HtmlParser::getList ()
{
  parse(_file);
  return _bikeList;
}
