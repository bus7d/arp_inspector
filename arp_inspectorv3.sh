#!/bin/bash
#file you need:
#oui.txt and ouibase16.txt
#noarpi.py

cat *.arp|grep -Ev "Ending|packets|Interface|Starting"| cut -f1,2|cut -d " " -f 1 |sort -u>>UniqueARPHost.txt

cat UniqueARPHost.txt |cut -f 1,2 |cut -d " " -f 1 |cut -d ":" -f1,2,3 > IP_OUI.txt


sed 's/://g' IP_OUI.txt >UniqueOUI.txt

for mac in $(cat UniqueOUI.txt|cut -f2);do cat oui.txt|grep $mac >> UniqueVendor.txt;done 
cat UniqueVendor.txt |sort -u >> RealVendor.txt

for vendor in $(cat RealVendors.txt);do cat UniqueARPHost.txt|grep "$vendors" > $vendors.txt;done



python2 noarpi.py>>toast.txt


 for oui in $(cat toast.txt|grep OUI|cut -d ":" -f2);do cat ouibase16.txt|grep $oui;cat toast.txt|grep -A1 $oui;echo "#############"; done > RESULTS.txt

cat RESULTS.txt|grep -A1 Apple|grep OUI|cut -d ":" -f2  > AppleOUI.txt
 for forbidden in $(cat AppleOUI.txt );do cat acquired.txt |grep -A1 $forbidden|grep IP|cut -d ":" -f2 >>appledevice.txt;done
echo "Apple Devices:";wc -l appledevice.txt
#recuperer les adresses MAC forbidden
for ip in $(cat appledevice.txt );do cat UniqueARPHost.txt|grep $ip|cut -f2|cut -d " " -f1>>excludelist.txt;done    


cat RESULTS.txt|grep -A1 Samsung|grep OUI|cut -d ":" -f2  > SAMSUNGOUI.txt

