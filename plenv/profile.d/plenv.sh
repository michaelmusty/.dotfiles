# Add plenv to PATH and MANPATH if it appears to be in use
[ -d "$HOME"/.plenv ] || return
PATH=$HOME/.plenv/shims:$HOME/.plenv/bin:$PATH
MANPATH=$HOME/.plenv/versions/$(perl -e 'print substr($^V,1)')/man:$MANPATH
export MANPATH
