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

        # Slashes aren't allowed
        */*)
            printf >&2 'sd(): Illegal slash\n'
            return 2
            ;;

        # If blank, we try to find if there's just one sibling, and change to
        # that if so
        '')
            # First a special case: root dir
            case $PWD in
                *[!/]*) ;;
                *)
                    printf >&2 'sd(): No siblings\n'
                    return 1
                    ;;
            esac

            # Get a full list of directories at this level; include dotfiles,
            # but not the . and .. entries, using glob tricks to avoid Bash
            # ruining things with `dotglob`
            set -- ../[!.]*/
            [ -e "$1" ] || shift
            set -- ../.[!.]*/ "$@"
            [ -e "$1" ] || shift
            set -- ../..?*/ "$@"
            [ -e "$1" ] || shift

            # Check the number of matches
            case $# in

                # One match?  Must be $PWD, so no siblings--throw in 0 just in
                # case, but that Shouldn't Happen (TM)
                0|1)
                    printf >&2 'sd(): No siblings\n'
                    return 1
                    ;;

                # Two matches; hopefully just one sibling, but which is it?
                2)

                    # Push PWD onto the stack, strip trailing slashes
                    set -- "$1" "$2" "$PWD"
                    while : ; do
                        case $3 in
                            */) set -- "$1" "$2" "${3%/}" ;;
                            *) break ;;
                        esac
                    done

                    # Pick whichever of our two parameters doesn't look like
                    # PWD as our sole parameter
                    case $1 in
                        ../"${3##*/}"/) set -- "$2" ;;
                        *) set -- "$1" ;;
                    esac
                    ;;

                # Anything else?  Multiple siblings--user will need to specify
                *)
                    printf >&2 'sd(): Multiple siblings\n'
                    return 1
                    ;;
            esac
            ;;

        # If not, simply set our target to that directory, and let `cd` do the
        # complaining if it doesn't exist
        *) set -- ../"$1" ;;
    esac

    # Try and change into the first parameter
    # shellcheck disable=SC2164
    cd -- "$1"
}
