# Test and open a clipboard URL with an apt program

# Check arguments
if [ "$#" -eq 0 ] ; then
    printf >&2 'xgo: At least one URL required\n'
    exit 2
fi

# Iterate over the URL arguments
for url do (

    # Look for patterns in the URL that suggest transformations
    case $url in

        # If this is a GitHub or GitLab link, swap "blob" for "raw" to get the actual file
        (*://github.com/*/blob/*|*://gitlab.com/*/blob/*)
            url=$(printf '%s\n' "$url" | sed 's_/blob/_/raw/_')
            ;;

        # Dig out the plain text for pastebin.com links
        (*://pastebin.com/*)
            # shellcheck disable=SC2016
            url=$(printf '%s\n' "$url" | sed 's_/[A-Za-z0-9][A-Za-z0-9]*$_/raw&_')
            ;;

        # If this is a not-direct imgur link and not to an album, swap URL
        # elements to get to the actual file (it may not actually be a JPEG;
        # the MIME type will tell us)
        (*://imgur.com/a/*) ;;
        (*://imgur.com/*)
            url=$(printf '%s\n' "$url" | sed 's_imgur\.com_i.imgur.com_;s/$/.jpg/')
            ;;

        # If this is a YouTube video without a given start time, load it in mpv(1)
        (*[/.]youtube.com/watch*[?\&]t=) ;;
        (*[/.]youtube.com/watch*)
            mpv -- "$url" && exit
            ;;
    esac

    # Get the MIME type data
    mt=$(urlmt "$url")

    # Switch on media type
    case $mt in

        # Open PDFs in xpdf(1); download them first as xpdf(1) does not seem to
        # have a way to handle stdin files
        (application/pdf)
            (
                cd -- "$HOME"/Downloads || exit
                curl -O -- "$url" || exit
                xpdf -- "${url##*/}"
            ) && exit
            ;;

        # Open audio and video in mpv(1); force a window even for audio so I
        # can control it
        (audio/*|video/*)
            mpv --force-window -- "$url" && exit
            ;;

        # If the MIME type is an image that is not a GIF, load it in feh(1)
        (image/gif) ;;
        (image/*)
            curl -- "$url" | feh - && exit
            ;;

        # Open plain text in a terminal view(1)
        (text/plain)
            # shellcheck disable=SC2016
            urxvt -e sh -c 'curl -- "$1" | view -' _ "$url" && exit
            ;;
    esac

    # Otherwise, just pass it to br(1df)
    br "$url"

) & done
