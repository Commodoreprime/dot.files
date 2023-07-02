#!/bin/bash
# If environment is VSCodium flatpak, run intergrations

# Conditional guard
[ "$FLATPAK_ID" != "com.vscodium.codium" ] && return 0

#PATH="/run/host/usr/bin:$PATH"
#export PATH
