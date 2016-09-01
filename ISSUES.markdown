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
*   The \xFF syntax for regex as used in rfct(1df) is not POSIX. Need to decide
    if it's well-supported enough to keep it anyway.
*   On OpenBSD pdksh, including single quotes in comments within command
    substitution throws "unclosed quote" errors in the linter checks:

        sh/shrc.d/vr.sh[50]: no closing quote
        *** Error 1 in /home/tom/.dotfiles (Makefile:348 'check-sh')

    Fixed for the instances I found, but it would be interesting to find
    whether this is a bug in pdksh or whether it's a dark corner of the POSIX
    standard.

    Turns out that old versions of Bash in `sh` mode do this too.
*   I can probably share my psql() completions/shortcuts after sanitizing them
    a bit
*   A key binding for importing sections of the screen and optionally uploading
    it would be great, probably using ImageMagick import(1)
*   sxhkd(1) might be nicer than xbindkeys; it's in Debian Testing now
*   Maybe I should port some of the prompt functions to POSIX sh so I don't
    have to maintain parallel versions for bash, pdksh, and zsh
