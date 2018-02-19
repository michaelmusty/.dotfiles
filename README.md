Dotfiles (Tom Ryder)
====================

This is my personal repository of configuration files and scripts for `$HOME`,
including most of the settings that migrate well between machines.

This repository began as a simple way to share Vim and tmux configuration, but
over time a lot of scripts and shell configuration have been added, making it
into a personal suite of custom Unix tools.

Installation
------------

    $ git clone https://sanctum.geek.nz/code/dotfiles.git ~/.dotfiles
    $ cd ~/.dotfiles
    $ git submodule init
    $ git submodule update
    $ make
    $ make -n install
    $ make install

For the default `all` target, you'll need a POSIX-fearing userland, including
`make(1)` and `m4(1)`.

The installation `Makefile` will overwrite things standing in the way of its
installed files without backing them up, so read the output of `make -n
install` before running `make install` to make sure you aren't going to lose
anything unexpected. If you're still not sure, install it in a temporary
directory so you can explore:

    $ tmpdir=$(mktemp -d)
    $ make install HOME="$tmpdir"
    $ env -i HOME="$tmpdir" TERM="$TERM" "$SHELL" -l

The default `install` target will install these targets and all their
dependencies. Note that you don't actually have to have any of this except `sh`
installed.

* `install-bin`
* `install-bin-man`
* `install-curl`
* `install-ex`
* `install-git`
* `install-gnupg`
* `install-less`
* `install-login-shell`
* `install-readline`
* `install-vim`

The `install-login-shell` looks at your `SHELL` environment variable and tries
to figure out which shell's configuration files to install, falling back on
`install-sh`.

The remaining files can be installed with the other `install-*` targets. Try
`awk -f bin/mftl.awk Makefile` in the project's root directory to see a list.

Tools
-----

Configuration is included for:

* Bourne-style POSIX shells, sharing a `.profile`, an `ENV` file, and some
  helper functions:
    * [GNU Bash](https://www.gnu.org/software/bash/) (2.05a or higher)
    * [Korn shell](http://www.kornshell.com/) (`ksh93`, `pdksh`, `mksh`)
    * [Z shell](https://www.zsh.org/)
* [Abook](http://abook.sourceforge.net/) -- curses address book program
* [cURL](https://curl.haxx.se/) -- Command-line tool for transferring data with
  URL syntax
* [Dunst](http://knopwob.org/dunst/) -- A lightweight X11 notification daemon
  that works with `libnotify`
* `finger(1)` -- User information lookup program
* [Git](https://git-scm.com/) -- Distributed version control system
* [GnuPG](https://www.gnupg.org/) -- GNU Privacy Guard, for private
  communication and file encryption
* [GTK+](https://www.gtk.org/) -- GIMP Toolkit, for graphical user interface
  elements
* [i3](https://i3wm.org/) -- Tiling window manager
* [less](https://www.gnu.org/software/less/) -- Terminal pager
* [Mutt](http://www.mutt.org/) -- Terminal mail user agent
* [`mysql(1)`](https://linux.die.net/man/1/mysql) -- Command-line MySQL client
* [Ncmpcpp](https://rybczak.net/ncmpcpp/) -- ncurses music player client
* [Newsboat](https://newsboat.org/) -- Terminal RSS/Atom feed reader
* [`psql(1)`](https://linux.die.net/man/1/psql) -- Command-line PostgreSQL
  client
* [Perl::Critic](http://perlcritic.com/) -- static source code analysis engine
  for Perl
* [Perl::Tidy](http://perltidy.sourceforge.net/) -- Perl source code
  reformatter
* [Readline](https://cnswww.cns.cwru.edu/php/chet/readline/rltop.html) -- GNU
  library for user input used by Bash, MySQL, and others
* [rxvt-unicode](http://software.schmorp.de/pkg/rxvt-unicode.html) -- Fork of
  the rxvt terminal emulator with Unicode support
* [Subversion](https://subversion.apache.org/) -- Apache Subversion, a version
  control system
* [tidy](http://www.html-tidy.org/) -- HTML/XHTML linter and tidier
* [tmux](https://tmux.github.io/) -- Terminal multiplexer similar to GNU Screen
* [Vim](http://www.vim.org/) -- Vi IMproved, a text editor
    * [Neovim](https://neovim.io/) -- An "emphatic fork" of Vim
* [X11](https://www.x.org/wiki/) -- Windowing system with network transparency
  for Unix

The configurations for shells, GnuPG, Mutt, tmux, and Vim are the most
expansive, and most likely to be of interest. The i3 configuration is mostly
changed to make window switching behave like Vim windows and tmux panes do, and
there's a fair few resources defined for rxvt-unicode.

### Shell

My `.profile` and other files in `sh` are written in POSIX shell script, so
they should work in most `sh(1)` implementations. Individual scripts called by
`.profile` are saved in `.profile.d` and iterated on login for ease of
management. Most of these boil down to exporting variables appropriate to the
system and the software it has available.

Configuration that should be sourced for all POSIX-fearing interactive shells
is kept in `~/.shrc`, with subscripts read from `~/.shrc.d`. There's a shim in
`~/.shinit` to act as `ENV`. I make an effort to target POSIX for my functions
and scripts where I can so that the same files can be loaded for all shells.

On GNU/Linux I use Bash, on BSD I use some variant of Korn Shell, preferably
`ksh93` if it's available.

As I occasionally have work on very old internal systems, my Bash is written to
work with [any version 2.05a or
newer](http://wiki.bash-hackers.org/scripting/bashchanges). This is why I use
older syntax for certain things such as appending items to arrays:

    array[${#array[@]}]=$item

Compare this to the much nicer syntax available since 3.1-alpha1, which
actually works for arrays with sparse indices, unlike the above syntax:

    array+=("$item")

Where I do use features that are only available in versions of Bash newer than
2.05a, such as newer `shopt` options or `PROMPT_DIRTRIM`, they are only run
after testing `BASH_VERSINFO` appropriately.

#### Prompt

A terminal session with my prompt looks something like this:

    ~$ ssh remote
    remote:~$ cd .dotfiles
    remote:~/.dotfiles(master+!)$ git status
     M README.md
    M  bash/bashrc.d/prompt.bash
    A  init
    remote:~/.dotfiles(master+!)$ foobar
    foobar: command not found
    remote:~/.dotfiles(master+!)<127>$ sleep 5 &
    [1] 28937
    remote:~/.dotfiles(master+!){1}$

The hostname is elided if not connected via SSH. The working directory with
tilde abbreviation for `$HOME` is always shown. The rest of the prompt expands
based on context to include these elements in this order:

* Whether in a Git repository if applicable, and punctuation to show repository
  status including reference to upstreams at a glance. Subversion support can
  also be enabled (I need it at work), in which case a `git:` or `svn:` prefix
  is added appropriately.
* The number of running background jobs, if non-zero.
* The exit status of the last command, if non-zero.

You can set `PROMPT_COLOR`, `PROMPT_PREFIX`, and `PROMPT_SUFFIX` too, which all
do about what you'd expect.

If you start up Bash, Korn shell, or Z shell, and it detects that it's normally
your `$SHELL` is one of the other two, the prompt will display an appropriate
prefix.

This is all managed within the `prompt` function. There's some mildly hacky
logic on `tput` codes included such that it should work correctly for most
common terminals using both `termcap(5)` and `terminfo(5)`, including \*BSD
systems. It's also designed to degrade gracefully for eight-color and no-color
terminals.

#### Functions

If a function can be written in POSIX `sh` without too much hackery, I put it
in `sh/shrc.d` to be loaded by any POSIX interactive shell. Those include:

* Four functions for using a "marked" directory, which I find a more manageable
  concept than the `pushd`/`popd` directory stack:
    * `md()` marks a given (or the current) directory.
    * `gd()` goes to the marked directory.
    * `pmd()` prints the marked directory.
    * `xd()` swaps the current and marked directories.
* Ten other directory management and navigation functions:
    * `bd()` changes into a named ancestor of the current directory.
    * `gt()` changes into a directory or into a file's directory.
    * `lgt()` runs `gt()` on the first result from a `loc(1df)` search.
    * `mkcd()` creates a directory and changes into it.
    * `pd()` changes to the argument's parent directory.
    * `rd()` replaces the first instance of its first argument with its second
      argument in `$PWD`, emulating a feature of the Zsh `cd` builtin that I
      like.
    * `scr()` creates a temporary directory and changes into it.
    * `sd()` changes into a sibling of the current directory.
    * `ud()` changes into an indexed ancestor of a directory.
    * `vr()` tries to change to the root directory of a source control
      repository.
* `bc()` silences startup messages from GNU `bc(1)`.
* `ed()` tries to get verbose error messages, a prompt, and a Readline
  environment for `ed(1)`.
* `gdb()` silences startup messages from `gdb(1)`.
* `grep()` tries to apply color and other options good for interactive use if
  available.
* `hgrep()` allows searching `$HISTFILE`.
* `keychain()` keeps `$GPG_TTY` up to date if a GnuPG agent is available.
* `ls()` tries to apply color and other options good for interactive use if
  available.
    * `la()` runs `ls -A` if it can, or `ls -a` otherwise.
    * `ll()` runs `ls -Al` if it can, or `ls -al` otherwise.
* `path()` manages the contents of `PATH` conveniently.
* `scp()` tries to detect forgotten hostnames in `scp(1)` command calls.
* `sudo()` forces `-H` for `sudo(8)` calls so that `$HOME` is never preserved;
  I hate having `root`-owned files in my home directory.
* `tree()` colorizes GNU `tree(1)` output if possible (without having
  `LS_COLORS` set).
* `x()` is a one-key shortcut for `exec startx`.

There are a few other little tricks defined for other shells providing
non-POSIX features, as compatibility allows:

* `keep()` stores ad-hoc shell functions and variables (Bash, Korn Shell 93, Z
  shell).
* `prompt()` sets up my interactive prompt (Bash, Korn Shell, Z shell).
* `pushd()` adds a default destination of `$HOME` to the `pushd` builtin
  (Bash).
* `vared()` allows interactively editing a variable with Readline, emulating a
  Zsh function I like by the same name (Bash).
* `ver()` prints the current shell's version information (Bash, Korn Shell, Z
  shell).

#### Completion

I find the `bash-completion` package a bit too heavy for my tastes, and turn it
off using a stub file installed in `~/.config/bash_completion`. The majority of
the time I just want to complete paths anyway, and this makes for a quicker
startup without a lot of junk functions in my Bash namespace.

I do make some exceptions with completions defined in `.bash_completion.d`
files, for things I really do get tired of typing repeatedly:

* Bash builtins: commands, help topics, shell options, variables, etc.
* `find(1)`'s more portable options
* `ftp(1)` hostnames from `~/.netrc`
* `git(1)` subcommands, remotes, branches, tags, and addable files
* `gpg(1)` long options
* `make(1)` targets read from a `Makefile`
* `man(1)` page titles
* `pass(1)` entries
* `ssh(1)` hostnames from `~/.ssh/config`

For commands that pretty much always want to operate on text, such as text file
or stream editors, I exclude special file types and extensions I know are
binary. I don't actually read the file, so this is more of a heuristic thing,
and sometimes it will get things wrong.

I also add completions for my own scripts and functions where useful. The
completions are dynamically loaded if Bash is version 4.0 or greater.
Otherwise, they're all loaded on startup.

#### Korn shell

These are experimental; they are mostly used to tinker with MirBSD `mksh`, AT&T
`ksh93`, and OpenBSD `pdksh`. All shells in this family default to a yellow
prompt if detected.

#### Z shell

These are experimental; I do not like Z shell much at the moment. The files
started as a joke (`exec bash`). `zsh` shells default to having a prompt
colored cyan.

### GnuPG

The configuration for GnuPG is intended to follow [RiseUp's OpenPGP best
practices](https://riseup.net/en/security/message-security/openpgp/best-practices).
The configuration file is rebuilt using `mi5(1df)` and `make(1)` because it
requires hard-coding a path to the SKS keyserver certificate authority, and
neither tilde nor `$HOME` expansion works for this.

### Mutt

My mail is kept in individual Maildirs under `~/Mail`, with `inbox` being where
most unfiltered mail is sent. I use
[Getmail](http://pyropus.ca/software/getmail/),
[maildrop](https://www.courier-mta.org/maildrop/), and
[msmtp](http://msmtp.sourceforge.net/); the configurations for these are not
included here. I sign whenever I have some indication that the recipient might
be using a PGP implementation, and I encrypt whenever I have a public key
available for them. The GnuPG and S/MIME interfacing is done with
[GPGme](https://www.gnupg.org/related_software/gpgme/), rather than defining
commands for each crypto operation. I wrote [an article about this
setup](https://sanctum.geek.nz/arabesque/linux-crypto-email/) if it sounds
appealing.

You'll need [Abook](http://abook.sourceforge.net/) installed if you want to use
the `query_command` I have defined, and [msmtp](http://msmtp.sourceforge.net/)
for the `sendmail` command.

### rxvt-unicode

I've butchered the URxvt Perl extensions `selection-to-clipboard` and
`selection` into a single `select` extension in `~/.urxvt/ext`, which is the
only extension I define in `~/.Xresources`.

The included `.Xresources` file assumes that `urxvt` can use 256 colors and
Perl extensions. If you're missing functionality, try changing
`perl-ext-common` to `default`.

My choice of font is [Ubuntu Mono](http://font.ubuntu.com/), but the file
should allow falling back to the more common [Deja Vu Sans
Mono](https://dejavu-fonts.github.io/). I've found
[Terminus](http://terminus-font.sourceforge.net/) works well too, but bitmap
fonts are not really my cup of tea. The Lohit Kannada font bit is purely to
make ಠ\_ಠ work correctly. ( ͡° ͜ʖ ͡°) seems to work out of the box.

### tmux

These are just generally vi-friendly settings, not much out of the ordinary.
Note that the configuration presently uses a hard-coded 256-color color scheme,
and uses non-login shells, with an attempt to control the environment to stop
shells thinking they have access to an X display.

The shell scripts in `bin` include `tm(1df)`, a shortcut to make `attach` into
the default command if no arguments are given and sessions do already exist. My
`~/.inputrc` file binds Alt+M to run that, and Tmux in turn binds the same key
combination to detach.

### Vim

The majority of the Vim configuration is just setting options, with a few
mappings. I try not to deviate too much from the Vim defaults behavior in terms
of interactive behavior and keybindings.

The configuration is broken into smaller files in `~/.vim/config/*.vim`,
included by `~/.vimrc` using
[`:runtime`](http://vimdoc.sourceforge.net/htmldoc/repeat.html#:runtime). It's
extensively commented, mostly because I was reading through it one day and
realized I'd forgotten what half of it did.

#### Plugins

If the logic for doing something involves more than a few lines or any
structures like functions, I like to implement it as a plugin in
`~/.vim/plugin` and/or `~/.vim/autoload`. There's documentation for each of
those in `~/.vim/doc`.

Any/all of those plugins may eventually be spun off into their own repositories
in the future, but for the moment they live here. You can create distribution
packages for them with `make dist-vim-plugin`; they will be created in
`vim/dist`.

I also define a few rules specific to file types I often edit in
`~/.vim/after/ftplugin`, including some local mappings for checking, linting,
and tidying, and a few more in `~/.vim/after/indent`. There are also a few
tweaks to core syntax files in `~/.vim/after/syntax`, especially for shell
script (`sh.vim`).

Third-party plugins are in submodules in `~/.vim/bundle`. They are installed
into `~/.vim` as normal.

#### Neovim

I test my configuration every now and then with the [Neovim
fork](https://neovim.io/). To install the configuration where Neovim will use
it, do this:

    $ nvd=${XDG_CONFIG_HOME:-"$HOME"/.config}/nvim
    $ make install-vim VIMRC="$nvd"/init.vim VIMDIR="$nvd"

Neovim's [godless
arrogance](https://twitter.com/tpope/status/437019518444240896)
notwithstanding, I do rather like it overall, but I'm not presently using it as
my daily driver and so it might balk at recent addenda to my configuration.

Scripts
-------

Where practical, I make short scripts into POSIX (but not Bourne) `sh(1)`,
`awk(1)`, or `sed(1)` scripts in `~/.local/bin`. I try to use shell functions
only when I actually need to, which tends to be when I need to tinker with the
namespace of the user's current shell.

Installed by the `install-bin` target:

* Three SSH-related scripts:
    * `sls(1df)` prints hostnames read from a `ssh_config(5)` file. It uses
      `slsf(1df)` to read each one.
    * `sra(1df)` runs a command on multiple hosts read from `sls(1df)` and
      prints output.
    * `sta(1df)` runs a command on multiple hosts read from `sls(1df)` and
      prints the hostname if the command returns zero.
* Five URL-related shortcut scripts:
    * `hurl(1df)` extracts values of `href` attributes of `<a>` tags, sorts
      them uniquely, and writes them to `stdout`; it requires
      [pup](https://github.com/ericchiang/pup).
    * `murl(1df)` converts Markdown documents to HTML with `pandoc(1)` and runs
      the output through `hurl(1df)`.
    * `urlc(1df)` accepts a list of URLs on `stdin` and writes error messages
      to `stderr` if any of the URLs are broken, redirecting, or are insecure
      and have working secure versions; requires `curl(1)`.
    * `urlh(1df)` prints the values for a given HTTP header from a HEAD
      response.
    * `urlmt(1df)` prints the MIME type from the `Content-Type` header as
      retrieved by `urlh(1df)`.
* Three RFC-related shortcut scripts:
    * `rfcf(1df)` fetches ASCII RFCs from the IETF website.
    * `rfct(1df)` formats ASCII RFCs.
    * `rfcr(1df)` does both, displaying in a pager if appropriate, like a
      `man(1)` reader for RFCs.
* Five toy random-number scripts (not for sensitive/dead-serious use):
    * `rndi(1df)` gets a random integer within two bounds.
    * `rnds(1df)` attempts to get an optional random seed for `rndi(1df)`.
    * `rnda(1df)` uses `rndi(1df)` to choose a random argument.
    * `rndf(1df)` uses `rnda(1df)` to choose a random file from a directory.
    * `rndl(1df)` uses `rndi(1df)` to choose a random line from files.
* Four file formatting scripts:
    * `d2u(1df)` converts DOS line endings in files to UNIX ones.
    * `u2d(1df)` converts UNIX line endings in files to DOS ones.
    * `stbl(1df)` strips a trailing blank line from the files in its arguments.
    * `stws(1df)` strips trailing spaces from the ends of lines of the files in
      its arguments.
* Seven stream formatting scripts:
    * `sd2u(1df)` converts DOS line endings in streams to UNIX ones.
    * `su2d(1df)` converts UNIX line endings in streams to DOS ones.
    * `slow(1df)` converts uppercase to lowercase.
    * `supp(1df)` converts lowercase to uppercase.
    * `tl(1df)` tags input lines with a prefix or suffix, basically a `sed(1)`
      shortcut.
    * `tlcs(1df)` executes a command and uses `tl(1df)` to tag standard output
      and standard error lines, and color them if you want.
    * `unf(1df)` joins lines with leading spaces to the previous line. Intended
      for unfolding HTTP headers, but it should work for most RFC 822 formats.
* Six simple aggregate scripts for numbers:
    * `max(1df)` prints the maximum.
    * `mean(1df)` prints the mean.
    * `med(1df)` prints the median.
    * `min(1df)` prints the minimum.
    * `mode(1df)` prints the first encountered mode.
    * `tot(1df)` totals the set.
* Three quick-and-dirty HTML tools:
    * `htenc(1df)` encodes.
    * `htdec(1df)` decodes.
    * `htrec(1df)` wraps `a` tags around URLs.
* Two internet message quoting tools:
    * `quo(1df)` indents with quoting right angle-brackets.
    * `wro(1df)` adds a quote attribution header to its input.
* Six Git-related tools:
    * `fgscr(1df)` finds Git repositories in a directory root and scrubs them
      with `gscr(1df)`.
    * `grc(1df)` quietly tests whether the given directory appears to be a Git
      repository with pending changes.
    * `gscr(1df)` scrubs Git repositories.
    * `isgr(1df)` quietly tests whether the given directory appears to be a Git
      repository.
    * `jfc(1df)` adds and commits lazily to a Git repository.
    * `jfcd(1df)` watches a directory for changes and runs `jfc(1df)` if it
      sees any.
* Two time duration functions:
    * `hms(1df)` converts seconds to `hh:mm:ss` or `mm:ss` timestamps.
    * `sec(1df)` converts `hh:mm:ss` or `mm:ss` timestamps to seconds.
* Three pipe interaction tools:
    * `pst(1df)` runs an interactive program on data before passing it along a
      pipeline.
    * `ped(1df)` runs `pst(1df)` with `$EDITOR` or `ed(1)`.
    * `pvi(1df)` runs `pvi(1df)` with `$VISUAL` or `vi(1)`.
* `ap(1df)` reads arguments for a given command from the standard input,
  prompting if appropriate.
* `apf(1df)` inserts arguments to a command with ones read from a file,
  intended as a framework for shell wrappers or functions.
* `ax(1df)` evaluates an AWK expression given on the command line; this is
  intended as a quick way to test how Awk would interpret a given expression.
* `bcq(1df)` runs `bc(1)`, quieting it down if need be.
* `bel(1df)` prints a terminal bell character.
* `bl(1df)` generates a given number of blank lines.
* `bp(1df)` runs `br(1df)` after prompting for an URL.
* `br(1df)` launches `$BROWSER`.
* `ca(1df)` prints a count of its given arguments.
* `cf(1df)` prints a count of entries in a given directory.
* `cfr(1df)` does the same as `cf(1df)`, but recurses into subdirectories as
  well.
* `chc(1df)` caches the output of a command.
* `chn(1df)` runs a filter over its input a given number of times.
* `clog(1df)` is a tiny timestamped log system.
* `clrd(1df)` sets up a per-line file read, clearing the screen first.
* `clwr(1df)` sets up a per-line file write, clearing the screen before each
  line.
* `csmw(1df)` prints an English list of monospace-quoted words read from the
  input.
* `dam(1df)` buffers all its input before emitting it as output.
* `ddup(1df)` removes duplicate lines from unsorted input.
* `dmp(1df)` copies a pass(1) entry selected by `dmenu(1)` to the X CLIPBOARD.
* `dub(1df)` lists the biggest entries in a directory.
* `edda(1df)` provides a means to run `ed(1)` over a set of files preserving
  any options, mostly useful for scripts.
* `eds(1df)` edits executable script files in `EDSPATH`, defaulting to
  `~/.local/bin`, for personal scripting snippets.
* `exm(1df)` works around a screen-clearing quirk of Vim's `ex` mode.
* `finc(1df)` counts the number of results returned from a set of given
  `find(1)` conditions.
* `fnl(1df)` runs a command and saves its output and error into temporary
  files, printing their paths and line counts.
* `fnp(1df)` prints the given files to standard output, each with a plain text
  heading with the filename in it.
* `gms(1df)` runs a set of `getmailrc` files; does much the same thing as the
  script `getmails` in the `getmail` suite, but runs the requests in parallel
  and does up to three silent retries using `try(1df)`.
* `grec(1df)` is a more logically-named `grep -c`.
* `gred(1df)` is a more logically-named `grep -v`.
* `gwp(1df)` searches for alphanumeric words in a similar way to `grep(1)`.
* `han(1df)` provides a `keywordprg` for Vim's Bash script file type that will
  look for `help` topics. You could use it from the shell too.
* `igex(1df)` wraps around a command to allow you to ignore error conditions
  that don't actually worry you, exiting with 0 anyway.
* `ix(1df)` posts its input to the `ix.io` pastebin.
* `jfp(1df)` prints its input, excluding any shebang on the first line only.
* `loc(1df)` is a quick-search wrapped around `find(1)`.
* `maybe(1df)` is like `true(1)` or `false(1)`; given a probability of success,
  it exits with success or failure. Good for quick tests.
* `mex(1df)` makes given filenames in `$PATH` executable.
* `mi5(1df)` is a crude preprocessor for `m4`.
* `mftl(1df)` finds usable-looking targets in makefiles.
* `mkcp(1df)` creates a directory and copies preceding arguments into it.
* `mkmv(1df)` creates a directory and moves preceding arguments into it.
* `motd(1df)` shows the system MOTD.
* `mw(1df)` prints alphabetic space-delimited words from the input one per
  line.
* `oii(1df)` runs a command on input only if there is any.
* `onl(1df)` crunches input down to one printable line.
* `osc(1df)` implements a `netcat(1)`-like wrapper for `openssl(1)`'s
  `s_client` subcommand.
* `p(1df)` prints concatenated standard input; `cat(1)` as it should always
  have been.
* `pa(1df)` prints its arguments, one per line.
* `pp(1df)` prints the full path of each argument using `$PWD`.
* `pph(1df)` runs `pp(1df)` and includes a leading `$HOSTNAME:`.
* `paz(1df)` print its arguments terminated by NULL chars.
* `pit(1df)` runs its input through a pager if its standard output looks like a
  terminal.
* `plmu(1df)` retrieves a list of installed modules from
  [`plenv`](https://github.com/tokuhirom/plenv), filters out any modules in
  `~/.plenv/non-cpan-modules`, and updates them all.
* `pwg(1df)` generates just one decent password with `pwgen(1)`.
* `rep(1df)` repeats a command a given number of times.
* `rgl(1df)` is a very crude interactive `grep(1)` loop.
* `shb(1df)` attempts to build shebang lines for scripts from the system paths.
* `sqs(1df)` chops off query strings from filenames, usually downloads.
* `sshi(1df)` prints human-readable SSH connection details.
* `stex(1df)` strips extensions from filenames.
* `sue(8df)` execs `sudoedit(8)` as the owner of all the file arguments given,
  perhaps in cases where you may not necessarily have `root` `sudo(8)`
  privileges.
* `swr(1df)` allows you to run commands locally specifying remote files in
  `scp(1)`'s HOST:PATH format.
* `td(1df)` manages a to-do file for you with `$EDITOR` and `git(1)`; I used to
  use Taskwarrior, but found it too complex and buggy.
* `tm(1df)` runs `tmux(1)` with `attach-session -d` if a session exists, and
  `new-session` if it doesn't.
* `trs(1df)` replaces strings (not regular expression) in its input.
* `try(1df)` repeats a command up to a given number of times until it succeeds,
  only printing error output if all three attempts failed. Good for tolerating
  blips or temporary failures in `cron(8)` scripts.
* `umake(1df)` iterates upwards through the directory tree from `$PWD` until it
  finds a Makefile for which to run `make(1)` with the given arguments.
* `uts(1df)` gets the current UNIX timestamp in an unorthodox way that should
  work on all POSIX-compliant operating systems.
* `vest(1df)` runs `test(1)` but fails with explicit output via `vex(1df)`.
* `vex(1df)` runs a command and prints `true` or `false` explicitly to `stdout`
  based on the exit value.
* `xrbg(1df)` applies the same randomly-selected background to each X screen.
* `xrq(1df)` gets the values of specific resources out of `xrdb -query` output.

There's some silly stuff in `install-games`:

* `aaf(6df)` gets a random [ASCII Art Farts](http://www.asciiartfarts.com/)
    comic.
* `acq(6df)` allows you to interrogate AC, the interplanetary computer.
* `aesth(6df)` converts English letters to their full width CJK analogues,
    for ＡＥＳＴＨＥＴＩＣ　ＰＵＲＰＯＳＥＳ.
* `squ(6df)` makes a reduced Latin square out of each line of input.
* `kvlt(6df)` translates input to emulate a style of typing unique to black
    metal communities on the internet.
* `philsay(6df)` shows a picture to accompany `pks(6df)` output.
* `pks(6df)` laughs at a randomly selected word.
* `rndn(6df)` implements an esoteric random number generation algorithm.
* `strik(6df)` outputs s̶t̶r̶i̶k̶e̶d̶ ̶o̶u̶t̶ struck out text.
* `rot13(6df)` rotates the Latin letters in its input.
* `xyzzy(6df)` teleports to a marked location on the filesystem.
* `zs(6df)` prefixes "z" case-appropriately to every occurrence of "s" in the
    text on its standard input.

Manuals
-------

The `install-bin` and `install-games` targets install manuals for each script
they install. If you want to use the manuals, you may need to add
`~/.local/share/man` to your `~/.manpath` or `/etc/manpath` configuration,
depending on your system.

Testing
-------

You can check that both sets of shell scripts are syntactically correct with
`make check-bash`, `make check-sh`, or `make check` for everything including
the scripts in `bin` and `games`. There's no proper test suite for the actual
functionality (yet).

There are also optional `lint` targets, if you have the appropriate tools
available to run them:

* [ShellCheck](https://www.shellcheck.net/):
    * `lint-bash`
    * `lint-bin`
    * `lint-games`
    * `lint-ksh`
    * `lint-sh`
    * `lint-xinit`
* [Perl::Critic](http://perlcritic.com/):
    * `lint-urxvt`
* [Vint](https://github.com/Kuniwak/vint):
    * `lint-vim`

Known issues
------------

See ISSUES.markdown.

License
-------

Public domain; see the included `UNLICENSE` file. It's just configuration and
simple scripts, so do whatever you like with it if any of it's useful to you.
If you're feeling generous, please join and/or donate to a free software
advocacy group, and let me know you did it because of this project:

* [Free Software Foundation](https://www.fsf.org/)
* [Software in the Public Interest](https://www.spi-inc.org/)
* [FreeBSD Foundation](https://www.freebsdfoundation.org/)
* [OpenBSD Foundation](http://www.openbsdfoundation.org/)
