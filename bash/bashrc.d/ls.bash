# Function returns calculated options for ls
__lsopts() {
    local -a lsopts
    local lshelp="$(ls --help 2>/dev/null)"
    if [[ "$lshelp" == *--color* && "$(tput colors)" -ge 8 ]]; then
        lsopts[${#lsopts[@]}]='--color=auto'
    fi
    printf -- "${lsopts[*]}"
}

# Alias ls with these options
alias ls="ls $(__lsopts)"

# Unset helper function
unset __lsopts

# Define and store appropriate colors for ls
if command -v dircolors &>/dev/null; then
    eval "$(dircolors --sh)"
fi

