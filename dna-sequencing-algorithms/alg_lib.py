from util import *

# Get all exact match offsets for pat or its reverse complement in string.
def exact_matches(pat, string, strand_aware=True, max_mismatches=0):
	match = lambda a, b: (len(a) == len(b)) and (len(filter(lambda (x, y): x != y, zip(a, b))) <= max_mismatches)
	at_offset = lambda p, rc, s, offset: match(s[offset:offset+len(p)], p) or match(s[offset:offset+len(rc)], rc)
	p, rc = pat, pat
	if strand_aware:
		p, rc = pat, reverseComplement(pat)
	offsets = []
	for i in range(len(string)):
		#print((p,rc,string[i:i+len(p)]))
		#print((match(p,string[i:i+len(p)]), match(p,string[i:i+len(rc)])))
		if at_offset(p, rc, string, i):
			offsets.append(i)
	return offsets
		