# Search shell history file for a pattern. If you put your whole HISTFILE
# contents into memory, then you probably don't need this, as you can just do:
#
#     $ history | grep PATTERN
#
hgrep() {
    if ! (($#)) ; then
        printf >&2 '%s: Need a pattern\n' "$FUNCNAME"
        exit 2
    fi
    if ! [[ -n $HISTFILE ]] ; then
        printf >&2 '%s: No HISTFILE\n' "$FUNCNAME"
        exit 2
    fi
    grep "$@" "$HISTFILE"
}
