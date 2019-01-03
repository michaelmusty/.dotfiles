# If my Emacs wrapper is installed, use emacs as the visual editor; otherwise,
# use the system's vi
if command -v emacsm >/dev/null 2>&1 ; then
    VISUAL='emacsm'
else
    VISUAL='vi'
fi
export VISUAL
