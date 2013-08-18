# Function returns calculated options for grep
__grepopts() {
    local -a grepopts
    local grephelp="$(grep --help 2>/dev/null)"
    grepopts[${#grepopts[@]}]='-I'
    if [[ "$grephelp" == *--color* && "$(tput colors)" -ge 8 ]]; then
        grepopts[${#grepopts[@]}]='--color=auto'
    fi
    if [[ "$grephelp" == *--exclude* ]]; then
        grepopts[${#grepopts[@]}]='--exclude=.git{,ignore,modules}'
    fi
    if [[ "$grephelp" == *--exclude-dir* ]]; then
        grepopts[${#grepopts[@]}]='--exclude-dir=.{cvs,git,hg,svn}'
    fi
    printf -- "${grepopts[*]}"
}

# Alias grep with those options
alias grep="grep $(__grepopts)"

# Unset helper function
unset __grepopts

