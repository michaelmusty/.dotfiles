# Function returns calculated options for ls
lsopts() {

    # Declare options array
    local -a lsopts

    # Snarf the output of `ls --help` into a variable
    local lshelp=$(ls --help 2>/dev/null)

    # If the --color option is available and we have a terminal that supports
    # at least eight colors, add --color=auto to the options
    local -i colors=$(tput colors)
    if [[ $lshelp == *--color* ]] && ((colors >= 8)); then
        lsopts[${#lsopts[@]}]='--color=auto'
    fi

    # Print the options as a single string, space-delimited
    printf %s "${lsopts[*]}"
}

# Alias ls with these options
alias ls="ls $(lsopts)"

# Unset helper function
unset lsopts

# Define and store appropriate colors for ls
if hash dircolors 2>/dev/null; then
    eval "$(dircolors --sh)"
fi

