#! /bin/bash

# $1 -> n : number of games running simultaneously
# $2 -> tag (optional): Game results will be saved on results/tag
# $3 -> ssp (optional) : servers start port - first server will be run on
#           this port and the number will be increased for next server and so on
# $4 -> spd (optional) : servers port difference - the port number will be
#           increased by sdp from each server to the next

# initializing
declare -i n
read -p "enter number of games running simultaneously: " n
read -p "enter tag: " tag
declare -i ssp
read -p "enter servers start port" ssp
declare -i spd
read -p "enter servers port difference" spd

#if [ -n $3 ]
#then
#  ssp=$3
#else
#  ssp=6000
#fi

#if [ -n $4 ]
#then
#  spd=$4
#else
#  spd=10
#fi

DIR=`dirname $0`
echo "start" $$ >> proc.txt
# running runOnPort script for each set of games (n times)
declare -i i
declare -i port=$ssp
declare -i lim=$n-1
for (( i= 0; i<n; i++))
do
  $DIR/runOnPort.sh $port $n $i $tag &
  port=$port+$spd
done
rm -r $DIR/proc.txt
