from util import *

def strand_aware_exact_match(pat, string):
	at_offset = lambda p, rc, s, offset: s[offset:].startswith(p) or s[offset:].startswith(rc)
	p, rc = list(set(pat, reverseComplement(string)))
	offsets = []
	for i in range(len(string) - len(pat)):
		if at_offset(p, rc, string, i):
			offsets.append(i)
	return offsets
		