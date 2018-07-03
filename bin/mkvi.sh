#!/bin/sh
# Create paths to all files before invoking editor
for file ; do
    mkdir -p -- "${file%/*}" || exit
done
exec "$VISUAL" "$@"
