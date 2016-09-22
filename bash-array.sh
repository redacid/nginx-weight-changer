#!/usr/bin/env bash
#<hostname> <ssh port> <priority> <backup 0 or 1>

host_0=("back1" "2222" "1" "1")
host_1=("back2" "2222" "2" "0")
host_2=("back3" "2222" "3" "0")

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

bcount=${#BACKARRAY[@]}
for ((i=0; i<$bcount; i++))
do
  bhost=${!BACKARRAY[i]:0:1}
  bport=${!BACKARRAY[i]:1:1}
  bprio=${!BACKARRAY[i]:2:1}
  bbackup=${!BACKARRAY[i]:3:1}

  echo "${bhost}:${bport} ${bprio} ${bbackup}"
        frcount=${#FRONTARRAY[@]}
        for ((i=0; i<$frcount; i++))
        do
        echo "1"
#              fhost=${!FRONTARRAY[i]:0:1}
#              fport=${!FRONTARRAY[i]:1:1}
#              echo "---${fhost}:${fport}"
        done

done