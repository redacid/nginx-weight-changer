#!/usr/bin/env bash
#     <hostname> <ssh port> <priority> <backup 0 or 1>
host_0=("back1" "2222" "1" "1")
host_1=("back2" "2222" "2" "0")
host_2=("back3" "2222" "3" "0")

MAIN_ARRAY=(
  host_0[@]
  host_1[@]
  host_2[@]
)
COUNT=${#MAIN_ARRAY[@]}
for ((i=0; i<$COUNT; i++))
do
  HOST=${!MAIN_ARRAY[i]:0:1}
  PORT=${!MAIN_ARRAY[i]:1:1}
  PRIO=${!MAIN_ARRAY[i]:2:1}
  BACKUP=${!MAIN_ARRAY[i]:3:1}

  echo "${HOST}:${PORT} ${PRIO} ${BACKUP}"
done