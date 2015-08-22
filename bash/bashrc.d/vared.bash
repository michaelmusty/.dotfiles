# Requires Bash >= 4.0 for read -i and ${!name}
if ((BASH_VERSINFO[0] < 4)) ; then
    return
fi

# Edit named variables' values
vared() {
    local opt prompt
    local OPTERR OPTIND OPTARG
    while getopts 'p:' opt ; do
        case $opt in
            p)
                prompt=$OPTARG
                ;;
            \?)
                printf 'bash: %s: -%s: invalid option\n'
                    "$FUNCNAME" "$opt" >&2
                return 2
                ;;
        esac
    done
    shift "$((OPTIND-1))"
    if ! (($#)) ; then
        printf 'bash: %s: No variable names given\n' \
            "$FUNCNAME" >&2
        return 2
    fi
    local name
    for name ; do
        IFS= read -e -i "${!name}" -p "${prompt:-$name=}" -r -- "$name"
    done
}
complete -A variable vared

