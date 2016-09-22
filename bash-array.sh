#!/usr/bin/env bash
#<hostname> <ssh port> <priority> <backup 0 or 1>


host_0=("back1" "2222" "1" "1")
host_1=("back2" "2222" "2" "0")
host_2=("back3" "2222" "3" "0")

BACK_ARRAY=(
  host_0[@]
  host_1[@]
  host_2[@]
)

front_0=("fr1" "22")
front_1=("fr2" "22")

FRONT_ARRAY=(
  host_0[@]
  host_1[@]
)

BACK_COUNT=${#BACK_ARRAY[@]}
for ((i=0; i<$BACK_COUNT; i++))
do
  HOST=${!BACK_ARRAY[i]:0:1}
  PORT=${!BACK_ARRAY[i]:1:1}
  PRIO=${!BACK_ARRAY[i]:2:1}
  BACKUP=${!BACK_ARRAY[i]:3:1}

  echo "${HOST}:${PORT} ${PRIO} ${BACKUP}"
       FRONT_COUNT=${#FRONT_ARRAY[@]}
        for ((i=0; i<$FRONT_COUNT; i++))
        do
              F_HOST=${!FRONT_ARRAY[i]:0:1}
              F_PORT=${!FRONT_ARRAY[i]:1:1}
              echo "---${F_HOST}:${F_PORT}"
        done

done