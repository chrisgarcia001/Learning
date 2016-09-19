# Author: cgarcia
# This is a solution to the closestSequence2 challenge on codefights:
# https://codefights.com/challenge/Qjts7cukDvYpDW4Bc/main?utm_source=facebook&utm_medium=cpc&utm_campaign=Solve_A_Challenge_V6

def closestSequence2(a, b):
	mat = map(lambda i: [None] * len(b), range(len(a)))
	if a == []:
		return 0
	for j in range(len(mat[0])):
		mat[0][j] = abs(a[0] - b[j])
	for i in range(1, len(mat)):
		for j in range(i, len(mat[i])):
			mat[i][j] = min(mat[i - 1][(i - 1):j]) + abs(a[i] - b[j])
	return min(filter(lambda x: x != None, mat[len(mat) - 1]))
	
	