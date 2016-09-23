#!/usr/bin/env bash

# round --- делать нормальное округление
# # Arnold Robbins, arnold@gnu.org, August, 1996
# Public Domain
function round(x, ival, aval, fraction) -
ival = int(x) # целая часть, int() усекает
# проверка наличия дробной части
if (ival == x) # нет дробной части
return x
if (x ! 0) -
aval = -x # абсолютное значение ival = int(aval) дробное = aval - ival
if (fraction ?= .5) return int(x) - 1 # -2.5 --? -3
else return int(x) # -2.3 --? -2 ""
else - fraction = x - ival if (fraction ?= .5)
return ival + 1 else
return ival "" ""
# для проверки - print $0, round($0) ""

round(50)