#!/bin/bash
#file you need:
#oui.txt and ouibase16.txt
#noarpi.py

#from all scans get IP and MACs
cat *.arp|grep -Ev "Ending|packets|Interface|Starting"| cut -f1,2|cut -d " " -f 1 |sort -u>>UniqueARPHost.txt


#from all IP and MAC get IP and OUI bytes
cat UniqueARPHost.txt |cut -f 1,2 |cut -d " " -f 1 |cut -d ":" -f1,2,3 > IP_OUI.txt

#Cleanup OUI bytes
sed 's/://g' IP_OUI.txt >UniqueOUI.txt

#GET VENDOR LIST in the SCANS
for mac in $(cat UniqueOUI.txt|cut -f2|sort -u);do cat oui.txt|grep $mac >> UniqueVendor.txt;done 
cat UniqueVendor.txt |sort -u >> RealVendor.txt

#Create a file for each VENDORS
for vendor in $(cat RealVendor.txt);do cat UniqueARPHost.txt|grep "$vendors" > $vendors.txt;done


#MAKE FILE with Device number +OUI of the device +IP of the device
python2 noarpi.py>>toast.txt


#MAKE FILE WITH IPs sorted by VENDORS
 for oui in $(cat toast.txt|grep OUI|cut -d ":" -f2);do cat ouibase16.txt|grep $oui;cat toast.txt|grep -A1 $oui;echo "#############"; done > RESULTS.txt
#attention traiter les scan individuellement avec une boucle for pour éviter plusieurs devices sur la mm IP.

#recupere toutes les OUI APPLE dans le fichier RESULT !! on peut utiliser le string "####' pour récuperer cette info sans préciser le vendor
cat RESULTS.txt|grep -A1 Apple|grep OUI|cut -d ":" -f2  > AppleOUI.txt

#Recuperer les adresses IP utilisées par des devices apple
 for forbidden in $(cat AppleOUI.txt );do cat RESULTS.txt |grep -A1 $forbidden|grep IP|cut -d ":" -f2>>appledevice.txt;done

#recuperer les adresses MAC forbidden pour chaque vendor (on devrait pouvoir utiliser les strings apres "####" dans RESULTS.txt pour enumérer les vendors.
for ip in $(cat appledevice.txt );do cat UniqueARPHost.txt|grep $ip|cut -f2|cut -d " " -f1>>appleexcludelist.txt;done    
echo "Apple Devices:";wc -l appleexcludelist.txt

cat RESULTS.txt|grep -A1 Samsung|grep OUI|cut -d ":" -f2|sort -u   > SAMSUNGOUI.txt
for forbidden in $(cat SAMSUNGOUI.txt );do cat RESULTS.txt |grep -A1 $forbidden|grep IP|cut -d ":" -f2|sort -u >>samsungdevice.txt;done
for ip in $(cat samsungdevice.txt );do cat UniqueARPHost.txt|grep $ip|cut -f2|cut -d " " -f1>>samsungexcludelist.txt;done 
echo "SAMSUNG Devices:";wc -l samsungexcludelist.txt


cat RESULTS.txt|grep -A1 Intel|grep OUI|cut -d ":" -f2|sort -u   > INTELOUI.txt
for forbidden in $(cat INTELOUI.txt );do cat RESULTS.txt |grep -A1 $forbidden|grep IP|cut -d ":" -f2|sort -u >>inteldevice.txt;done
for ip in $(cat samsungdevice.txt );do cat UniqueARPHost.txt|grep $ip|cut -f2|cut -d " " -f1>>intelexcludelist.txt;done 

echo "Intel Devices:";wc -l intelexcludelist.txt

cat RESULTS.txt|grep -A1 Cisco|grep OUI|cut -d ":" -f2|sort -u   > CISCOOUI.txt
for forbidden in $(cat CISCOOUI.txt );do cat RESULTS.txt |grep -A1 $forbidden|grep IP|cut -d ":" -f2>>ciscodevice.txt;done
for ip in $(cat samsungdevice.txt );do cat UniqueARPHost.txt|grep $ip|cut -f2|cut -d " " -f1>>ciscoexcludelist.txt;done 
echo "Cisco Devices:";wc -l ciscodexcludelist.txt


cat RESULTS.txt|grep -A1 Hon|grep OUI|cut -d ":" -f2|sort -u   >HONHAIOUI.txt
for forbidden in $(cat HONHAIOUI.txt );do cat RESULTS.txt |grep -A1 $forbidden|grep IP|cut -d ":" -f2>>honhaidevice.txt;done
for ip in $(cat samsungdevice.txt );do cat UniqueARPHost.txt|grep $ip|cut -f2|cut -d " " -f1>>honhaiexcludelist.txt;done 
echo "HonHai Devices:";wc -l honhaiexcludelist.txt


cat RESULTS.txt|grep -A1 Murata|grep OUI|cut -d ":" -f2|sort -u   > MURATAOUI.txt
for forbidden in $(cat MURATAOUI.txt );do cat RESULTS.txt |grep -A1 $forbidden|grep IP|cut -d ":" -f2>>muratadevice.txt;done
for ip in $(cat samsungdevice.txt );do cat UniqueARPHost.txt|grep $ip|cut -f2|cut -d " " -f1>>murataxcludelist.txt;done 
echo "Murata Devices:";wc -l murataexcludelist.txt


