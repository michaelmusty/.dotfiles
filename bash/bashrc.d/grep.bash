# Function returns calculated options for grep
__grepopts() {
    local grepopts='-I'
    local grephelp="$(grep --help 2>/dev/null)"
    if [[ "$grephelp" == *--color* ]]; then
        grepopts="${grepopts} --color=auto"
    fi
    if [[ "$grephelp" == *--exclude* ]]; then
        grepopts="${grepopts} --exclude=.git{,ignore,modules}"
    fi
    if [[ "$grephelp" == *--exclude-dir* ]]; then
        grepopts="${grepopts} --exclude-dir=.{cvs,git,hg,svn}"
    fi
    printf '%s' "$grepopts"
}

# Alias grep with those options
alias grep="grep $(__grepopts)"

# Unset helper function
unset __grepopts

