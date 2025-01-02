#!/bin/bash
# ~/.bashrc
# Based on Manjaro/Arch, Ubuntu and Fedora default .bashrc files
#  As well as sections grabbed from various sources, lost to time
#
# This bashrc operates a more configurable setup,
#  utilizing seperate shell scripts that can be loaded individually
#

# shellcheck source=/dev/null

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
        export use_color=true
    else
        export use_color=false
    fi
fi

# Check if in a WSL2 environment
if [ -f /proc/sys/fs/binfmt_misc/WSLInterop ]; then
    export USING_WSL2=true
else
    export USING_WSL2=false
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# [ "$DEBUG" = true ] && set -x

print_log() {
    [ "$DEBUG" = true ] && printf "([%s] %s)\n" "${__DEBUG_ORIGIN_FILE}" "$*"
}

# shellcheck disable=2088
__DEBUG_ORIGIN_FILE='~/.bashrc'

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        case "$rc" in
            *.sh)
            __DEBUG_ORIGIN_FILE="$(basename "${rc}")"
            . "$rc" ;;
        esac
    done
fi

unset rc
unset use_color
unset USING_WSL2
unset __DEBUG_ORIGIN_FILE
