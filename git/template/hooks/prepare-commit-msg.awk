# Filter to clean up a merge commit; still experimental on tejr's part.

# If the first word of the subject line of the commit message is 'Merge', we
# know we need to rewrite this; otherwise we can just bail out directly
NR == 1 {
    if (!(rewrite = ($1 == "Merge")))
        exit(0)
}

# We're starting a new branch; save the whole line into a variable and skip to
# the next line
/^\* / {
    branch = $0
    next
}

# Skip this commit, it's just a version number bump
# Other patterns to skip go HERE; be as precise as you can
/^  Bump VERSION$/ { next }

# If we got past this point, we have an actual commit line to include, so if
# there's a branch heading yet to print, we should do so now; add it to the
# line buffer
length(branch) {
    lines[++l] = branch
    branch = ""
}

# Add the current line to the line buffer
{ lines[++l] = $0 }

# When we get to the end of the file, we need to decide whether we're going to
# rewrite the whole thing; note that the exit(0) call above still ends up down
# here, so we have to check and set a flag
END {
    if (rewrite)
        for (i = 1; i <= l; i++)
            print lines[i] > ARGV[1]
}
