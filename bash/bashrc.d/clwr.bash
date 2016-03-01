# Clear screen, accept line, write to all args, loop; use this as e.g. an input
# tmux window for a minimal IRC client like ii(1). Uses read -e to allow
# newlines.
clwr() {
    while { clear && IFS= read -er line ; } ; do
        printf '%s\n' "$line"
    done
}

