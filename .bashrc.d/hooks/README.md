### Grammar
`~/.bashrc.d/hooks/{pre,post}/*.sh|/[command/*.sh|command.sh]`

## Explanations
### pre
Run scripts that run before a command should execute.

### post
Run scripts that run after a command finishes executing.

### command
Optional command and/or directory that specifically runs based on program name.
Acts equivilently to a case statement (but without the globbing / RegEx).

## additional information
If the command directory or file is present, it will execute that first,
then it will iterate over the rest of the scripts.

## Interfaces
This hooking system exposes multiple variables during script execution:
| | |
|:---:|---|
|`COMMAND_ARGS`    | Arguments given from the command-line, equivilent to `$@` after `shift 1`. Exposed in both pre and post hooks
|`COMMAND_PROGRAM` | The command name given from the command-line, equivilent to bash `$1`. Exposed in both pre and post hooks
|`EXIT_CODE`       | The exit code given by the program once it finished executing. Only exposed in the post hook
