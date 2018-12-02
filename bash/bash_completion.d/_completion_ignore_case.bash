# Return whether to ignore case for filename completion
_completion_ignore_case() {

    # Check Readline settings for case-insensitive matching
    while read -r _ set ; do
        [[ $set == 'completion-ignore-case on' ]] || continue
        return 0
    done < <(bind -v)
    
    # Didn't find it, stay case-sensitive
    return 1
}
