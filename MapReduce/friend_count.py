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
    

def reducer(key, list_of_values):
    # key: person name
    # value: 1
    mr.emit( (key, len(list_of_values) ) )    

# Do not modify below this line
# =============================
if __name__ == '__main__':
  inputdata = open(sys.argv[1])
  mr.execute(inputdata, mapper, reducer)