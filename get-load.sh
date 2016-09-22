#!/bin/bash

Sdebug="0"
host=$1

if [ $# -lt 1 ]; then
    echo "usage $0 <host>"
    exit 0
fi

mib_cpu_system='.1.3.6.1.4.1.2021.11.52.0'
mib_cpu_user='.1.3.6.1.4.1.2021.11.50.0'
mib_cpu_nice='.1.3.6.1.4.1.2021.11.51.0'

mib_percent_cpu_sys='.1.3.6.1.4.1.2021.11.9.0'
mib_percent_cpu_usr='.1.3.6.1.4.1.2021.11.10.0'
mib_percent_cpu_idle='.1.3.6.1.4.1.2021.11.11.0'

val_cpu_sys=`snmpwalk -v2c -c public $host $mib_percent_cpu_sys | cut -d " " -f 4`
val_cpu_usr=`snmpwalk -v2c -c public $host $mib_percent_cpu_usr | cut -d " " -f 4`
let "total_cpu_load = val_cpu_sys1+val_cpu_usr"
echo $total_cpu_load

if [ $debug -eq 1 ]; then
    echo "host:$host $total_cpu"
fi


