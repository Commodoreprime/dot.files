#!/bin/bash
# Add the real paths of symlinks under paths/* to PATH, if they exist
# Order is presented in reverse, so if one is called 01 and the other is called 00,
#  01 is added first, then 00, resulting in PATH=/path/to/00:/path/to/01:... .

PATH="/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin"

if [ -d ~/.bashrc.d/paths ]; then
    for _path in $(find ~/.bashrc.d/paths/ -type l | sort -r); do
        real_path="$(realpath "${_path}")"
        if [ -d "${real_path}" ] && ! [[ "${PATH}" =~ ${real_path}: ]]; then
            print_log "Adding \"${real_path}\" to PATH"
            PATH="${real_path}:${PATH}"
        fi
    done
fi

print_log  "PATH is now \"${PATH}\""
export PATH
