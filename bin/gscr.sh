# Scrub and pack Git repositories

# Iterate through given directories; default to the current one
for arg in "${@:-.}" ; do (

    # Note the "exit" calls here in lieu of "continue" are deliberate; we're in
    # a subshell, so leaving it will continue the loop.

    # Enter either bare repository or .git subdir
    case $arg in
        *.git)
            cd -- "$arg" || exit
            ;;
        *)
            cd -- "$arg"/.git || exit
            ;;
    esac

    # Check for bad references or other integrity/sanity problems
    git fsck || exit

    # Expire dangling references
    git reflog expire --expire=now || exit

    # Remove dangling references
    git gc --prune=now --aggressive || exit

) done
