#!/bin/bash
# shellcheck source=/dev/null
# .bash_profile

# First, execute scripts from .bash_profile.d
if [ -d ~/.bash_profile.d ]; then
	for rc in ~/.bash_profile.d/*; do
		case "$rc" in
			*.sh) . "${rc}" ;;
		esac
	done
fi

# Run .bashrc scripts
if [ -f "${HOME}/.bashrc" ]; then
	. "${HOME}/.bashrc"
fi
