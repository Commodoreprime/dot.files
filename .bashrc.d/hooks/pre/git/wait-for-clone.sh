#!/bin/bash

case "$COMMAND_ARGS" in
    "clone"*) inotifywait -q -t 10 --format '%w%f' -e create "$PWD" &> /tmp/git.clone.output & disown ;;
esac
