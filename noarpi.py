#!/usr/bin/python2
#!-*-coding:utf8-*-


#lire fichier .arp
#mettre ip/mac dans une liste
#transformer mac en oui
#comparer macoui avec oui.txt
#obtenir un dico ip;mac;oui;vendor
#lister les items par vendor
#lister les items par OUI

#on commence le code ici avec un fichier qui comporte IPADDRESS[TAB]OUI

f=open('UniqueOUI.txt')
line=f.readlines()
f.close()
f=open('oui.txt')
lone=f.readlines()
f.close()
print "*****************"
x=1
y=1
clean=[]
l=open("ouibase16.txt")
lone=l.readlines()
print "Total des DEVICES:",len(line)
print "#########################"
while x<len(line):


                var=line[x]
                vor=var
                print "Device n°:",x
                oui=vor[-7:]
                ip=vor[0:-7]
                oui=oui[0:6]
                oui=oui.upper()
		x=x+1
	        print "OUI:",oui
                print "IP:",ip
                print "###################"

print clean

		






