# Completion setup for MySQL for configured databases
_mysql() {

    # Only makes sense for first argument
    ((COMP_CWORD == 1)) || return

    # Bail if directory doesn't exist
    local dirname
    dirname=$HOME/.mysql
    [[ -d $dirname ]] || return

    # Return the names of the .cnf files sans prefix as completions
    local db
    while IFS= read -rd '' db ; do
        [[ -n $db ]] || continue
        COMPREPLY[${#COMPREPLY[@]}]=$db
    done < <(

        # Set options so that globs expand correctly
        shopt -s dotglob nullglob

        # Make globbing case-insensitive if appropriate
        while read -r _ setting ; do
            case $setting in
                ('completion-ignore-case on')
                    shopt -s nocaseglob
                    break
                    ;;
            esac
        done < <(bind -v)

        # Collect all the config file names, strip off leading path and .cnf
        local -a cnfs
        cnfs=("$dirname"/"${COMP_WORDS[COMP_CWORD]}"*.cnf)
        cnfs=("${cnfs[@]#"$dirname"/}")
        cnfs=("${cnfs[@]%.cnf}")

        # Print quoted entries, null-delimited
        printf '%q\0' "${cnfs[@]}"
    )
}
complete -F _mysql -o bashdefault -o default mysql
