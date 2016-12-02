# Try to find the targets in a Makefile that look like they're targets the user
# could be reasonably expected to call directly

# Separators are space, tab, or colon
BEGIN {
    FS = "[ \t:]"
}

# Skip comments
/^#/ { next }

# Join backslash-broken lines
/\\$/ {
    sub(/\\$/, "")
    line = line $0
    next
}
{
    $0 = line $0
    line = ""
}

# Check lines matching expected "targets:dependencies" format
/^[a-zA-Z0-9][a-zA-Z0-9 \t_-]+:([^=]|$)/ {

    # Iterate through the targets that don't look like substitutions or
    # inference rules and stack them up into an array's keys to keep them
    # unique; this probably needs refinement
    for (i = 1; i < NF; i++)
        if ($i ~ /^[a-zA-Z0-9][a-zA-Z0-9.\/_-]*$/)
            ats[$i]
}

# Print unique determined targets, sorted
END {
    for (t in ats)
        print t | "sort"
}
