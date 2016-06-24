# Add ~/.local/games to PATH if it exists
if [ -d "$HOME"/.local/games ] ; then
    PATH=$HOME/.local/games:$PATH
fi
