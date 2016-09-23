#!/usr/bin/env bash

round()
{
let sum="$1+5"
if [ $? = 1 ]
then
 echo $1
else
 b=`echo $1 | sed 's/[^,]*\,//'` # берем дробную часть от $1, позиционная переменная - $1
if [ "$b" -ge 5 ] # если она >= 5
then # отбрасываем дробную часть от $a
 b=`echo $1 | sed 's/[$,].//'`
 let "b % 2"
if [ $? = 1 ] # если целая часть чётная
then
 let "b=b+1" # увеличиваем $b на 1
 echo $b
else # иначе используем printf :)
 printf "%.0f" $1; echo
fi
else
 printf "%.0f" $1; echo
fi
fi
}

size="66,7"
round $size