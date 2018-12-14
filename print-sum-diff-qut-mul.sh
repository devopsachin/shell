read x
read y
sum=`expr $x + $y`
diff=`expr $x - $y`
mul=`expr $x \* $y`
div=`expr $x / $y`

echo "$sum" 
echo "$diff"
echo "$mul"
echo "$div"

