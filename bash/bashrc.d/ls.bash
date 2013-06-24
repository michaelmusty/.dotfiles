# Apply color and exclusions to ls and grep
eval "$(dircolors -b &>/dev/null)"

# Function returns calculated options for ls
function __lsopts {
    local lsopts=
    local lshelp=$(ls --help )
    echo $lshelp | grep -- --color &>/dev/null \
        && lsopts="${lsopts} --color=auto"
    echo $lsopts
}

# Alias ls with these options
alias ls="ls $(__lsopts)"

