from util import *
from alg_lib import *

data = readGenome('lambda_virus.fa')
print('Data length: ' + str(len(data)))
#print(data)
#print(strand_aware_exact_matches('TTAA','TTAA'))
print(strand_aware_exact_matches('TTAA','TTAAGGGG'))
print('Q1 - AGGTA in lambda: ' + str(len(strand_aware_exact_matches('AGGT',data))))
print('Q2 - TTAA in lambda: ' + str(len(strand_aware_exact_matches('TTAA',data))))
print('Q3 - Leftmost ACTAAGT in lambda: ' + str(strand_aware_exact_matches('ACTAAGT',data)[0]))
print('Q4 - Leftmost AGTCGA in lambda: ' + str(strand_aware_exact_matches('AGTCGA',data)[0]))
print('Q5 - TTCAAGCC in lambda (Max 2 mismatches): ' + str(len(strand_aware_exact_matches('TTCAAGCC',data,2))))
print('Q6 - AGGAGGTT in lambda (Max 2 mismatches): ' + str(len(strand_aware_exact_matches('AGGAGGTT',data,2))))

reads = readFastq('ERR037900_1.first1000.fastq')

