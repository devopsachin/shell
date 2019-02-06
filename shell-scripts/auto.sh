#!/bin/sh/

aws ec2 start-instances --instance-ids i-0fc050066ef724cb5 | awk 'FNR==2 {print}' | awk '{print $3}' > /var/www/html/master/shell/auto.txt

state=`cat /var/www/html/master/shell/auto.txt`

# checking if its instances is running or not !
if [[ "$state" == "running" ]]; then
        aws ec2 describe-instances --instance-ids i-0fc050066ef724cb5 | awk 'FNR==2 {print}' | awk '{print $15}' > /var/www/html/master/shell/auto-ip.txt
	ip=`cat /var/www/html/master/shell/auto-ip.txt`
	echo "ip is : $ip"
	curl -X POST --data-urlencode 'payload={"channel": "#entertainment", "username": "webhookbot", "text": "Ip for master server is `'$ip'`", "icon_emoji": ":ghost:"}' https://hooks.slack.com/services/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
else 
echo "server not started is this weekends "
sleep 0.5
printf "explain the day [Y/n]:" && read yes
if [[ "$yes" == "y" ]];then
	date    
	echo       
	cal

else 
	echo "good by " 
       	exit
fi
fi



