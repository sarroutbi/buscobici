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
#include "string.h"
#include "Bike.h"

Bike::Bike ()
{
  memset(_trademark, 0, MAX_TRADEMARK);
  memset(_model, 0, MAX_MODEL);
  memset(_url, 0, MAX_URL);
  _type  = BIKE_TYPE_UNDEFINED;
  _price = 0;
}
  
Bike::Bike (char* trademark, char* model, char* url, float price, 
            bike_type_t type) : _price(price), _type(type)
  
{
  strncpy(_trademark, trademark, MAX_TRADEMARK);
  strncpy(_model, model, MAX_MODEL);
  strncpy(_url, url, MAX_URL);
}

Bike::~Bike ()
{
  ;
}
