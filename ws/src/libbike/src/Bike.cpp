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
#include <iostream>
#include <limits>

#include "string.h"
#include "Bike.h"

using namespace std;
using std::numeric_limits;

Bike::Bike ()
{
  memset(_trademark, 0, MAX_TRADEMARK);
  memset(_model, 0, MAX_MODEL);
  memset(_store, 0, MAX_STORE);
  memset(_url, 0, MAX_URL);
  memset(_url_text, 0, MAX_URL_TEXT);
  _type  = BIKE_TYPE_UNDEFINED;
  _price = 0;
}
  
Bike::Bike (const char* trademark, const char* model, 
            const char* url, const char* store,
            const char* url_type, float price, bike_type_t type) : 
            _price(price), _type(type)  
{
  strncpy(_trademark, trademark, MAX_TRADEMARK);
  strncpy(_model, model, MAX_MODEL);
  strncpy(_store, store, MAX_STORE);
  strncpy(_url, url, MAX_URL);
}

void Bike::log ()
{
  cout << "=================== BIKE =================" << endl;
  cout << "Trademark:" << _trademark << endl;
  cout << "Model    :" << _model     << endl;

  cout << "URL      :" << _url       << endl;
  cout << "URL Text :" << _url_text  << endl;
  cout.precision(numeric_limits<double>::digits10 + 1);
  cout << "Price    :" << _price << endl;
  cout << "Type     :" << _type      << endl;
  cout << "================== /BIKE =================" << endl;
}

void Bike::set(const char* trademark, const char* model, const char* store,
               const char* url, const char* url_text, float price, 
               bike_type_t type)
{
  _price = price;
  _type  = type;
  strncpy(_trademark, trademark, MAX_TRADEMARK);
  strncpy(_model, model, MAX_MODEL);
  strncpy(_store, store, MAX_STORE);
  strncpy(_url, url, MAX_URL);
  strncpy(_url_text, url_text, MAX_URL_TEXT);
}

Bike::~Bike ()
{
  ;
}
