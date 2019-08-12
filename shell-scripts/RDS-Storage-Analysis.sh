#!/bin/bash

#Author=devops-sachin

#date=07/08/2019

dd=`date +"%Y-%m-%d"` #to take current date format of yyyy-mm-dd

cat Db-name.txt | tr "\t" "\n" > /jenkins/Trend/want.txt  #convert tab saperted into comma saparated
DB=`cat /jenkins/Trend/want.txt`

for a in $DB ; do  # loop to get avilible storage

mon-get-stats --access-key-id "******************" --secret-key "************************" --region "ap-south-1"  --metric-name="FreeStorageSpace" --namespace="AWS/RDS" --dimensions="DBInstanceIdentifier=$a" --statistics Maximum | sed -n -e '$p' | awk '{print $3}' >/jenkins/Trend/DB-TOTAL-STORAGE.txt

FREE=`cat /jenkins/Trend/DB-TOTAL-STORAGE.txt` && echo "$FREE" | awk '{ foo = $1 / 1024 / 1024 / 1024 ; print foo "GB" }' >> /jenkins/Trend/Final.csv


done

aws rds describe-db-instances --query 'DBInstances[*].AllocatedStorage' --output text | tr "\t" "\n" > /jenkins/Trend/Total.txt

paste -d "," /jenkins/Trend/want.txt Final.csv /jenkins/Trend/Total.txt > /jenkins/Trend/Free_Storage_$dd.csv

sed -i '1i DB NAME,AVILIBLE STORAGE,TOTAL STORAGE' /jenkins/Trend/Free_Storage_$dd.csv

sed -i '$d' /jenkins/Trend/Free_Storage_$dd.csv


aws s3 mv /jenkins/Trend/Free_Storage_$dd.csv s3://imc-reports/Storage-RDS/$dd/ --profile jenkins --region ap-south-1

send=`cat `

echo  "Hi

      The Current storage details are below

      $send

      https://bucket-name.amazonaws.com/Storage-RDS/$dd/Free_Storage_$dd.csv

      By clicking above url you can download RDS storage details file!

      Regards
      Jenkins Auto Generated " > /jenkins/Trend/content.txt
#mailx -s "Storage Info of RDS"  -c email_id email_id  < /jenkins/Trend/content.txt
#mailx -s "Storage Info of RDS" -c email_id email_id email_ids < /jenkins/Trend/content.txt

>/jenkins/Trend/Final.csv
>/jenkins/Trend/content.txt
