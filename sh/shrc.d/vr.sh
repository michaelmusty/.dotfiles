# Move to the root directory of a VCS working copy
vr() {

    # Set positional parameters to the result of trying to figure out the
    # repository root
    set -- "$(

        # Check we have at most one argument
        if [ "$#" -gt 1 ] ; then
            printf >&2 'vr(): Too many arguments\n'
            exit 2
        fi

        # Get path from first argument
        path=${1:-"$PWD"}

        # Strip a trailing slash
        case $path in
            (/) ;;
            (*) path=${path%/} ;;
        esac

        # Step into the directory
        cd -- "$path" || exit

        # Ask Git the top level (good)
        if git rev-parse --show-toplevel 2>/dev/null ; then
            printf /
            exit
        fi

        # Ask Mercurial the top level (great)
        if hg root 2>/dev/null ; then
            printf /
            exit
        fi

        # If we can get SVN info, iterate upwards until we cannot; hopefully
        # that is the root (bad)
        while svn info >/dev/null 2>&1 ; do
            root=$PWD
            ! [ "$root" = / ] || break
            cd .. || exit
        done
        if [ -n "$root" ] ; then
            printf '%s\n/' "$root"
            exit
        fi

        # Could not find repository root, say so
        printf >&2 'vr(): Failed to find repository root\n'
        exit 1
    )"

    # Chop the trailing newline and slash
    set -- "${1%?/}"

    # Check we figured out a target, or bail
    [ -n "$1" ] || return

    # Try to change into the determined directory
    # shellcheck disable=SC2164
    cd -- "$@"
}
