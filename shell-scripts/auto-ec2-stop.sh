#!/bin/bash

instance=i-0afb51b6533e44b98
aws ec2 describe-instances --instance-ids $instance --query 'Reservations[].Instances[].State[]' --output text | awk '{print $2}' > /var/www/html/master/shell/shell/shell-scripts/auto-ec2-stop.txt
run=`cat /var/www/html/master/shell/shell/shell-scripts/auto-ec2-stop.txt`

if [[ "$run" == "running" ]]; then
	aws ec2 stop-instances --instance-ids $instance
	echo "Instance was running and now its stopped istance id $instance"
else 
	echo "The server is alredy stopped"
fi


