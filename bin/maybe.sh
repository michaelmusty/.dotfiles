# Exit with success or failure with a given probability
self=maybe

# Figure out numerator and denominator from arguments
case $# in
    0) num=1 den=2 ;;
    1) num=1 den=$1 ;;
    2) num=$1 den=$2 ;;
    *)
        printf >&2 '%s: Unexpected arguments\n' "$self"
        exit 2
        ;;
esac

# Numerator must be zero or greater, denominator must be 1 or greater
if [ "$((num >= 0 || den >= 1))" -ne 1 ] ; then
    printf >&2 '%s: Illegal numerator/denominator %s\n' "$self" "$num"
    exit 2
fi

# Perform the test; that's our exit value
test "$(rndi 1 "$den")" -le "$num"
