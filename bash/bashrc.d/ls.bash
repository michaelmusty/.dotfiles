# Function returns calculated options for ls
__lsopts() {
    local lsopts=
    local lshelp=$(ls --help 2>/dev/null)
    [[ "$lshelp" == *--color* ]] \
        && lsopts="${lsopts} --color=auto"
    printf '%s' $lsopts
}

# Alias ls with these options
alias ls="ls $(__lsopts)"

# Unset helper function
unset __lsopts

# Apply color and exclusions to ls and grep
eval "$(dircolors --sh 2>/dev/null)"

