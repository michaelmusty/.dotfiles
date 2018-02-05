# Manage to-do files with just $EDITOR and git(1)

# Specify the path and file
dir=${TODO_DIR:-"$HOME"/Todo}
file=${1:-"${TODO_NAME:-todo}"}

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

# If the to-do file doesn't exist yet, create it
[ -e "$file" ] || touch -- "$file" || exit

# Launch an appropriate editor to edit that file
"${VISUAL:-"${EDITOR:-ed}"}" "$file"

# Add the file to the changeset
git add -- "$file"

# If there are changes to commit, commit them
git diff-index --quiet HEAD 2>/dev/null ||
git commit --message 'Changed by td(1df)' --quiet
