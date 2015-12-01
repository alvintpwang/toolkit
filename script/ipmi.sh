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



sol()
{
  #config data   name, ip, id, password
  declare -A machines;
  machines+=( "palmetto1" "192.168.1.150" "ADMIN" "admin" )
  machines+=( "palmetto2" "192.168.1.150" "ADMIN" "admin" )
  #machines+=( "firestone" "192.168.1.150" "ADMIN" "admin" )
  #machines+=( "palmetto1" "192.168.1.150" "ADMIN" "admin" )

  item+=( "palmetto1:ipmitool -H 192.168.1.150 -I lanplus -U ADMIN  -P admin sol deactiveate" )
  menu "${item[@]}" Quit: ## pass array to menu function
}

# main
# check subcommand
if [ ${1:0:1} != - ]
then
  subcmd=${1}
  shift
fi


# $OPTARG
optstring=hv
while getopts $optstring opt
do
  case $opt in
    h) usage exit 0;;
    v) verbose=$(( $verbose + 1 )); set -x;;
    *) printf "Not supported option %s" $opt; exit 1 ;;
 esac
done


# subcmd handler
case $subcmd in
  "sol") sol ;;
  *) printf "Not supported sub command: $subcmd \n" ;;
esac





