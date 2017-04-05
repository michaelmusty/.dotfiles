# Try to get a low-quality random seed from a random device if possible

# Sole optional argument is the bytes to read; 32 is the default
count=${1:-32}

# Try and find a random device to use; none of these are specified by POSIX
for dev in /dev/urandom /dev/arandom /dev/random '' ; do
    [ -e "$dev" ] && break
done

# Bail if we couldn't find a random device
[ -n "$dev" ] || exit 1

# Read the bytes from the device
dd if="$dev" bs=1 count="$count" 2>/dev/null |

# Run cksum(1) over the read random bytes
cksum |

# cut(1) the cksum(1) output to only the first field, and print that to stdout
cut -d' ' -f1
