# Flatten input into one single-space separated line with no unprintable chars

# For each line of input ...
{ 
    # Strip out whitespace characters and rebuild the fields
    gsub(/[\n\t\r ]+/, "")

    # Print each field, without a newline; add a leading space if it's not the
    # very first one
    for (i = 1; i <= NF; i++)
        printf (f++) ? OFS "%s" : "%s", $i
}

# Print a newline to close the line
END { print "" }
