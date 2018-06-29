# Limit to ksh93; most of this works in mksh, but not all of it, and pdksh
# doesn't have a `typeset -p` that includes printable values at all.
case $KSH_VERSION in
    *' 93'*) ;;
    *) return ;;
esac

#
# keep -- Main function for kshkeep; provided with a list of NAMEs, whether
# shell functions or variables, writes the current definition of each NAME to a
# directory $KSHKEEP (defaults to ~/.kshkeep.d) with a .ksh suffix, each of
# which is reloaded each time this file is called. This allows you to quickly
# arrange to keep that useful shell function or variable you made inline on
# subsequent logins.
#
# Consider a shell function declared inline with the NAME 'ayy':
#
#   $ ayy() { printf '%s\n' lmao ; }
#   $ ayy
#   lmao
#   $ keep ayy
#   $ keep
#   ayy
#   $ exit
#
# Then, on next login, the function is redefined for you:
#
#   $ ayy
#   lmao
#
# To get rid of it:
#
#   $ keep -d ayy
#
function keep {

    # Name self
    typeset self
    self=keep

    # Figure out the directory to which we're reading and writing these scripts
    typeset kshkeep
    kshkeep=${KSHKEEP:-"$HOME"/.kshkeep.d}
    mkdir -p -- "$kshkeep" || return

    # Parse options
    typeset opt delete
    typeset OPTERR OPTIND OPTARG
    while getopts 'dh' opt ; do
        case $opt in

            # -d given; means delete the keepfiles for the given names
            d)
                delete=1
                ;;

            # -h given; means show help
            h)
                cat <<EOF
$self: Keep variables and functions in shell permanently by writing them to
named scripts iterated on shell start, in \$KSHKEEP (defaults to
~/.kshkeep.d).

USAGE:
  $self
    List all the current kept variables and functions
  $self NAME1 [NAME2 ...]
    Write the current definition for the given NAMEs to keep files
  $self -d NAME1 [NAME2 ...]
    Delete the keep files for the given NAMEs
  $self -h
    Show this help

EOF
                return
                ;;

            # Unknown other option
            \?)
                printf 'ksh: %s -%s: invalid option\n' \
                    "$self" "$opt" >&2
                return 2
                ;;
        esac
    done
    shift "$((OPTIND-1))"

    # If any arguments left, we must be either keeping or deleting
    if (($#)) ; then

        # Start keeping count of any errors
        typeset -i errors
        errors=0

        # Iterate through the NAMEs given
        typeset name
        for name ; do

            # Check NAMEs for validity
            case $name in

                # NAME must start with letters or an underscore, and contain no
                # characters besides letters, numbers, or underscores
                *[!a-zA-Z0-9_]*|[!a-zA-Z_]*)
                    printf 'ksh: %s: %s not a valid NAME\n' \
                        "$self" "$name" >&2
                    ((errors++))
                    ;;

                # NAME is valid, proceed
                *)

                    # If -d was given, delete the keep files for the NAME
                    if ((delete)) ; then
                        rm -- "$kshkeep"/"$name".ksh ||
                            ((errors++))

                    # Save a function
                    elif [[ $(whence -v "$name" 2>/dev/null) == *' is a function' ]] ; then
                        typeset -f -- "$name" >"$kshkeep"/"$name".ksh ||
                            ((errors++))

                    # Save a variable
                    elif [[ -n "$name" ]] ; then
                        typeset -p -- "$name" >"$kshkeep"/"$name".ksh ||
                            ((errors++))
                    fi
                    ;;
            esac
        done

        # Return 1 if we accrued any errors, 0 otherwise
        return "$((errors > 0))"
    fi

    # Deleting is an error, since we need at least one argument
    if ((delete)) ; then
        printf 'ksh: %s: must specify at least one NAME to delete\n' \
            "$self" >&2
        return 2
    fi

    # Otherwise the user must want us to print all the NAMEs kept
    (
        for keep in "$kshkeep"/*.ksh ; do
            [[ -f "$keep" ]] || break
            keep=${keep##*/}
            keep=${keep%.ksh}
            printf '%s\n' "$keep"
        done
    )
}

# Load any existing scripts in kshkeep
for kshkeep in "${KSHKEEP:-"$HOME"/.kshkeep.d}"/*.ksh ; do
    [[ -e $kshkeep ]] || continue
    source "$kshkeep"
done
unset -v kshkeep
