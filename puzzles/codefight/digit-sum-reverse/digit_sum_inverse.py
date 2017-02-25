# This is a solution to Codefights digitSumInverse challenge found here:
# https://codefights.com/challenge/w6JSeYrX4s2DSSbfQ
def digitSumInverse(sumv, numberLength, h={}):
	if numberLength < 1 or sumv < 0:
		return 0
	elif h.has_key((sumv, numberLength)):
		return h[(sumv, numberLength)]
	elif numberLength == 1:
		if sumv < 10:
			return 1
		return 0
	v = sum(map(lambda x: digitSumInverse(sumv - x, numberLength - 1, h), range(10)))
	h[(sumv, numberLength)] = v
	return v
	