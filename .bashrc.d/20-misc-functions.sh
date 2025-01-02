#!/bin/bash
# shellcheck disable=SC2164
# Functions that don't need dedicated files

# Prints keycodes with xev in a readable format
# https://wiki.archlinux.org/index.php/Keyboard_input#Identifying_keycodes_in_Xorg
output-keycodes() {
  xev | awk -F'[ )]+' '/^KeyPress/ { a[NR+2] } NR in a { printf "%-3s %s\n", $5, $8 }'
}

# Make directory and immediatly change directory into it
# This only supports one argument only and is pretty rutementry
mkcd() {
  case "$1" in
    "--help"|"-h")
      mkdir --help
      cd --help
      return 0 ;;
    *) mkdir "$1" && cd "$1" ;;
  esac
}

# Quickly verify if checksums for md5 and sha1 match when given a sum string and file path
# usage: <target file> <*sum>
sha1check(){
  [ "$(sha1sum "$1" | cut -d' ' -f1)" = "$2" ] && echo "sha1sums match!" || echo "sha1sums DON'T match! ($1 != $2)"
}
md5check(){
  [ "$(md5sum "$1" | cut -d' ' -f1)" = "$2" ] && echo "md5sums match!" || echo "md5sums DON'T match! ($1 != $2)"
}
