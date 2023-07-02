#!/bin/bash
# ~/.bashrc
# Based on Manjaro/Arch, Ubuntu and Fedora default .bashrc files
#  As well as sections grabbed from various sources, lost to time
#
# This bashrc operates a more configurable setup,
#  utilizing seperate shell scripts that can be loaded individually
#

# Untrap DEBUG signal so it does not get in the way
trap - DEBUG

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

[ "$VTE_VERSION" ] && source /etc/profile.d/vte.sh

case "$-" in
        # Don't do anyting if not running interactivly
    !*i*) return ;;
        # Checks if terminal is being sourced
    *s*) echo "Resourcing" ;;
esac

# Determins if terminal has color support, overrides use_color if it does not
if [ "$use_color" = true ] ; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >& /dev/null ; then
        use_color=true
    else
        use_color=false
    fi
fi

# User specific environment
if ! [[ "$PATH" =~ $HOME/.local/bin:$HOME/bin: ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

[ "$DEBUG" = true ] && set -x

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        case "$rc" in
            *.sh) . "$rc" ;;
        esac
    done
fi

unset rc
unset use_color
