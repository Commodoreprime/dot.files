#!/bin/bash
# Proton related shell intergrations

# When launched in a proton enviroment, bash will try to fetch the command string.
# Steam must echo the launch command into the specified file via custom launch options
#  something like: echo "%command%" > /file/location; + some term. emulator

if [ -f "/tmp/STEAM_COMMAND" ]; then
  STEAM_COMMAND="$(cat /tmp/STEAM_COMMAND)"
  export STEAM_COMMAND
  rm /tmp/STEAM_COMMAND
fi
