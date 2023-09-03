#!/bin/bash
# Declares functions useful for outputting and testing colors
# Knowledge is mostly sourced from: https://misc.flogisoft.com/bash/tip_colors_and_formatting

# This outputs control sequences for formatting and coloring terminal output.
# The syntax is as follows:
#  color [<color>] [bg|background <color>] [fg|foreground <color>]
#        [bold] [brighten] [dim] [underline] [blink] [invert] [reverse]
#        [hidden] [passwd] [reset]
# Arguments can be specified in any order. Except when specifying a color as a foreground or background,
#   in that case the operation must be specified before the color.
# All arguments are optional, if no arguments are specified, see 5 below.
# 1. If a fg or bg operation is specified multiple times, the last operator will take precedence.
#   For example: `color bg blue fg yellow bg red # the background will be red as it was specified last.`
# 2. If there are multiple formatting operatiors, they will stack. Results will vary depending on the terminal.
#   For example: `color fg red bold underline # this should result in bolded, underlined, red text`
# 3. If a color is specified without an accomanying operator, then the color will be applied as a foreground color (shorthand).
#   Because the shorthand outputs as a foreground color control sequence, rule 1 applies when specifying fg multiple times.
# 4. If 'reset' is specified then all other operations are discarded and will return a sequence where formatting and colors are back to normal.
# 5. If no operation is specified then it will do the same thing as if reset was specified (shorthand).
color() {
    # Reset control sequence only if num of args is == 0 or reset is found in arguments
    if [ "$#" -eq 0 ] || [ "$(expr "$*" : '.*reset.*')" -gt 0 ]; then
        printf "\e[0m"
        return
    fi
    declare -A colors
    declare -A formats
    # Text coloring definitions
    colors["black"]=30
    colors["red"]=31
    colors["green"]=32
    colors["yellow"]=33
    colors["blue"]=34
    colors["magenta"]=35
    colors["purple"]=${colors["magenta"]}
    colors["cyan"]=36
    colors["lightgray"]=37
    colors["darkgray"]=90
    colors["lightred"]=91
    colors["lightgreen"]=92
    colors["lightyellow"]=93
    colors["lightblue"]=94
    colors["lightmagenta"]=95
    colors["lightpurple"]=${colors["lightmagenta"]}
    colors["lighcyan"]=96
    colors["white"]=97
    # Text formatting definitions
    formats["bold"]=1
    formats["bright"]=${formats["bold"]}
    formats["dim"]=2
    formats["underline"]=4
    formats["blink"]=5
    formats["invert"]=7
    formats["reverse"]=${formats["invert"]}
    formats["hidden"]=8
    formats["passwd"]=${formats["hidden"]}
    arguments=("$@")
    for ((i=0; i<"${#arguments[@]}"; i++)); do
        arg="${arguments[$i]}"
        next_arg="${arguments[$((i+1))]}"
        case "$arg" in
            "fg"|"foreground")
                [ -z "$next_arg" ] && continue
                fg_color="${colors[${next_arg}]}"
                printf "\e[%sm" "$fg_color" ;;
            "bg"|"background")
                [ -z "$next_arg" ] && continue
                bg_color="$(( "${colors[${next_arg}]}" + 10 ))"
                printf "\e[%sm" "$bg_color" ;;
            *)  # Handles control sequences that don't have an operator parent
                # This is also a shorthand for specifying a foreground color
                ctrl_seq="${formats[${arg}]}"
                # If the sequence is not part of formats,
                if [ -z "$ctrl_seq" ]; then
                    # try colors.
                    ctrl_seq="${colors[${arg}]}"
                    # If still not found, give up.
                    [ -z "$ctrl_seq" ] && continue
                fi
                # Otherwise if there is a value, print it.
                printf "\e[%sm" "$ctrl_seq"
            ;;
        esac
    done
    unset colors
    unset formats
}

# Prints 256 or 16 color terminal color array
colors() {
    if [ "$1" = "256" ]; then
        for fgbg in 38 48 ; do # Foreground / Background
            for color in {0..255} ; do # Colors
                # Display the color
                printf "\e[${fgbg};5;%sm  %3s  \e[0m" "$color" "$color"
                # Display 6 colors per lines
                if [ $((("$color" + 1) % 6)) == 4 ] ; then
                    echo # New line
                fi
            done
            echo # New line
        done
    else # 16 colors
        #Background
        for clbg in {40..47} {100..107} 49 ; do
            #Foreground
            for clfg in {30..37} {90..97} 39 ; do
                #Formatting
                for attr in 0 1 2 4 5 7 ; do
                    #Print the result
                    printf "\e[%s;%s;%sm \\\e[%s;%s;%sm \e[0m" \
                        "$attr" "$clbg" "$clfg" "$attr" "$clbg" "$clfg"
                done
                echo #Newline
            done
        done
    fi
}
