# If given two arguments to cd, replace the first with the second in $PWD,
# emulating a Zsh function that I often find useful; preserves options too
__cd() {
    while getopts lPe opt
    do
        local opts="$opts -$opt"
    done
    shift $(($OPTIND-1))
    if [[ $# -eq 2 ]]; then
        builtin cd $opts "${PWD/$1/$2}"
    else
        builtin cd $opts "$@"
    fi
}
alias cd='__cd'

