#!/bin/bash/

aws ec2 describe-addresses --query 'Addresses[?AssociationId==null]' --output text | awk '{print $3}' > /var/www/html/master/shell/shell/shell-scripts/free-ip.txt
ip=`cat /var/www/html/master/shell/shell/shell-scripts/free-ip.txt`
ip2=12
if [[ `aws ec2 describe-addresses --query 'Addresses[?AssociationId==null]' --output json ` = *vpc* ]]; then
       for a in $ip ; do	
	echo "we have free ip $a "
done
else
	echo "we dont have free ips"
fi
