# Start an Emacs server if we can't detect one already running
pgrep -fx -u "$USER" 'emacs --daemon' >/dev/null || emacs --daemon
