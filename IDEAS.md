Ideas
=====

* A wrapper `ksw(1df)` (kill-switch) that traps `SIGINT` to kill a called
  program or loop immediately, rather than aborting a loop (is this possible?)
* A wrapper `sil(1df)` or `nec(1df)` to turn `stty -echo` off for the duration
  of a paste?
* I can probably share my `psql()` completions/shortcuts after sanitizing them
  a bit
* Wouldn't be too hard to add some HTTP BASIC authentication to `ix(1df)` to
  make pastes manageable
* Have `eds(1df)` accept standard input with the "starting content" for the
  script
* Convert all the manual pages to Mandoc format maybe?
  <https://en.wikipedia.org/wiki/Mandoc>
* `qmp(1df)`--quick man page
* The solution to `chn(1df)` not running in parallel is probably backgrounded
  processes and `mkfifo(1)`.
* Write something like `hcat(1df)` or `tcat(1df)` that includes filename
  headings for each concatenated file.
* I can probably get rid of all that nasty templated shell by writing something
  that wraps around `mktd(1df)` and generates shell script to run, and calls
  that via `eval`.
* Ideally, the AWK and/or sed scripts in the bin and games directories should
  be syntax-checked or linted.  I could at least add some patient application
  of appropriate `gawk --lint` calls for each of the .awk scripts.
* Write a ftplugin for Perl to switch between punctuation variable names and
  English variable names., i.e. \e on `$?` would change to `$CHILD_ERROR`, and
  vice-versa.
* Almost definitely going to want to try a runparts layout for Git hooks at
  some point
* I'd like a Git hook that pre-fills out "Version X.Y.Z" if making an annotated
  tag named `vX.Y.Z`.
* There's no reason to limit `digraph_search.vim` to insert mode only
* fortune.vim can be spun out into its own repository
* put\_date.vim can be spun out into its own repository
