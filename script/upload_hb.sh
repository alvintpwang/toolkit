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
optstring=hv
while getopts $optstring opt
do
  case $opt in
    h) usage ;;
    v) verbose=$(( $verbose + 1 )); set -x;;
    *) printf "Not supported option %s" $opt; exit 1 ;;
 esac
done

image_path="output/host/usr/powerpc64le-buildroot-linux-gnu/sysroot/openpower_pnor_scratch"

sshpass -p alvin scp $image_path/*.ecc alvin@openpowerlcb:/fspmount/hostboot/




