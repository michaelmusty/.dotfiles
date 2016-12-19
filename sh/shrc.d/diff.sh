# Use a unified format for diff(1) by default
diff() {
    if (
        for arg ; do
            case $arg in
                -*) shift ;;
                --) shift ; break ;;
                *) break ;;
            esac
        done
        [ "$#" -gt 1 ]
    ) ; then
        set -- -u "$@"
    fi
    command diff "$@"
}
