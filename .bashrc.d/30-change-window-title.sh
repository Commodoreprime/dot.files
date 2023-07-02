#!/bin/bash
# Change the window title of X terminals

# Shorthand to quickly change the title for future endevours
update_shell_title() {
  printf '\033]30;%s\007' "$1"
}

case ${TERM} in
  konsole*)
    update_shell_title "${USER}@${HOSTNAME%%.*}: ${PWD/#$HOME/\~}"
    ;;
  xterm*|rxvt*|Eterm*|aterm|kterm|gnome*|interix)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}: ${PWD/#$HOME/\~}\007"'
    ;;
  screen*)
    PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}: ${PWD/#$HOME/\~}\033\\"'
    ;;
esac
