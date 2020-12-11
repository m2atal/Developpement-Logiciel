#!/usr/bin/python
import sys
import re 
messages=sys.stdin.readlines()
regex=re.compile(sys.argv[1])
for line in messages:
	if regex.search(line):
		print (line.strip());

