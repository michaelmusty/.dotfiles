# If an Emacs is installed, and ~/.emacs exists, use emacs as the visual
# editor; otherwise, use the system's vi
if command -v emacs >/dev/null 2>&1 &&
        [ -f "$HOME"/.emacs ] ; then

    # Use or start a GNU Emacs client, if possible
    if command -v pgrep >/dev/null 2>&1 &&
            pgrep --exact --full --euid="$USER" \
                'emacs --daemon' >/dev/null ||
            emacs --daemon >/dev/null ; then
        VISUAL=emacsclient

    # If no GNU Emacs daemon is available, just create a new instance every
    # time
    else
        VISUAL=emacs
    fi

# If an Emacs isn't installed, just use good old vi
else
    VISUAL=vi
fi

# Export final editor decision
export VISUAL
