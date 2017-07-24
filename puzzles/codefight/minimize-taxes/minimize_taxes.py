# This is a solution to minimizeTaxes challenge: https://codefights.com/challenge/bJTqcLjbyvMq42feg

# Given c1 = (x1, y1) and c2 = (x2, y2), return a list of 4 (x, y)
# coordinates that form a square
def square_coords(c1, c2):
	coords = []
	x1, y1 = c1
	x2, y2 = c2
	rise = y2 - y1
	run = x2 - x1
	x3 = x1 + rise
	y3 = y1 - run
	x4 = x3 + run
	y4 = y3 + rise
	return [c1, c2, (x3, y3), (x4, y4)]

# Get the distance btween the two coordinates.
def dist(c1, c2):
	x1, y1 = c1
	x2, y2 = c2
	return (((x2 - x1)**2) + ((y2 - y1)**2))**0.5

# Main algorithm.	
def minimizeTaxes(land):
	good_coords = []
	for i in range(len(land)):
		for j in range(len(land[i])):
			if land[i][j] == 1:
				good_coords.append((i, j))
	if len(good_coords) < 4:
		return None
	best = None
	for i in range(len(good_coords) - 1):
		for j in range(i+1, len(good_coords)):
			d = dist(good_coords[i], good_coords[j])
			if best == None or d < best:
				sq = square_coords(good_coords[i], good_coords[j])
				if (reduce(lambda x,y: x and y, map(lambda (p,q): p >= 0 and q >= 0, sq)) and 
					reduce(lambda x,y: x and y, map(lambda z: z in good_coords, sq))):
					best = d
	return int(round(best**2))
			

				