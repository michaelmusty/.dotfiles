# Function returns calculated options for ls
__lsopts() {

    # Declare options array
    local -a lsopts

    # Snarf the output of `ls --help` into a variable
    local lshelp="$(ls --help 2>/dev/null)"

    # If the --color option is available and we have a terminal that supports
    # at least eight colors, add --color=auto to the options
    local -i colors="$(tput colors)"
    if [[ $lshelp == *--color* ]] && ((colors >= 8)); then
        lsopts[${#lsopts[@]}]='--color=auto'
    fi

    # Print the options as a single string, space-delimited
    printf '%s' "${lsopts[*]}"
}

# Alias ls with these options
alias ls="ls $(__lsopts)"

# Unset helper function
unset __lsopts

# Define and store appropriate colors for ls
if command -v dircolors &>/dev/null; then
    eval "$(dircolors --sh)"
fi

