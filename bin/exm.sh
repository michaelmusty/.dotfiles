# Prevent Vim's ex(1) implementation from clearing the screen
if [ -t 0 ] ; then

    # Lie to Vim; tell it it's a dumb terminal, and that its required "cm"
    # feature is invoked with a carriage return.
    cmd=$(printf 'set t_cm=\r|')
    set -- -T dumb --cmd "${cmd%|}" "$@"
fi
exec ex "$@"
