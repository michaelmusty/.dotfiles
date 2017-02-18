# Add ~/.local/games to PATH if it exists
[ -d "$HOME"/.local/games ] || return
PATH=$HOME/.local/games:$PATH
