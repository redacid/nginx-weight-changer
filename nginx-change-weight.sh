#!/bin/bash

cmd="$1"
host="$2"
weight="$3"
file="$4"
debug="0"
debug_separator="------------------------------------------------------------------------------------------------------------"
#comment=`nslookup $host | grep "name =" | cut -d"=" -f2`
comment=`host ${host} | cut -d " " -f5`

if [ $# -lt 2 ]; then
    echo usage $0 command host weight
    echo example: $0 weight 111.111.111.111 60 
    echo commands: weight
    echo enable,disable,backup - in progress
    exit 0
fi

# server 111.111.111.111 weight=10 max_fails=1 fail_timeout=5; #back1.mi.
#regexp='(server)(\s+)((?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?))(?![\d])(\s+)(weight)(=)(\d+)(\s+)(max_fails)(=)(\d+)(\s+)(fail_timeout)(=)(5)(;)'

case "$1" in

        "weight")
            regexp='(server)(\s+)('${host}')(\s+)(weight)(=)(\d+)(\s+)(max_fails)(=)(\d+)(\s+)(fail_timeout)(=)(5)(;)'
            line=`cat ${file} | grep -P ${regexp} | grep ${host} | sed 's/^[ \t]*//' | grep -v ^"#" |head -n 1`
            newline="server $host weight=$weight max_fails=1 fail_timeout=5; #$comment"
            sed -i -e "/^[ \t]*#/!s/$line/$newline/g" ${file}
            #sed -e "/^[ \t]*#/!s/$line/$newline/g" ${file}

        if [ ${debug} -eq 1 ]; then
            echo ${debug_separator}
            #cat $file
            echo ${debug_separator}
            echo "/^[ \t]*#/!s/$line/$newline/g"
            echo ${debug_separator}
            echo "line="${line}
            echo ${debug_separator}
            echo "newline="${newline}
            echo ${debug_separator}
            echo "regexp=(server)(\s+)('$host')(\s+)(weight)(=)(\d+)(\s+)(max_fails)(=)(\d+)(\s+)(fail_timeout)(=)(5)(;)"
            echo ${debug_separator}
        fi     
        ;;

esac


