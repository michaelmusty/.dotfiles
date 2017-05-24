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

# Form program
prog=$(printf '
    BEGIN {
        printf "%s\\n", %s
    }
' "$form" "$expr")

# Run program
awk "$prog"