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
#include <stdint.h>

const uint16_t MAX_TRADEMARK = 255;
const uint16_t MAX_MODEL     = 255;
const uint16_t MAX_URL       = 255;
enum bike_type_t
{
  BIKE_TYPE_MTB=0, 
  BIKE_TYPE_ROAD=1, 
  BIKE_TYPE_URBAN=2,
  BIKE_TYPE_BMX=3,
  BIKE_TYPE_KIDS=4,
  BIKE_TYPE_UNDEFINED=255
};

class Bike
{
public:

  Bike ();
  Bike (char* trademark, char* model, char* url, float price, bike_type_t type);
 ~Bike ();
private:
  char  _trademark[MAX_TRADEMARK];
  char  _model    [MAX_MODEL];
  char  _url      [MAX_URL];
  float _price; 
  bike_type_t _type;
};
