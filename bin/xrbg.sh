# Apply a random background image.  Requires rndf(1df) and feh(1).
bg=$(rndf "${XBACKGROUNDS:-"$HOME"/.xbackgrounds}") || exit
feh --bg-scale --no-fehbg -- "$bg"
