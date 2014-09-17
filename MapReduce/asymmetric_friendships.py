#!/usr/bin/python
# -*- coding: utf-8 -*-.

import MapReduce
import sys

"""
Friend count in the Simple Python MapReduce Framework
"""

mr = MapReduce.MapReduce()

# =============================
# Do not modify above this line

def mapper(record):
    # key: person name
    # value: person befriended
    key = record[0] 
    value = record[1]
    mr.emit_intermediate(key, value)
    mr.emit_intermediate(value, key)
    

def reducer(key, list_of_values):
    # key: person name
    # list_of_values: list of names related in one way with key
    temp = []
    for name in list_of_values:
        if name not in temp:
            if list_of_values.count(name) < 2:
                mr.emit((key, name))

# Do not modify below this line
# =============================
if __name__ == '__main__':
  inputdata = open(sys.argv[1])
  mr.execute(inputdata, mapper, reducer)