# Completion setup for bd()
_bd() {

    # Only makes sense for the first argument
    ((COMP_CWORD == 1)) || return

    # Build a list of dirnames in $PWD
    local -a dirnames
    IFS=/ read -rd '' -a dirnames < <(printf '%s\0' "${PWD#/}")

    # Remove the last element in the array (the current directory)
    ((${#dirnames[@]})) || return
    dirnames=("${dirnames[@]:0:${#dirnames[@]}-1}")

    # Add the matching dirnames to the reply
    local dirname
    for dirname in "${dirnames[@]}" ; do
        case $dirname in
            "${COMP_WORDS[COMP_CWORD]}"*)
                COMPREPLY[${#COMPREPLY[@]}]=$(printf %q "$dirname")
            ;;
        esac
    done
}
complete -F _bd bd
