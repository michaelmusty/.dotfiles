# Print arguments, terminated by null chars. Compare pa(1df).
[ "$#" -gt 0 ] || exit 0
printf '%s\0' "$@"
