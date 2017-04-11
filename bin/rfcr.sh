
# Check arguments
if [ "$#" -ne 1 ] ; then
    printf >&2 'rfcf: Need one RFC number\n'
    exit 2
fi

# Argument is RFC number
rn=$1

# Retrieve the RFC with rfcf(1df)
rfcf "$rn" |

# Pipe it through rfct(1df) to format it as text
rfct |

# Either spit it directly or through a pager
pit
