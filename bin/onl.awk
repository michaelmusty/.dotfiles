# Flatten input into one single-space separated line with no unprintable chars

# For each not-all-spaces line:
{ 
    # Strip unprintable chars
    gsub(/[^[:print:]]/, "")

    # All horizontal whitespace groups to one space
    gsub(/[ \t]+/, " ")

    # No leading or trailing space
    sub(/^ /, "")
    sub(/ $/, "")

    # If there's nothing left, go on to the next line
    if (!length)
        next

    # If this isn't the first line, add a leading space
    if (NR > 1)
        printf " "

    # Print the content without a newline
    printf "%s", $0
}

# Print a newline to close the line
END { printf "\n" }
