from util import *
from alg_lib import *

def hist(itms):
	h = {}
	for itm in itms:
		if not(h.has_key(itm)):
			h[itm] = 0
		h[itm] += 1
	return h

def find_gc_by_pos(reads):
		gc = [0] * 100
		totals = [0] * 100
		for read in reads:
			if read[i] in 'GC':
				gc[i] += 1
			totals[i] += 1
		for i in range(len(gc)):
			gc[i] /= float(totals[i])
		return gc

seqs, quals = readFastq('ERR037900_1.first1000.fastq')
print('Num Sequences: '  + str(len(seqs)))


lefts = map(lambda x: exact_matches('C',x)[0], seqs)
cycles = apply(zip, map(lambda x: list(x), seqs))
print('Num Cycles: '  + str(len(cycles)))
gcs = map(lambda x: len(filter(lambda y: y in 'GC', x)), cycles)

print([('mean',sum(gcs)/float(len(gcs))), ('max',max(gcs)), ('min',min(gcs))])
#print(hist(gcs))
print('Min index: ' + str(gcs.index(min(gcs))))
#print(hist(lefts))
#for (i,s) in zip(range(len(seqs)), seqs):
#	print((i, , strand_aware_exact_matches('G',s)[0]))

	
print('------------- Q1-Q7 ---------------')	
data = readGenome('lambda_virus.fa')
print('Data length: ' + str(len(data)))
#print(data)
#print(strand_aware_exact_matches('TTAA','TTAA'))
print(exact_matches('TTAA','TTAAGGGG'))
print('Q1 - AGGTA in lambda: ' + str(len(exact_matches('AGGT',data))))
print('Q2 - TTAA in lambda: ' + str(len(exact_matches('TTAA',data))))
print('Q3 - Leftmost ACTAAGT in lambda: ' + str(exact_matches('ACTAAGT',data)[0]))
print('Q4 - Leftmost AGTCGA in lambda: ' + str(exact_matches('AGTCGA',data)[0]))
print('Q5 - TTCAAGCC in lambda (Max 2 mismatches): ' + str(len(exact_matches('TTCAAGCC',data,strand_aware=False,max_mismatches=2))))
print('Q6 - Leftmost AGGAGGTT in lambda (Max 2 mismatches): ' + str(exact_matches('AGGAGGTT',data,strand_aware=False,max_mismatches=2)[0]))
print('Q7 - Min index: ' + str(gcs.index(min(gcs))))

