#!/bin/bash
#
# Author: Asghar Ghorbani ghorbani59@gmail.com 
#
# An script for ploting virtual physical memory uasge of a java based command
# though all java alternatives that are installed.
# NOTE: this code will work in machine that have update-alternatives commands.
#
# Example:
# > run.sh -c "Java Main" -o "mem_usage_of_Main_App.csv"
#

# set -e somehow does not work with update-alternatives.
# Then don't forget to run it with sudo.
## handle() {
##   echo "An error occured! It could be that you need to run as sudo." 
## }
## trap handle 0
## set -euo pipefail

OUTPUT=""
CMD=""

progname=$0

function usage () {
  cat <<EOF
Usage: $progname -c command -o filename  
EOF
  exit 0
}

while getopts "c:o:h?" opt; do
   case $opt in
   c )  CMD=$OPTARG ;;
   o )  OUTPUT=$OPTARG ;;
   h|\? )  usage ;;
   esac
done
if [ -z "$OUTPUT" ] || [ -z "$CMD" ]; then
  usage
fi

header="version,pid,vmem,pmem" 

JVMs=$(update-alternatives --list java)
current_java_path=$(update-alternatives --query java | grep Value | cut -d' ' -f 2) 
echo $header > $OUTPUT 

for java_path in $JVMs
do
  ver=$(echo $java_path | cut -d'/' -f 5)
  echo "Java Version: $ver"
  update-alternatives --quiet --set java $java_path
  $CMD &
  PID=$!
  echo "PID: $PID"
  ifCMDrunning="yes"
  while [ -n "$ifCMDrunning" ]; do 
    ps -o pid,vsz,rss | grep $PID | cut -d' ' --output-delimiter="," -f 1- | awk -v var="$ver" '{print var","$1}' | sed 's/,\{1,\}/,/g' >> $OUTPUT
    ifCMDrunning=$(ps -o pid,cmd | grep -v grep | grep $PID)
    # echo "ifcCMD: $ifCMDrunning"
  done
done

update-alternatives --quiet --set java $current_java_path

