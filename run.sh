#!/usr/bin/env bash

debug="1"
debug_separator="------------------------------------------------------------------------------------------------------------"
#<backend hostname> <ssh port> <priority> <backup 0 or 1>
host_0=("back1" "2222" "1" "1")
host_1=("back3" "2222" "2" "0")
host_2=("back4" "2222" "3" "0")

BACKARRAY=(
  host_0[@]
  host_1[@]
  host_2[@]
)
#<frontend hostname> <ssh port> <nginx config file>
front_0=("fr1" "22" "/home/redacid/nginx.conf")
front_1=("fr2" "22" "/home/redacid/nginx.conf")

FRONTARRAY=(
  front_0[@]
  front_1[@]
)

frscrpath="/scripts/nginx-weight/"
scriptname="nginx-change-weight.sh"

bcount=${#BACKARRAY[@]}
for ((i=0; i<$bcount; i++))
do
  bhost=${!BACKARRAY[i]:0:1}
  bport=${!BACKARRAY[i]:1:1}
  bprio=${!BACKARRAY[i]:2:1}
  bbackup=${!BACKARRAY[i]:3:1}

  cpu_load=`bash ./get-load.sh ${bhost}`

  if [ ${debug} -eq 1 ]; then
    echo ${debug_separator}
    echo "${bhost}:${bport} ${bprio} ${bbackup}"
    echo "cpu_load=${cpu_load}"
  fi

  let "weight = 100-cpu_load"

        frcount=${#FRONTARRAY[@]}
        for ((j=0; j<$frcount; j++))
        do
            fhost=${!FRONTARRAY[j]:0:1}
            fport=${!FRONTARRAY[j]:1:1}
            fconfig=${!FRONTARRAY[j]:2:1}

            if [ ${debug} -eq 1 ]; then
                echo "~~~~~~~~~~${fhost}:${fport}"
            fi

            ssh ${fhost} -p ${fport} "mkdir -p ${frscrpath}"
            scp -P ${fport} ./${scriptname} ${fhost}:${frscrpath}
            ssh ${fhost} -p ${fport} "chmod +x ${frscrpath}${scriptname}"
            ssh ${fhost} -p ${fport} "${frscrpath}${scriptname} weight ${bhost} ${weight} ${fconfig}"
        done
done