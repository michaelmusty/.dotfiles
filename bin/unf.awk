# Unfold header lines in an internet message, don't touch the body

BEGIN { buf = "" }

# Function to write and empty the buffer
function wrbuf() {
    if (length(buf))
        print buf
    buf = ""
}

# Flag to stop processing once we hit the first blank line
!length($0) {
    wrbuf() 
    body = 1
}
body {
    print
    next
}

# Write any buffer contents once we hit a line not starting with a space
/^[^ \t]/ { wrbuf() }

# Append the current line to the buffer
{
    sub(/^[ \t]+/, " ")
    buf = buf $0
}

# Write the buffer out again when we hit the end
END { wrbuf() }
