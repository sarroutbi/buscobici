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
#include <stdio.h>

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
  memset(_type, 0, MAX_TYPE);
  _price = 0;
}
  
Bike::Bike (const char* trademark, const char* model, 
            const char* url, const char* store,
            const char* url_type, float price, const char* type) : 
            _price(price)
{
  strncpy(_trademark, trademark, MAX_TRADEMARK);
  strncpy(_model, model, MAX_MODEL);
  strncpy(_store, store, MAX_STORE);
  strncpy(_url, url, MAX_URL);
  strncpy(_type, type, MAX_TYPE);
}

void Bike::log ()
{
  cout << "=================== BIKE =================" << endl;
  cout << "Trademark:" << _trademark << endl;
  cout << "Model    :" << _model     << endl;
  cout << "Store    :" << _store     << endl;
  cout << "URL      :" << _url       << endl;
  cout << "URL Text :" << _url_text  << endl;
  printf ("Price    :%.2f\n", _price);
  cout << "Type     :" << _type      << endl;
  cout << "================== /BIKE =================" << endl;
}

void Bike::set(const char* trademark, const char* model, const char* store,
               const char* url, const char* url_text, float price, 
               const char* type)
{
  _price = price;
  strncpy(_trademark, trademark, MAX_TRADEMARK);
  strncpy(_model, model, MAX_MODEL);
  strncpy(_store, store, MAX_STORE);
  strncpy(_url, url, MAX_URL);
  strncpy(_url_text, url_text, MAX_URL_TEXT);
  strncpy(_type, type, MAX_TYPE);
}

Bike::~Bike ()
{
  ;
}
