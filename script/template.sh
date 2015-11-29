#!/bin/bash

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


