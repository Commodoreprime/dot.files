#!/bin/bash

export GIT_AWARE_IS_REPO=0
export GIT_AWARE_IS_DETACHED=0

# Determin git branch with flavoring
check_git() {
  [ -x /usr/bin/git ] || return
  local current_branch="$(git branch --no-color 2>/dev/null | grep '*' | cut -c 3-)"
  [ -z "$current_branch" ] && return
  GIT_AWARE_IS_IN_REPO=1
  case "$current_branch" in
  # Checks if the head is in a detached state, this trims excess text leaving only the branch/tag name.
  # This could be optimized better but it works
  '(HEAD detached at'*)
    GIT_AWARE_IS_DETACHED=1
    current_branch="$(cut -c 19- <<<"$current_branch" | rev | cut -c 2- | rev)"
    ;;
  esac
  # test if $1 == true for color support, for some reason does not work any other way?
  if [ "$1" = true ]; then
    printf ' ('
    [ $GIT_AWARE_IS_DETACHED = 1 ] && printf "%s{" "$(color yellow bold)"
    printf "%s%s" "$(color green)" "$current_branch"
    [ $GIT_AWARE_IS_DETACHED = 1 ] && printf "%s}" "$(color yellow bold)"
    printf "%s)" "$(color reset)"
  else
    printf ' ('
    [ $GIT_AWARE_IS_DETACHED = 1 ] && printf '{'
    printf "%s" "$current_branch"
    [ $GIT_AWARE_IS_DETACHED = 1 ] && printf '}'
  fi 
}

# Used to check if in a proton enviroment
test_proton_wine() {
  [ -z "$PROTON_PATH" ] && return
  ct_name="$(printf "%s" "$PROTON_PATH" | awk -F'/' '{print $NF}')"
  if [ "$1" = true ]; then
    printf "(%s" "$(color yellow)"
    printf "%s" "$ct_name"
    printf "%s)" "$(color reset)"
  else
    printf "(%s)" "$ct_name"
  fi
}

# TODO: Reimplement in python?
pathcolorer() {
  case "$PWD" in
    # If path is strictly only $HOME, only print ~ in blue
    "$HOME")
      printf "%s~" "$(color blue bold)"
    ;;
    # If any other path, do this
    *)
      colored_path=()
      CPWD="$PWD"
      while [ "$CPWD" != "/" ]; do
        DNAME="$(rev <<<"$CPWD" | cut -d'/' -f1 | rev)"
        if [ -L "$CPWD" ]; then
          colored_path+=("$(color lightblue bold)$DNAME$(color blue bold)")
        else
          colored_path+=("$DNAME")
        fi
        CPWD="$(dirname "$CPWD")"
      done
      color_path="$(color blue bold)"
      i="${#colored_path[@]}"
      while [[ "$i" -ge 0 ]]; do
        color_path="$color_path${colored_path[$i]}/"
        i=$(("$i" - 1))
      done
      printf "%s" "$color_path" | sed "s|${HOME}|~|"
    ;;
  esac
}

if [ "$use_color" = true ]; then
  export PS1='\[$(color green bold)\]\u@\H\[$(color reset)\]\[$(check_git true)\]\[$(test_proton_wine true)\]:\[$(pathcolorer)\]\[$(color reset)\]\n └\$ '
else
  export PS1='\u@\H$(check_git)$(test_proton_wine):\w\n └\$ '
fi
