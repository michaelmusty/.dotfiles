if [ -e "$HOME"/.xyzzy ] ; then
    printf >&2 '%s\n' 'Nothing happens.'
    exit 1
fi
printf '%s\n' 'I see no cave here.' > "$HOME"/.xyzzy
