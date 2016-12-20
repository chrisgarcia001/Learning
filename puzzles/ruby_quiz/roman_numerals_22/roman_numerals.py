# ----------------------------------------------------------------------------------------------------------
# @author cgarcia
# About: This provides a converter between decimal and Roman numerals. It is a solution to Ruby Quiz #22:
#        http://rubyquiz.com/quiz22.html
# ----------------------------------------------------------------------------------------------------------

# Get a dict mapping key numbers to Roman Numeral values.
def decimal_to_rn_dict():
	h = {1:'I', 2:'II', 3:'III', 4:'IV', 5:'V', 6:'VI', 7:'VII', 8:'VIII', 9:'IX', 
	     10:'X', 20:'XX', 30:'XXX', 40:'XL', 50:'L', 60:'LX', 70:'LXX', 80:'LXXX', 90:'XC',
		 100:'C', 200:'CC', 300:'CCC', 400:'CD', 500:'D', 600:'DC', 700:'DCC', 800:'DCCC', 900:'CM',
		 1000:'M', 2000:'MM', 3000:'MMM'}
	return h

# Get an inverse of the above dict.	
def rn_to_decimal_dict():
	h = {}
	for (dec, rn) in decimal_to_rn_dict().items():
		h[rn] = dec
	return h

# Convert a specified decimal number to a Roman Numeral.
def decimal_to_rn(decimal):
	if decimal >= 4000 or decimal < 1:
		raise 'Decimal value must range from 1-3999 inclusively, given value was: ' + str(decimal)
	digits = map(lambda x: int(x), list(str(decimal)))
	rn = ''
	lookup = decimal_to_rn_dict()
	for i in range(len(digits)):
		v = digits[i] * (10 ** (len(digits) - i - 1))
		rn += lookup[v] if v != 0 else ''
	return rn

# For a list of prefixes and a word, find the longest matching prefix.
def longest_prefix(prefixes, word):
	matches = filter(lambda p: word.startswith(p), prefixes)
	if len(matches) == 0:
		return ''
	return reduce(lambda (p1, n1), (p2, n2): (p1, n1) if n1 > n2 else (p2, n2), map(lambda p: (p, len(p)), matches))[0]

# Convert a specified Roman Numeral to its decimal equivalent.	
def rn_to_decimal(rn):
	lookup = rn_to_decimal_dict()
	keys = lookup.keys()
	n = 0
	while rn != '':
		prefix = longest_prefix(keys, rn)
		n += lookup[prefix]
		rn = rn[len(prefix):]
	return n

# Perform a general conversion; infer incoming type.	
def convert(val):
	try:
		v = int(val)
		return decimal_to_rn(v)
	except: 
		return rn_to_decimal(val)
	