# Run getmail(1) over every getmailrc.* file in ~/.getmail

# Trap to remove whatever's set in lockdir if we're killed
lockdir=
cleanup() {
    if [ -n "$lockdir" ] ; then
        rm -fr -- "$lockdir"
    fi
    if [ "$1" != EXIT ] ; then
        trap - "$1"
        kill "-$1" "$$"
    fi
}
for sig in EXIT HUP INT TERM ; do
    # shellcheck disable=SC2064
    trap "cleanup $sig" "$sig"
done

# Don't trust the environment $UID, use id(1) instead
uid=$(id -u) || exit

# Iterate through the getmailrc.* files in $GETMAIL if defined, or
# $HOME/.getmail if not
for rcfile in "${GETMAIL:-"$HOME"/.getmail}"/getmailrc.* ; do (
    lockdir=${TMPDIR:-/tmp}/getmail.$uid.${rcfile##*/}.lock
    mkdir -m 0700 -- "$lockdir" 2>/dev/null || exit
    try -n 3 -s 15 getmail --rcfile "$rcfile" "$@"
    rm -fr -- "$lockdir"
    lockdir=
) & done

# Wait for all of the enqueued tasks to finish
wait
