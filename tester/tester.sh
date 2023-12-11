#!/bin/bash

function help() {
  echo HEEEEEEELP
}

function compare() {
  # files must be in correct format "*_in"
  # check if path is directory
   for FILE_IN in "$2"/*_in; do
     cat "$FILE_IN"
     echo
   done
}

function generate_output () {

  #check if binary exists
  if [ ! -e "$1" ]; then
    echo "File doesn't exist. Did you write it correctly?"
    exit
  fi

  #check if data input is dir or empty
  if [ ! -d "$2" ]; then
    echo "Directory doesn't exist. Did you write it correctly?"
    exit
  fi

  if [ ! "$(ls -A "$2")" ]; then
    echo "Directory is empty. Did you write it correctly?"
    exit
  fi

  if [ ! -d "$3" ]; then
    mkdir "$3"
  fi

  local i=0
  for IN_FILE in "$2"/*in*; do
    ./"$1" < "$IN_FILE" > "$3"/"$i"_out.txt
    i=$((i + 1))
  done
}

function delete_output() {
  echo sds
}

PATH_TO_BIN=a.out
PATH_TO_INPUT="$PWD"/sample/CZE
PATH_TO_OUTPUT="$PWD"/output
KEEP=0



while getopts ":ht:s:o:k:" option; do
  case "$option" in
    h) help; exit;;
    t) PATH_TO_BIN="$OPTARG";;
    s) PATH_TO_INPUT="$PWD/$OPTARG";;
    o) PATH_TO_OUTPUT="$PWD/$OPTARG";;
    k) PATH_TO_OUTPUT="$OPTARG"; KEEP=1;;
    \?) echo "Not a flag, exiting..."; exit;;
  esac
done

shift $((OPTIND - 1))

generate_output "$PATH_TO_BIN" "$PATH_TO_INPUT" "$PATH_TO_OUTPUT"

if [ "$KEEP" -eq 0 ]; then
  delete_output "$PATH_TO_OUTPUT"
fi


