#!/usr/bin/python
# -*- coding: utf-8 -*-.

import MapReduce
import sys

"""
Relational join in the Simple Python MapReduce Framework
"""

mr = MapReduce.MapReduce()

# =============================
# Do not modify above this line

def mapper(record):
    # key: order_id
    # value: columns of record
    typ = record[0] #type
    key = record[1]
    mr.emit_intermediate(key, record)
    

def reducer(key, list_of_values):
    # key: order_id
    # value: list of orders, lineitems with that key
    order = list_of_values[0]
    for line_item in list_of_values[1:]:
      mr.emit(order + line_item)
    print (key, order + line_item)

# Do not modify below this line
# =============================
if __name__ == '__main__':
  inputdata = open(sys.argv[1])
  mr.execute(inputdata, mapper, reducer)
