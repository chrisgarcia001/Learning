# Challenge Description: https://app.codesignal.com/challenge/vsHiqRWjq3Nhyi6KR

def parse(s):
	ar = s.split(' ')
	return (ar[0], int(ar[1][1:]))

# hist is a list of (org, num_rejects, num_accepts), move is an org, 
# possible_move is a list of orgs
def next_state(hist, move, possible_moves):
	nh = []
	pm = set(possible_moves)
	for (mv, rej, acc) in hist:
		if mv == move:
			nh.append((mv, rej, acc + 1))
		else:
			if rej + 1 <= acc / 2 and mv in pm:
				nh.append((mv, rej + 1, acc))
			elif not(mv in pm):
				nh.append((mv, rej, acc))
	return nh

def optimize(hist, offers, day):
	if hist == []:
		return 0
	moves = list(set([m for (m,_,_) in hist]).intersection(offers[day].keys()))
	#print(moves)
	if day == len(offers) - 1:
		return max([offers[day][m] for m in moves]) if len(moves) > 0 else 0
	if moves == []:
		return optimize(hist, offers, day + 1)
	else:
		best = 0
		for m in moves:
			state = next_state(hist, m, moves)
			#print(state)
			profit = offers[day][m] + optimize(state, offers, day + 1)
			if profit > best:
				best = profit
		return best	

def optimalSupplyGigs(offers):
	if len(offers) == 0:
		return 0
	item_lists = [[parse(x) for x in y] for y in offers]
	orgs = list(set([i for (i,j) in reduce(lambda x,y: x+y, item_lists)]))
	offer_dicts = [dict(x) for x in item_lists]
	init_history = [(i, 0, 0) for i in orgs]
	return optimize(init_history, offer_dicts, 0)

# ------------------------------------------------
print(parse("A $101"))

offers = [["A $100","B $200"], 
					["A $250"], 
					["A $200"]]
item_lists = [[parse(x) for x in y] for y in offers]
orgs = list(set([i for (i,j) in reduce(lambda x,y: x+y, item_lists)]))
offer_dicts = [dict(x) for x in item_lists]

print(item_lists)
print(orgs)
print(offer_dicts)
print optimalSupplyGigs(offers)

offers = [["V $75","H $100","P $100"], 
					["F $100"], 
					["P $150"], 
					["H $75"], 
					["R $150","F $250","C $125","X $150","P $200","Q $150"], 
					["B $125"], 
					["F $150","B $75","H $75"], 
					["D $200","X $175","C $125","B $250"], 
					["R $150","V $125","D $200"], 
					["H $250"]]

print optimalSupplyGigs(offers)