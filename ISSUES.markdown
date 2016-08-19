Known issues
============

*   vr() does not handle the newer version of Subversion repositories which
    only have a .svn directory at the root level.
*   The terminfo files probably still do not work on NetBSD (needs retesting
    and manual page reading).
*   man(1) completion doesn't work on OpenBSD as manpath(1) isn't a thing on
    that system; need to find some way of finding which manual directories
    should be searched at runtime, if there is one.
*   Where practical, the remaining Bash scripts in bin need to be reimplemented
    as POSIX sh
    -   Mostly done now:

        [tom@conan:~/.dotfiles/bin](git:master)$ grep bash *
        apf:#!/usr/bin/env bash
        edda:#!/usr/bin/env bash
        eds:#!/usr/bin/env bash
        han:#!/usr/bin/env bash

*   OpenBSD doesn't have a `pandoc` package at all. It would be nice to find
    some way of converting the README.markdown into a palatable troff format
    with some more readily available (and preferably less heavyweight) tool.
*   At least one of the completion scripts (pass.bash) hangs on empty
    completions (i.e. nothing matches the search term) in Bash 4.4rc1; the last
    thing bash -x shows is an "exit 1" hang
*   The checks gscr(1) makes to determine where it is are a bit naive (don't
    work with bare repos) and could probably be improved with some appropriate
    git-reflog(1) cals
