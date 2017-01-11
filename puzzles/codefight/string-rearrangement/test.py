# Author: cgarcia
# This is a test driver for the stringsRearrangement function.

from strings_rearrangement import *

inputs = [["aba", "bbb", "bab"],
          ["ab", "bb", "aa"],
		  ["q", "q"],
		  ["zzzzab",  "zzzzbb", "zzzzaa"],
		  ["abc", "abx", "axx", "abx", "abc"],
		  ["f", "g", "a", "h"]]

		  
for i in inputs:
	print(build_graph(i))
	print(stringsRearrangement(i))
	
