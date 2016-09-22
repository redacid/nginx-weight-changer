#!/bin/bash

debug="1"
host1="back1"
host2="back3"
host3="back4"

mib_cpu_system='.1.3.6.1.4.1.2021.11.52.0'
mib_cpu_user='.1.3.6.1.4.1.2021.11.50.0'
mib_cpu_nice='.1.3.6.1.4.1.2021.11.51.0'
mib_percent_cpu='.1.3.6.1.4.1.2021.11.9.0'

#val_system=`snmpwalk -v2c -c public $host $mib_cpu_system | cut -d " " -f 4`
#val_user=`snmpwalk -v2c -c public $host  $mib_cpu_user | cut -d " " -f 4`
#val_nice=`snmpwalk -v2c -c public $host $mib_cpu_nice | cut -d " " -f 4`

val_cpu1=`snmpwalk -v2c -c public $host1 $mib_percent_cpu | cut -d " " -f 4`
val_cpu2=`snmpwalk -v2c -c public $host2 $mib_percent_cpu | cut -d " " -f 4`
val_cpu3=`snmpwalk -v2c -c public $host3 $mib_percent_cpu | cut -d " " -f 4`


#let "total = val_system+val_user+val_nice"

if [ $debug -eq 1 ]; then

echo "host:$host1 val_cpu=$val_cpu1"
echo "host:$host2 val_cpu=$val_cpu2"
echo "host:$host3 val_cpu=$val_cpu3"


#echo "val_system="$val_system
#echo "val_user="$val_user
#echo "val_nice="$val_nice
#echo "total="$total

fi
