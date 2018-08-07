# Invoke $VISUAL
v() {
    "${VISUAL:-vi}" "$@"
}
