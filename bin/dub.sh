# List the biggest files in a directory
self=dub

# First optional argument is the directory, defaulting to the
# current dir; second optional argument is the number of files to
# show, defaulting to 20
dir=${1:-.} lines=${2:-10}

# Enter the target dir or bail
cd -- "$dir" || exit

# Some find(1) devilry to deal with newlines as safely as possible. The idea is
# not even to touch them, and warn about their presence; better the results are
# wrong than malformed
nl=$(printf '\n/')
find . ! -name . -prune \( \
    -name '*'"${nl%/}"'*'  \
        -exec sh -c '
            printf >&2 '\''%s: warning: skipped newline filename\n'\'' "$1"
        ' _ "$self" \; \
    -o -exec du -ksx -- {} + \) |

# Sort the first field (the sizes) numerically, in reverse
sort -k1,1nr |

# Limit the output to the given number of lines
sed "$((lines))"q
