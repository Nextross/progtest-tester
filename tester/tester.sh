#!/bin/bash

function help() {
  echo HEEEEEEELP
}

function compare() {
   for FILE_IN in "$2"/*_in; do
     cat "$FILE_IN"
     echo
   done
}

function generate_output () {
  if [ ! -e "$1" ]; then
    echo "File doesn't exist. Did you write it correctly?"
    exit
  fi

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
  rm -rd "$1"
}

function get_params() {
  while getopts ":ht:s:o:k" option; do
    case "$option" in
      h) help; exit;;
      t) PATH_TO_BIN="$OPTARG";;
      s) PATH_TO_INPUT="$PWD/$OPTARG";;
      o) PATH_TO_OUTPUT="$PWD/$OPTARG";;
      k) KEEP=1;;
      \?) echo "Not a flag, exiting..."; exit;;
    esac
  done
  shift $((OPTIND - 1))
}

function main() {
  PATH_TO_BIN=a.out
  PATH_TO_INPUT="$PWD"/sample/CZE
  PATH_TO_OUTPUT="$PWD"/output
  KEEP=0

  get_params "$1"
  generate_output "$PATH_TO_BIN" "$PATH_TO_INPUT" "$PATH_TO_OUTPUT"

  if [ "$KEEP" -eq 0 ]; then
    delete_output "$PATH_TO_OUTPUT"
  fi
}

main "$@"