#!/bin/bash
id=i-0afb51b6533e44b98
aws ec2 describe-instances --instance-id "$id" --query 'Reservations[*].Instances[].State[]' --output text | awk '{print $2}' > /var/www/html/master/shell/shell/shell-scripts/eip-stop-status.txt

state=`cat /var/www/html/master/shell/shell/shell-scripts/eip-stop-status.txt`
if [[ "$state" == "stopped" ]]; then
	echo "Instance --> $id is stopped is now starting "
	aws ec2 start-instances --instance-id "$id" 
	sleep 5
	aws ec2 describe-instances --instance-id "$id" --query 'Reservations[*].Instances[].State[]' --output text | awk '{print $2}' > /var/www/html/master/shell/shell/shell-scripts/eip-start-status.txt
	stat=`cat /var/www/html/master/shell/shell/shell-scripts/eip-start-status.txt`
	if [[ "$stat" == "running" ]];then
		aws ec2 allocate-address --output text | awk '{print $3}' > /var/www/html/master/shell/shell/shell-scripts/eip.txt
		ip=`cat /var/www/html/master/shell/shell/shell-scripts/eip.txt`
		aws ec2 associate-address --instance-id "$id" --public-ip $ip
		aws ec2 describe-instances --instance-id "$id" --query 'Reservations[*].Instances[].PublicIpAddress' --output text > /var/www/html/master/shell/shell/shell-scripts/eip-attached.txt
		eip=`cat /var/www/html/master/shell/shell/shell-scripts/eip-attached.txt`
		if [[ "$eip" == "$ip" ]];then
			echo "Server state was $state "
			echo
			sleep 0.5
			echo "So we started $id <-- this instance"
			echo
			sleep 0.5
			echo "we alocated eip --> $eip "
			echo
			sleep 0.5
			echo "Now its running and new eip alocated"
	       else
			  echo "Somewhare eip is not maching"
		  fi
		  exit
	       else 
	    	echo "we cant start the server"
	fi
	exit

else 
	echo "server alredy running state"
fi	
exit

	
