#!/usr/bin/python
import sys
import re 
messages=sys.stdin.readlines()
for line in messages:
	if re.search(sys.argv[1], line):
		print (line.strip());
