# Custom completion for pass(1), because I don't like the one included with the
# distribution
_pass()
{
    # If we can't read the password directory, just bail
    local passdir
    passdir=${PASSWORD_STORE_DIR:-"$HOME"/.password-store}
    [[ -r $passdir ]] || return

    # Iterate through completions produced by subshell
    local ci comp
    while IFS= read -d '' -r comp ; do
        COMPREPLY[ci++]=$comp
    done < <(

        # Set shell options to expand globs the way we expect
        shopt -u dotglob
        shopt -s nullglob

        # Check Readline settings for case-insensitive matching
        while read -r _ setting ; do
            if [[ $setting == 'completion-ignore-case on' ]] ; then
                shopt -s nocaseglob
                break
            fi
        done < <(bind -v)

        # Gather the entries, use ** for depth search if we can
        entries=("$passdir"/"$2"*.gpg)
        if shopt -s globstar 2>/dev/null ; then
            entries=("${entries[@]}" "$passdir"/"$2"**/*.gpg)
        else
            entries=("${entries[@]}" "$passdir"/"$2"*/*.gpg)
        fi

        # Bail out if there are no entries
        ((${#entries[@]})) || exit

        # Strip leading path and .gpg suffix from entry names
        entries=("${entries[@]#"$passdir"/}")
        entries=("${entries[@]%.gpg}")

        # Print entries, quoted and null-delimited
        printf '%q\0' "${entries[@]}"
    )
}
complete -F _pass pass
