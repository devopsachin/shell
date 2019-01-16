#!bin/bash/
w > /some && cat /some | wc -l > num.txt
#grep devlop /some > /som.txt
#cat /some | wc -l > num
cat /some | awk '{print $1}' | grep devlop > /pan.txt
cat /some | awk '{print $1}' | grep dhana > /pan1.txt

p=$(cat /pan.txt) #devlop
s=$(cat /pan1.txt) #dhana

q="devlop"
e="dhana"

if [[ "$p" == "$q" ]];  then  #devlop condition
for v in `cat /pan.txt` ; do 
/usr/bin/curl -X POST --data-urlencode 'payload={"username": "Devloper Pacrtice Session", "text": " `'$v'` user logged in ", "icon_emoji": ":computer:"}' https://hooks.slack.com/services/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
done 
elif [[ "$s" == "$e" ]];  then
for z in `cat /pan1.txt`; do
/usr/bin/curl -X POST --data-urlencode 'payload={"username": "Devloper Pacrtice Session", "text": " `'$z'` user logged in ", "icon_emoji": ":computer:"}' https://hooks.slack.com/services/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
done

exit

else
#for b in `cat /`
/usr/bin/curl -X POST --data-urlencode 'payload={"username": "Devloper Pacrtice Session", "text": " `'$e' '$q'` users Not-logged in ", "icon_emoji": ":computer:"}' https://hooks.slack.com/services/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
fi
exit

if [[ "$s" == "$e" ]];  then  #dhana condition
for g in `cat /pan1.txt` ; do
/usr/bin/curl -X POST --data-urlencode 'payload={"username": "Devloper Pacrtice Session", "text": " `'$g'` user logged in ", "icon_emoji": ":computer:"}' https://hooks.slack.com/services/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
done
else
exit 
fi

