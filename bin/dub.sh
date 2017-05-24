# List the biggest files in a directory

# First optional argument is the directory, defaulting to the
# current dir; second optional argument is the number of files to
# show, defaulting to 20
dir=${1:-.} lines=${2:-10}

# Enter the target dir or bail
cd -- "$dir" || exit

# Add files matching glob, shift them off if unexpanded (first and
# only entry doesn't exist)
set -- *
[ -e "$1" ] || shift

# Add dot files, shift off the "." and ".." entries (sh(1)
# implementations seem to vary on whether they include these)
set -- .* "$@"
[ -e "$1" ] || shift
[ "$1" = . ] && shift
[ "$1" = .. ] && shift

# Run du(1) with POSIX compatible flags -k for kilobyte unit and
# -s for total over the arguments
du -ks -- "$@" |

# Sort the first field (the sizes) numerically, in reverse
sort -k1,1nr |

# Limit the output to the given number of lines
sed "$lines"q