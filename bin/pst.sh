#!/bin/sh
# Interrupt a pipe with manual /dev/tty input to a program
self=pst

# Don't accept terminal as stdin
if [ -t 0 ] ; then
    printf >&2 '%s: stdin is a term\n' "$self"
    exit 2
fi

# Create a temporary directory with name in $td, and handle POSIX-ish traps to
# remove it when the script exits.
td=
cleanup() {
    [ -n "$td" ] && rm -fr -- "$td"
    if [ "$1" != EXIT ] ; then
        trap - "$1"
        kill "-$1" "$$"
    fi
}
for sig in EXIT HUP INT TERM ; do
    # shellcheck disable=SC2064
    trap "cleanup $sig" "$sig"
done
td=$(mktd "$self") || exit

# Run the interactive command on the temporary file forcing /dev/tty as
# input/output
tf=$td/data
cat - > "$tf" || exit
"${@:-"${PAGER:-more}"}" "$tf" </dev/tty >/dev/tty
cat -- "$tf" || exit
