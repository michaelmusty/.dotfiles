# Get values for HTTP headers for the given URL

# Check arguments
if [ "$#" -ne 2 ] ; then
    printf 'urlt: Need an URL and a header name\n'
    exit 2
fi
url=$1 header=$2

# Run cURL header request
curl -fIsSL -- "$url" |

# Unfold the headers
unf |

# Change the line endings to UNIX format
sd2u |

# Use awk to find any values for the header case-insensitively
awk -F ': *' -v header="$header" '
BEGIN { header = tolower(header) }
tolower($1) == header {
    sub(/^[^:]*: */, "")
    print
}
'
