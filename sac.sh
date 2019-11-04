#!/bin/bash

Total=`free -m | awk 'NR==2 {print $2 }' `
Free=`free -m | awk 'NR==2 {print $4}'`
Used=`free -m | awk 'NR==2 {print $3}'`
shared=`free -m | awk 'NR==2 {print $5}'`
buffer=`free -m | awk 'NR==2 {print $6}'`
availible=`free -m | awk 'NR==2 {print $7}'`




echo "1","Test VM", "$Total","$Free","$Used","$shared","$buffer","$availible" > /home/ec2-user/Memory.csv 


sed -i '1i Si No,VM Name,Total Memory(MB),Free Memory(MB),Used Memory(MB),Shared,Buffer(MB),Availible(MB)' /home/ec2-user/Memory.csv

echo  "Hi All
Hopes..
This mail containing Current status of VM Name and its Memory Status

Regards
Auto Gen" > /content.txt
mailx -a /home/ec2-user/Memory.csv  -s "Memory Info of VM1"  kesavarao.singupuram@atos.net  < /content.txt
