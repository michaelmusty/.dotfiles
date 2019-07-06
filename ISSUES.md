Known issues
============

* `man(1)` completion doesn't work on OpenBSD as `manpath(1)` isn't a thing on
  that system; need to find some way of finding which manual directories should
  be searched at runtime, if there is one.
* The checks `gscr(1df)` makes to determine where it is are a bit naïve (don't
  work with bare repos) and could probably be improved with some appropriate
  `git-reflog(1)` calls
* `dr(6df)` is probably more practical in awk
* Running the block of git(1) commands in the prompt leaves five "stale"
  jobspecs around that flee after a jobs builtin run; only saw this manifest
  after `90dcadf`; either I understand job specs really poorly or this may be a
  bug in bash
* I can't find a clean way of detecting a restricted shell for ksh instances to
  prevent trying to load anything fancy (works for Bash)
    * Zsh, either! $options[restricted] is "off" within the startup file
* Would be good to complete the Makefile variables for NAME, EMAIL etc with
  educated guesses (`id -u`@`cat /etc/mailname`) etc rather than hardcoding my
  own stuff in there
* Need to decide whether I care about XDG, and implement it if I do
* Need to decide whether I'm testing the shell snippets for MPD, Keychain etc,
  and if so how.
* The custom shell functions really should be documented, but it's not clear to
  me exactly where this should happen, because the commands' availability
  depends on which shell you're using; the `sd` function isn't available when
  you're not using Bash.  Maybe I should try to extend `help` without breaking
  it?
* The `b:undo\_indent` definition for the `perl` filetype can probably be
  pushed upstream.
* The `_text_filenames` completion handler for Bash won't work on files with
  newlines in their names.  Can it be made to?
* A paste operation, maybe TextChanged, should probably end a pending paste
