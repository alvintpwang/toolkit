#!/bin/bash
##################################################################
# Script to limit cpu usage of HTX exercisers                    #
# make sure to "apt-get install cpulimit"   first                #     
# Useful to quickly change CPU loading and check thermal control #
#                                                                #
# usage: ./limithtx.sh <cpu usage percentage>                    #
#       CPU usage percentage can be from 1-100                   #
#                                                                #
# Written by: Kyle Loh (kyleloh@tw.ibm.com)                      #
#             2015/11/26 verified on Ubuntu 15.04                #
##################################################################

if [ $# -eq 1 ]
then
echo " "
echo " HTX exercisers need to be running for this scrip to work!! "
echo " "
sleep 1
x=1
process=0
killcpu=( `ps -e | grep cpulimit` )
if [ ${#killcpu[@]} != 0 ]
then
echo " Previous cpulimit process found. Killing first "
while [ $x -le $(( ${#killcpu[@]} / 4 )) ]
  do
  `kill -9 ${killcpu[$process]}`
  process=$(( $process + 4 ))
  x=$(( $x + 1 ))
done
process=0
x=1
fi
sleep 1
echo " "
array=( `ps -e | grep hxe` )
echo "Found $(( ${#array[@]} / 4 )) HTX processes"
echo "limiting all of them to $1 percent CPU usage"
while [ $x -le $(( ${#array[@]} / 4 )) ]
  do 
#  echo "HXE thread $x"
  cpulimit -l $1 -p ${array[$process]} -q &
  process=$(( $process + 4 ))
  x=$(( $x + 1 ))
done 

echo "Done. Please verify with top/htop/nmon"

else
echo "usage: limithtx.sh <cpu usage percentage>"
echo "  cpu usage percentage can be from 1-100 "
fi
