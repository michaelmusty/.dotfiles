# Load _completion_ignore_case helper function
if ! declare -F _completion_ignore_case >/dev/null ; then
    source "$HOME"/.bash_completion.d/_completion_ignore_case.bash
fi

# Completion setup for bd()
_bd() {

    # Iterate through completions produced by subshell
    local ci comp
    while IFS= read -d / -r comp ; do
        COMPREPLY[ci++]=$comp
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
        ((${#nodes[@]} > 1)) || return

        # Shift off the leaf, since it is not meaningful to go "back to" the
        # current directory
        nodes=("${nodes[@]:1}")

        # Make matching behave appropriately
        if _completion_ignore_case ; then
            shopt -s nocasematch 2>/dev/null
        fi

        # Iterate through the nodes and print the ones that match the word
        # being completed, with a trailing slash as terminator
        for node in "${nodes[@]}" ; do
            case $node in
                ("$2"*) printf '%s/' "$node" ;;
            esac
        done
    )
}
complete -F _bd bd
