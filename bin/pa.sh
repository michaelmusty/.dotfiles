# Print arguments, one per line. Compare paz(1df).
[ "$#" -gt 0 ] || exit 0
printf '%s\n' "$@"
