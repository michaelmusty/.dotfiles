# Run a command and print a string to stdout showing pass/fail
if [ "$#" -eq 0 ] ; then
    printf >&2 'vex: Need a command\n'
    exit 2
fi
"$@"
ex=$?
case $ex in
    0) op='true'  ;;
    *) op='false' ;;
esac
printf '%s\n' "$op"
exit "$ex"
