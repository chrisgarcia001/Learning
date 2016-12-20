# ----------------------------------------------------------------------------------------------------------
# @author cgarcia
# About: Provides a quick-and-dirty test for Roman Numeral converter. See Ruby Quiz #22:
#        http://rubyquiz.com/quiz22.html
# ----------------------------------------------------------------------------------------------------------

from roman_numerals import *

prefixes = ['a', 'b', 'ab', 'ba', 'abc', 'dab', 'dabc']
print(longest_prefix(prefixes, 'abcde'))

print('')
vals = ['III', 29, 38, 'CCXCI', 1999, 'MCMXV', 89, 97, 979, 899, 889, 888, 4, 900, 1001, 2094]
for v in vals:
	print(v, convert(v), convert(convert(v)))

