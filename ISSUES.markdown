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
*   xrbg(1) is likely redundant:

    13:31:51 <tejr> i pick a random one on startup with a little script
    13:32:41 <cosarara> I run this on startup http://sprunge.us/JFCL
    13:33:06 <tejr> haha i didn't even know about --randomize
    13:33:14 <tejr> p sure that makes my script redundant actually
    13:33:32 <tejr> yep it does

*   dr(1df) is probably more practical in awk
*   unf(1df) doesn't work on NetBSD sed(1); might be time to give up and
    rewrite it in awk
*   sd2u(1df) and su2d(1df) are not portable because \r in the replacement text
    is not POSIX. Again, best bet is awk. *sigh*
