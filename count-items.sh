#!/bin/bash
##################################################
# Name: count.sh
# Description: Basic script to count files or directories withing a specified location
# Script Maintainer: Attila Antal
#
# Last Updated: February 12th 2018
##################################################
#

## Common
SOURCE=`pwd`
SCRIPTFILE=`basename $0`
SCRIPTDIR=`dirname $0`
NOW=$(date +"%Y-%m-%d|%H:%M:%S.%s")

## Some colors
RED="\033[0;31m"
GREEN="\033[0;32m"
NC="\033[0m"

## Default values
SOURCE=`pwd`
NAME="someFile"
MAXDEPTH=1
TYPE="f"

# Usage Help text
read -r -d '' USAGE <<- EOM
Program to count the number of item in a specified directory${NC}

USAGE:
    ${SCRIPTFILE} [OPTION]...

OPTIONS:
    -s, --source        Source directory (default is working dirrectory: ${SOURCE})
    -n, --name          Name of file/directory (default is: ${NAME})
    -t, --type          Type of item, f for File, d for Directory (default: ${TYPE})
    -d, --depth         Maximum depth (default: ${MAXDEPTH})
    -h, --help,-?       Prints this usage

EXAMPLE:
    ${SCRIPTFILE} -w /path/to/dir -n some-name -t f -d 2
EOM

# Processing arguments
while [ $# -gt 0 ]
do
    case "$1" in
        -s|--sourcedir)
                [ -z "$2" ] && printf "\n${USAGE}\n"; exit $E_OPTERROR;
                SOURCE="$2"; shift;;
        -n|--name)
                NAME="$2"; shift;;
        -d|--depth)
                [ -z "$2" ] && printf "\n${USAGE}\n"; exit $E_OPTERROR;
                if ! [[ "$2" =~ ^[0-9]+$ ]]; then printf "\n${USAGE}"; exit $E_OPTERROR; fi ## If maxdepth is not numeric, exit
                MAXDEPTH="$2"; shift;;
        -t|--type)
                [ -z "$2" ] && printf "\n${USAGE}\n"; exit $E_OPTERROR;
                TYPE="$2"; shift;;
        -?|-h|--help)
                [ -z "$2" ] && printf "\n${USAGE}\n"; exit $E_OPTERROR;
                printf "\n${USAGE}\n\n"; exit;;
        *)
                printf -e "\nERROR: Unknown parameter: $1\n";
                printf "\n${USAGE}\n"; exit $E_OPTERROR;;
    esac
    shift
done

## Loop through the source folder and count the items
COUNTER=0
for item in `find $WORKDIR -maxdepth $MAXDEPTH -name $NAME -type $TYPE`; do
        let COUNTER++
done

case "${TYPE}" in
        d) if [ $COUNTER -gt 0 ]; then SELECTEDTYPE="directories"; else SELECTEDTYPE="directory"; fi ;;
        f) if [ $COUNTER -gt 0 ]; then SELECTEDTYPE="files"; else SELECTEDTYPE="file"; fi ;;
esac

if [ $COUNTER -gt 0 ]; then
        COUNTER="${GREEN}${COUNTER}${NC}"
else
        COUNTER="${RED}${COUNTER}${NC}"
fi

## Print the results
printf "Found $COUNTER $SELECTEDTYPE with the name containing \"${NAME}\" in $SOURCE\n"
