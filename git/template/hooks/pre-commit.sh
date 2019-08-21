# Reject a commit directly to a branch named 'master' if a branch named
# 'develop' exists

# Allow commit if no HEAD ref (new repo), master branch, or develop branch
if ! git show-ref --quiet --verify \
        HEAD refs/heads/develop refs/heads/master ; then
    exit 0
fi

# Allow merge commit
if git show-ref --quiet --verify MERGE_HEAD ; then
    exit 0
fi

# Allow commit if not on master
case $(git rev-parse --abbrev-ref --verify HEAD) in
    master) ;;
    *) exit 0 ;;
esac

# Refuse to commit
printf >&2 'Branch develop exists, commits to master blocked\n'
exit 1
