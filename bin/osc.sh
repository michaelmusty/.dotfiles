# Sane and safe OpenSSL s_client(1ssl) connection
self=osc

# Check we have openssl(1); we need to fail early lest we go setting up FIFOs
# needlessly
if ! command -v openssl >/dev/null 2>&1 ; then
    printf >&2 '%s: openssl(1) not found\n' "$self"
    exit 1
fi

# Hostname is first argument; assume localhost if empty/unset
host=${1:-localhost}
# Service name or port is second argument; assume HTTPS if empty/unset
serv=${2:-https}

# Start building the command-line string
set --
## If we have rlwrap, use it, but don't complain if we don't
if command -v rlwrap >/dev/null 2>&1 ; then
    set -- "$@" rlwrap --history-filename=/dev/null
fi
## The actual openssl(1ssl) and subcommand call
set -- "$@" openssl s_client
## No insecure SSL methods
set -- "$@" -no_ssl3
## Don't dump nonsense to terminal, and don't renegotiate on R or quit on Q
set -- "$@" -quiet
## But do cut the connection if I issue ^D, even though I just set -quiet
set -- "$@" -no_ign_eof
## Do verify the certificate chain and don't connect if we can't
set -- "$@" -verify 5 -verify_return_error
## We might add STARTTLS for the supported services:
case $serv in
    ftp|21)
        set -- "$@" -starttls ftp
        ;;
    smtp|25)
        set -- "$@" -starttls smtp
        ;;
    pop3|110)
        set -- "$@" -starttls pop3
        ;;
    imap|143)
        set -- "$@" -starttls imap
        ;;
    xmpp-client|5222)
        set -- "$@" -starttls xmpp
        ;;
esac
## Send the host parameter as the server name (SNI)
set -- "$@" -servername "$host"
## Finally, add the host and service to connect to
set -- "$@" -connect "$host":"$serv"

# Do the POSIX dance to kill child processes and clean up temp files even if
# killed by a signal
td='' fil=''
cleanup() {
    trap - EXIT "$1"
    if [ -n "$fil" ] ; then
        kill -TERM "$fil"
    fi
    if [ -n "$td" ] ; then
        rm -fr -- "$td"
    fi
    if [ "$1" != EXIT ] ; then
        kill -"$1" "$$"
    fi
}
for sig in EXIT HUP INT TERM ; do
    # shellcheck disable=SC2064
    trap "cleanup $sig" "$sig"
done

# Create a temporary directory and a FIFO in it
td=$(mktd "$self") || exit
mkfifo -- "$td"/verify-filter || exit

# Open a read-write file descriptor onto the FIFO
exec 3<>"$td"/verify-filter || exit

# Start a background filter process on the FIFO to get rid of the leading
# verification output set to stderr; as soon as we find a single line that
# doesn't look like that routine output, print all future lines to stderr as
# normal
awk '
body{print;next}
/^verify depth is [0-9]+$/{next}
/^depth=[0-9]+ /{next}
/^verify return:[0-9]+$/{next}
{body=1;print}
' <&3 >&2 & fil=$!

# Start the process with the options we stacked up
"$@" 2>&3
