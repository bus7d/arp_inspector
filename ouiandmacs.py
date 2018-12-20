#!/usr/bin/python2


f=open("unique.macn","r")
lines=f.readlines()
m=open("ouiandmacs.txt","w+")
for line in lines:
	 lone=line[0:6]+"	"+line
	 m.write(lone)
