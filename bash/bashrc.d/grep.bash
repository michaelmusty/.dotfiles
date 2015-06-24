# Store grep(1)'s --help output in a variable
grep_help=$(grep --help 2>/dev/null)

# Use GREP_OPTIONS to add some useful options to grep(1) calls if applicable
GREP_OPTIONS=
case $grep_help in
    *--binary-files*)
        GREP_OPTIONS=${GREP_OPTIONS:+$GREP_OPTIONS }'--binary-files=without-match'
        ;;
esac
case $grep_help in
    *--exclude*)
        for exclude in .gitignore .gitmodules ; do
            GREP_OPTIONS=${GREP_OPTIONS:+$GREP_OPTIONS }'--exclude='$exclude
        done
        unset -v exclude
        ;;
esac
case $grep_help in
    *--exclude-dir*)
        for exclude_dir in .cvs .git .hg .svn ; do
            GREP_OPTIONS=${GREP_OPTIONS:+$GREP_OPTIONS }'--exclude-dir='$exclude_dir
        done
        unset -v exclude_dir
        ;;
esac

# We're done parsing grep(1)'s --help output now
unset -v grep_help

# Define function wrapper for grep(1) with --color option if GREP_COLORS is
# set; checks that color is available in the terminal within the function
if [[ ! -n $GREP_COLORS ]] ; then
    return
fi

# Define function proper
grep() {
    local -i colors
    colors=$( {
        tput Co || tput colors
    } 2>/dev/null )
    if ((colors >= 8)) ; then
        command grep --color=auto "$@"
    else
        command grep "$@"
    fi
}

