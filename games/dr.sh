# Roll D&D-style dice in a ndn+n formula, e.g. 10d6+2

# Need exactly one argument
[ "$#" -eq 1 ] || exit 2

# Arcane string chopping
n=1 a=0
nd=${1%+*}
d=${nd#*d}
[ "${nd%d*}" != "" ] && n=${nd%d*}
[ "${1#*+}" = "$1" ] || a=${1#*+}

# Check number of roles and addendum make sense
[ "$((n > 0 && a >= 0))" -eq 1 ] || exit 2

# Check this is a real die you can actually roll
case $d in
    4|6|8|10|12|20) ;;
    *) exit 2 ;;
esac

# Roll the dice the appropriate number of times using rndi(1df)
i=0 t=0
while [ "$i" -lt "$n" ] ; do
    r=$(rndi 1 "$d")
    t=$((t + r))
    i=$((i + 1))
done

# Add the addendum
t=$((t + a))

# Print it
printf '%u\n' "$t"
