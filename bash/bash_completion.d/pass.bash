# Load _completion_ignore_case helper function
if ! declare -F _completion_ignore_case >/dev/null ; then
    source "$HOME"/.bash_completion.d/_completion_ignore_case.bash
fi

# Custom completion for pass(1), because I don't like the one included with the
# distribution
_pass() {

    # Iterate through completions produced by subshell
    local ci comp
    while IFS= read -d '' -r comp ; do
        COMPREPLY[ci++]=$comp
    done < <(

        # Make globs expand appropriately
        shopt -u dotglob
        shopt -s nullglob
        if _completion_ignore_case ; then
            shopt -s nocaseglob
        fi

        # Set password store path
        pass_dir=${PASSWORD_STORE_DIR:-"$HOME"/.password-store}

        # Gather the entries
        for entry in "$pass_dir"/"$2"*.gpg ; do
            entries[ei++]=$entry
        done

        # Try to iterate into subdirs, use depth search with ** if available
        if shopt -s globstar 2>/dev/null ; then
            for entry in "$pass_dir"/"$2"**/*.gpg ; do
                entries[ei++]=$entry
            done
        else
            for entry in "$pass_dir"/"$2"*/*.gpg ; do
                entries[ei++]=$entry
            done
        fi

        # Iterate through entries
        for entry in "${entries[@]}" ; do
            # Skip directories
            ! [[ -d $entry ]] || continue
            # Strip leading path
            entry=${entry#"$pass_dir"/}
            # Strip .gpg suffix
            entry=${entry%.gpg}
            # Print shell-quoted entry, null terminated
            printf '%q\0' "$entry"
        done
    )
}
complete -F _pass pass
