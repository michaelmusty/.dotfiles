# Tag lines from files or stdin with a string prefix or suffix
self=tl

# Parse options out
while getopts 'p:s:' opt ; do
    case $opt in

        # Prefix
        p) pref=$OPTARG ;;

        # Suffix
        s) suff=$OPTARG ;;

        # Unknown option
        \?)
            printf >&2 '%s: Unknown option %s\n' \
                "$self" "$opt"
            exit 2
            ;;
    esac
done
shift "$((OPTIND-1))"

# Print each line as we read it, adding the tags
cat -- "${@:--}" |
while IFS= read -r line ; do
    printf '%s%s%s\n' "$pref" "$line" "$suff"
done
