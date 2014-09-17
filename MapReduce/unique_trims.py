#!/usr/bin/python
# -*- coding: utf-8 -*-.

import MapReduce
import sys

"""
Unique trimming in the Simple Python MapReduce Framework
"""

mr = MapReduce.MapReduce()

# =============================
# Do not modify above this line

def mapper(record):
    # key: person name
    # value: person befriended
    key = record[0] 
    value = record[1]
    trimmed = value[0:-10]
    mr.emit_intermediate(1, trimmed)
    

def reducer(key, list_of_values):
    # key: person name
    # list_of_values: list of names related in one way with key

    #Sets automatically exclude duplicate terms
    temp = set()
    for sequence in list_of_values:        
        temp.add(sequence)    
            
    for uniqueSequence in temp:        
        mr.emit(uniqueSequence)
                

# Do not modify below this line
# =============================
if __name__ == '__main__':
  inputdata = open(sys.argv[1])
  mr.execute(inputdata, mapper, reducer)