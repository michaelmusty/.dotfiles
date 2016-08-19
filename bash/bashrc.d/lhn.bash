# Print the history number of the last command
lhn () {
    local last
    last=$(fc -l -1) || return
    [[ -n $last ]] || return
    printf '%u\n' "${last%%[^0-9]*}"
}
