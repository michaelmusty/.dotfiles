# Shortcut to switch to another directory with the same parent, i.e. a sibling
# of the current directory.
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
sd() {

    # Check argument count
    if [ "$#" -gt 1 ] ; then
        printf >&2 'sd(): Too many arguments\n'
        return 2
    fi

    # Read sole optional argument
    case $1 in

        # If blank, get a full list of directories at this level; include
        # dotfiles, but not the . and .. entries, using glob tricks to avoid
        # Bash ruining things with `dotglob`
        '')
            set -- ../[!.]*/
            [ -e "$1" ] || shift
            set -- ../.[!.]*/ "$@"
            [ -e "$1" ] || shift
            set -- ../..?*/ "$@"
            [ -e "$1" ] || shift
            ;;

        # If not, get that directory, and the current one; shift it off if it
        # doesn't exist
        *)
            set -- ../"${1%/}"/ ../"${PWD##*/}"/
            [ -e "$1" ] || shift
            ;;
    esac

    # We should now have two parameters: the current directory and the matched
    # sibling
    case $# in
        2) ;;
        0|1)
            printf >&2 'sd(): No match\n'
            return 1
            ;;
        *)
            printf >&2 'sd(): Multiple matches\n'
            return 1
            ;;
    esac

    # Find which of these two is not the current directory and set that as our
    # sole parameter
    case $1 in
        ../"${PWD##*/}"/) set -- "$2" ;;
        *) set -- "$1" ;;
    esac

    # Try and change into the first parameter
    command cd -- "$1"
}
