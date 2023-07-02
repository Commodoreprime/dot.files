#!/bin/bash
# Functions that don't need dedicated files

# Prints all terminal colors
colors() {
  local fgc bgc vals seq0

  printf "Color escapes are %s\n" "\e[${value};...;${value}m"
  printf "Values 30..37 are \e[33mforeground colors\e[m\n"
  printf "Values 40..47 are \e[43mbackground colors\e[m\n"
  printf "Value  1 gives a  \e[1mbold-faced look\e[m\n\n"

  # foreground colors
  for fgc in {30..37}; do
    # background colors
    for bgc in {40..47}; do
      fgc=${fgc#37} # white
      bgc=${bgc#40} # black

      vals="${fgc:+$fgc;}${bgc}"
      vals=${vals%%;}

      seq0="${vals:+\e[${vals}m}"
      printf "  %-9s" "${seq0:-(default)}"
      printf " %sTEXT\e[m" "${seq0}"
      printf " \e[%s1mBOLD\e[m" "${vals:+${vals+$vals;}}"
    done
    echo; echo
  done
  return 0
}

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
    *)
      mkdir "$1"
      cd "$1" ;;
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
