#!/bin/bash/
d=2
for a in $(seq 9)
do
expr b=$((a / d))
if ["$b" = 0]
then
echo
else 
echo "$a"
fi
done 


