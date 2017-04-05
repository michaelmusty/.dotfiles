# Show the system MOTD
motd=${MOTD:-/etc/motd}
[ -f "$motd" ] || exit
cat -- "$motd"
