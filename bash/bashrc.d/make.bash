# Completion setup for Make, completing targets
_make() {

    # Bail if no legible Makefile
    [[ -r Makefile ]] || return 1

    # Build a list of targets by parsing the Makefile
    local -a targets tokens
    local line target token
    while read -r line ; do
        if [[ $line == *:* && $line != *:=* ]] ; then
            target=$line
            target=${target%%:*}
            target=${target% }
            [[ $target != *[^[:alnum:][:space:]_-]* ]] || continue
            IFS=' ' read -a tokens \
                < <(printf '%s\n' "$target")
            for token in "${tokens[@]}" ; do
                targets[${#targets[@]}]=$token
            done
        fi
    done < Makefile

    # Complete with matching targets
    for target in "${targets[@]}" ; do
        [[ $target == "${COMP_WORDS[COMP_CWORD]}"* ]] || continue
        COMPREPLY[${#COMPREPLY[@]}]=$target
    done
}
complete -F _make -o default make

