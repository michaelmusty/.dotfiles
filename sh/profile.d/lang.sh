# Use the system's locale and language, but if it's not C or C.UTF-8, then
# force LC_COLLATE to an appropriate C locale so that the order of sort and
# glob expansion stays sane without making e.g. dates insane. Don't interfere
# at all if LANG isn't even set.
case $LANG in
    C|C.UTF-8) ;;
    *)
        if locale -a | grep -q C.UTF-8 ; then
            LC_COLLATE=C.UTF-8
        else
            LC_COLLATE=C
        fi
        export LC_COLLATE
        ;;
esac
