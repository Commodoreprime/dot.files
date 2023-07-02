#!/bin/bash
# Post and Pre command hooking system

# shellcheck disable=2068 source=/dev/null

__common_command_hook__script_launching__() {
	# Initalize basic vars from input arguments
	local script_path_base="$1"
	[ -d "$script_path_base" ] || return
	local program_name="$2"
	local script_paths=()
	# Add script.d and script.sh paths if they exist
	local script_file_path="$script_path_base/$program_name.sh"
	[ -f "$script_file_path" ] && \
		script_paths+=("$script_file_path")
	local script_dir_path="$script_path_base/$program_name"
	[ -d "$script_dir_path" ] && \
		script_paths+=("$script_dir_path/*")
	# Add base directory last as it has lowest priority
	script_paths+=("$script_path_base/*")
	unset script_file_path script_dir_path program_name script_path_base
	# Iterate over all paths and source files
	for rc in ${script_paths[@]}; do
		case "$rc" in
			*.sh) [ -f "$rc" ] && source "$rc"
			;;
		esac
	done
}

# This runs before a command is executed
__pre_command_hook__() {
	COMMAND_PROGRAM="$1"
	shift
	COMMAND_ARGS="$*"
	export COMMAND_PROGRAM
	export COMMAND_ARGS
	__common_command_hook__script_launching__ \
		"$HOME/.bashrc.d/hooks/pre" \
		"$COMMAND_PROGRAM"
	return 0
}

# This runs after a command has executed
__post_command_hook__() {
	EXIT_CODE="$?"
	export EXIT_CODE
	__common_command_hook__script_launching__ \
		"$HOME/.bashrc.d/hooks/post" \
		"$COMMAND_PROGRAM"
	unset COMMAND_PROGRAM
	unset COMMAND_ARGS
	unset EXIT_CODE
	return 0
}

# Launches __post_command_hook__ passing the last return status
__post_command_hook__wrapper__() {
	__post_command_hook__ "$?"
}

# Implement command pre/post command launch hooks

# post command hook
old_prompt_command="$PROMPT_COMMAND"
PROMPT_COMMAND="__post_command_hook__wrapper__"
PROMPT_COMMAND+=("$old_prompt_command")
unset old_prompt_command

# Trap for running pre command hook, does not run if command is PROMPT_COMMAND
__debug_trap__() {
	for pcmd in "${PROMPT_COMMAND[@]}"; do
		[ "$BASH_COMMAND" = "$pcmd" ] && return 0
	done
		__pre_command_hook__ ${BASH_COMMAND[@]}
}
trap __debug_trap__ DEBUG
