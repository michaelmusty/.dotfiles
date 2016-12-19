# Use a unified format for diff(1) by default if two files and no options given
diff() {
    if (
        for arg ; do
            case $arg in
                --) shift ; break ;;
                -*) return 1 ;;
                *) break ;;
            esac
        done
        [ "$#" -eq 2 ]
    ) ; then
        set -- -u "$@"
    fi
    command diff "$@"
}
