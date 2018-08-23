# Upgrade plenv modules with cpanm(1)

# Set up exceptions file if it exists
ef=$HOME/.plenv/non-cpanm-modules
[ -e "$ef" ] || ef=/dev/null

# Check that exceptions file is sorted
if ! LC_COLLATE=C sort -c -- "$ef" ; then
    printf >&2 '%s not sorted\n' "$ef"
    exit 1
fi

# Get the list of modules; sort them in case our current locale disagrees on
# the existing sorting
plenv list-modules | LC_COLLATE=C sort |

# Exclude any modules in ~/.plenv/non-cpanm-modules if it exists
LC_COLLATE=C comm -23 -- - "$ef" |

# Read that list of modules to upgrade and upgrade them one by one
while read -r module ; do
    cpanm --notest --quiet -- "$module"
done
