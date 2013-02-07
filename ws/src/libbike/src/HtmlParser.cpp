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
#include <stdlib.h>
#include <string.h>
#include <list>
#include <iostream>

#include "HtmlParser.h"

using namespace std;

inline void trim(const char* cstr, char* trimmed, 
                 uint32_t trim_length)
{
  std::string str(cstr);
  str.erase(0, str.find_first_not_of(' '));
  str.erase(str.find_last_not_of(' ')+1);
  strncpy(trimmed, str.c_str(), trim_length);
}

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
    bike->set("Specialized", "2013", "http://test.com/test-url", "TheStore",
              "Specialized 2013", (rand()*999), BIKE_TYPE_MTB);
}

uint8_t HtmlParser::parseABike (const char* htmlPiece, uint32_t htmlPieceSize, Bike* bike)
{
  uint8_t err = 0;
  char trademark[MAX_TRADEMARK] = "";
  char model    [MAX_MODEL]     = "";
  char store    [MAX_STORE]     = "";
  char c_type   [MAX_TYPE]      = "";
  char c_price  [MAX_PRICE]     = "";
  char url      [MAX_URL]       = "";
  char url_text [MAX_URL_TEXT]  = "";
  char url_all  [MAX_HTML_PIECE_LINE] = "";
  float       price = 0;
  bike_type_t type  = BIKE_TYPE_UNDEFINED;
  /* Each html piece of each bike is of the type:
   *   <td> Trademark </td>
   *   <td> Model </td>
   *   <td> Type  </td>
   *   <td> Price </td>
   *   <td> Store </td>
   *   <td><a href="http://url.com/the_url">URL TEXT</a></td>
   */
  char piece[MAX_HTML_PIECE];
  strncpy(piece, htmlPiece, MAX_HTML_PIECE);

  if(bike)
  {
    char* now = piece;
    while(now = strstr(now, "<td>"))
    {
      now += strlen("<td>");
      if(!strlen(trademark))
      {
        sscanf(now, "%[^<]</td>", trademark);
        now += strlen(trademark);
      }
      else if(!strlen(model))
      {
        sscanf(now, "%[^<]</td>", model);
        now += strlen(model);
      }
      else if(!strlen(c_type))
      {
        sscanf(now, "%[^<]</td>", c_type);
        now += strlen(c_type);
      }
      else if(!strlen(c_price))
      {
        sscanf(now, "%[^<]</td>", c_price);
        now += strlen(c_price);
        price = strtod(c_price, NULL);
      }
      else if(!strlen(store))
      {
        sscanf(now, "%[^<]</td>", store);
        now += strlen(model);
      }
      else if(!strlen(url_all))
      {
        sscanf(now, "%[^<]</td>", url_all);
        now += strlen(model);
      }
      else
      {
        break;
      }
      now += strlen("</td>");
    }
    bike->set(trademark, model, store, url, url_text, price, type);
  }
  else
  {
    err = 1;
  }
  return err;
}

uint16_t 
HtmlParser::getHtmlPiece (FILE* f, char* htmlPiece, const uint16_t maxHtml)
{
  uint16_t read = 0;
  bool pieceStart = false;
  bool finish = false;
  if(f && htmlPiece)
  {
    char line[MAX_HTML_PIECE_LINE];
    char trimmedLine[MAX_HTML_PIECE_LINE];
    uint16_t piecePending = MAX_HTML_PIECE_LINE;

    while((fgets(line, MAX_HTML_PIECE, f)) && (!finish) 
          && (read <= maxHtml))
    {
      if (strstr(line, "<tr>"))
      {
         pieceStart = true;
      }
      else if(pieceStart && strstr(line, "</tr>"))
      {
         pieceStart = false;
        finish = true;
      }
      else if(pieceStart)
      {
        piecePending -= strlen(line);
        read += strlen(line);
        strncat(htmlPiece, line, piecePending);
      }
    }
  }
  return read;
}

void HtmlParser:: logList ()
{  
  BikeList::iterator i; 

  for(i = _bikeList.begin(); i != _bikeList.end(); ++i)
    (*i).log();
}

uint8_t HtmlParser::parse ()
{
  uint8_t  err = 0;
  uint16_t pieceLength = 0;
  FILE*    f = fopen(_file, "r");
  char     htmlPiece[MAX_HTML_PIECE];

  memset(htmlPiece, 0, MAX_HTML_PIECE);

  if(!f)
  {
    err = 1;
  }
  else 
  { 
    while((pieceLength = getHtmlPiece(f, htmlPiece, MAX_HTML_PIECE))>0)
    {
      //fprintf(stderr, "Read html piece of [%d] bytes, =>%s<=\n", 
      //        pieceLength, htmlPiece);
      Bike bike;
      parseABike(htmlPiece, pieceLength, &bike);
      memset(htmlPiece, 0, MAX_HTML_PIECE);
      _bikeList.push_back(bike);
    }
    fclose(f);
  }
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
