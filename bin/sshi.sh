# Print some human-readable information from SSH_CONNECTION

# Check we have an SSH_CONNECTION variable
if [ -z "$SSH_CONNECTION" ] ; then
    printf >&2 'sshi: SSH_CONNECTION appears empty\n'
    exit 1
fi

# Print the two variables into a compound command so we can `read` them
printf '%s\n' "$SSH_CONNECTION" "${SSH_TTY:-unknown}" |
{
    # Read connection details from first line
    read -r ci cp si sp

    # Read TTY from second line
    read -r tty

    # Try to resolve the client and server IPs
    ch=$(dig -x "$ci" +short 2>/dev/null | sed 's/\.$//;1q')
    sh=$(dig -x "$si" +short 2>/dev/null | sed 's/\.$//;1q')

    # Print the results in a human-readable format
    printf '%s:%u -> %s:%u (%s)\n' \
        "${ch:-"$ci"}" "$cp" \
        "${sh:-"$si"}" "$sp" \
        "$tty"
}
