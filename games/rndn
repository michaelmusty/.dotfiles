#!/bin/sh
# Esoteric random number generator

# Single optional argument is a random seed, otherwise use rnds(1df)
s=${1:-"$(rnds)"}

# Validate s
case $s in
    *[!0-9]*)
        printf >&2 'rndn: Seed must be non-negative integer\n'
        exit 2
        ;;
esac

# Helper functions
t() {
    printf %u "$1" | cut -c -"$2"
}
l() {
    printf %u "$1" | wc -c
}
c() {
    printf %u "$1" | cut -c "$2"
}

# Apply algorithm; you are not expected to understand this
s=$(t "$((s + 10))" 32) i=1 t=0
while [ "$i" -le "$(l "$s")" ] ; do
    d=$(c "$s" "$i")
    t=$((t + d)) i=$((i + 1))
done
p=$((s - t))
while [ "$(l "$p")" -gt 1 ] ; do
    j=1 q=0
    while [ "$j" -le "$(l "$p")" ] ; do
        d=$(c "$p" "$j")
        q=$((q + d)) j=$((j + 1))
    done
    p=$q
done

# Print result
printf '%u\n' "$p"
