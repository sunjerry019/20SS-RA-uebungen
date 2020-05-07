#!/usr/bin/env python3

functions = [
	lambda a,b,c: not (a | b | c)
]


for a in range(2):
	for b in range(2):
		for c in range(2):
			print (a, b, c, end='')
			for func in functions:
				print(f" {int(func(a,b,c))}", end='')
			print("")