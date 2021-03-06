# Commit all changes to a Git repository with a stock message message

# Enter the given directory, default to the current one
cd -- "${1:-.}" || exit

# Check if there are any changes; if not, don't proceed (but it's not an error)
grc || exit 0

# Add all changes
git add --all || exit

# Quietly commit with a stock message and use its exit value as ours
git commit --message 'Committed by jfc(1df)' --quiet
