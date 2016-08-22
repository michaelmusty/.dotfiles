# Basic PS1 for POSIX shell
# Does every POSIX shell support these? dash does, at least.
PS1=$(printf '%s@%s$ ' "$(whoami)" "$(hostname -s)")
