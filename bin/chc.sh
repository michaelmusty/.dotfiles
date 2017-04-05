# Cache the output of a command and emit it straight from the cache if not
# expired on each run

# First argument is the cache path, second is the duration in seconds
cac=$1 dur=$2
shift 2

# Get the current timestamp with uts(1df)
uts=$(uts) || exit

# Function checks cache exists, is readable, and not expired
fresh() {
    [ -f "$cac" ] || return
    [ -r "$cac" ] || return
    exp=$(sed 1q -- "$cac") || return
    [ "$((exp > uts))" -eq 1 ]
}

# Write runs the command and writes it to the cache
write() {
    exp=$((uts + dur))
    printf '%u\n' "$exp"
    "$@"
}

# If the cache isn't fresh, try to write a new one, or bail out
fresh "$cac" || write "$@" > "$cac" || exit

# Emit the content (exclude the first line, which is the timestamp)
sed 1d -- "$cac"
