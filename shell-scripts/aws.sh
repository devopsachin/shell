aws ec2 describe-instance-status --instance-id i-001272545337ab5ae | awk 'FNR == 2 {print}' | awk -v x=3 '{print $x}' > sam.txt

if [ "$(cat sam.txt)" == running ]; then 
curl -X POST --data-urlencode 'payload={"channel":"#server_status","username":"Status", "text":"the server `i-001272545337ab5ae` status is `'$(cat sam.txt)'`","icon_emoji":":ghost:"}' https://hooks.slack.com/services/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
else
#curl -X POST --data-urlencode 'payload={"channel":"#server_status","username":"Status", "text":"the server status ins `'$sam.txt'`","icon_emoji":":ghost:"}' https://hooks.slack.com/services/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
echo "if is not working"
fi
