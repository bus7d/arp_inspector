
#!/usr/bin/python2
#-*-coding:utf8-*-

import os

f=open("ouimacs.txt","r")

x=1
lines=f.readlines()
f.close()

l=open(str(x),"w+")
n="hgfhgf"
for line in lines:

                        if "(base 16)" in line:
                                   
                                        if n in os.listdir("."):
                                         
                                                l.close()               #verifier que un fichier ouvert x est incrémentel verifier que x est présent
                                                x=x+1
                                        n=str(x)+".test"
                                        
                                      
                                        
                                        l=open(n,"w+")
                                        l.write(line)
                        else :
                                print "FILE is:",n
                                
                                l.write(line)
if x in os.listdir("./"):
        l.close()

