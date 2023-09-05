#!/bin/bash
# Settings

# This is overwritten if the terminal cannot output color, most of the time it should
export use_color=true

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# Enables command tracing
export DEBUG=false

# Set terminal editor
EDITOR=/usr/bin/nvim

# append to the history file, don't overwrite it
shopt -s histappend
# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

shopt -s expand_aliases
