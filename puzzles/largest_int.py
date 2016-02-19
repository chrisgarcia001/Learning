# This solves the largest integer problem: From a set of integers,
# construct the largest integer possible by concatenating them into one.
# Challenge found here: http://rosettacode.org/wiki/Largest_int_from_concatenated_ints

# Score an integer - the closer it is to the maximum for its number of digits
# the higher the score.
def score(integer):
	digits = len(str(integer))
	max_num = (10 ** digits) - 1
	return float(integer) / float(max_num)

# Construct the largest integer and return it (as an int or long)	
def largest_integer(integers):
	seq = map(lambda z: str(z), sorted(integers, key=lambda a: score(a)))
	seq.reverse()
	return int(reduce(lambda x,y: x + y, seq + ['']))
	
