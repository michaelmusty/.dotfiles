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
    -   Mostly fixed now with mktd(1), still using mktemp(1) in a few places
*   Where practical, the remaining Bash scripts in bin need to be reimplemented
    as POSIX sh
    -   Mostly done now:

        [tom@conan:~/.dotfiles/bin](git:master)$ grep bash *
        apf:#!/usr/bin/env bash
        edda:#!/usr/bin/env bash
        eds:#!/usr/bin/env bash
        han:#!/usr/bin/env bash
        jfcd:#!/usr/bin/env bash

*   OpenBSD doesn't have a `pandoc` package at all. It would be nice to find
    some way of converting the README.markdown into a palatable troff format
    with some more readily available (and preferably less heavyweight) tool.
*   Stepping into .git directories breaks the prompt functions:

        tom@REDACTED:REDACTED(git:master!?)$ cd .git
        fatal: This operation must be run in a work tree
        fatal: This operation must be run in a work tree
