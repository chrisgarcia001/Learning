# This is a solution to minimizeTaxes challenge: https://codefights.com/challenge/bJTqcLjbyvMq42feg

# Given c1 = (x1, y1) and c2 = (x2, y2), return a list of 4 (x, y)
# coordinates that form a square
def square_coords(c1, c2):
	coords = []
	x1, y1 = c1
	x2, y2 = c2
	rise = y2 - y1
	run = x2 - x1
	mag = (((x2 - x1)**2) + ((y2 - y1)**2))**0.5
	x3 = x2 - rise
	y3 = y2 - run
	x4 = 1
	y4 = 1
	return [[rise, run], c1, c2, (x3, y3), (x4, y4)]

def minimizeTaxes(land):
	return 0