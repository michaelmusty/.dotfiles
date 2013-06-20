# If given two arguments to cd, replace the first with the second in $PWD
function cd {
    if [[ -n "$2" ]]; then
        builtin cd "${PWD/$1/$2}"
    elif [[ -n "$1" ]]; then
        builtin cd "$1"
    else
        builtin cd
    fi
}

