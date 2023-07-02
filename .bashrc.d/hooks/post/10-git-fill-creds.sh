#!/bin/bash
# Run operations for git repository vendors

#TODO: Check if git clone exited with error, if so, dont do anything
gitcloneoutput_file="/tmp/git.clone.output"
if [ -f $gitcloneoutput_file ] && [ $EXIT_CODE = 0 ]; then
  OLDPWD="$PWD"
  cd "$(cat "$gitcloneoutput_file")"
  remote_origin_url="$(git config --local --get remote.origin.url)"
  remote="$(printf %s "$remote_origin_url" | cut -d':' -f1)"
  user="$(printf %s "$remote_origin_url" | cut -d':' -f2 | cut -d'/' -f1)"
  if [ "$remote" = "git@github.com" ]; then
    values="$(grep '^\#>> github.com '$user'' -A2 ~/.gitconfig | grep '^\#> ')"
    if [ ! -z "$values" ]; then
      git config --local user.email "$(printf %s "$values" | grep 'email' | cut -d'=' -f2 |xargs)"
      git config --local user.name "$(printf %s "$values" | grep 'name' | cut -d'=' -f2 |xargs)"
    fi
    echo "Added account information for GitHub"
  fi
  cd "$OLDPWD"
  /usr/bin/rm "$gitcloneoutput_file"
fi
