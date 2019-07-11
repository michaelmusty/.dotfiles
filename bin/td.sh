# Manage to-do files with just $EDITOR and git(1)

# Specify the path and file
dir=${TODO_DIR:-"$HOME"/Todo}

# If the directory doesn't exist, create it
[ -d "$dir" ] || mkdir -p -- "$dir" || exit

# Change into the directory
cd -- "$dir" || exit

# If the current directory isn't a Git repository, try to create one
if ! command -v isgr >/dev/null 2>&1 ; then
    printf >&2 'isgr: command not found\n'
    exit 1
fi
isgr || git init --quiet || exit

if [ "$#" -eq 0 ] ; then
    set -- "${TODO_NAME:-todo}"
fi

# Launch an appropriate editor to edit those files
"${VISUAL:-"${EDITOR:-ed}"}" "$@"

# Add those files to the changeset
git add -- "$@"

# If there are changes to those files to commit, commit them
git diff-index --quiet HEAD "$@" 2>/dev/null ||
    git commit --message 'Changed by td(1df)' --quiet
