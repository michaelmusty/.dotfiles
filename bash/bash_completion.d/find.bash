# Semi-intelligent completion for find(1); nothing too crazy
_find() {

    # Iterate through completions produced by subshell
    local ci comp
    while IFS= read -r comp ; do
        COMPREPLY[ci++]=$comp
    done < <(

        # Complete POSIX-specified options
        case $2 in
            (-*)
                compgen -W '
                    -atime
                    -ctime
                    -depth
                    -exec
                    -group
                    -links
                    -mtime
                    -name
                    -newer
                    -nogroup
                    -nouser
                    -ok
                    -perm
                    -print
                    -prune
                    -size
                    -type
                    -user
                    -xdev
                ' -- "$2"
                exit
                ;;
        esac

        # Look at the word *before* this one to figure out what to
        # complete
        case $3 in

            # Args to -exec and -execdir should be commands
            (-exec|-execdir) compgen -A command -- "$2" ;;

            # Legal POSIX flags for -type
            (-type) compgen -W 'b c d f l p s' -- "$2" ;;

            # Args to -group should complete group names
            (-group) compgen -A group -- "$2" ;;

            # Args to -user should complete usernames
            (-user) compgen -A user -- "$2" ;;

        esac
    )
}
complete -F _find -o bashdefault -o default find
