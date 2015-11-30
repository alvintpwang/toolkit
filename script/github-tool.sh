#!/bin/bash

# Default values
verbose=0
program=${0##*/}
user=open-power
#declare -A skip_repos=( linux )

usage()
{
  printf "Usage: %s [OPTIONS]... \n" $program
  printf "This is github tool to clone, fetch the code from github.\n\n"
  printf " -h,  help (this page)\n"
  printf " -v,  verbose (ex: -v, -vv)\n"
  printf " -u,  user (ex: open-power, openbmc)\n"
  printf " -s,  skip repository (ex: -s linux)\n"
  exit 0;
}


# main
optstring=hvu:
while getopts $optstring opt
do
  case $opt in
    h) usage ;;
    v) verbose=$(( $verbose + 1 )) ;;
    u) user=$OPTARG ;;
    *) printf "Not supported option %s" $opt; exit 1 ;;
 esac
done

# check verbose
if [ $verbose -eq 2 ]
then
  set -x
fi

# get all repositories
# ex: "https://github.com/open-power/apss.git"
packages=( `curl -q "https://api.github.com/users/$user/repos?per_page=1000" 2>/dev/null | grep  -o  "\"clone_url\".*\".*\"" | cut -b14-` )
total_repos=${#packages[@]}
[ $verbose -ge 1 ] && printf "%s\n" "${packages[@]}"


# create folder
mkdir -p $user
cd $user


# clone all repositories
for repo in "${packages[@]}"
do
  # remove the quatation ("xxx" -> xxx)
  tmp=${repo#?};
  tmp=${tmp%?};

  printf "%s\n" "git clone $tmp"
  git clone $tmp
  if [ $? -eq 0 ]
  then
    success_repos=$(( ${success_repos:=0}+1 ))
  fi
done

printf "\n\n%s\n" "Success/Total=${success_repos:=0}/$total_repos"

