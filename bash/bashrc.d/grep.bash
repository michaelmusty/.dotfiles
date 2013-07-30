# Function returns calculated options for grep
__grepopts() {
    local grepopts='-I'
    local grephelp=$(grep --help 2>/dev/null)
    [[ "$grephelp" == *--color* ]] \
        && grepopts="${grepopts} --color=auto"
    [[ "$grephelp" == *--exclude* ]] \
        && grepopts="${grepopts} --exclude=.git{,ignore,modules}"
    [[ "$grephelp" == *--exclude-dir* ]] \
        && grepopts="${grepopts} --exclude-dir=.{cvs,git,hg,svn}"
    printf '%s' $grepopts
}

# Alias grep with those options
alias grep="grep $(__grepopts)"

# Unset helper function
unset __grepopts

