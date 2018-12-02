# Load _completion_ignore_case helper function
if ! declare -F _completion_ignore_case >/dev/null ; then
    source "$HOME"/.bash_completion.d/_completion_ignore_case.bash
fi

# Email addresses from abook(1)
_abook_addresses() {

    # Needs abook(1)
    hash abook 2>/dev/null || return

    # Iterate through completions produced by subshell
    local ci comp
    while read -r comp ; do
        COMPREPLY[ci++]=$comp
    done < <(

        # Make matches behave appropriately
        if _completion_ignore_case ; then
            shopt -s nocasematch 2>/dev/null
        fi

        # Generate list of email addresses from abook(1)
        while IFS=$'\t' read -r address _ ; do
            case $address in
                ("$2"*) printf '%s\n' "$address" ;;
            esac
        done < <(abook --mutt-query \@)
    )
}
