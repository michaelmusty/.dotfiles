Dotfiles (Tom Ryder)
====================

This is my personal repository of configuration files and scripts for `$HOME`,
including most of the settings that migrate well between machines.

Installation
------------

    $ git clone https://sanctum.geek.nz/code/dotfiles.git ~/.dotfiles
    $ cd ~/.dotfiles
    $ git submodule init
    $ git submodule update
    $ make
    $ make -n install
    $ make install

For the default target, you'll need `bash(1)`, `git(1)`, `install(1)`,
`make(1)`, `m4(1)`, and `tic(1)`. You'll need to have a recent enough version
of Git to support
[submodules](https://git-scm.com/book/en/v2/Git-Tools-Submodules) for the Vim
installation to work; it's required for the plugin setup.

The installation `Makefile` will overwrite things standing in the way of its
installed files without backing them up, so read the output of `make -n
install` before running `make install` to make sure you aren't going to lose
anything unexpected. If you're still not sure, install it in a temporary
directory so you can explore:

    $ tmpdir=$(mktemp -d)
    $ make install HOME="$tmpdir"
    $ env -i HOME="$tmpdir" TERM="$TERM" bash -l

The default target will install the core terminal-only files (cURL, Git, GnuPG,
Vim, and shell and terminal setup files). The remaining dotfiles can be
installed with the other targets. Take a look at the `Makefile` to see what's
available.

Tools
-----

Configuration is included for:

*   [Abook](http://abook.sourceforge.net/) -- curses address book program
*   [Bash](https://www.gnu.org/software/bash/) -- GNU Bourne-Again Shell,
    including a `~/.profile` configured to work with most Bourne-compatible
    shells
*   [cURL](https://curl.haxx.se/) -- Command-line tool for transferring data with
    URL syntax
*   [`dircolors(1)`](https://www.gnu.org/software/coreutils/manual/html_node/dircolors-invocation.html)
    -- Color GNU `ls(1)` output
*   [Dunst](http://knopwob.org/dunst/) -- A lightweight X11 notification daemon
    that works with `libnotify`
*   `finger(1)` -- User information lookup program
*   [Git](https://git-scm.com/) -- Distributed version control system
*   [GnuPG](https://www.gnupg.org/) -- GNU Privacy Guard, for private
    communication and file encryption
*   [GTK+](http://www.gtk.org/) -- GIMP Toolkit, for graphical user interface
    elements
*   [i3](https://i3wm.org/) -- Tiling window manager
*   [Mutt](http://www.mutt.org/) -- Terminal mail user agent
*   [`mysql(1)`](http://linux.die.net/man/1/mysql) -- Command-line MySQL client
*   [Ncmpcpp](http://rybczak.net/ncmpcpp/) -- ncurses music player client
*   [Newsbeuter](https://www.newsbeuter.org/) -- Terminal RSS/Atom feed reader
*   [`psql(1)`](http://linux.die.net/man/1/psql) -- Command-line PostgreSQL
    client
*   [Perl::Critic](http://perlcritic.com/) -- static source code analysis engine
    for Perl
*   [Perl::Tidy](http://perltidy.sourceforge.net/) -- Perl indenter and
    reformatter
*   [Readline](https://cnswww.cns.cwru.edu/php/chet/readline/rltop.html) -- GNU
    library for user input used by Bash, MySQL, and others
*   [rxvt-unicode](http://software.schmorp.de/pkg/rxvt-unicode.html) -- Fork of
    the rxvt terminal emulator with Unicode support
*   [Subversion](https://subversion.apache.org/) -- Apache Subversion, a version
    control system
*   [tmux](https://tmux.github.io/) -- Terminal multiplexer similar to GNU
    Screen
*   [Vim](http://www.vim.org/) -- Vi IMproved, a text editor
*   [Wyrd](https://packages.debian.org/sid/wyrd) -- a `curses` calendar
    frontend for [Remind](https://www.roaringpenguin.com/products/remind)
*   [X11](https://www.x.org/wiki/) -- Windowing system with network transparency
    for Unix
*   [Zsh](http://www.zsh.org/) -- Bourne-style shell designed for interactive
    use

The configurations for Bash, GnuPG, Mutt, tmux, and Vim are the most expansive
and most likely to be of interest. The i3 configuration is mostly changed to
make window switching behave like Vim windows and tmux panes do, and there's a
fair few resources defined for rxvt-unicode. Otherwise, the rest of the
configuration isn't too distant from the defaults.

### Shell

My `.profile` and other files in `sh` are written in Bourne/POSIX shell script,
so they should work in most `sh(1)` implementations. Individual scripts called
by `.profile` are saved in `.profile.d` and iterated on login for ease of
management. All of these boil down to exporting variables appropriate to the
system and the software it has available.

My `.bash_profile` calls `.profile` and then runs subscripts in
`.bash_profile.d`. It then runs `.bashrc`, which only applies for interactive
shells; subscripts for that in turn are loaded from `.bashrc.d`. The contents
of the two directories changes depending on the host, so only specific scripts
in it are versioned.

My interactive and scripting shell of choice is Bash; as a GNU/Linux admin who
ends up installing Bash on \*BSD machines anyway, I very rarely have to write
Bourne-compatible scripts, so all of these files are replete with Bashisms.

As I occasionally have work on very old internal systems, my Bash is written to
work with [any version 2.05a or
newer](http://wiki.bash-hackers.org/scripting/bashchanges). This is why I use
older syntax for certain things such as appending items to arrays:

    array[${#array[@]}]=$item

Compare this to the much nicer syntax available since 3.1-alpha1, which
actually works for arrays with sparse indexes, unlike the above syntax:

    array+=("$item")

Where I do use features that are only available in versions of Bash newer than
2.05a, such as newer `shopt` options or `PROMPT_DIRTRIM`, they are only run
after testing `BASH_VERSINFO` appropriately.

When I use any other Bourne-compatible shell, I'm generally happy to accept its
defaults for interactive behavior.

A terminal session with my prompt looks something like this:

    [tom@conan:~/.dotfiles](git:master+!)$ git status
     M README.markdown
    M  bash/bashrc.d/prompt.bash
    A  init
    [tom@conan:~/.dotfiles](git:master+!)$ foobar
    foobar: command not found
    [tom@conan:~/.dotfiles](git:master+!)<127>$ sleep 5 &
    [1] 28937
    [tom@conan:~/.dotfiles](git:master+!){1}$

It expands based on context to include these elements in this order:

*   Whether in a Git repository if applicable, and punctuation to show whether
    there are local modifications at a glance; Subversion and Mercurial support
    can also be enabled
*   The number of running background jobs, if non-zero
*   The exit status of the last command, if non-zero

You can set `PROMPT_COLOR`, `PROMPT_PREFIX`, and `PROMPT_SUFFIX` too, which all
do about what you'd expect.

This is all managed within the `prompt` function. There's some mildly hacky
logic on `tput` codes included such that it should work correctly for most
common terminals using both `termcap(5)` and `terminfo(5)`, including \*BSD
systems. It's also designed to degrade gracefully for eight-color and no-color
terminals.

#### Completion

I find the `bash-completion` package a bit too heavy for my tastes, and turn it
off using a stub file installed in `.config/bash_completion`. The majority of
the time I just want to complete paths anyway, and this makes for a quicker
startup without a lot of junk functions in my Bash namespace.

I do make some exceptions with completions defined in `.bashrc.d` files for
things I really do get tired of typing repeatedly:

*   Builtins, commands, help topics, shell options, and variables
*   `ftp(1)` hostnames from `~/.netrc`
*   `git(1)` branch names
*   `gpg(1)` long options
*   `make(1)` targets read from a `Makefile`
*   `man(1)` page titles
*   `mysql(1)` databases from `~/.mysql/*.cnf`
*   `pass(1)` entries
*   `ssh(1)` hostnames from `~/.ssh/config`

#### Functions

There are a few other little tricks in `bash/bashrc.d`, including:

*   `apf` -- Prepend arguments to a command with ones read from a file
*   `bd` -- Change into a named ancestor of the current directory
*   `cf` -- Count files in a given directory
*   `fnl` -- Run a command and save its output and error into temporary files
*   `hgrep` -- `HISTFILE` search
*   `keep` -- Permanently store ad-hoc shell functions and variables
*   `mkcd` -- Create a directory and change into it
*   `pa` -- Print given arguments, one per line
*   `path` -- Manage the contents of `PATH` conveniently
*   `paz` -- Print given arguments separated by NULL chars
*   `pd` -- Change to the argument's parent directory
*   `readv` -- Print names and values from `read` calls to `stderr`
*   `readz` -- Alias for `read -d '' -r`
*   `scr` -- Create a temporary directory and change into it
*   `sd` -- Switch to a sibling directory
*   `sprunge` -- Pastebin frontend tool I pilfered from `#bash` on Freenode
*   `ud` -- Change into an indexed ancestor of a directory

I also wrap a few command calls with functions to stop me from doing silly
things that the commands themselves don't catch. My favourite is the one that
stops me from calling `scp(1)` with no colon in either argument. I also do
things like give default arguments to `pwgen(1)`.

### GnuPG

The configuration for GnuPG is intended to follow [RiseUp's OpenPGP best
practices](https://help.riseup.net/en/security/message-security/openpgp/best-practices).
The configuration file is rebuilt using `m4(1)` and `make(1)` because it
requires hard-coding a path to the SKS keyserver certificate authority, and
neither tilde nor `$HOME` expansion works for this.

### Mutt

My mail is kept in individual Maildirs under `~/Mail`, with `inbox` being where
most unfiltered mail is sent. I use
[Getmail](http://pyropus.ca/software/getmail/),
[maildrop](http://www.courier-mta.org/maildrop/), and
[MSMTP](http://msmtp.sourceforge.net/); the configurations for these are not
included here. I sign whenever I have some indication that the recipient might
be using a PGP implementation, and I encrypt whenever I have a public key
available for them. The GnuPG interfacing is done with
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
Mono](http://dejavu-fonts.org/wiki/Main_Page). I've found
[Terminus](http://terminus-font.sourceforge.net/) works well too, but bitmap
fonts are not really my cup of tea. The Lohit Kannada font bit is purely to
make ಠ\_ಠ work correctly. ( ͡° ͜ʖ ͡°) seems to work out of the box.

### tmux

These are just generally vi-friendly settings, not much out of the ordinary.
Note that the configuration presently uses a hard-coded 256-color colorscheme,
and uses non-login shells, with an attempt to control the environment to stop
shells thinking they have access to an X display.

The configuration file is created with `m4(1)` to allow specifying a colour
theme. This is just because I use a different colour for my work session. The
default is a dark grey.

The configuration for Bash includes a `tmux` function designed to make `attach`
into the default command if no arguments are given and sessions do already
exist. The default command is normally `new-session`.

### Vim

The majority of the `.vimrc` file is just setting options, with a few mappings.
I try not to deviate too much from the Vim defaults behaviour in terms of
interactive behavior and keybindings.

The configuration is extensively commented, mostly because I was reading
through it one day and realised I'd forgotten what half of it did. Plugins are
loaded using @tpope's [pathogen.vim](https://github.com/tpope/vim-pathogen).

Scripts
-------

Installed by the `install-bin` target:

*   Three SSH-related scripts:
    *   `sls(1)` prints hostnames read from a `ssh_config(5)` file.
    *   `sra(1)` runs a command on multiple hosts read from `sls(1)` and prints
        output.
    *   `sta(1)` runs a command on multiple hosts read from `sls(1)` and prints
        the hostname if the command returns zero.
*   Three URL-related shorcut scripts:
    *   `hurl(1)` extracts values of `href` attributes of `<a>` tags, sorts
        them uniquely, and writes them to `stdout`; requires
        [pup](https://github.com/ericchiang/pup)
    *   `murl(1)` converts Markdown documents to HTML with `pandoc(1)` and
        runs the output through `hurl(1)`
    *   `urlc(1)` accepts a list of URLs on `stdin` and writes error messages
        to `stderr` if any of the URLs are broken, redirecting, or are insecure
        and have working secure versions; requires `curl(1)`
*   Three RFC-related shortcut scripts:
    *   `rfcf(1)` fetches ASCII RFCs from the IETF website
    *   `rfct(1)` formats ASCII RFCs
    *   `rfcr(1)` does both, displaying in a pager if appropriate, like a
        `man(1)` reader for RFCs
*   `ax(1)` evaluates an awk expression given on the command line; intended as
    a quick way to test how Awk would interpret a given expression.
*   `ca(1)` prints a count of its given arguments.
*   `dub(1)` lists the biggest entries in a directory.
*   `edda(1)` provides a means to run `ed(1)` over a set of files preserving
    any options, mostly useful for scripts.
*   `eds(1)` edits executable script files in `EDSPATH`, defaulting to
    `~/.local/bin`, for personal scripting snippets.
*   `fgscr(1)` finds Git repositories in a directory root and scrubs them with
    `gscr(1)`.
*   `gms(1)` runs a set of `getmailrc` files; does much the same thing as the
    script `getmails` in the `getmail` suite, but runs the requests in parallel
    and does up to three silent retries using `try(1)`
*   `gscr(1)` scrubs Git repositories.
*   `han(1)` provides a `keywordprg` for Vim's Bash script filetype that will
    look for `help` topics. You could use it from the shell too.
*   `igex(1)` wraps around a command to allow you to ignore error conditions
    that don't actually worry you, exiting with 0 anyway.
*   `jfc(1)` adds and commits lazily to a Git repository.
*   `jfcd(1)` watches a directory for changes and runs `jfc(1)` if it sees any.
*   `maybe(1)` is like `true(1)` or `false(1)`; given a probability of success,
    it exits with success or failure. Good for quick tests.
*   `mkcp(1)` creates a directory and copies preceding arguments into it
*   `mkmv(1)` creates a directory and moves preceding arguments into it
*   `pit(1)` runs its input through a pager if its standard output looks like a
    terminal.
*   `plmu(1)` retrieves a list of installed modules from
    [`plenv`](https://github.com/tokuhirom/plenv), filters out any modules in
    `~/.plenv/non-cpan-modules`, and updates them all.
*   `stbl(1)` strips a trailing blank line from the files in its arguments.
*   `sue(8)` execs `sudoedit(8)` as the owner of all the file arguments given,
    perhaps in cases where you may not necessarily have `root` `sudo(8)`
    privileges.
*   `td(1)` manages a to-do file for you with `$EDITOR` and `git(1)`; I used to
    use Taskwarrior, but found it too complex and buggy.
*   `tl(1)` tags input lines with a prefix or suffix, basically a `sed(1)`
    shortcut.
*   `tlcs(1)` executes a command and uses `tl(1)` to tag stdout and stderr
    lines, and color them if you want.
*   `try(1)` repeats a command up to a given number of times until it succeeds,
    only printing error output if all three attempts failed. Good for
    tolerating blips or temporary failures in `cron(8)` scripts.

There's some silly stuff in `install-games`:

*   `aaf(6)` gets a random [ASCII Art Farts](http://www.asciiartfarts.com/)
    comic.
*   `kvlt(6)` translates input to emulate a style of typing unique to black
    metal communities on the internet.
*   `rndn(6)` implements an esoteric random number generation algorithm.
*   `zs(6)` prepends "z" case-appropriately to every occurrence of "s" in the
    text on its standard input.

Manuals
-------

The `install-bin` and `install-games` targets install manuals for each script
they install. There's also an `install-dotfiles-man` target that uses
`pandoc(1)` to reformat this document as a manual page for section 7
(`dotfiles(7)`) if you want that. I haven't made that install by default,
because `pandoc(1)` is a bit heavy.

If you want to use the manuals, you may need to add `~/.local/share/man` to
your `/etc/manpath` configuration, depending on your system.

Testing
-------

You can test that both sets of shell scripts are syntactically correct with
`make test-bash`, `make test-sh`, or `make test` for everything including the
scripts in `bin` and `games`.

If you have [ShellCheck](https://www.shellcheck.net/) and/or
[Perl::Critic](http://perlcritic.com/), there's a `lint` target for the shell
script files and Perl files respectively. The files don't need to pass that
check to be installed.

Known issues
------------

I'd welcome patches or advice on fixing any of these problems.

*   The `install-terminfo` target does not work correctly on NetBSD due to the
    different way `tic(1)` works, which I don't understand at all.

Note for previous visitors
--------------------------

Most of this repository's five-year history was rewritten shortly after I moved
it from GitHub to cgit, taking advantage of the upheaval to reduce its size and
remove useless binary blobs and third-party stuff that I never should have
versioned anyway. If you've checked this out before, you'll probably need to do
it again, and per-commit links are likely to be broken. Sorry about that.

License
-------

Public domain; see the included `UNLICENSE` file. It's just configuration and
simple scripts, so do whatever you like with it if any of it's useful to you.
If you're feeling generous, you could always [buy me a
coffee](https://sanctum.geek.nz/) next time you're in New Zealand.
