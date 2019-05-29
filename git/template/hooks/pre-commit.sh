# Reject a commit directly to a branch named 'master' if a branch named
# 'develop' exists

# Allow commit if it's not to master
[ "$(git rev-parse --abbrev-ref HEAD)" = master ] || exit 0

# Allow commit if there's no develop branch
git show-ref --quiet --verify refs/heads/develop || exit 0

# Throw toys
printf >&2 'Branch develop exists, commits to master blocked\n'
exit 1
