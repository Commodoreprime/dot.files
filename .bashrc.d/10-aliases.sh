#!/bin/bash
# Generic aliases that are not dependent on a particular DE

# Enable color for various utilities if enabled
if [ "$use_color" = true ]; then
  alias ls='ls --color=auto'
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
  alias diff='diff --color=auto'
fi

# Defines useful aliases / overrides commands with switches enabled
alias df='df -h'               # human-readable sizes
alias free='free -m'           # rebinds free to also show sizes in MB
alias cp="cp -vi"              # confirm before overwriting something and verbose
alias mv="mv -vi"              # verbose and iteractive (prompt before overwriting)
alias rm="rm -vI"              # verbose and slightly less, though still, interactive
alias np='$EDITOR -w PKGBUILD' # begin writing a new PKGBUILD file in current directory
alias l='ls -CFN'              # prints standard ls output with characters appended to end to describe type 
alias la='ls -AN'              # prints with standard ls output but includes hidden .files but not '.' '..'
alias ll='ls -alFihN'          # prints directories/files with additional info in list form using human readable sizes
alias nv='nvim'                # shorthand for neovim command

alias tree='tree -lCF'  # prints tree in a format visually similar to ls --color=auto -F
alias treel='tree -ah'  # same as tree but prints hidden directories and print file sizes

alias extip='curl icanhazip.com' # grabs External ip address
alias llports='netstat -tulanp'  # print tcp and udp port table
alias ..='cd ..'                 # shorthand for going up a directory
alias lns='ln -sn'               # executes ln with symbolic and no defference switches on
alias ping='ping -c 6 '          # define number of pings for address, can be overrwritten using new -c flag
alias shred='shred -vzun 7 '     # shreds a given file or files with useful flags, removes the file in the end

alias virshsy='virsh -c qemu:///system' # run virsh within the system hypervisor context

# Hehehe
alias docker='podman'

# Terminal <--> UI
alias copy='xclip -sel clip'
alias paste='xclip -sel clip -o'

# flatpak VSCodium IDE
alias codium='flatpak run --file-forwarding --command=/app/bin/codium com.vscodium.codium --new-window'
alias vscode='codium'

alias protontricks='flatpak run com.github.Matoking.protontricks'

#alias gb='/usr/bin/git branch 2>/dev/null || echo "Not in a git repository"'

