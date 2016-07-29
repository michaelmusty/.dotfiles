# Completion setup for MySQL for configured databases
_mysql() {

    # Only makes sense for first argument
    ((COMP_CWORD == 1)) || return 1

    # Bail if directory doesn't exist
    local dirname
    dirname=$HOME/.mysql
    [[ -d $dirname ]] || return 1

    # Return the names of the .cnf files sans prefix as completions
    local db
    while IFS= read -rd '' db ; do
        COMPREPLY[${#COMPREPLY[@]}]=$db
    done < <(

        # Set options so that globs expand correctly
        shopt -s dotglob nullglob

        # Collect all the config file names, strip off leading path and .cnf
        local -a cnfs
        cnfs=("$dirname"/"${COMP_WORDS[COMP_CWORD]}"*.cnf)
        cnfs=("${cnfs[@]#"$dirname"/}")
        cnfs=("${cnfs[@]%.cnf}")

        # Bail if no files to prevent empty output
        ((${#cnfs[@]})) || exit 1

        # Print the conf names, null-delimited
        printf '%q\0' "${cnfs[@]}"
    )
}
complete -F _mysql -o default mysql
