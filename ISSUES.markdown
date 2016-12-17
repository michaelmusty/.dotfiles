Known issues
============

*   man(1) completion doesn't work on OpenBSD as manpath(1) isn't a thing on
    that system; need to find some way of finding which manual directories
    should be searched at runtime, if there is one.
*   OpenBSD doesn't have a `pandoc` package at all. It would be nice to find
    some way of converting the README.markdown into a palatable troff format
    with some more readily available (and preferably less heavyweight) tool.
*   The checks gscr(1df) makes to determine where it is are a bit naive (don't
    work with bare repos) and could probably be improved with some appropriate
    git-reflog(1) calls
*   I can probably share my psql() completions/shortcuts after sanitizing them
    a bit
*   A key binding for importing sections of the screen and optionally uploading
    it would be great, probably using ImageMagick import(1)
*   sxhkd(1) might be nicer than xbindkeys; it's in Debian Testing now
*   dr(1df) is probably more practical in awk
*   How come commands I fix with the fc builtin always seem to exit 1 even if
    they succeed? Did I do that or is it Bash?
*   typeset in ksh93 does not seem to make the variable local, maybe I'm
    missing some magic
