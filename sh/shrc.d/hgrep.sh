# Search shell history file for a pattern. If you put your whole HISTFILE
# contents into memory, then you probably don't need this, as you can just do:
#
#     $ history | grep PATTERN
#
hgrep() {
    if [ "$#" -eq 0 ] ; then
        printf >&2 'hgrep: Need a pattern\n'
        exit 2
    fi
    if ! [ -n "$HISTFILE" ] ; then
        printf >&2 'hgrep: No HISTFILE\n'
        exit 2
    fi
    grep "$@" "$HISTFILE"
}
