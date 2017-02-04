Ideas
=====

*   I can probably share my psql() completions/shortcuts after sanitizing them
    a bit
*   sxhkd(1) might be nicer than xbindkeys; it's in Debian Testing now
*   Wouldn't be too hard to add some HTTP BASIC auth to ix(1df) to make pastes
    manageable
*   Have eds(1df) accept stdin with the "starting content" for the script
*   Convert all the manual pages to mandoc maybe? <https://en.wikipedia.org/wiki/Mandoc>
*   edio(1df), like vipe(1)
*   Detect appropriate shell family to install in Makefile
*   qmp(1df)--quick man page
*   ad() could be more intelligent; if there's only one directory that matches
    the *whole pattern*, we can assume it's safe to use that one, rather than
    stopping each time any node has more than one match
*   It seems likely that testing the terminal with tput to check if we can use
    --color with GNU grep(1) or ls(1) is overkill--I suspect it probably tests
    that internally, which would simplify the function wrappers. Need to check
    the source probably.
