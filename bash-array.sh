#!/bin/bash

bpath=/storage/srvconfs

rsyncopt="-czavPptgo"
#rsyncopt="-czavPptgo -n"

host_0=("back1" "2222" "1")
host_1=("back2" "2222" "2")
host_2=("back3" "2222" "3")
host_3=("back4" "2222" "4")
host_4=("back5" "2222" "5")
host_5=("back6" "2222" "6")
host_6=("back7" "2222" "7")

MAIN_ARRAY=(
  host_0[@]
  host_1[@]
  host_2[@]
  host_3[@]
  host_4[@]
  host_5[@]
  host_6[@]
)
COUNT=${#MAIN_ARRAY[@]}
for ((i=0; i<$COUNT; i++))
do
  HOST=${!MAIN_ARRAY[i]:0:1}
  PORT=${!MAIN_ARRAY[i]:1:1}
  PRIO=${!MAIN_ARRAY[i]:2:1}
  #echo "------------------------Backup ${HOST}:${PORT}------------------------"

  echo "${HOST}:${PORT} ${PRIO}"
done
