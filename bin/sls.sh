# Print hostnames from ssh_config(5) files, defaulting to the usual paths

# If we weren't given a file explicitly, we'll try to read both /etc/ssh_config
# and ~/.ssh_config in that order if they exist
if [ "$#" -eq 0 ] ; then
    for cfg in /etc/ssh_config "$HOME"/.ssh/config ; do
        [ -e "$cfg" ] || continue
        set -- "$@" "$cfg"
    done
fi

# If we still have no files to read, bail out and warn the user
if [ "$#" -eq 0 ] ; then
    printf >&2 'sls: ssh_config(5) paths not found, need argument\n'
    exit 1
fi

# Otherwise, we can run slsf(1df) over the ones we did collect
slsf -- "$@"
