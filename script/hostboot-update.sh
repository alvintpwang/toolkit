#!/bin/bash
#DIR="${BASH_SOURCE%/*}"
#source $DIR/

# Default values
verbose=0
program=${0##*/}

usage()
{
  printf "Usage: %s [OPTIONS]... \n" $program
  printf "This tool will install the toolkit.\n\n"
  printf " -h,  help (this page)\n"
  printf " -v,  verbose\n"
  exit 0;
}


# main
# $OPTARG
optstring=hvf:
while getopts $optstring opt
do
  case $opt in
    h) usage ;;
    v) verbose=$(( $verbose + 1 )); set -x ;;
    f) file=$OPTARG ;;
    *) printf "Not supported option %s" $opt; exit 1 ;;
 esac
done


# check BMCIP, file
if [ ! $BMCIP ] 
then
 printf "\$BMCIP is empty!\n";
 exit 1
fi

if [ ! $file ] 
then
  printf "\$file is empty!\n"
  exit 1
fi


# check mount point
# sshpass -p superuser ssh sysadmin@$BMCIP


# copy file to BMC
#sshpass -p superuser ssh systemadmin@$BMCIP 


# check file
file_exist=`sshpass -p superuser ssh sysadmin@$BMCIP "if [ -f $file ] ;then echo yes; fi"`
if [ ! "$file_exist" = "yes" ]
then
  printf "$file not exists in BMC\n"
  exit 1
fi

# update hostboot
printf "$file exists in BMC\n"

pflash -e -f -p $file -P 



