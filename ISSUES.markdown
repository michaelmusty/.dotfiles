Known issues
============

*   vr() does not handle the newer version of Subversion repositories which
    only have a .svn directory at the root level.
*   The terminfo files probably still do not work on NetBSD (needs retesting
    and manual page reading).
*   man(1) completion doesn't work on OpenBSD as manpath(1) isn't a thing on
    that system; need to find some way of finding which manual directories
    should be searched at runtime, if there is one.
*   mktemp(1) is not POSIX, though it's commonly available; where a temporary
    file is unavoidable, it might be nice to abstract this with a wrapper
    script that uses mktemp(1) if it can, but otherwise uses mkdir(1) with a
    randomised name in "${TMPDIR:-/tmp}". Is mktemp(1) on every *BSD?
