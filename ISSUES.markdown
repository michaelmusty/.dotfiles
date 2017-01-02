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
*   dr(6df) is probably more practical in awk
*   How come commands I fix with the fc builtin always seem to exit 1 even if
    they succeed? Did I do that or is it Bash?
*   Running the block of git(1) commands in the prompt leaves five "stale"
    jobspecs around that flee after a jobs builtin run; only saw this manifest
    after 90dcadf; either I understand job specs really poorly or this may be a
    bug in bash
*   md() does not handle e.g. "../..". If there's a tidy way of making it do so
    that would probably be worthwhile.
