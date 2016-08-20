#
# sd -- sibling/switch directory -- Shortcut to switch to another directory
# with the same parent, i.e. a sibling of the current directory.
#
#     $ pwd
#     /home/you
#     $ sd friend
#     $ pwd
#     /home/friend
#     $ sd you
#     $ pwd
#     /home/you
#
# If no arguments are given and there's only one other sibling, switch to that;
# nice way to quickly toggle between two siblings.
#
#     $ cd -- "$(mktemp -d)"
#     $ pwd
#     /tmp/tmp.ZSunna5Eup
#     $ mkdir a b
#     $ ls
#     a b
#     $ cd a
#     pwd
#     /tmp/tmp.ZSunna5Eup/a
#     $ sd
#     $ pwd
#     /tmp/tmp.ZSunna5Eup/b
#     $ sd
#     $ pwd
#     /tmp/tmp.ZSunna5Eup/a
#
# Seems to work for symbolic links.
#
sd() {

    set -- "$(
    
        # Check argument count
        if [ "$#" -gt 1 ] ; then
            printf >&2 'sd(): Too many arguments\n'
            exit 1
        fi

        # Set the positional parameters to either the requested directory, or
        # all of the current directory's siblings if no request
        spec=$1
        set --
        if [ -n "$spec" ] ; then
            set -- "$@" ../"$spec"
        else
            for sib in ../.* ../* ; do
                case ${sib#../} in
                    .|..|"${PWD##*/}") continue ;;
                esac
                set -- "$@" "$sib"
            done
        fi

        # We should have exactly one sibling
        case $# in
            1) ;;
            0)
                printf >&2 'sd(): No siblings\n'
                exit 1
                ;;
            *)
                printf >&2 'sd(): More than one sibling\n'
                exit 1
                ;;
        esac

        # Print the target
        printf '%s\n' "$1"
    )"

    # If the subshell printed nothing, return with failure
    [ -n "$1" ] || return

    # Try to change into the determined directory
    command cd -- "$@"
}
