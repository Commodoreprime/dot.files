# dot.files
dotfiles.... mmmm

## What is this
This is my repository to ~~store~~ share with the world! My configuration files for config purposes.

## Notable files and what they do

#### `bashrc`
This implements a custom bashrc bootstrap script that loads files sequentially from a `.bashrc.d` directory.

It also implements some other things which should be obvious when looking at the file.

#### `.bash_profile`
Effectivly the same as `.bashrc` but also reads `.bash_profile.d` directory before reading `.bashrc`.

#### `.bashrc.d`
Main star of the show here. This is a directory that is read as a series of shell scripts to configure
the users shell dynamically and with the ability to turn on/off certain features, its the modern age baby!

The directory has a [README](.bashrc.d/README.md) that helps explain specifics.

#### `scripts/`
A variety of shell, python, powershell or other scripting like script files for automation type work / shortcuts.

Contains a [README](scripts/README.md) for details on certain script files.
The files themselves in addition should have at least light documentation at the top of the file.

## Installation and requirements
Run `make install` to install files relative to the users home directory.
