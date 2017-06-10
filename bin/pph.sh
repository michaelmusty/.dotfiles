# Run pp(1df) on args, prefix with machine hostname
hn=$(hostname -s) || exit
pp "$@" | while IFS= read -r path ; do
    printf '%s:%s\n' "$hn" "$path"
done
