# Add ~/.local/games to PATH if it exists
[ -d "$HOME"/.local/games ] || return
PATH=$PATH:$HOME/.local/games
