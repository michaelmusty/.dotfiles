# Function returns calculated options for grep
function __grepopts {
    local grepopts='-I'
    local grephelp=$(grep --help)
    echo $grephelp | grep -- --color &>/dev/null \
        && grepopts="${grepopts} --color=auto"
    echo $grephelp | grep -- --exclude &>/dev/null \
        && grepopts="${grepopts} --exclude=.git{,ignore,modules}"
    echo $grephelp | grep -- --exclude-dir &>/dev/null \
        && grepopts="${grepopts} --exclude-dir=.{cvs,git,hg,svn}"
    echo $grepopts
}

# Alias grep with those options
alias grep="grep $(__grepopts)"

# Unset helper function
unset __grepopts

