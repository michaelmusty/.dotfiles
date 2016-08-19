# If Vim exists on the system, use it instead of ex, vi, and view
command -v vim >/dev/null 2>&1 || return

# Define functions proper
ex() {
    vim -e "$@"
}
vi() {
    vim "$@"
}
view() {
    vim -R "$@"
}
