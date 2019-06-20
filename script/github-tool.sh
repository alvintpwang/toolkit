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

# get repo number
#https://api.github.com/orgs/openbmc
packages_number=`curl -q "https://api.github.com/orgs/$user" 2>/dev/null | grep  -o  "\"public_repos\": \d*" | cut -b17-`
page=1;
packages=()
while [ "$packages_number" -gt 0 ]
do
  packages+=( `curl -q "https://api.github.com/users/$user/repos?page=$page&per_page=100" 2>/dev/null | grep  -o  "\"clone_url\".*\".*\"" | cut -b14-` )
 
  page=$((page+1))
  packages_number=$((packages_number-100))
done


[ $verbose -ge 1 ] && printf "%s\n" "${packages[@]}"


# create folder
mkdir -p $user
cd $user

# clone all repositories
for repo in "${packages[@]}"
do
  # remove the quotation ("xxx" -> xxx)
  tmp=${repo#?};
  tmp=${tmp%?};
  
  # get the folder
  folder=`echo $repo | grep -oE "(\w|\-)*\.git" | grep -oE "(\w|\-)*"`

  # clone if reps doesn't exit
  if [ ! -d "$folder" ]; then
    printf "%s\n" "git clone $tmp"
    git clone $tmp
    if [ $? -eq 0 ]
    then
      success_repos=$(( ${success_repos:=0}+1 ))
    fi
  else #fetch the latest one
    printf "%s\n" "git pull $folder"
    cd $folder
    git pull --rebase --force
    cd ..
  fi
done

printf "\n\n%s\n" "Success/Total=${success_repos:=0}/$total_repos"

