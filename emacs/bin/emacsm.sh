# Try to manage GNU emacs daemons on the terminal
# Emphasis on "try".  Man, I have no idea what I'm doing.
emacsclient --create-frame --alternate-editor='' "$@"
