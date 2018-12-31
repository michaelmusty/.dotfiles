# Create and edit executable scripts in a directory EDSPATH (defaults to
# ~/.local/bin)

# Need at least one script name
if [ "$#" -eq 0 ] ; then
    printf >&2 'eds: Need at least one script name\n'
    exit 2
fi

# Create the script directory if it doesn't exist yet
ep=${EDSPATH:-$HOME/.local/bin}
if ! [ -d "$ep" ] ; then
    mkdir -p -- "$ep" || exit
fi

# Warn if that's not in $PATH
case :$PATH: in
    *:"$ep":*) ;;
    *)
        printf >&2 'eds: warning: %s not in PATH\n' "$ep"
        ;;
esac

# Prepend the path to each of the names given if they don't look like options
for arg do
    if [ -z "$reset" ] ; then
        set -- 
        reset=1
    fi
    case $arg in
        --)
            optend=1
            set -- "$@" "$arg"
            continue
            ;;
        -*)
            if [ -z "$optend" ] ; then
                set -- "$@" "$arg"
                continue
            fi
            ;;
    esac
    optend=1
    set -- "$@" "$ep"/"$arg"
done

# Run the editor over the arguments
"${VISUAL:-"${EDITOR:-ed}"}" "$@"

# Make any created scripts executable if they now appear to be files
for script do
    [ -f "$script" ] || continue
    chmod +x -- "$script"
done
