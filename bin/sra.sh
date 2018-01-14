# Run ssh(1) with an optional command on every host in sls(1df) output
# Use FD3 to keep a reference to the script's stdin for the ssh(1) calls
exec 3<&0
sls | while read -r hostname ; do
    printf 'sra: %s\n' "$hostname"
    # shellcheck disable=SC2029
    ssh -qt -- "$hostname" "$@" <&3
done
