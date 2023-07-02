#!/bin/sh
# Display related configuration settings that can be *dynamically* applied

# Guard that returns if DISPLAY var is not found
[ "$DISPLAY" ] || return 0

xrandr --dpi 96
