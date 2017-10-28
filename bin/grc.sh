# Check whether a directory is a Git repository with uncommitted changes

# Enter given directory or bail
cd -- "${1:-.}" || exit

# If not a Git repository at all, warn explicitly
if ! isgr ; then
    printf >&2 'grc: Not a Git repository\n'
    exit 1
fi

# Exit 0 if the first command gives any output (added files) or the second one
# exits 1 (inverted; differences in tracked files)
[ -n "$(git ls-files --others --exclude-standard)" ] ||
! git diff-index --quiet HEAD
