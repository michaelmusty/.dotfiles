# Crude m4 preprocessor
BEGIN { mac = 0 }

# Print an m4 opener as the first byte
NR == 1 { printf "`" }

# Blocks
NF == 1 && $1 == "<%" && !mac {
    mac = 1
    printf "'"
    next
}
NF == 1 && $1 == "%>" && mac {
    mac = 0
    printf "`"
    next
}

# If processing macros, strip leading and trailing whitespace and skip blank
# lines
mac {
    sub(/^ */, "")
    sub(/ *$/, "")
}
mac && !NF { next }

# Inlines
mac {
    print $0 "dnl"
}
!mac {

    # Don't let apostrophes close the comment
    gsub(/'/, "''`")

    # Don't let $ signs confound expansion
    gsub(/\$/, "$'`")

    # Replace m5 opener with m4 closer
    gsub(/<% */, "'")

    # Replace m5 closer with m4 opener
    gsub(/ *%>/, "`")
    print
}

# Print an m4 closer and newline deleter as the last bytes
END {
    print "'dnl"
}
