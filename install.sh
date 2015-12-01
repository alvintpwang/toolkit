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
  printf " -o,  overwrite files (default is symbolic link)\n"
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
  #cp -rfT "${path}/configs/vimrc" "$HOME/.vimrc"
  rm -rf "$HOME/.gitconfig"
  cp -rfT "${path}/configs/gitconfig" "$HOME/.gitconfig"

  rm -rf "$HOME/script"
  cp -rfT "${path}/script" "$HOME/script"
else
  #ln -fsT "${path}/configs/vimrc" "$HOME/.vimrc"
  rm -rf "$HOME/.gitconfig"
  ln -fsT "${path}/configs/gitconfig" "$HOME/.gitconfig"
  
  rm -rf "$HOME/script"
  ln -fsT "${path}/script" "$HOME/script"
fi


# modify .bashrc init file to include the bashrc in toolkit
if [ -f "$HOME/.bashrc" ]
then
  if ! grep -q "$HOME/script/bashrc" "$HOME/.bashrc"
  then
    printf "\n%s\n" ". $HOME/script/bashrc" >> "$HOME/.bashrc"
  fi
else
  printf "\n%s\n" ". $HOME/script/bashrc" > "$HOME/.bashrc"
  chmod +x "$HOME/.bashrc"
fi


