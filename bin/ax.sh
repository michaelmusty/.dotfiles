# Evaluate an Awk expression given on the command line with an optional format

# Count arguments
case $# in

    # If one argument, we assume format is %s
    1) form=%s expr=$1 ;;

    # If two arguments, first is format, second expression
    2) form=$1 expr=$2 ;;

    # Any other number of arguments is wrong
    *)
        printf >&2 'ax: Need an expression\n'
        exit 2
        ;;
esac

# Important note: there's little stopping the user from putting a fully-fledged
# Awk program into the expression; don't use this anywhere that code injection
# could wreck your life. See manual page ax(1df).
awk -v form="$form" 'BEGIN{printf form,('"$expr"');exit}'
