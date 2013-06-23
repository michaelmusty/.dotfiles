# If given two arguments to cd, replace the first with the second in $PWD,
# emulating a Zsh function that I often find useful; preserves options too
function cd {
    while getopts lPe opt
    do
        local opts="$opts -$opt"
    done
    shift $(($OPTIND-1))
    if [[ -n "$2" ]]; then
        builtin cd $opts "${PWD/$1/$2}"
    elif [[ -n "$1" ]]; then
        builtin cd $opts "$1"
    else
        builtin cd $opts
    fi
}

