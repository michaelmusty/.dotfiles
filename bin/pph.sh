# Run pp(1df) on args, prefix with machine hostname
hn=$(hostname -s) || exit
pp "$@" |
awk -v hn="$hn" '{ print hn ":" $0 }'
