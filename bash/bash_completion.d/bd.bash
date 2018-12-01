# Completion setup for bd()
_bd() {

    # The function accepts only one argument, so it doesn't make sense to
    # complete anywhere else
    ((COMP_CWORD == 1)) || return

    # Iterate through slash-delimited matching parent path elements, as piped
    # in by the subshell
    local ci word
    while IFS= read -rd/ word ; do
        COMPREPLY[ci++]=$word
    done < <(

        # Build an array of path nodes, leaf to root
        path=$PWD
        while [[ -n $path ]] ; do
            node=${path##*/}
            path=${path%/*}
            [[ -n $node ]] || continue
            nodes[ni++]=$node
        done

        # Continue if we have at least two nodes, counting the leaf
        ((${#nodes} > 1)) || return

        # Shift off the leaf, since it's not meaningful to go "back to" the
        # current directory
        nodes=("${nodes[@]:1}")

        # Turn on case-insensitive matching, if configured to do so
        while read -r _ setting ; do
            case $setting in
                ('completion-ignore-case on')
                    shopt -s nocasematch 2>/dev/null
                    break
                    ;;
            esac
        done < <(bind -v)

        # Iterate through the nodes and print the ones that match the word
        # being completed, with a trailing slash as terminator
        for node in "${nodes[@]}" ; do
            case $node in
                ("$2"*)
                    printf '%s/' "$node"
                    ;;
            esac
        done
    )
}
complete -F _bd bd
