# Our ~/.profile should already have made a directory with the supported
# options for us
[[ -d $HOME/.cache/grep ]] || return

# Store whether we have colors in a variable
declare -i colors
colors=$( {
    tput Co || tput colors
} 2>/dev/null )

# Use GREPOPTS to add some useful options to grep(1) calls if applicable; we
# use a function wrapper to do this, rather than GREP_OPTIONS as we don't want
# to change grep(1)'s actual behaviour inside scripts
declare -a GREPOPTS
GREPOPTS=()
if ((colors >= 8)) && [[ -n $GREP_COLORS ]] ; then
    GREPOPTS[${#GREPOPTS[@]}]='--color=auto'
fi
if [[ -e $HOME/.cache/grep/binary-files ]] ; then
    GREPOPTS[${#GREPOPTS[@]}]='--binary-files=without-match'
fi
if [[ -e $HOME/.cache/grep/exclude ]] ; then
    GREPOPTS[${#GREPOPTS[@]}]='--exclude={.gitignore,.gitmodules}'
fi
if [[ -e $HOME/.cache/grep/exclude-dir ]] ; then
    GREPOPTS[${#GREPOPTS[@]}]='--exclude-dir={.cvs,.git,.hg,.svn}'
fi

# Done, unset color var
unset -v colors

# Define function proper
grep() {
    command grep "${GREPOPTS[@]}" "$@"
}
