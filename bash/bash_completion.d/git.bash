# Complete Git with branch names or tag names if specific keys are used, but
# fall back on filenames otherwise; it's too complicated to be worth trying to
# do it all contextually

# Requires Bash >=4.0 for COMP_KEY
((BASH_VERSINFO[0] >= 4)) || return

# Define and set helper function
_git() {

    # What completion to do 
    case $COMP_KEY in

        # Complete with branch names if C-x,B is pressed
        98)
            local ci
            while read -r _ ref ; do
                branch=${ref#refs/heads/}
                case $branch in
                    "$2"*) COMPREPLY[ci++]=$branch ;;
                esac
            done < <(git show-ref --heads)
            ;;

        # Complete with tag names if C-x,T is pressed
        116)
            local ci
            while read -r _ ref ; do
                tag=${ref#refs/tags/}
                case $tag in
                    "$2"*) COMPREPLY[ci++]=$tag ;;
                esac
            done < <(git show-ref --tags)
            ;;

        # Do no completion, so we fall back on filenames
        *) return 1 ;;

    esac
}
complete -F _git -o bashdefault -o default git
