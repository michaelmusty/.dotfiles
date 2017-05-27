#!/bin/sh
# Record a timestamped message to a logfile, defaulting to ~/.clog
self=clog

# Ignore arguments
set --

# If we have rlwrap, quietly use it
command -v rlwrap >/dev/null 2>&1 &&
    set -- rlwrap --history-filename=/dev/null -C "$self" "$@"

# Write the date, the standard input (rlwrapped if applicable), and two dashes
# to $CLOG, defaulting to ~/.clog.
{
    date
    "$@" cat -
    printf '%s\n' --
} >>"${CLOG:-"$HOME"/.clog}"
