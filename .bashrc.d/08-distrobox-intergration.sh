#!/bin/bash
# Implements various (host) shell intergrations for Distrobox
# Features:
#   include ~/.local/bin.dibx into $PATH
#   ...

if ! [[ "$PATH" =~ $HOME/.local/bin.dibx: ]]
then
    PATH="$HOME/.local/bin.dibx:$PATH"
fi

export PATH
