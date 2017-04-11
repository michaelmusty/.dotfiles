# Set visual editor; vim if we've got it, but vi will do fine
if command -v vim >/dev/null 2>&1 ; then
    VISUAL=vim
else
    VISUAL=vi
fi
export VISUAL
