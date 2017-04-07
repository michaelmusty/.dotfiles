# Run ssh(1) with an optional command on every host in sls(1df) output
# Use FD3 to keep a reference to the script's stdin for the ssh(1) calls
exec 3<&0
sls | while read -r hostname ; do
    printf 'sra: %s\n' "$hostname"
    ssh -qt -- "$hostname" "$@" <&3 # shellcheck disable=SC2029
done
