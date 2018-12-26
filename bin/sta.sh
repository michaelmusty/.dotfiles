# Print list of sls(1df) hostnames that exit 0 when a connection is attempted
# and the optional given command is run.  Discard stdout, but preserve stderr.
sls | while read -r hostname ; do
    # shellcheck disable=SC2029
    ssh -nq -- "$hostname" "$@" >/dev/null || continue
    printf '%s\n' "$hostname"
done
