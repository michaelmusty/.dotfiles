# Generate blank lines
if [ "$#" -ne 1 ] || [ "$1" -lt 0 ] ; then
    printf >&2 'bl: Non-negative line count needed as sole argument\n'
    exit 2
fi
n=0
while [ "$n" -lt "${1:-0}" ] ; do
    printf '\n'
    n=$((n+1))
done