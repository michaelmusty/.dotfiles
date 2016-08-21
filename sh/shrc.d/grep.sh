# Our ~/.profile should already have made a directory with the supported
# options for us; if not, we won't be wrapping grep(1) with a function at all
[ -d "$HOME"/.cache/grep ] || return

# Define function proper
grep() {

    # Add --exclude-dir to ignore version control dot-directories
    [ -e "$HOME"/.cache/grep/exclude-dir ] &&
        set -- \
            --exclude-dir=.cvs \
            --exclude-dir=.git \
            --exclude-dir=.hg  \
            --exclude-dir=.svn \
            "$@"

    # Add --exclude to ignore .gitignore and .gitmodules files
    [ -e "$HOME"/.cache/grep/exclude ] &&
        set -- \
            --exclude=.gitignore  \
            --exclude=.gitmodules \
            "$@"

    # Add --directories=skip to gracefully skip directories
    [ -e "$HOME"/.cache/grep/directories ] &&
        set -- --directories=skip "$@"

    # Add --devices=skip to gracefully skip devices
    [ -e "$HOME"/.cache/grep/devices ] &&
        set -- --devices=skip "$@"

    # Add --color if the terminal has at least 8 colors
    [ -e "$HOME"/.cache/grep/color ] &&
    [ "$({ tput colors || tput Co ; } 2>/dev/null)" -ge 8 ] &&
        set -- --color=auto "$@"

    # Add --binary-files=without-match to gracefully skip binary files
    [ -e "$HOME"/.cache/grep/binary-files ] &&
        set -- --binary-files=without-match "$@"

    # Run grep(1) with the concluded arguments
    command grep "$@"
}
