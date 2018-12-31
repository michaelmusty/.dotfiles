# If emacs is installed, and ~/.emacs exists, use emacs as the visual editor;
# otherwise, use the system's vi
if command -v emacs >/dev/null 2>&1 &&
    [ -f "$HOME"/.emacs ] ; then
    VISUAL=emacs
else
    VISUAL=vi
fi
export VISUAL
