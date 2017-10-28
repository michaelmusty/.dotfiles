# Try to make a random temp directory

# Build the intended directory name, with the last element a random integer
# from 1..2^31
lim=$((2 << 31))
dn=${TMPDIR:-/tmp}/${1:-mktd}.$$.$(rndi 1 "$lim")

# Create the directory and print its name if successful
mkdir -m 700 -- "$dn" && printf '%s\n' "$dn"
