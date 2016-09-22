#!/usr/bin/env bash
#<hostname> <ssh port> <priority> <backup 0 or 1>
debug_separator="------------------------------------------------------------------------------------------------------------"
host_0=("back1" "2222" "1" "1")
host_1=("back3" "2222" "2" "0")
host_2=("back4" "2222" "3" "0")

BACKARRAY=(
  host_0[@]
  host_1[@]
  host_2[@]
)

front_0=("fr1" "22")
front_1=("fr2" "22")

FRONTARRAY=(
  front_0[@]
  front_1[@]
)

frscrpath="/scripts/nginx-weight/"
scriptname="nginx-change-weight.sh"
#configpath="/etc/nginx/nginx.conf"
configpath="/home/redacid/nginx.conf"

bcount=${#BACKARRAY[@]}
for ((i=0; i<$bcount; i++))
do
  bhost=${!BACKARRAY[i]:0:1}
  bport=${!BACKARRAY[i]:1:1}
  bprio=${!BACKARRAY[i]:2:1}
  bbackup=${!BACKARRAY[i]:3:1}
  echo ${debug_separator}
  echo "${bhost}:${bport} ${bprio} ${bbackup}"

  bash ./get-load.sh ${bhost}

        frcount=${#FRONTARRAY[@]}
        for ((j=0; j<$frcount; j++))
        do
            fhost=${!FRONTARRAY[j]:0:1}
            fport=${!FRONTARRAY[j]:1:1}
            echo "      ${fhost}:${fport}"
            ssh ${fhost} -p ${fport} "mkdir -p ${frscrpath}"
            scp -P ${fport} ./${scriptname} ${fhost}:${frscrpath}
            ssh ${fhost} -p ${fport} "chmod +x ${frscrpath}${scriptname}"
            ssh ${fhost} -p ${fport} "${frscrpath}${scriptname} weight ${bhost} 20 ${configpath}"
        done

done