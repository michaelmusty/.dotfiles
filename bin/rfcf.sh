
# Check arguments
if [ "$#" -ne 1 ] ; then
    printf >&2 'rfcf: Need one RFC number\n'
    exit 2
fi

# Argument is RFC number
rn=$1

# Retrieve the RFC with curl(1)
curl -fsSL https://tools.ietf.org/rfc/rfc"$rn".txt
