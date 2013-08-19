# Function returns calculated options for grep
__grepopts() {

    # Declare options array
    local -a grepopts

    # Snarf the output of `grep --help` into a variable
    local grephelp="$(grep --help 2>/dev/null)"

    # Add option to ignore binary files
    grepopts[${#grepopts[@]}]='-I'

    # If the --exclude option is available, exclude some VCS files
    if [[ $grephelp == *--exclude* ]]; then
        grepopts[${#grepopts[@]}]='--exclude=.git{,ignore,modules}'
    fi

    # If the --exclude option is available, exclude some VCS dirs
    if [[ $grephelp == *--exclude-dir* ]]; then
        grepopts[${#grepopts[@]}]='--exclude-dir=.{cvs,git,hg,svn}'
    fi

    # If the --color option is available and we have a terminal that supports
    # at least eight colors, add --color=auto to the options
    local -i colors="$(tput colors)"
    if [[ $grephelp == *--color* ]] && ((colors >= 8)); then
        grepopts[${#grepopts[@]}]='--color=auto'
    fi

    # Print the options as a single string, space-delimited
    printf '%s' "${grepopts[*]}"
}

# Alias grep with those options
alias grep="grep $(__grepopts)"

# Unset helper function
unset __grepopts

