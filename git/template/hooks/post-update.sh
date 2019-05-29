# Update server info automatically if this is a bare repository

# Get whether this is bare from git-config(1); this returns the strings 'true'
# or 'false'; I don't think you can coerce the exit value instead, which would
# have been nice
bare=$(git config core.bare)

# If it's 'true', update the server info so that this works via cgit or Gitweb
case $bare in
    true) git update-server-info ;;
esac
