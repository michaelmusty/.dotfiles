# Prepend arguments from a file to the given arguments for a command
self=apf

# Require at least two arguments
if [ "$#" -lt 2 ] ; then
    printf >&2 '%s: Need an arguments file and a command\n' "$self"
    exit 2
fi

# First argument is the file containing the null-delimited arguments
argf=$1 cmd=$2
shift 2

# If there were arguments given on the command line, we need to be careful and
# prepend our ones first
if [ "$#" -gt 0 ] ; then

    # Iterate through any remaining arguments
    for carg ; do

        # If this is the first command argument, then before we add it, we'll
        # add all the ones from the file first if it exists
        if [ -n "$argf" ] ; then

            # Reset the positional parameters
            set --

            # Put our file arguments in first before we continue with the loop
            if [ -e "$argf" ] ; then
                while IFS= read -r farg ; do
                    case $farg in
                        '#'*) continue ;;
                        *[![:space:]]*) ;;
                        *) continue ;;
                    esac
                    set -- "$@" "$farg"
                done < "$argf"
            fi

            # Unset the argfile so we don't repeat this bit
            unset -v argf
        fi

        # Stack the original invocation argument back onto the positional
        # parameters
        set -- "$@" "$carg"
    done

# If there weren't, we can just read the file and slap them in
elif [ -e "$argf" ] ; then
    while IFS= read -r farg ; do
        case $farg in
            '#'*) continue ;;
            *[![:space:]]*) ;;
            *) continue ;;
        esac
        set -- "$@" "$farg"
    done < "$argf"
fi

# Run the command with the changed arguments
exec "$cmd" "$@"
