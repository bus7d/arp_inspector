#!/bin/bash

for scan in $(ls *.arp);do cat $scan|grep -Ev "Ending|Packets|Interface|Starting|received"|cut  -f1,2|cut -d " " -f1 |sort -u>>$scan.scan;done
for scan in $(ls *.scan);do cat $scan |cut -f2> $scan.macs;done
wc -l *.macs
cat *.macs >>allmacs.mac;cat allmacs.mac|sort -u >> unique.mac;wc -l unique.mac
for scan in $(ls *.scan);do cat $scan |cut -f 1,2 |cut -d " " -f 1 |cut -d ":" -f1,2,3 >> $scan.ipoui ;done
for scan in $(ls *.scan.ipoui);do sed 's/://g' $scan >> $scan.uniqueoui;done
for mac in $(cat *.arp.scan.ipoui.uniqueoui|cut -f2|sort -u);do cat ouibase16.txt|grep -i $mac >>uniqueVendor.txt|| echo $mac "NOT FOUND">>uniqueVendor.txt;done
cat uniqueVendor.txt|grep FOUND >> notfound.txt
for oui in $(cat notfound.txt|sort -u);do cat ouibase16.txt|grep $oui>>notthat.txt;done
cat notthat.txt|sort -u >> notfoundoui.txt
cat uniqueVendor.txt |grep -v FOUND >> lastvendor.txt
cat notfoundoui.txt >> lastvendor.txt
cat lastvendor.txt |cut -f2 |sort -u >Vendors.txt
sed 's/://g' unique.mac >> unique.macn

python2 ouiandmacs.py
for oui in $(cat ouiandmacs.txt|cut -f1);do cat uniqueVendor.txt|grep -i $oui>>ouimacs.txt;cat ouiandmacs.txt |grep -i $oui>>ouimacs.txt;done
python2 tricks.py
for file in $(ls *.test);do wc -l $file >>file.list;cat $file|grep base>>file.list;done
for vendor in $(cat Vendors.txt|cut -d " "  -f1);do cat file.list|grep -B1 $vendor|grep test>>$vendor.device;done
chmod +x vendorcount.sh
cat Vendors.txt
echo " NOW PLEASE LAUNCH vendorcount.sh FOR EACH VENDORS IN Vendors.txt"
./vendorcount.sh
