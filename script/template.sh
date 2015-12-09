#!/bin/bash
#DIR="${BASH_SOURCE%/*}"
#source $DIR/

# Default values
program=${0##*/}

usage()
{

echo "\
Usage: $program [OPTIONS]...
This tool will install the toolkit.

 -h,  help (this page)
 -v,  verbose
"
exit;
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

[ $verbose ] && printf "verbose is: %s\n" $verbose



