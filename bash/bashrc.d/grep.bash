# Function returns calculated options for grep
function __grepopts {
    local grepopts='-I'
    grep --help | grep -- --color &>/dev/null \
        && grepopts="${grepopts} --color=auto"
    grep --help | grep -- --exclude &>/dev/null \
        && grepopts="${grepopts} --exclude=.git{,ignore,modules}"
    grep --help | grep -- --exclude-dir &>/dev/null \
        && grepopts="${grepopts} --exclude-dir=.{cvs,git,hg,svn}"
    echo $grepopts
}

# Alias grep with those options
alias grep="grep $(__grepopts)"

