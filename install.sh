#!/bin/bash

# Default values
verbose=0
overwrite=
program=${0##*/}

usage()
{
  printf "Usage: %s [OPTIONS]... \n" $program
  printf "This tool will install the toolkit.\n\n"
  printf " -h,  help (this page)\n"
  printf " -v,  verbose\n"
  printf " -o,  overwrite files (default is hard link)\n"
  exit 0;
}


# main
optstring=hvo
while getopts $optstring opt
do
  case $opt in
    h) usage ;;
    v) verbose=$(( $verbose + 1 )); set -x;;
    o) overwrite=1 ;;
    *) printf "Not supported option %s" $opt; exit 1 ;;
 esac
done


# copy files or make links
fullpath="${PWD}/${0}"
path=${fullpath%/*}

if [ $overwrite ]
then
  #cp -f "${path}/configs/vimrc" "$HOME/.vimrc"
  cp -f "${path}/configs/gitconfig" "$HOME/.gitconfig"
else
  printf "hello\n"
  #ln -f "${path}/configs/vimrc" "$HOME/.vimrc"
  ln -f "${path}/configs/gitconfig" "$HOME/.gitconfig"
fi



