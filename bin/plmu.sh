
# Set up exceptions file if it exists
ef=$HOME/.plenv/non-cpanm-modules
[ -e "$ef" ] || ef=/dev/null

# Check that exceptions file is sorted
if ! sort -c -- "$ef" ; then
    printf >&2 '%s not sorted\n' "$ef"
    exit 1
fi

# Get the list of modules; sort them in case our current locale disagrees on
# the existing sorting
plenv list-modules | sort |

# Exclude any modules in ~.plenv/non-cpanm-modules if it exists
comm -23 -- - "$ef" |

# Read that list of modules to upgrade and upgrade them one by one
while read -r module ; do
    cpanm --notest --quiet -- "$module"
done
