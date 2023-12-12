#!/bin/bash

# Version 1.0

function help() {
  echo HEEEEEEELP
}

function compare() {
  local RED='\033[0;31m' GREEN='\033[0;32m' NO_COLOR='\033[0m'
  local i=0

  for REF_FILE in "$1"/*out.txt; do
    OUT_FILE="$2"/"$i"_out.txt
    diff  "$REF_FILE" "$OUT_FILE" > tmp
    REF_FILE="$(echo "$REF_FILE" | grep -o '[0-9]*_out.txt')"

    if [ -s tmp ]; then
      printf "[${RED}FAILED${NO_COLOR}]: %s\n" "$REF_FILE"
      tail -n +2 tmp
      else
        printf "[${GREEN}OK${NO_COLOR}]: %s\n" "$REF_FILE"
    fi

    i=$((i + 1))
  done
  rm tmp
}

function generate_output () {
  if [ ! -e "$1" ]; then
    echo "File $1 doesn't exist. Did you write it correctly?"
    exit
  fi

  if [ ! -d "$2" ]; then
    echo "Directory $2 doesn't exist. Did you write it correctly?"
    exit
  fi

  if [ ! "$(ls -A "$2")" ]; then
    echo "Directory $2 is empty. Did you write it correctly?"
    exit
  fi

  if [ ! -d "$3" ]; then
    mkdir "$3"
  fi

  local i=0
  for IN_FILE in "$2"/*_in.txt; do
    OUT_FILE="$3"/"$i"_out.txt
    ./"$1" < "$IN_FILE" > "$OUT_FILE"
    i=$((i + 1))
  done
}

function delete_output() {
  rm -rd "$1"
}

function get_params() {
  while getopts ":ht:i:o:k" option; do
    case "$option" in
      h) help; exit;;
      t) PATH_TO_BIN="$OPTARG";;
      i) PATH_TO_INPUT="$PWD/$OPTARG";;
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

  get_params "$@"
  generate_output "$PATH_TO_BIN" "$PATH_TO_INPUT" "$PATH_TO_OUTPUT"
  compare "$PATH_TO_INPUT" "$PATH_TO_OUTPUT"

  if [ "$KEEP" -eq 0 ]; then
    delete_output "$PATH_TO_OUTPUT"
  fi
}

main "$@"