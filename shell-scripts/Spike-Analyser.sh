#!/bin/bash

#Author = sachin ur
#Date=21/June/2019

#>/jenkins/Trend/Db-name.txt

date=`date +"%Y-%m-%d_%H:%M:%S"`

aws rds describe-db-instances --query 'DBInstances[*].DBInstanceIdentifier' --output text >> /jenkins/Trend/Db-name.txt

for a in `cat /jenkins/Trend/Db-name.txt` ; do


mon-get-stats --access-key-id "**************" --secret-key "***********" --region "ap-south-1"  --metric-name="DatabaseConnections" --namespace="AWS/RDS" --dimensions="DBInstanceIdentifier=$a" --statistics Maximum >> /jenkins/Trend/raw.txt

awk 'END{printf "%.0f",$3}' /jenkins/Trend/raw.txt > /jenkins/Trend/Finals.txt

CURRENT=`cat /jenkins/Trend/Finals.txt`


if [[ "$CURRENT" -gt "50" ]]; then


        echo "The Db  name is $a and current connections is = $CURRENT"

        aws rds describe-db-log-files --db-instance-identifier $a --output text | grep 'slow' | awk '{print $2}' > /jenkins/Trend/d

        awk -v RS='[[:space:]]+' 'BEGIN{max=-inf};{max = $0>max? $0: max};END{print max}' /jenkins/Trend/d > /jenkins/Trend/Latest-File-decoder.txt

        DOWN=`cat /jenkins/Trend/Latest-File-decoder.txt`

        echo "Decoder is $DOWN"

        aws rds describe-db-log-files --db-instance-identifier $a --output text | grep 'slow' | grep "$DOWN" | awk '{print $3}' > /jenkins/Trend/log-file-name.txt

        DOWNLOADBLE=`cat /jenkins/Trend/log-file-name.txt`


        aws rds download-db-log-file-portion --db-instance-identifier $a --log-file-name $DOWNLOADBLE --profile jenkins --region ap-south-1 >> /jenkins/Trend/slow-query-of-$a-$date.txt
D=`date +"%Y-%m-%d"`
        MOVEBLE=/jenkins/Trend/slow-query-of-$a-$date.txt


        aws s3 mv /jenkins/Trend/slow-query-of-$a-$date.txt s3://imc-reports/Db-Spike-Analysis/$D/ --profile jenkins --region ap-south-1

/usr/bin/curl -X POST --data-urlencode 'payload={"username": "Jenkins Spike Analyser", "text": " 'https://Bucket-name.s3.region.amazonaws.com/Db-Spike-Analysis/$D/slow-query-of-$a-$date.txt' ", "icon_emoji": ":computer:"}' https://hooks.slack.com/

else

        echo "The Db $a is Under Controle and nothing is above 50 and current connections is $CURRENT"

fi
done
