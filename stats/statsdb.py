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

def parse_args(opts, args):
  database = default_db
  hostname = default_hostname
  dbuser   = default_dbuser
  dbpasswd = default_dbpasswd
  dbtable  = default_dbtable
  store    = ""
  stat     = default_stat
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
    elif opt in ("-S", "--stat"):
      stat = arg

  #print 'database is :', database
  #print 'table    is :', dbtable
  #print 'hostname is :', hostname
  #print 'dbuser   is :', dbuser
  #print 'store    is :', store
  #print 'password is :', dbpasswd
  #print 'stat     is :', stat
 
  return database, dbtable, hostname, dbuser, store, dbpasswd, stat
   
def print_usage(command):
  print command + ":" 
  print '             ' + command + ' [-d <database> -u <user> -h<dbhost> -S<stat>] -s<store> -p<password>'
  print '             Valid stats: all, nummodels, meanprice, modelsbytype' 
  print 

def print_stat(cur, table, store, stat):
  if stat == "all":
    get_models(cur, table, store)
    get_meanprice(cur, table, store)
  elif stat == "nummodels":
    get_models(cur, table, store)
  elif stat == "meanprice":
    get_meanprice(cur, table, store)
  elif stat == "modelsbytype":
    get_models_bytype(cur, table, store)

def get_meanprice(cur, table, store): 
  if store == "all": 
    cur.execute("SELECT DISTINCT store FROM " + table)
    stores = cur.fetchall()
    for store in stores:
      get_meanprice(cur, table, store[0])
    return 0
  elif store == "Total": 
    cur.execute("SELECT AVG(price) FROM " + table )
  else:
    cur.execute("SELECT AVG(price) FROM " + table + " WHERE store LIKE '" + store + "'")

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
    print ",%d" % num_models[0],

def dump_store_models_type(cur, table, store, type):
  cur.execute("SELECT COUNT(*) FROM " + table + " WHERE kind ~ '" + type + "'"\
    + " AND store LIKE '" + store +"'")
  for record in cur:
    num_models = record 

  #print 'Num models number of type:%s,store:%s, is:%d' % (type, store, num_models[0])
  if num_models:
    print ",%d" % num_models[0],

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
  print 

def get_models(cur, table, store): 
  #print 
  #print 'Dumping models number of store:' + store
  #print
  if store == "all": 
    cur.execute("SELECT DISTINCT store FROM " + table)
    stores = cur.fetchall()
    for store in stores:
      get_models(cur, table, store[0])
    return 0
  elif store == "Total": 
    cur.execute("SELECT COUNT(*) FROM " + table )
  else:
    cur.execute("SELECT COUNT(*) FROM " + table + " WHERE store LIKE '" + store + "'")

  for record in cur:
    num_models = record

  #print 'Num models number of store is:%d' % num_models[0]
  if num_models:
    print '\"' + store + '\", %d ' % num_models[0]

def main(argv):
  try:
    opts, args = getopt.getopt(argv[1:],"hd:h:u:s:p:S:",["database=","hostname=","user=","store=","password=","stat="])
  except getopt.GetoptError:
    print_usage(argv[0])
    sys.exit(2)
 
  db, table, hostname, dbuser, store, password, stat = parse_args(opts, args)

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

  print_stat(cur, table, store, stat)

if __name__ == "__main__":
   main(sys.argv[0:])
