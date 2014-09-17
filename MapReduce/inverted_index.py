#!/usr/bin/python
# -*- coding: utf-8 -*-.

import MapReduce
import sys

"""
Inverted index in the Simple Python MapReduce Framework
"""

mr = MapReduce.MapReduce()

# =============================
# Do not modify above this line

def mapper(record):
    # key: document identifier
    # value: document contents
    key = record[0]
    value = record[1]
    words = value.split()
    for w in words:
      mr.emit_intermediate(w, key)
      

def reducer(key, list_of_values):
    # key: word
    # value: list of documents where the word appears
    s = set()
    for v in list_of_values:
      s.add(v)
    mr.emit((key, [k for k in s]))

# Do not modify below this line
# =============================
if __name__ == '__main__':
  inputdata = open(sys.argv[1])
  mr.execute(inputdata, mapper, reducer)
