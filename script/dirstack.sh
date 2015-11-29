#!/bin/bash

# This script is to speed up the CLI navigation

alias d='dirs -v'  # Show directory stacks 
alias b='pushd +1' # Go backward
alias f='pushd -0' # Go forward
alias pu='pushd'
alias po='popd'
alias 1='pushd +1'
alias 2='pushd +2'
alias 3='pushd +3'
alias 4='pushd +3'
alias 5='pushd +5'
alias 6='pushd +6'
alias 7='pushd +7'
alias 8='pushd +8'
alias 9='pushd +9'


cd() #@ Change directory, storing new directory on DIRSTACK
{
  local dir error ## variables for directory and return code

  while : ## ignore all options
  do
    case $1 in
      --) break ;;
      -*) shift ;;
       *) break ;;
    esac
  done

  dir=$1

  if [ -n "$dir" ] ## if a $dir is not empty
  then
    pushd "$dir" ## change directory
  else
    pushd "$HOME" ## go HOME if nothing on the command line
  fi 2>/dev/null ## error message should come from cd, not pushd

  error=$? ## store pushd's exit code

  if [ $error -ne 0 ] ## failed, print error message
  then
    builtin cd "$dir" ## let the builtin cd provide the error message
  fi
  return "$error" ## leave with pushd's exit code
} > /dev/null


cdm() #@ select new directory from a menu of those already visited
{
  local dir IFS=$'\n' item
  for dir in $(dirs -l -p) ## loop through diretories in DIRSTACK[@]
  do
    [ "$dir" = "$PWD" ] && continue ## skip current directory
    case ${item[*]} in
      *"$dir:"*) ;; ## $dir already in array; do nothing
      *) item+=( "$dir:cd '$dir'" ) ;; ## add $dir to array
    esac
  done
  menu "${item[@]}" Quit: ## pass array to menu function
}



menu()
{
  local IFS=$' \t\n' ## Use default setting of IFS
  local num n=1 opt item cmd
  echo

  ## Loop though the command-line arguments
  for item
  do
    printf " %3d. %s\n" "$n" "${item%%:*}"
    n=$(( $n + 1 ))
  done
  echo

  ## If there are fewer than 10 items, set option to accept key without ENTER
  if [ $# -lt 10 ]
  then
    opt=-sn1
  else
    opt=
  fi
  read -p " (1 to $#) ==> " $opt num ## Get response from user

  ## Check that user entry is valid
  case $num in
    [qQ0] | "" ) return ;; ## q, Q or 0 or "" exits
    *[!0-9]* | 0*) ## invalid entry
    printf "\aInvalid response: %s\n" "$num" >&2
    return 1
    ;;
  esac
  echo

  if [ "$num" -le "$#" ] ## Check that number is <= to the number of menu items
  then
    eval "${!num#*:}" ## Execute it using indirect expansion
  else
    printf "\aInvalid response: %s\n" "$num" >&2
   return 1
  fi
}





