# Author: cgarcia
# This is a solution to the stringsRearrangement challenge on codefights:
# https://codefights.com/challenge/RWQS5cCEodqSWx4bR?utm_source=facebook&utm_medium=cpc&utm_campaign=Solve_A_Challenge_V11%28US%29

# Count the number of character differences in two strings of equal length.
def char_diff(s1, s2):
	diff = 0
	for i in range(len(s1)):
		if s1[i] != s2[i]:
			diff += 1
	return diff

# Build a graph where vertices are strings and edges are where 2 strings differ by 1 character.
def build_graph(strings):
	g = []
	for i in range(len(strings)):
		g.append([])
		for j in range(len(strings)):
			if char_diff(strings[i], strings[j]) == 1:
				g[i].append(j)
	return g

# Return true if a path through all vertices can be found, starting on the specified vertex.
def find_full_path(g, start_vertex, seen = set([])):
	next_seen = seen.union(set([start_vertex]))
	if len(g) == len(next_seen):
		return True
	for nv in set(g[start_vertex]).difference(next_seen):
		result = find_full_path(g, nv, next_seen)
		if result:
			return True
	return False
	
# Main algorithm.
def stringsRearrangement(inputArray):
	graph = build_graph(map(lambda x: x.lower(), inputArray))
	for v in range(len(graph)):
		if find_full_path(graph, v):
			return True
	return False
	
	