# Frontend to controlling prompt
prompt() {

    # If no arguments, print the prompt strings as they are
    if ! (($#)) ; then
        declare -p PS1 PS2 PS3 PS4
        return
    fi

    # What's done next depends on the first argument to the function
    case $1 in

        # Turn complex, colored PS1 and debugging PS4 prompts on
        on)
            # Declare the PROMPT_RETURN variable as an integer
            declare -i PROMPT_RETURN

            # Set up pre-prompt command
            PROMPT_COMMAND='PROMPT_RETURN=$? ; history -a'

            # Set up prompt, including optional PROMPT_PREFIX and PROMPT_SUFFIX
            # variables
            PS1='[\u@\h:\w]'
            PS1=$PS1'$(prompt job)'
            PS1=$PS1'$(prompt ret)'
            PS1='${PROMPT_PREFIX}'$PS1
            PS1=$PS1'${PROMPT_SUFFIX}'
            PS1=$PS1'\$'

            # If Bash 4.0 is available, trim very long paths in prompt
            if ((BASH_VERSINFO[0] >= 4)) ; then
                PROMPT_DIRTRIM=4
            fi

            # Count available colors
            local -i colors
            colors=$( {
                tput Co || tput colors
            } 2>/dev/null )

            # Prepare reset code
            local reset
            reset=$( {
                tput me || tput sgr0
            } 2>/dev/null )

            # Decide prompt color formatting based on color availability
            local format
            case $colors in

                # Check if we have non-bold bright green available
                256)
                    format=$( {
                        : "${PROMPT_COLOR:=10}"
                        tput AF "$PROMPT_COLOR" ||
                        tput setaf "$PROMPT_COLOR" ||
                        tput AF "$PROMPT_COLOR" 0 0  ||
                        tput setaf "$PROMPT_COLOR" 0 0
                    } 2>/dev/null )
                    ;;

                # If we have only eight colors, use bold green
                8)
                    format=$( {
                        : "${PROMPT_COLOR:=2}"
                        tput AF "$PROMPT_COLOR" ||
                        tput setaf "$PROMPT_COLOR"
                        tput md || tput bold
                    } 2>/dev/null )
                    ;;

                # For all other terminals, we assume non-color (!), and we just
                # use bold
                *)
                    format=$( {
                        tput md || tput bold
                    } 2>/dev/null )
                    ;;
            esac

            # String it all together
            PS1='\['"$format"'\]'"$PS1"'\['"$reset"'\] '
            PS2='> '
            PS3='? '
            PS4='+<$?> ${BASH_SOURCE:-$BASH}:$FUNCNAME:$LINENO:'
            ;;

        # Revert to simple inexpensive prompts
        off)
            unset -v PROMPT_COMMAND PROMPT_DIRTRIM PROMPT_RETURN
            PS1='\$ '
            PS2='> '
            PS3='? '
            PS4='+ '
            ;;

        # Show return status of previous command in angle brackets, if not zero
        ret)
            if ((PROMPT_RETURN > 0)) ; then
                printf '<%u>' "$PROMPT_RETURN"
            fi
            ;;

        # Show the count of background jobs in curly brackets, if not zero
        job)
            local -i jobc
            while read ; do
                ((jobc++))
            done < <(jobs -p)
            if ((jobc > 0)) ; then
                printf '{%u}' "$jobc"
            fi
            ;;

        # Print error
        *)
            printf '%s: Unknown command %s\n' "$FUNCNAME" "$1" >&2
            return 2
            ;;

    esac
}

# Start with full-fledged prompt
prompt on
