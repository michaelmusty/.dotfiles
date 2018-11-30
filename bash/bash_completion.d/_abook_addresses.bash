# Email addresses from abook(1)
_abook_addresses() {

    # Needs abook(1)
    hash abook 2>/dev/null || return

    # Iterate through words produced by subshell
    local word
    while read -r word ; do
        [[ -n $word ]] || continue
        COMPREPLY[${#COMPREPLY[@]}]=$word
    done < <(

        # Set case-insensitive matching if appropriate
        while read -r _ setting ; do
            case $setting in
                ('completion-ignore-case on')
                    shopt -s nocasematch 2>/dev/null
                    break
                    ;;
            esac
        done < <(bind -v)

        # Generate list of email addresses from abook(1)
        while IFS=$'\t' read -r address _ ; do
            case $address in
                ("${COMP_WORDS[COMP_CWORD]}"*)
                    printf '%s\n' "$address"
                    ;;
            esac
        done < <(abook --mutt-query \@)
    )
}
