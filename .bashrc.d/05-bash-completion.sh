#!/bin/bash
# Configures autocompetion

# Starts bash autocompletion routines
[ -r /usr/share/bash-completion/bash_completion ] && . /usr/share/bash-completion/bash_completion

complete -cf sudo
