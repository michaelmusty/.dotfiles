# Function to manage contents of PATH variable within the current shell
path() {

    # The second argument, the directory, can never have a colon
    case $2 in
        *:*)
            printf >&2 'path(): Illegal colon in given directory\n'
            return 2
            ;;
    esac

    # Check first argument to figure out operation 
    case $1 in

        # List current directories in PATH
        list|'') (
            # shellcheck disable=SC2030
            path=$PATH:
            while [ -n "$path" ] ; do
                dir=${path%%:*}
                path=${path#*:}
                [ -n "$dir" ] || continue
                printf '%s\n' "$dir"
            done
            ) ;;

        # Add a directory at the start of $PATH
        insert)
            if path check "$2" ; then
                printf >&2 'path(): %s already in PATH\n'
                return 1
            fi
            PATH=${2}${PATH:+:"$PATH"}
            ;;

        # Add a directory to the end of $PATH
        append)
            if path check "$2" ; then
                printf >&2 'path(): %s already in PATH\n'
                return 1
            fi
            PATH=${PATH:+"$PATH":}${2}
            ;;

        # Remove a directory from $PATH
        remove)
            if ! path check "$2" ; then
                printf >&2 'path(): %s not in PATH\n'
                return 1
            fi
            PATH=$(
                path=:$PATH:
                path=${path%%:"$2":*}:${path#*:"$2":}
                path=${path#:}
                path=${path%:}
                printf '%s\n' "$path"
            )
            ;;

        # Check whether a directory is in PATH
        check) (
            # shellcheck disable=SC2030
            path=:$PATH:
            [ "$path" != "${path%:"$2":*}" ]
            ) ;;

        # Print help output (also done if command not found)
        help)
            cat <<'EOF'
path(): Manage contents of PATH variable

USAGE:
  path [list]
    Print the current directories in PATH, one per line (default command)
  path insert DIR
    Add a directory to the front of PATH
  path append DIR
    Add a directory to the end of PATH
  path remove DIR
    Remove directory from PATH
  path check DIR
    Return whether DIR is a component of PATH
  path help
    Print this help message (also done if command not found)
EOF
            ;;

        # Command not found
        *)
            printf >&2 'path(): Unknown command\n'
            path help >&2
            return 2
            ;;
    esac
}
