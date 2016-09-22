#!/bin/bash

debug="1"
host1="back1"
host2="back3"
host3="back4"

mib_cpu_system='.1.3.6.1.4.1.2021.11.52.0'
mib_cpu_user='.1.3.6.1.4.1.2021.11.50.0'
mib_cpu_nice='.1.3.6.1.4.1.2021.11.51.0'

mib_percent_cpu_sys='.1.3.6.1.4.1.2021.11.9.0'
mib_percent_cpu_usr='.1.3.6.1.4.1.2021.11.10.0'
mib_percent_cpu_idle='.1.3.6.1.4.1.2021.11.11.0'


val_cpu_sys1=`snmpwalk -v2c -c public $host1 $mib_percent_cpu_sys | cut -d " " -f 4`
val_cpu_usr1=`snmpwalk -v2c -c public $host1 $mib_percent_cpu_usr | cut -d " " -f 4`
let "total_cpu1 = val_cpu_sys1+val_cpu_usr1"

val_cpu_sys2=`snmpwalk -v2c -c public $host2 $mib_percent_cpu_sys | cut -d " " -f 4`
val_cpu_usr2=`snmpwalk -v2c -c public $host2 $mib_percent_cpu_usr | cut -d " " -f 4`
let "total_cpu2 = val_cpu_sys2+val_cpu_usr2"

val_cpu_sys3=`snmpwalk -v2c -c public $host3 $mib_percent_cpu_sys | cut -d " " -f 4`
val_cpu_usr3=`snmpwalk -v2c -c public $host3 $mib_percent_cpu_usr | cut -d " " -f 4`
let "total_cpu3 = val_cpu_sys3+val_cpu_usr3"



if [ $debug -eq 1 ]; then

echo "host:$host1 $total_cpu1"
echo "host:$host2 $total_cpu2"
echo "host:$host3 $total_cpu3"

fi
