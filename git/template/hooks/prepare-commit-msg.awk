# Filter to clean up a merge commit; still experimental on tejr's part.

# If the second argument to this script is "merge", this is a merge commit, and
# we know we need to filter it; otherwise we can just bail out directly
BEGIN {
    if (ARGV[2] != "merge")
        exit(0)
    message = ARGV[1]
    ARGC = 2
}

# This line starts with an asterisk, so we're starting the commit listings for
# a new branch; save the whole line into a variable and skip to the next line
/^\* / {
    branch = $0
    next
}

# This line is blank, or a comment; reset the branch
!NF || $1 ~ /^\#/ { branch = 0 }

# Commit message subject patterns to skip go here; be as precise as you can
$0 == "  Bump VERSION" { next }  # Skip version number bumps

# If we got past this point, we have an actual commit line to include, so if
# there's a branch heading yet to print, we should do so now; add it to the
# line buffer
branch {
    lines[++l] = branch
    branch = 0
}

# Add the current line to the line buffer
{ lines[++l] = $0 }

# If we set the message filename in BEGIN due to this being a merge commit,
# write our filtered message back to that file, and we're done
END {
    for (i = 1; message && i <= l; i++)
        print lines[i] > message
}
