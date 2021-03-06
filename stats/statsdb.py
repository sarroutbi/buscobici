#!/usr/bin/python
#
# Copyright (c) 2012-2013 Sergio Arroutbi Braojos <sarroutbi@gmail.com>
# 
# Permission to use, copy, modify, and/or distribute this software 
# for any purpose with or without fee is hereby granted, provided that 
# the above copyright notice and this permission notice appear in all copies.
# 
# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES 
# WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY 
# AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, 
# INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM 
# LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, 
# NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE 
# OR PERFORMANCE OF THIS SOFTWARE.
#
#
#
import psycopg2
import sys
import getopt

default_db="bikesearch"
default_dbuser="postgres"
default_dbpasswd="postgres"
default_dbtable="bikes"
default_hostname="localhost"
default_stat="all"
default_extra=""

def parse_args(opts, args):
  database = default_db
  hostname = default_hostname
  dbuser   = default_dbuser
  dbpasswd = default_dbpasswd
  dbtable  = default_dbtable
  store    = ""
  stat     = default_stat
  extra    = default_extra
  for opt, arg in opts:
    if opt == '-h':
      print_usage()
      sys.exit(0)
    elif opt in ("-d", "--database"):
      database = arg
    elif opt in ("-t", "--table"):
      dbtable = arg
    elif opt in ("-h", "--hostname"):
      hostname = arg
    elif opt in ("-u", "--dbuser"):
      dbuser = arg
    elif opt in ("-s", "--store"):
      store = arg
    elif opt in ("-p", "--password"):
      dbpasswd = arg
    elif opt in ("-e", "--extra_stat_data"):
      extra = arg
    elif opt in ("-S", "--stat"):
      stat = arg

  #print 'database is :', database
  #print 'table    is :', dbtable
  #print 'hostname is :', hostname
  #print 'dbuser   is :', dbuser
  #print 'store    is :', store
  #print 'password is :', dbpasswd
  #print 'stat     is :', stat
  #print 'extra is :', extra
 
  return database, dbtable, hostname, dbuser, store, dbpasswd, stat, extra
   
def print_usage(command):
  print command + ":" 
  print '             ' + command + ' [-d <database> -u <user> -h<dbhost> -S<stat> -e<extra_stat_data>] -s<store> -p<password>'
  print '             Valid stats: all, nummodels, meanprice, modelsbytype, modelsbypricerange' 
  print 

def print_stat(cur, table, store, stat, extra):
  if stat == "all":
    get_models(cur, table, store, extra)
    get_meanprice(cur, table, store, extra)
    get_models_bytype(cur, table, store)
  elif stat == "nummodels":
    get_models(cur, table, store, extra)
  elif stat == "meanprice":
    get_meanprice(cur, table, store, extra)
  elif stat == "modelsbytype":
    get_models_bytype(cur, table, store)
  elif stat == "modelsbypricerange":
    get_models_bypricerange(cur, table, store)

def get_meanprice(cur, table, store, type): 
  if store == "all": 
    cur.execute("SELECT DISTINCT store FROM " + table + " WHERE kind ~ '" + type + "'")
    stores = cur.fetchall()
    for store in stores:
      get_meanprice(cur, table, store[0], type)
    return 0
  elif store == "Total": 
    cur.execute("SELECT AVG(price) FROM " + table )
  else:
    cur.execute("SELECT AVG(price) FROM " + table + " WHERE store LIKE '" 
                + store + "'" + " AND kind ~ '" + type + "'")

  for record in cur:
    price = record

  #print 'Mean price of store is:%d' % price[0]
  if price and price[0] and price[0] > 0:
    print '\"' + store + '\", %d ' % price[0]

def dump_models_type(cur, table, type):
  cur.execute("SELECT COUNT(*) FROM " + table + " WHERE kind ~ '" + kind + "'")
  for record in cur:
    num_models = record 

  #print 'Num models number of type:%s is:%d' % (type, num_models[0])
  if num_models:
    print ", %d" % num_models[0],

def dump_store_models_type(cur, table, store, type):
  cur.execute("SELECT COUNT(*) FROM " + table + " WHERE kind ~ '" + type + "'"\
              + " AND store LIKE '" + store +"'")
  for record in cur:
    num_models = record 

  #print 'Num models number of type:%s,store:%s, is:%d' % (type, store, num_models[0])
  if num_models:
    print ", %d" % num_models[0],

def dump_store_models(cur, table, store):
  cur.execute("SELECT COUNT(*) FROM " + table + " WHERE store LIKE '" + store + "'")
    
  for record in cur:
    num_models = record 

  #print 'Num models number of store:%s, is:%d' % (store, num_models[0])
  if num_models:
    print ", %d" % num_models[0],

def dump_store_models_pricerange(cur, table, store, pricerange):
  minprice, maxprice = pricerange.split("-", 1)
  cur.execute("SELECT COUNT(*) FROM " + table + " WHERE price > " + minprice \
    + "AND price <= " + maxprice + " AND store LIKE '" + store +"'")
  for record in cur:
    num_models = record

  #print 'Num models number of pricerange:%s,store:%s, is:%d' % (pricerange, store, num_models[0])
  if num_models:
    print ", %d" % num_models[0],
  else:
    print ", %0"

def get_models_bytype(cur, table, store): 
  #print 
  #print 'Dumping models by type of store:' + store
  #print
  types = ['MTB','ROAD','URBAN','BMX','KIDS'];

  if store == "all": 
    cur.execute("SELECT DISTINCT store FROM " + table)
    stores = cur.fetchall()
    for store in stores:
      get_models_bytype(cur, table, store[0])
    return 0
  else:
    if store != "Total" and store != "":
      print '\"' + store + '\"',
      for type in types:
        if store == "Total":
          dump_models_type(cur, table, type)
        elif store != "":
          dump_store_models_type(cur, table, store, type)
      dump_store_models(cur, table, store)
      print 

def get_models_bypricerange(cur, table, store): 
  #print 
  #print 'Dumping models by range of store:' + store
  #print
  ranges = ['0-500','500-750','750-1000','1000-1500','1500-2000','2000-2500','2500-3000','3000-5000','5000-30000'];
  if store == "all":
    cur.execute("SELECT DISTINCT store FROM " + table)
    stores = cur.fetchall()
    for store in stores:
      get_models_bypricerange(cur, table, store[0])
    return 0
  else:
    if store != "Total" and store != "":
      print '\"' + store + '\"',
      for range in ranges:
        if store == "Total":
          dump_models_pricerange(cur, table, range)
        elif store != "":
          dump_store_models_pricerange(cur, table, store, range)
      dump_store_models(cur, table, store)
      print

def get_models(cur, table, store, type): 
  #print 
  #print 'Dumping models number of store:' + store
  #print 'With extra type:' + type
  #print
  if type == "": 
    sql_type = ''
  else: 
    sql_type = type

  if store == "all": 
    cur.execute("SELECT DISTINCT store FROM " + table)
    stores = cur.fetchall()
    for store in stores:
      get_models(cur, table, store[0], type)
    return 0
  elif store == "Total": 
    cur.execute("SELECT COUNT(*) FROM " + table + "AND kind ~ '" + sql_type + "'")
  else:
    cur.execute("SELECT COUNT(*) FROM " + table + " WHERE store LIKE '" + store + "'" + "AND kind ~ '" + sql_type + "'")

  for record in cur:
    num_models = record

  #print 'Num models number of store is:%d' % num_models[0]
  if num_models:
    print '\"' + store + '\", %d ' % num_models[0]

def main(argv):
  try:
    opts, args = getopt.getopt(argv[1:],"hd:h:u:s:p:S:e:",["database=","hostname=","user=","store=","password=","stat=", "extra="])
  except getopt.GetoptError:
    print "Exception!"
    print_usage(argv[0])
    sys.exit(2)
 
  db, table, hostname, dbuser, store, password, stat, extra = parse_args(opts, args)

  if store == "":
    print ''
    print 'Please, specify the store where to extract statistics (\'Total\' for all stores)!'
    print ''
    print_usage(argv[0])
    sys.exit(3)

  # Connect to an existing DB
  conn = psycopg2.connect("dbname=" + db + " host=" + hostname + " user=" + dbuser + " password=" + password)

  # Obtain the cursor to the Database
  cur = conn.cursor()

  print_stat(cur, table, store, stat, extra)

if __name__ == "__main__":
   main(sys.argv[0:])
