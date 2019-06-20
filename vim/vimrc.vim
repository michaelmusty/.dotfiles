" Tom Ryder (tejr)'s Literate Vimrc
" =================================
"
" <https://sanctum.geek.nz/cgit/dotfiles.git>
"
" This is an attempt at something like a 'literate vimrc', in the tradition of
" Donald Knuth's "literate programming":
"
" <http://www.literateprogramming.com/>
"
" It's a long file, and comments abound.  If this bothers you, you can execute
" this command in Vim to strip out all the blank lines and lines with only
" comments:
"
"   :g/\m^$\|^\s*"/d
"
" This file should be saved as "vimrc" in the user runtime directory. On
" Unix-like operating systems, this is ~/.vim; on Windows, it's ~/vimfiles.
" It requires Vim 7.0 or newer with +eval, with 'nocompatible'.  The vimrc
" stub at ~/.vimrc on Unix or ~/_vimrc on Windows should check that these
" conditions are met before loading this file with `:runtime vimrc`.
"
" > And I was lifted up in heart, and thought
" > Of all my late-shown prowess in the lists,
" > How my strong lance had beaten down the knights,
" > So many and famous names; and never yet
" > Had heaven appeared so blue, nor earth so green,
" > For all my blood danced in me, and I knew
" > That I should light upon the Holy Grail.
" >
" > --Tennyson
"

" This file has characters outside the ASCII character set, which makes the
" Vim script linter vim-vint recommend declaring the file encoding with
" a :scriptencoding command.  The :help for this command specifies that it
" should be done after 'encoding' is set, so we'll do that here at the top of
" the file too.
"
" On Unix, I keep LANG defined in my environment, and it's almost always set
" to a multibyte (UTF-8) locale.  This informs Vim's choice of internal
" character encoding, but the default for the 'encoding' option in LANG's
" absence is "latin1".  Nowadays, this is never what I want, so we'll manually
" choose "utf-8" as an encoding instead if the encoding is the default
" 'latin1', and LANG is not defined.
"
if !exists('$LANG') && &encoding ==# 'latin1'
  set encoding=utf-8
endif
scriptencoding utf-8

" With encoding handled, the next thing we'll do is ensure we have an
" environment variable MYVIM set that specifies the path to the directory
" holding user runtime files.  We'll only set our own if such a variable does
" not already exist in the environment.
"
" We'll use the path nominated in the MYVIM variable as the root of our
" 'backupdir', 'directory', 'undodir', and 'viminfofile' caches, and anywhere
" else we need a sensible writable location for Vim-related files.  Having it
" available as an environment variable makes assignments with :set and
" escaping much more convenient, without requiring awkward :execute wrappers.
"
" I think the absence of a variable like this is a glaring omission from Vim.
" We have VIM, VIMRUNTIME, and MYVIMRC, so why is there not an environment
" variable for the user's Vim runtime directory?  It is a mystery.
"
" The default value for MYVIM will be the first path in &runtimepath.  This is
" similar to what Vim does internally for situating its spelling database
" files, in the absence of a specific setting for 'spellfile'.
"
" Splitting the values of a comma-separated option like 'runtimepath'
" correctly is surprisingly complicated.  The list separator for such options
" is more accurately defined as follows:
"
" > A comma not preceded by a backslash, and possibly followed by an arbitrary
" > number of spaces and commas.
"
" The pattern required for the split breaks down like this:
"
"   \\     <- Literal backslash
"   \@<!   <- Negative lookbehind assertion; means that whatever occurred
"             before this pattern, here a backslash, cannot precede what
"             follows, but anything that does precede it is not removed from
"             the data as part of the split delimiter
"   ,      <- Literal comma
"   [, ]*  <- Any number of commas and spaces
"
" For the edge case of a blank 'runtimepath', MYVIM will be set to the empty
" string, due to the way that split() works by default without its third
" parameter {keepempty} set to false.
"
" Once we have the path elements, we have to remove the escaping for periods,
" specifically remove up to one backslash before all periods.  We do that with
" a map() over substitute(), string-eval style to accommodate older Vim before
" Funcref variables were added.
"
" We don't, however, have to deal with backslashes before other backslashes,
" nor before any other character.  You can read the source code for the ad-hoc
" tokenizer in copy_option_part() in src/misc2.c in Vim's source code, and
" test it with some values of your own, if you want to understand why.
"
" I'll factor all of this mess out into a global function if I ever need it
" anywhere else.  Vim, I love you, but you are really weird.
"
if !exists('$MYVIM')
  let $MYVIM = map(
        \ split(&runtimepath, '\\\@<!,[, ]*')
        \,'substitute(v:val, ''\\,'', '''', ''g'')'
        \)[0]
endif

" Having either imported or defined a value for the MYVIM environment
" variable, we now need to ensure it's not going to cause problems for the
" rest of this file.  If any of those conditions are met, we'll throw an
" explanatory error and stop reading this file.  Most of the file doesn't
" depend on MYVIM, but there's not much point accommodating these edge cases.
"

" Firstly, MYVIM can't be an empty string.  We need a real path.
"
if $MYVIM ==# ''
  echoerr 'Blank user runtime path'
  finish
endif

" Secondly, if MYVIM's value contains a comma, its use in comma-separated
" option values will confuse Vim into thinking more than one directory is
" being specified, splitting our value into parts.  This is normal :set
" behavior.  It's possible to work around this with some careful escaping or
" :execute abstraction, but it's not really worth the extra complexity for
" such a niche situation.
"
if stridx($MYVIM, ',') >= 0
  echoerr 'Illegal comma in user runtime path'
  finish
endif

" Thirdly, Vim v7 prior to v7.1.055 had a nasty bug with escaping with
" multiple backslash characters on the command line, and so on these older
" versions of Vim, we'll need to forbid that character in the value of MYVIM
" in order to be confident that we're stashing files in the correct path.
"
" To reproduce this bug on these older versions, try this command:
"
"   :file foo\ bar\ baz
"
" It should rename the buffer as "foo bar aaz"; note the change in the first
" letter of the last word of the filename.
"
" <https://github.com/vim/vim/releases/tag/v7.1.055>
"
if (v:version < 701 || v:version == 701 && !has('patch55'))
      \ && stridx($MYVIM, '\') >= 0
  echoerr 'Illegal backslash in user runtime path on Vim < v7.1.055'
  finish
endif

" Now that we have a bit more confidence in our runtime environment, set up
" all of the filetype detection, plugin, and indent hooks.
"
filetype plugin indent on

" There are a couple of contexts in which it's useful to reload filetypes for
" the current buffer, quietly doing nothing if filetypes aren't enabled.
" We'll set up a user command named :ReloadFileType to do this, with
" a script-local function backing it.
"
function! s:ReloadFileType() abort
  if exists('g:did_load_filetypes')
    doautocmd filetypedetect BufRead
  endif
endfunction
command! -bar ReloadFileType
      \ call s:ReloadFileType()

" We'll also define a :ReloadVimrc command.  This may seem like overkill, at
" first.  Surely just `:source $MYVIMRC` would be good enough?
"
" The problem is there are potential side effects to the current buffer when
" the vimrc is reloaded.  The :set commands for options like 'expandtab' and
" 'shiftwidth' may trample over different buffer-local settings that were
" specified by filetype and indent plugins.  To ensure these local values are
" reinstated, we'll define the new command wrapper to issue a :ReloadFileType
" command after the vimrc file is sourced.
"
" We can't put the actual :source command into the script-local function we
" define here, because Vim would get upset that we're trying to redefine
" a function as it executes!
"
" Just to be on the safe side, we also suppress any further ##SourceCmd hooks
" from running the :source command with a :noautocmd wrapper.  This is
" a defensive measure to avoid infinite recursion.  It may not actually be
" necessary.
"
" We emit a message afterwards, just to make it clear that something has
" happened.  The :redraw just before that message seems to be necessary for
" this message to display correctly.  I'm not sure why.
"
function! s:ReloadVimrc() abort
  ReloadFileType
  redraw
  echomsg fnamemodify($MYVIMRC, ':p:~').' reloaded'
endfunction
command! -bar ReloadVimrc
      \ noautocmd source $MYVIMRC | call s:ReloadVimrc()

" We'll now create or reset a group of automatic command hooks specific to
" matters related to reloading the vimrc itself, or maintaining and managing
" options set within it.
"
augroup vimrc
  autocmd!
augroup END

" Reload the stub vimrc, and thereby this main one, each time either of them
" is written.  This often makes errors in the file immediately apparent, and
" saves restarting Vim or running the :source command manually, which I almost
" always want to do after changing my vimrc file anyway.
"
autocmd vimrc BufWritePost $MYVIMRC,$MYVIM/vimrc
      \ ReloadVimrc

" If Vim is new enough (v7.0.187) to support the ##SourceCmd event for
" automatic command hooks, we'll also apply a hook for that event to catch
" invocations of :source of either vimrc file, and translate that into
" reloading the stub vimrc.
"
" <https://github.com/vim/vim/releases/tag/v7.0.187>
"
if exists('##SourceCmd')
  autocmd vimrc SourceCmd $MYVIMRC,$MYVIM/vimrc
        \ ReloadVimrc
endif

" We're going to be creating a few directories now.  The code to do so in
" a compatible way is verbose, mostly because we need to check whether the
" directory already exists, even though we're specifying the special 'p' value
" for its optional {path} argument.  This is because until v8.0.1708, mkdir()
" raises an error if the directory to be created already exists, even with
" a {path} of 'p', where the analogous `mkdir` shell command does not do so
" with its -p option included.
"
" <https://github.com/vim/vim/releases/tag/v8.0.1708>
"
" So, let's wrap that logic in a script-local function s:Establish(), and then
" hide it behind a user command :Establish.  We'll lock down all the
" directories that we create with restrictive permissions, too.  Who knows
" what secrets are in your file buffers?
"
" We set the command's tab completion to provide directory names as
" candidates, and specify that there must be only one argument, which we'll
" provide as a quoted parameter to the function.
"
function! s:Establish(name) abort
  let name = a:name
  let path = 'p'
  let prot = 0700
  if !isdirectory(name) && exists('*mkdir')
    call mkdir(name, path, prot)
  endif
endfunction
command! -bar -complete=dir -nargs=1 Establish
      \ call s:Establish(<f-args>)

" Now that we have a clean means to create directories if they don't already
" exist, let's apply it for the first time to the user runtime directory.
" Note that we aren't checking whether this actually succeeded.  We do want
" errors raised if there were problems with the creation, but we'll barrel on
" ahead regardless after warning the user about our failure.
"
Establish $MYVIM

" Our next application of our new :Establish command is to configure the path
" for the viminfo metadata file, putting it in a cache subdirectory of the
" user runtime directory set in MYVIM.
"
" Using this non-default location for viminfo has the nice benefit of
" preventing command and search history from getting clobbered when something
" runs Vim without using this vimrc, because such an instance will safely
" write its history to the default viminfo path instead.  It also contributes
" to our aim of having everything related to the Vim runtime process in one
" dedicated directory tree.
"
" The normal method of specifying the path to the viminfo file, as applied
" here, is an addendum of the path to the 'viminfo' option with an "n" prefix.
" Vim v8.1.716 introduced a nicer way to set this with an option named
" 'viminfofile', which is too new for us to use just yet.
"
" <https://github.com/vim/vim/releases/tag/v8.1.0716>
"
Establish $MYVIM/cache
set viminfo+=n$MYVIM/cache/viminfo

" Speaking of recorded data in viminfo files, the default Vim limit of a mere
" 50 entries for command and search history is pretty mean.  Because I don't
" think I'm ever likely to be in a situation where remembering several
" thousand Vim commands and search patterns is going to severely tax memory,
" let alone disk space, I'd rather this limit were much higher.  It's
" sometimes really handy to dig up commands from many days ago.
"
" The maximum value for the 'history' option is documented in `:help
" 'history'` as 10000, so let's just use that, and see if anything breaks.
"
set history=10000

" We'll now enable automatic backups of most file buffers, since that's off by
" default.  In practice, I don't need these backups very much, at least if I'm
" using version control sensibly, but they have still saved my bacon a few
" times.
"
" We'll try to keep the backup files in a dedicated cache directory, to stop
" them popping up next to the file to which they correspond, and getting
" accidentally committed to version control.
"
" If Vim is new enough, we'll add two trailing slashes to the path we're
" inserting, which prompts Vim to incorporate the full escaped path of the
" relevant buffer in the backup filename, avoiding collisions.
"
" As a historical note, other similar directory path list options supported
" this trailing slashes hint for a long time before 'backupdir' caught up to
" them.  The 'directory' option for swap files has supported it at least as
" far back as v5.8.0 (2001), and 'undodir' appears to have supported it since
" its creation in v7.2.438.  Even though the :help for 'backupdir' didn't say
" so, people assumed it would work the same way, when in fact Vim simply
" ignored it until v8.1.0251.  I don't want to add the slashes to the option
" value in older versions of Vim where they don't do anything, so we'll check
" the version ourselves to see if there's any point in including them.
"
" <https://github.com/vim/vim/releases/tag/v8.1.0251>
"
" It's all so awkward.  Surely separate options named something like
" 'backupfullname', 'swapfilefullname' would have been clearer.
"
set backup
Establish $MYVIM/cache/backup
if has('patch-8.1.251')
  set backupdir^=$MYVIM/cache/backup//
else
  set backupdir^=$MYVIM/cache/backup
endif

" Files in certain directories on Unix-compatible filesystems should not be
" backed up, for security reasons.  This is particularly important if editing
" temporary files created by sudoedit(8).  On Unix-like systems, we here add
" a few paths to the default value of 'backupskip' in order to prevent the
" creation of such undesired backup files.
"
" * /dev/shm: RAM disk, default path for password-store's temporary files
" * /usr/tmp: Hard-coded path for sudoedit(8) [1/2]
" * /var/tmp: Hard-coded path for sudoedit(8) [2/2]
"
" Prior to v8.1.1519, Vim didn't check patterns added to 'backupskip' for
" uniqueness, so adding the same path repeatedly resulted in duplicate strings
" in the value.  This was due to the absence of the P_NODUP flag for the
" option's definition in src/option.c in the Vim source code.  If we're using
" a version older than v8.1.1519, we'll need to explicitly reset 'backupskip'
" to its default value before adding patterns to it, so that reloading this
" file doesn't stack up multiple copies of any added paths.
"
" <https://github.com/vim/vim/releases/tag/v8.1.1519>
"
if has('unix')
  if !has('patch-8.1.1519')
    set backupskip&
  endif
  set backupskip^=/dev/shm/*,/usr/tmp/*,/var/tmp/*
endif

" Keep swap files for file buffers in a dedicated directory, rather than the
" default of writing them to the same directory as the buffer file.  Add two
" trailing slashes to the path to prompt Vim to use the full escaped path in
" its name, in order to avoid filename collisions, since the 'directory'
" option has supported that hint for much longer than 'backupdir' has.  We
" apply :Establish to attempt to create the path first, if needed.
"
Establish $MYVIM/cache/swap
set directory^=$MYVIM/cache/swap//

" Keep tracked undo history for files permanently, in a dedicated cache
" directory, so that the u/:undo and CTRL-R/:redo commands will work between
" Vim invocations.
"
" The 'undodir' option has the same structure as 'backupdir' and 'directory';
" if we have a user runtime directory, create a sub-subdirectory within it
" dedicated to the undo files cache.  Note also the trailing double-slash as
" a signal to Vim to use the full path of the original file in its undo file
" cache's name.
"
" Support for these persistent undo file caches was not released until v7.3.0,
" so we need to check for the feature's presence before we enable it.
"
if has('persistent_undo')
  Establish $MYVIM/cache/undo
  set undofile
  set undodir^=$MYVIM/cache/undo//
endif

" For spelling, use New Zealand English by default, but later on we'll
" configure a leader mapping to switch to United States English, since I so
" often have to write for Yankees.  We'll set the 'spellfile' option too, to
" place it in the cache directory into which we've been putting everything.
" We'll follow Vim's standard naming convention for the file itself, though.
" If available, my plugin spellfile_local.vim will extend this later to add
" more spelling word lists per filetype and per file.
"
set spelllang=en_nz
Establish $MYVIM/cache/spell
let &spellfile = $MYVIM.'/cache/spell/'.join([
      \ substitute(&spelllang, '_.*', '', '')
      \,&encoding
      \,'add'
      \], '.')

" For word completion in insert mode with CTRL-X CTRL-K, or if 'complete'
" includes the 'k' flag, the 'dictionary' option specifies the path to the
" system word list.  This makes the dictionary completion work consistently,
" even if 'spell' isn't set at the time to coax it into using 'spellfile'.
"
" It's not an error if the system directory file added first doesn't exist;
" it's just a common location that often yields a workable word list, and does
" so on all of my main machines.
"
" At some point, I may end up having to set this option along with 'spellfile'
" a bit more intelligently to ensure that spell checking and dictionary
" function consistently, and with reference to the same resources.  For the
" moment, I've just added another entry referring to a directory in the user
" runtime directory, but I don't have anything distinct to put there yet.
"
" In much the same way, we add an expected path to a thesaurus, for completion
" with CTRL-X CTRL-T in insert mode, or with 't' added to 'completeopt'.  The
" thesaurus data isn't installed as part of the default `install-vim` target
" in tejr's dotfiles, but it can be retrieved and installed with
" `install-vim-thesaurus`.
"
" I got the thesaurus itself from the link in the :help for 'thesaurus' in
" v8.1.  It's from WordNet and MyThes-1.  I maintain a mirror on my own
" website that the Makefile recipe attempts to retrieve.  I had to remove the
" first two metadata lines from thesaurus.txt, as Vim appeared to interpret
" them as part of the body data.
"
" Extra checks for appending the 'dictionary' and 'thesaurus' paths in MYVIM
" need to be made, because the P_NDNAME property is assigned to them, which
" enforces a character blacklist in the option value.  We check for the same
" set of blacklist characters here, and if the MYVIM path offends, we just
" skip the setting entirely, rather than throwing cryptic errors at the user.
" None of them are particularly wise characters to have in paths, anyway,
" legal though they may be on Unix filesystems.
"
set dictionary^=/usr/share/dict/words
if $MYVIM !~# '[*?[|;&<>\r\n]'
  set dictionary^=$MYVIM/ref/dictionary.txt
  set thesaurus^=$MYVIM/ref/thesaurus.txt
endif

" Next, we'll modernize a little in adjusting some options with old
" language-specific defaults.
"
" Traditional vi was often used for development in the C programming language.
" The default values for a lot of Vim's options still reflect this common use
" pattern.  In this case, the 'comments' and 'commentstring' options reflect
" the C syntax for comments:
"
"     /*
"      * This is an ANSI C comment.
"      */
"
" Similarly, the 'define' and 'include' options default to C preprocessor
" directives:
"
"     #define FOO "bar"
"
"     #include "baz.h"
"
" Times change, however, and I don't get to work with C nearly as much as I'd
" like.  The defaults for these options no longer make sense, and so we blank
" them, compelling filetype plugins to set them as they need instead.
"
" The default value for the 'path' option is similar, in that it has an aged
" default; this option specifies directories in which project files and
" includes can be unearthed by navigation commands like 'gf'.  Specifically,
" its default value comprises /usr/include, which is another C default.  Let's
" get rid of that, too.
"
set comments= commentstring= define= include=
set path-=/usr/include

" Next, we'll adjust the global indentation settings.  In general and as
" a default, I prefer spaces to tabs, and I like to use four of them, for
" a more distinct visual structure.  Should you happen to disagree with this,
" I cordially invite you to fite me irl.
"
" <https://sanctum.geek.nz/blinkenlights/spaces.webm>
"
" Filetype indent plugins will often refine these settings for individual
" buffers.  For example, 'expandtab' is not appropriate for Makefiles, nor for
" the Go programming language.  For another, two-space indents are more
" traditional for Vim script.
"
set autoindent    " Use indent of previous line on new lines
set expandtab     " Insert spaces when tab key is pressed in insert mode
set shiftwidth=4  " Indent command like < and > use four-space indents
set smarttab      " Tab at start of line means indent, otherwise means tab

" Apply 'softtabstop' option to make a tab key press in insert mode insert the
" same number of spaces as defined by the indent depth in 'shiftwidth'.  If
" Vim is new enough to support it (v7.3.693), apply a negative value to do
" this dynamically if 'shiftwidth' changes.
"
" <https://github.com/vim/vim/releases/tag/v7.3.693>
"
if v:version > 703 || v:version == 703 && has('patch693')
  set softtabstop=-1
else
  let &softtabstop = &shiftwidth
endif

" Relax traditional vi's harsh standards over what regions of the buffer can
" be removed with backspace in insert mode.  While this admittedly allows bad
" habits to continue, since insert mode by definition is not really intended
" for deleting text, I feel the convenience outweighs that in this case.
"
set backspace+=eol     " Line breaks
set backspace+=indent  " Leading whitespace characters created by 'autoindent'
set backspace+=start   " Text before the start of the current insertion

" When soft-wrapping text with the 'wrap' option on, which is off by default,
" break the lines between words, rather than within them; it's much easier to
" read.
"
set linebreak

" Similarly, show that the screen line is a trailing part of a wrapped line by
" prefixing it with an ellipsis.  If we have a multi-byte encoding, use
" a proper ellipsis character to save a couple of columns, but otherwise three
" periods will do just fine.
"
"     …  U+2026  HORIZONTAL ELLIPSIS
"
" Note that we test for the presence of a multi-byte encoding with a special
" feature from `:help feature-list`, as recommended by `:help encoding`.
" Checking that `&encoding ==# 'utf-8'` is not quite the same thing, though
" it's unlikely I'll ever use a different Unicode encoding by choice.
"
if has('multi_byte_encoding')
  set showbreak=…
else
  set showbreak=...
endif

" The visual structure of code provided by indents breaks down if a lot of the
" lines wrap.  Ideally, most if not all lines would be kept below 80
" characters, but in cases where this isn't possible, soft-wrapping longer
" lines when 'wrap' is on so that the indent is preserved in the following
" line mitigates this breakdown somewhat.
"
" With this 'breakindent' option set, it's particularly important to have
" 'showbreak' set to something besides an empty string, as done above,
" otherwise without line numbers it's hard to tell what's a logical line and
" what's not.
"
" The 'breakindent' option wasn't added until v7.4.338, so we need to check it
" exists before we set it.
"
" <https://github.com/vim/vim/releases/tag/v7.4.338>
"
if exists('+breakindent')
  set breakindent
endif

" Rather than rejecting operations like :write or :saveas when 'readonly' is
" set or in other situations in which data might be lost, Vim should give me
" a prompt to allow me to confirm that I know what I'm doing.
"
set confirm

" If Vim receives an Escape key code in insert mode, it shouldn't wait to see
" if it's going to be followed by another key code, despite this being how the
" function keys and Meta/Alt modifier are implemented for many terminal types.
" Otherwise, if I press Escape, there's an annoying delay before 'showmode'
" stops showing '--INSERT--'.
"
" This breaks the function keys and the Meta/Alt modifier in insert mode in
" most or maybe all of the terminals I use, but I don't want those keys in
" insert mode, anyway.  All of this works fine in the GUI, of course.
"
set noesckeys

" Automatic text wrapping options using flags in the 'formatoptions' option
" begin here.  I rely on the filetype plugins to set the 't' and 'c' flags for
" this option to configure whether text or comments should be wrapped, as
" appropriate for the document type or language, and so I don't mess with
" either of those flags here.

" If a line is already longer than 'textwidth' would otherwise limit when
" editing of that line begins in insert mode, don't suddenly automatically
" wrap it; I'll break it apart myself with a command like 'gq'.  This doesn't
" seem to stop paragraph reformatting with 'a', if that's set.
"
set formatoptions+=l

" Don't wrap a line in such a way that a single-letter word like "I" or "a" is
" at the end of it.  Typographically, as far as I can tell, this seems to be
" a stylistic preference rather than a rule, rather like avoiding "widow" and
" "orphan" lines in typesetting.  I think it generally looks better to have
" the short word start the line, so we'll switch it on.
"
set formatoptions+=1

" If the filetype plugins have correctly described what the comment syntax for
" the buffer's language looks like, it makes sense to use that to figure out
" how to join lines within comments without redundant comment syntax cropping
" up.  For example, with this set, joining lines in this very comment with 'J'
" would remove the leading '"' characters.
"
" This 'formatoptions' flag wasn't added until v7.3.541.  Because we can't
" test for the availability of option flags directly, we resort to a version
" number check before attempting to set it.  I don't like using :silent! to
" suppress errors for this sort of thing when I can reasonably avoid it, even
" if the tests are somewhat more verbose.
"
" <https://github.com/vim/vim/releases/tag/v7.3.541>
"
if v:version > 703 || v:version == 703 && has('patch541')
  set formatoptions+=j
endif

" A momentary digression here into the doldrums of 'cpoptions'--after
" staunchly opposing it for years, I have converted to two-spacing.  You can
" blame Steve Losh:
"
" <http://stevelosh.com/blog/2012/10/why-i-two-space/>
"
" Consequently, we specify that sentence objects for the purposes of the 's'
" text object, the '(' and ')' sentence motions, and formatting with the 'gq'
" command must be separated by *two* spaces.  One space does not suffice.
"
" My defection to the two-spacers is also the reason I now leave 'joinspaces'
" set, per its default, so that two spaces are inserted when consecutive
" sentences separated by a line break are joined onto one line by the 'J'
" command.
"
set cpoptions+=J

" Separating sentences with two spaces has an advantage in making a clear
" distinction between two different types of periods: periods that abbreviate
" longer words, as in "Mr. Moolenaar", and periods that terminate sentences,
" like this one.
"
" If we're using two-period spacing for sentences, Vim can interpret the
" different spacing to distinguish between the two types, and can thereby
" avoid breaking a line just after an abbreviating period.  For example, the
" two words in "Mr. Moolenaar" should never be split apart, preventing
" confusion on the reader's part lest the word "Mr." look too much like the
" end of a sentence, and also preserving the semantics of that same period for
" subsequent reformatting; its single-space won't get lost.
"
" So, getting back to our 'formatoptions' settings, that is what the 'p' flag
" does.  I wrote the patch that added it, after becoming envious of an
" analogous feature during an ill-fated foray into GNU Emacs usage.
"
" <https://github.com/vim/vim/releases/tag/v8.1.1523>
"
if has('patch-8.1.728')
  set formatoptions+=p
endif

" In an effort to avoid loading unnecessary files, we add a flag to the
" 'guioptions' option to prevent the menu.vim runtime file from being loaded.
" It doesn't do any harm, but I never use it, and it's easy to turn it off.
"
" The documentation for this flag in `:help 'go-M'` includes a note saying the
" flag should be set here, rather that in the GUI-specific gvimrc file, as one
" might otherwise think.
"
if has('gui_running')
  set guioptions+=M
endif

" By default, Vim doesn't allow a file buffer to have unwritten changes if
" it's not displayed in a window.  Setting this option removes that
" restriction so that buffers can remain in a modified state while not
" actually displayed anywhere.
"
" This option is set in almost every vimrc I read; it's so pervasive that
" I sometimes see comments expressing astonishment or annoyance that it isn't
" set by default.  However, I didn't actually need this option for several
" years of Vim usage, because I instinctively close windows onto buffers only
" after the buffers within them have been written anyway.
"
" However, the option really is required for batch operations performed with
" commands like :argdo or :bufdo, because Vim won't otherwise tolerate
" unwritten changes to a litany of buffers that are not displayed in any
" window.  After I started using such command maps a bit more often,
" I realized I finally had a reason to turn this on permanently.
"
set hidden

" Highlight matches for completed searches in the buffer text, but clear that
" highlighting away when this vimrc file is reloaded.  Later on in this file,
" CTRL-L in normal mode is remapped to issue :nohlsearch in addition to its
" usual screen refresh function.
"
set hlsearch
nohlsearch

" Highlight search matches in my text while I'm still typing my pattern,
" including scrolling the screen to show the first such match if necessary.
" This can be somewhat jarring, particularly when the cursor ends up scrolling
" a long way from home in a large file, but I think the benefits of being able
" to see instances of what I'm trying to match as I type the pattern do
" outweigh that discomfort.
"
set incsearch

" Don't waste cycles and bandwidth redrawing the screen during execution of
" macro recordings and scripts.
"
set lazyredraw

" Define meta-characters to show in place of characters that are otherwise
" invisible, or line wrapping attributes when the 'list' option is enabled.
"
" These 'list' characters all correspond to invisible or indistinguishable
" characters.  We leave the default eol:$ in place to show newlines, and add
" a few more.
"
set listchars+=tab:>-   " Tab characters, preserve width with hyphens
set listchars+=trail:-  " Trailing spaces
set listchars+=nbsp:+   " Non-breaking spaces

" The next pair of 'list' characters are arguably somewhat misplaced, in that
" they don't really represent invisible characters in the same way as the
" others, but are hints for the presence of other characters on unwrapped
" lines that are wider than the screen.  They're very useful, though.
"
" If the current encoding supports it, use these non-ASCII characters for the
" markers, as they're visually distinctive:
"
" extends: Signals presence of unwrapped text to screen right
"     »  U+00BB  RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK
" precedes: Signals presence of unwrapped text to screen left
"     «  U+00BB  LEFT-POINTING DOUBLE ANGLE QUOTATION MARK
"
" Failing that, '<' and '>' will do the trick.
"
if has('multi_byte_encoding')
  set listchars+=extends:»,precedes:«
else
  set listchars+=extends:>,precedes:<
endif

" Don't let your editor's options be configured by content in arbitrary files!
" Down with modelines!  Purge them from your files!  Écrasez l'infâme!
"
" I think that modelines are Vim's worst misfeature, and that 'nomodeline'
" should be the default.  It's enabled pretty bad security vulnerabilities
" over the years, and it's a lot more effective to use filetype detection,
" other automatic command hooks, or methods like .editorconfig to set
" variables specifically for a buffer or project.
"
set nomodeline

" The only octal numbers I can think of that I ever even encounter are Unix
" permissions masks, and I'd never use CTRL-A or CTRL-X to increment them.
" Numbers with leading zeroes are far more likely to be decimals.
"
set nrformats-=octal

" I like to leave the last line of the screen blank unless something is
" actually happening in the editor for it to report, so I have grown to like
" the Vim default of 'noruler'.  CTRL-G shows me everything I need to know,
" and is near-instinctive now.
"
" Rude system vimrc files tend to switch this back on, though, so we force it
" off here.
"
set noruler

" Sessions preserve window, tab, and buffer layout, and are thereby great for
" more complex and longer-term projects like books, but they don't play
" together well with plugins and filetype plugins.  Restoring the same
" settings from both reloaded plugins and from the session causes screeds of
" errors.  Adjusting session behavior to stop it trying to restore the sorts
" of settings that plugins manage makes them usable again.
"
set sessionoptions-=localoptions  " No buffer options or mappings
set sessionoptions-=options       " No global options or mappings

" The 'I' flag for the 'shortmess' option prevents the display of the Vim
" startup screen with version information, :help hints, and donation
" suggestion.  After I registered Vim and donated to Uganda per the screen's
" plea, I didn't feel bad about turning this off anymore.  Even with this
" setting in place, I wouldn't normally see it too often anyway, as I seldom
" start Vim with no file arguments.
"
" I haven't felt the need to mess with the other flags in this option.
" I don't have any problems with spurious Enter prompts, which seems to be the
" main reason people pile it full of letters.
"
set shortmess+=I

" We'll only use the old 'showmatch' method of a brief jump to the matching
" bracket under the cursor if the much-preferred matchparen.vim standard
" plugin doesn't look like it's going to load, whether because plugins have
" been disabled, or it's not in any of the plugin directories.
"
if !&loadplugins || globpath(&runtimepath, 'plugin/matchparen.vim') ==# ''
  set showmatch matchtime=3
endif

" I find the defaults of new windows opening above or to the left of the
" previous window too jarring, because I'm used to both the i3 window manager
" and the tmux terminal multiplexer doing it the other way around, in reading
" order.  I prefer the visual effect of the previous text staying where it is,
" and the new window occupying previously blank space.
"
set splitbelow splitright

" Limit the number of characters per line that syntax highlighting will
" attempt to match.  This is as much an effort to encourage me to break long
" lines and do hard wrapping correctly as it is for efficiency.
"
set synmaxcol=500

" Vim has an internal list of terminal types that support using smoother
" terminal redrawing, and for which 'ttyfast' is normally set, described in
" `:help 'ttyfast'`.  That list includes most of the terminals I use, but
" there are a couple more for which the 'ttyfast' option should apply: the
" windows terminal emulator PuTTY, and the terminal multiplexer tmux, both of
" which I use heavily.
"
if &term =~# '^putty\|^tmux'
  set ttyfast
endif

" We really don't want a mouse; while I use it a lot for cut and paste in X,
" it just gets in the way if the tool running in the terminal tries to use it
" too.  Mouse events should be exclusively handled by the terminal emulator
" application, so Vim shouldn't try to give me terminal mouse support, even if
" it would work.
"
" The manual suggests that disabling this should be done by clearing 't_RV',
" but that didn't actually seem to work when I tried it.
"
set ttymouse=

" While using virtual block mode, allow me to navigate to any column of the
" buffer window; don't confine the boundaries of the block to the coordinates
" of characters that actually exist in the buffer text.  While working with
" formatted columnar data with this off is generally OK, it's a hassle for
" more subtle applications of visual block mode.
"
set virtualedit+=block

" I can't recall a time that Vim's error beeping or flashing was actually
" useful to me, and so we turn it off in the manner that the manual instructs
" in `:help 'visualbell'`.  This enables visual rather than audio error bells,
" but in the same breath, blanks the terminal attribute that would be used to
" trigger such screen blinking, indirectly disabling the bell altogether.
"
" I thought at first that the newer 'belloff' and/or 'errorbells' options
" would be a more intuitive way to keep Vim quiet, but the last time I checked
" that, neither appeared to work as comprehensively as this older method does.
"
" Interestingly, the :help says that this setting has to be repeated in the
" gvimrc file for GUI Vim.
"
set visualbell t_vb=

" When Ex command line completion is started with Tab, list valid completions
" and complete the command line to the longest common substring, just as Bash
" does, with just the one key press.
"
" The default value of 'full' for the 'wildmode' option puts the full
" completion onto the line immediately, which I tolerate for insert mode
" completion but don't really like on the Ex command line.  Instead, I arrange
" for that to happen only with a second key press.
"
set wildmenu
set wildmode=list:longest,full

" Define a list of patterns to ignore for file and directory command line
" completion.  Files and directories with names matching any of these patterns
" won't be presented as candidates for tab completion on the command line.
"
" To make this list, I went right through my home directory with
" a `find`-toothed comb; counted the occurrences of every extension, forced
" down to lowercase; and then manually selected the ones that I was confident
" would seldom contain plain text.
"
" The following incantation does the trick with POSIX-compatible shell tools,
" giving patterns for the top 100 alphanumeric extensions for files from the
" running user's home directory:
"
"     $ (LC_ALL=C find "$HOME" ! -type d -name '*.?*' -exec \
"           sh -c 'for fn ; do
"              ext=${fn##*.}
"              case $ext in
"                  (*[![:alnum:]]*) continue ;;
"                  (?*) printf "%s\n" "$ext" ;;
"              esac
"           done' _ {} + |
"           tr '[[:upper:]]' '[[:lower:]]' | sort | uniq -c |
"           sort -k1,1nr | awk 'NR <= 100 {print "*." $2}')
"
" I turned out to have rather a lot of .html and .vim files.
"
" If you're scoffing at that and thinking "I could write a much simpler one",
" please do so, and send it to me at <tom@sanctum.geek.nz> to have yours put
" in here instead, with appropriate credit.  Don't forget to handle more than
" ARG_MAX files, include filenames with newlines, and that the -z or -0 null
" separator extensions are not standardized in POSIX.
"
" <https://mywiki.wooledge.org/UsingFind#Complex_actions>
"
set wildignore=*~,#*#
      \,*.7z
      \,.DS_Store
      \,.git
      \,.hg
      \,.svn
      \,*.a
      \,*.adf
      \,*.asc
      \,*.au
      \,*.aup
      \,*.avi
      \,*.bin
      \,*.bmp
      \,*.bz2
      \,*.class
      \,*.db
      \,*.dbm
      \,*.djvu
      \,*.docx
      \,*.exe
      \,*.filepart
      \,*.flac
      \,*.gd2
      \,*.gif
      \,*.gifv
      \,*.gmo
      \,*.gpg
      \,*.gz
      \,*.hdf
      \,*.ico
      \,*.iso
      \,*.jar
      \,*.jpeg
      \,*.jpg
      \,*.m4a
      \,*.mid
      \,*.mp3
      \,*.mp4
      \,*.o
      \,*.odp
      \,*.ods
      \,*.odt
      \,*.ogg
      \,*.ogv
      \,*.opus
      \,*.pbm
      \,*.pdf
      \,*.png
      \,*.ppt
      \,*.psd
      \,*.pyc
      \,*.rar
      \,*.rm
      \,*.s3m
      \,*.sdbm
      \,*.sqlite
      \,*.swf
      \,*.swp
      \,*.tar
      \,*.tga
      \,*.ttf
      \,*.wav
      \,*.webm
      \,*.xbm
      \,*.xcf
      \,*.xls
      \,*.xlsx
      \,*.xpm
      \,*.xz
      \,*.zip

" Allow me to be lazy and type a path to complete on the Ex command line in
" all-lowercase, and transform the consequent completion to match the
" appropriate case, like the Readline setting completion-ignore-case can be
" used for GNU Bash.
"
" As far as I can tell, despite its name, the 'wildignore' case option doesn't
" have anything to do with the 'wildignore' option, and so files that would
" match any of those patterns only with case insensitivity implied will still
" be candidates for completion.
"
" The option wasn't added until v7.3.72, so we need to check it exists before
" we try to set it.
"
" <https://github.com/vim/vim/releases/tag/v7.3.072>
"
if exists('+wildignorecase')
  set wildignorecase
endif

" Enable syntax highlighting, but only if it's not already on, to save
" reloading the syntax files unnecessarily.
"
" <https://sanctum.geek.nz/blinkenlights/syntax-on.jpg>
"
" For several months in 2018, as an experiment, I tried using terminals with
" no color at all, imitating a phenomenally productive BSD purist co-worker
" who abhorred color in any form on his terminals.  He only drank black
" coffee, too.  If you're reading this: Hello, bdh!
"
" That experiment was instructive and interesting, and I found I had been
" leaning on color information in some surprising ways.  However, some months
" later, I found I still missed my colors, and so I went back to my
" Kodachrome roots, and didn't pine at all for that monochrome world.
"
" The thing I most like about syntax highlighting is detecting runaway
" strings, which generally works in even the most threadbare language syntax
" highlighting definitions.  I kept missing such errors when I didn't have the
" colors.  I don't have high standards for it otherwise, except maybe for
" shell script.
"
if !exists('syntax_on')
  syntax enable
endif

" Before we attempt to pick a syntax highlighting color scheme, we'll set up
" a couple of hooks for color scheme loading.  In this case, we turn
" 'cursorline' on if my 'sahara' color scheme is loaded, since I've configured
" it to be a very dark gray that doesn't stand out too much against a black
" background.  For any other color scheme, turn the option off, because it
" almost always stands out too much for my liking.
"
" You'd think the autocommand pattern here could be used to match the colour
" scheme name, and it can be ... after patch v7.4.108, when Christian Brabandt
" fixed it.  Until that version, it matched against the current buffer name,
" so we're forced to have an explicit test in the command instead.
"
" <https://github.com/vim/vim/releases/tag/v7.4.108>
"
autocmd vimrc ColorScheme *
      \ let &cursorline = g:colors_name ==# 'sahara'

" Use 'dark' as my default value for 'background', in the absence of an
" environment variable COLORFGBG or a response in v:termrbgresp that would set
" it specifically.
"
if !exists('$COLORFGBG') && get(v:, 'termrbgresp', '') ==# ''
  set background=dark
endif

" If the background seems to be dark, and I have either the GUI or a 256 color
" terminal, and my custom sahara.vim color scheme looks to be available, load
" it.
"
if &background ==# 'dark'
      \ && (has('gui_running') || &t_Co >= 256)
      \ && globpath(&runtimepath, 'colors/sahara.vim') !=# ''
  colorscheme sahara
endif

" My mapping definitions begin here.  I have some general personal rules for
" approaches to mappings:
"
" * Use the configured Leader key as a prefix for mappings as much as
"   possible.
"
" * Use only the configured LocalLeader key as a prefix for mappings that are
"   defined as local to a buffer, which for me are almost always based on
"   &filetype and set up by ftplugin files.
"
" * If a normal mode map would make sense in visual mode, take the time to
"   configure that too.  Use :xmap and its analogues rather than :vmap to
"   avoid defining unusable select-mode mappings, even though I never actually
"   use selection mode directly.
"
" * Avoid mapping in insert mode; let characters be literal to the greatest
"   extent possible, and avoid "doing more" in insert mode besides merely
"   inserting text as it's typed.
"
" * Avoid key chords with Ctrl in favor of leader keys.
"
" * Never use Alt/Meta key chords; the terminal support for them is just too
"   confusing and flaky.
"
" * Don't suppress display of mapped commands for no reason; it's OK to show
"   the user the command that's being run under the hood.  Do avoid HIT-ENTER
"   prompts, though.
"
" * Avoid shadowing any of Vim's existing functionality.  If possible, extend
"   or supplement what Vim does, rather than replacing it.
"
" We'll start with the non-leader mappings.  Ideally, there shouldn't be too
" many of these.
"

" Use backspace as an even quicker way to switch to the current buffer's
" alternate buffer.  User nickspoons of #vim was incredulous that I had never
" used CTRL-^ and indeed did not know about it.  I have since repented.
"
nnoremap <Backspace> <C-^>

" I find the space bar's default behavior in normal mode of moving right one
" character to be useless.  Instead, I remap it to be a lazy way of paging
" through the argument list buffers, scrolling a page until the last line of
" the buffer is visible, and then moving to the :next buffer.
"
" I always wanted you to go into space, man.
"
nnoremap <expr> <Space>
      \ line('w$') < line('$')
      \ ? "\<PageDown>"
      \ : ":\<C-U>next\<CR>"

" I hate CTRL-C's default insert mode behavior.  It ends the insert session
" without firing the InsertLeave event for automatic command hooks.  Why would
" anyone want that?  It breaks plugins that hinge on mirrored functionality
" between the InsertEnter and InsertLeave events, and doesn't otherwise differ
" from Escape or :stopinsert.  Even worse, people think it's a *synonym* for
" Escape, and use it because it's easier to reach than the Escape key or
" CTRL-[.  Terrible!
"
" Instead, I apply a custom plugin named insert_cancel.vim to make it cancel
" the current insert operation; that is, if the buffer has changed at all
" since the start of the insert operation, pressing CTRL-C will reverse it,
" while ending insert mode and firing InsertLeave as normal.  This makes way
" more sense to me, and I use it all the time now.
"
" <https://sanctum.geek.nz/cgit/vim-insert-cancel.git/about/>
"
" You might think on a first look, as I did, that a plugin is overkill, and
" that a mapping like this would be all that's required:
"
"   :inoremap <C-C> <Esc>u
"
" Indeed, it *mostly* works, but there are some subtle problems with it.  The
" primary issue is that if you didn't make any changes during the insert mode
" session that you're terminating, it *still* reverses the previous change,
" which will be something else entirely that you probably *didn't* mean to be
" undone.  The plugin's way of working around this and the other shortcomings
" of the simple mapping above is not too much more complicated, but it was not
" easy to figure out.
"
" At any rate, we only want to establish the mapping if we can expect the
" plugin to load, so test that 'loadplugins' is set and that the plugin file
" exists with the expected filename.
"
" If the plugin isn't available, I just abandon CTRL-C to continue its
" uselessness.
"
if &loadplugins && globpath(&runtimepath, 'plugin/insert_cancel.vim') !=# ''
  imap <C-C> <Plug>(InsertCancel)
endif

" I often can't remember (or guess) digraph codes, and want to look up how to
" compose a specific character that I can name, at least in part.  The table
" in `:help digraph-table` is what to use for that situation, and it solves
" the problem, but I didn't like the overhead of repeated lookups therein.
"
" Steve Losh has a solution I liked where a double-tap of CTRL-K in insert
" mode brought up the applicable :help window:
"
" <https://bitbucket.org/sjl/dotfiles/src/2559256/vim/vimrc#lines-309:310>
"
" I took that one step further with a custom plugin named digraph_search.vim.
" It parses the digraph table from :help and runs a simple text search of its
" names using a string provided by the user.  For example, searching for ACUTE
" yields:
"
" > Digraphs matching ACUTE:
" > ´  ''  ACUTE ACCENT
" > Á  A'  LATIN CAPITAL LETTER A WITH ACUTE
" > É  E'  LATIN CAPITAL LETTER E WITH ACUTE
" > Í  I'  LATIN CAPITAL LETTER I WITH ACUTE
" > ...etc...
"
" <https://sanctum.geek.nz/cgit/vim-digraph-search.git/about/>
"
" This leaves you in insert mode, ready to hit CTRL-K one more time and then
" type the digraph that you've hopefully found.
"
" Since a double-tap of CTRL-K does nothing in default Vim, we don't bother
" checking that the plugin's available before we map to it; it'll just quietly
" do nothing.
"
imap <C-K><C-K> <Plug>(DigraphSearch)

" I end up hitting CTRL-L to clear or redraw the screen in interactive shells
" and tools like Mutt and Vim pretty often.  It feels natural to me to stack
" issuing a :nohlsearch command to stop highlighting searches on top of this.
"
" This gets by far the most use in normal mode, but I'd like it to work in
" insert and visual modes, too, where it's occasionally useful, especially on
" things like mobile phone terminal emulators that can be choppy and require
" a lot of redrawing.
"
" For each of these, we end the mapping with a CTRL-L in normal mode, thereby
" extending rather than replacing Vim's normal behavior.
"
nnoremap <C-L>
      \ :<C-U>nohlsearch<CR><C-L>

" The insert mode wrapper for normal CTRL-L uses i_CTRL-O to issue a single
" normal mode command.  We intentionally use `:normal` rather than `:normal!`
" so that the mapping works recursively.  I tried using <C-O><C-L> with :imap
" for this, but it didn't work.  Maybe i_CTRL-O doesn't respect mappings.
" I couldn't find any documentation about it.
"
inoremap <C-L> <C-O>:execute "normal \<C-L>"<CR>

" We use :vnoremap here rather than :xnoremap and thereby make the mapping
" apply to select mode as well, because CTRL-L doesn't reflect a printable
" character, and so we may as well make it work, even though I don't actually
" use select mode directly.
"
vmap <C-L> <Esc><C-L>gv

" By default, the very-useful normal mode command '&' that repeats the
" previous :substitute command doesn't preserve the flags from that
" substitution.  I'd prefer it to do so, like the :&& command does, and it's
" easily remapped for both normal and visual mode, so let's just do it.
"
nnoremap &
      \ :&&<CR>
xnoremap &
      \ :&&<CR>

" I really like using the '!' command in normal mode as an operator to filter
" text through a shell command.  It always bugged me a little that there
" didn't seem to be an analogue for a motion to filter text through an
" internal command like :sort, so I wrote one.
"
" <https://sanctum.geek.nz/cgit/vim-colon-operator.git/about/>
"
nmap g: <Plug>(ColonOperator)

" I used Tim Pope's unimpaired.vim plugin for ages, and I liked some of these
" bracket pair mappings, so I've carried a few of the simpler ones over.  All
" of these can be prefixed with a count if needed, too.  I use all of them
" pretty regularly, even though cycling through lists to look for something
" can be a bit wasteful.

" Argument list
nnoremap [a
      \ :previous<CR>
nnoremap ]a
      \ :next<CR>
" Buffers
nnoremap [b
      \ :bprevious<CR>
nnoremap ]b
      \ :bnext<CR>
" Quickfix list
nnoremap [c
      \ :cprevious<CR>
nnoremap ]c
      \ :cnext<CR>
" Location list
nnoremap [l
      \ :lprevious<CR>
nnoremap ]l
      \ :lnext<CR>

" Here's another mapping I particularly liked from unimpaired.vim; insert
" blank lines from normal mode, using a custom plugin of mine called
" put_blank_lines.vim.  These use operator functions so that they're
" repeatable without repeat.vim.  They accept count prefixes, too.
"
" <https://sanctum.geek.nz/cgit/vim-put-blank-lines.git/about/>
"
nmap [<Space> <Plug>(PutBlankLinesAbove)
nmap ]<Space> <Plug>(PutBlankLinesBelow)

" We're on to the leader maps, now.  It's difficult to know in what order to
" describe and specify these.  I used to have them in alphabetical order, but
" it seems much more useful to group them by the type of action they take.
"
" First of all, let's set the leader keys; backslash happens to be the
" default, but I like to make my choice explicit here.  As of 2019, I'm still
" not certain that comma is the best choice for my local leader.  I use it all
" the time for this purpose, and it works well, but I don't much like that it
" shadows a useful function in the fFtT;, group, and I sometimes wonder if
" I would use the key for its original function more, had I not shadowed it.
"
let mapleader = '\'
let maplocalleader = ','

" If the local leader is a comma, map double-tap comma to its original
" function in the relevant modes so that I can still use it quickly without
" relying on mapping 'timeout'.
"
if maplocalleader ==# ','
  noremap ,, ,
  sunmap ,,
endif

" Let's start with some simple ones; these ones all just toggle a boolean
" option, and print its new value.  They're dirt simple to specify, and don't
" require any plugins.
"
" These are sometimes applicable in visual mode, and sometimes not.  We'll
" start with the ones that only make sense as normal mode maps.  Annoyingly,
" a visual mode mapping for 'cursorline' toggling doesn't work at all;
" 'cursorline' is always off when in any visual mode, including block mode,
" where it actually might have been really handy.

"" Leader,TAB toggles automatic indentation based on the previous line
nnoremap <Leader><Tab>
      \ :<C-U>set autoindent! autoindent?<CR>
"" Leader,c toggles highlighted cursor row; doesn't work in visual mode
nnoremap <Leader>c
      \ :<C-U>set cursorline! cursorline?<CR>
"" Leader,h toggles highlighting search results
nnoremap <Leader>h
      \ :<C-U>set hlsearch! hlsearch?<CR>
"" Leader,i toggles showing matches as I enter my pattern
nnoremap <Leader>i
      \ :<C-U>set incsearch! incsearch?<CR>
"" Leader,s toggles spell checking
nnoremap <Leader>s
      \ :<C-U>set spell! spell?<CR>

" The next group of option-toggling maps are much the same as the previous
" group, except they also include analogous maps for visual mode, defined as
" recursive maps into normal mode that conclude with re-selecting the text.

"" Leader,C toggles highlighted cursor column; works in visual mode
nnoremap <Leader>C
      \ :<C-U>set cursorcolumn! cursorcolumn?<CR>
xmap <Leader>C <Esc><Leader>Cgv
"" Leader,l toggles showing tab, end-of-line, and trailing white space
nnoremap <Leader>l
      \ :<C-U>set list! list?<CR>
xmap <Leader>l <Esc><Leader>lgv
"" Leader,n toggles line number display
nnoremap <Leader>n
      \ :<C-U>set number! number?<CR>
xmap <Leader>n <Esc><Leader>ngv
"" Leader,N toggles position display in bottom right
nnoremap <Leader>N
      \ :<C-U>set ruler! ruler?<CR>
xmap <Leader>N <Esc><Leader>Ngv
"" Leader,w toggles soft wrapping
nnoremap <Leader>w
      \ :<C-U>set wrap! wrap?<CR>
xmap <Leader>w <Esc><Leader>wgv

" This next one just shows option state of the 'formatoptions' affecting how
" text is automatically formatted; it doesn't change its value.

"" Leader,f shows the current 'formatoptions' at a glance
nnoremap <Leader>f
      \ :<C-U>set formatoptions?<CR>

" I often have to switch between US English and NZ English.  The latter is
" almost exactly the same as UK English in most locales, although we use
" dollars rather than pounds.  This is mostly so I remember things like
" excluding or including the 'u' in words like 'favourite', depending on the
" target audience.  I generally use US English for international audiences.

"" Leader,u sets US English spelling language
nnoremap <Leader>u
      \ :<C-U>set spelllang=en_us<CR>
"" Leader,z sets NZ English spelling language
nnoremap <Leader>z
      \ :<C-U>set spelllang=en_nz<CR>

" The next mapping is also for toggling an option, but it's more complicated;
" it uses a simple plugin of mine called copy_linebreak.vim to manage several
" options at once, related to the 'wrap' option that soft-wraps text.
"
" It's designed for usage in terminal emulators and multiplexers to
" temporarily make the buffer text suitable for copying in such a way that the
" wrapping and any associated soft formatting won't pervert the text,
" including 'breakindent', 'linebreak', and 'showbreak' artifacts.
"
" This is really handy for quick selections of small regions of text.  For
" larger blocks of text or for manipulating the text as it leaves the buffer,
" it makes more sense to use :! commands.
"
" <https://sanctum.geek.nz/cgit/vim-copy-linebreak.git/about/>
"

"" Leader,b toggles settings friendly to copying and pasting
nmap <Leader>b <Plug>(CopyLinebreakToggle)

" The above mappings show that mappings for toggling boolean options are
" simple, but there isn't a way to toggle single flags within option strings
" with just the :set command, so I wrote a plugin called toggle_flags.vim to
" provide :ToggleFlag and :ToggleFlagLocal commands.  The first argument is
" the name of an option, and the second is the flag within it that should be
" toggled on or off.

"" Leader,a toggles 'formatoptions' 'a' auto-flowing flag
nnoremap <Leader>a
      \ :<C-U>ToggleFlagLocal formatoptions a<CR>
"" Leader,L toggles 'colorcolumn' showing the first column beyond 'textwidth'
nnoremap <Leader>L
      \ :<C-U>ToggleFlagLocal colorcolumn +1<CR>
xmap <Leader>L <Esc><Leader>Lgv

" This mapping uses my paste_insert.vim plugin to queue up automatic commands
" for the next insert operation.  It's still pretty new.  It replaces my old
" paste_open.vim plugin which did this only for opening new lines, and which
" kept confusing me.  I'm hoping this will be better.

"" Leader,p prepares the next insert for paste mode
nmap <Leader>p <Plug>PasteInsert

" These mappings are for managing filetypes.  The first one uses the
" :ReloadFileType command that was defined much earlier in this file for
" application in the vimrc reload command.

"" Leader,F reloads filetype settings
nnoremap <Leader>F
      \ :<C-U>ReloadFileType<CR>
"" Leader,t shows current filetype
nnoremap <Leader>t
      \ :<C-U>set filetype?<CR>
"" Leader,T clears filetype
nnoremap <Leader>T
      \ :<C-U>set filetype=<CR>

" These mappings use my put_date.vim plugin for date insertion into the
" buffer.

"" Leader,d inserts the local date (RFC 2822)
nnoremap <Leader>d
      \ :PutDate<CR>
"" Leader,D inserts the UTC date (RFC 2822)
nnoremap <Leader>D
      \ :PutDate!<CR>

" This group contains mappings that are to do with file and path management
" relative to the current buffer.  The Leader,P mapping that creates
" directory hierarchies uses the :Establish command created earlier.

"" Leader,g shows the current file's fully expanded path
nnoremap <Leader>g
      \ :<C-U>echo expand('%:p')<CR>
"" Leader,G changes directory to the current file's location
nnoremap <Leader>G
      \ :<C-U>cd %:h<Bar>pwd<CR>
"" Leader,P creates the path to the current file if it doesn't exist
nnoremap <Leader>P
      \ :<C-U>Establish %:h<CR>

" This group contains mappings that show information about Vim's internals:
" marks, registers, variables, and the like.

"" Leader,H shows command history
nnoremap <Leader>H
      \ :<C-U>history :<CR>
"" Leader,k shows my marks
nnoremap <Leader>k
      \ :<C-U>marks<CR>
"" Leader,K shows functions
nnoremap <Leader>K
      \ :<C-U>function<CR>
"" Leader,m shows normal maps
nnoremap <Leader>m
      \ :<C-U>nmap<CR>
"" Leader,M shows buffer-local normal maps
nnoremap <Leader>M
      \ :<C-U>nmap <buffer><CR>
"" Leader,S shows loaded scripts
nnoremap <Leader>S
      \ :<C-U>scriptnames<CR>
"" Leader,U shows user commands
nnoremap <Leader>U
      \ :<C-U>command<CR>
"" Leader,v shows all global and internal variables
nnoremap <Leader>v
      \ :<C-U>let g: v:<CR>
"" Leader,V shows all buffer, tab, and window local variables
nnoremap <Leader>V
      \ :<C-U>let b: t: w:<CR>
"" Leader,y shows all registers
nnoremap <Leader>y
      \ :<C-U>registers<CR>

" This group contains mappings concerned with buffer navigation and
" management.  I use the "jetpack" buffer jumper one a lot.  I got it from one
" of bairui's "Vim and Vigor" comics:
"
" <http://of-vim-and-vigor.blogspot.com/p/vim-vigor-comic.html>

"" Leader,DEL deletes the current buffer
nnoremap <Leader><Delete>
      \ :bdelete<CR>
"" Leader,INS edits a new buffer
nnoremap <Leader><Insert>
      \ :<C-U>enew<CR>
"" Leader,e forces a buffer to be editable, even a :help one
nnoremap <Leader>e
      \ :<C-U>set modifiable noreadonly<CR>
"" Leader,E locks a buffer, reversible with <Leader>e
nnoremap <Leader>E
      \ :<C-U>set nomodifiable readonly<CR>
"" Leader,j jumps to buffers ("jetpack")
nnoremap <Leader>j
      \ :<C-U>buffers<CR>:buffer<Space>

" Leader,o hacks up the list of old files from viminfo just long enough to
" ensure that :browse :oldfiles fits in a screen, avoiding an Enter or 'q'
" keystroke before entering the number.  This one is handy followed by
" <Leader>,\ to jump back to the last remembered position in that file, since
" by definition viminfo remembers that mark, too.
"
nmap <Leader>o <Plug>SelectOldFiles

" This group defines mappings for filtering and batch operations to clean up
" buffer text.  All of these mappings use commands from my custom plugins:
"
" :KeepPosition
"   <https://sanctum.geek.nz/cgit/vim-keep-position.git/about/>
" :SqueezeRepeatBlanks
"   <https://sanctum.geek.nz/cgit/vim-squeeze-repeat-blanks.git/about/>
" :StripTrailingWhitespace
"   <https://sanctum.geek.nz/cgit/vim-strip-trailing-whitespace.git/about/>
"

"" Leader,x strips trailing whitespace
nnoremap <Leader>x
      \ :StripTrailingWhitespace<CR>
xnoremap <Leader>x
      \ :StripTrailingWhitespace<CR>
"" Leader,X squeezes repeated blank lines
nnoremap <Leader>X
      \ :SqueezeRepeatBlanks<CR>
xnoremap <Leader>X
      \ :SqueezeRepeatBlanks<CR>
"" Leader,= runs the whole buffer through =, preserving position
nnoremap <Leader>=
      \ :<C-U>KeepPosition execute 'normal! 1G=G'<CR>
"" Leader,+ runs the whole buffer through gq, preserving position
nnoremap <Leader>+
      \ :<C-U>KeepPosition execute 'normal! 1GgqG'<CR>

" This group defines a few :onoremap commands to make my own text objects.
" I should probably make some more of these, as they've proven to be
" terrifically handy.

"" Leader,_ uses last changed or yanked text as an object
onoremap <Leader>_
      \ :<C-U>execute 'normal! `[v`]'<CR>
"" Leader,% uses entire buffer as an object
onoremap <Leader>%
      \ :<C-U>execute 'normal! 1GVG'<CR>

" This group defines some useful motions, including navigating by indent
" block using a custom plugin:
"
" <https://sanctum.geek.nz/cgit/vim-vertical-region.git/about/>
"

"" Leader,{ and Leader,} move to top and bottom of indent region
map <Leader>{ <Plug>(VerticalRegionUp)
sunmap <Leader>{
map <Leader>} <Plug>(VerticalRegionDown)
sunmap <Leader>}
"" Leader,\ jumps to the last edit position mark: think "Now, where was I?"
noremap <Leader>\ `"
sunmap <Leader>\

" This group does both: useful motions on defined text objects.

"" Leader,< and Leader,> adjust indent of last edit; good for pasting
nnoremap <Leader><lt>
      \ :<C-U>'[,']<lt><CR>
nnoremap <Leader>>
      \ :<C-U>'[,']><CR>

" This group is for directory tree or help search convenience mappings.

"" Leader,/ types :vimgrep for me ready to enter a search pattern
nnoremap <Leader>/
      \ :<C-U>vimgrep /\c/j **<S-Left><S-Left><Right>
"" Leader,? types :lhelpgrep for me ready to enter a search pattern
nnoremap <Leader>?
      \ :<C-U>lhelpgrep \c<S-Left>

" This group contains miscellaneous mappings for which I couldn't find any
" other place.  The plugin mappings probably require their own documentation
" comment block, but my hands are getting tired from all this typing.
"
" * <https://sanctum.geek.nz/cgit/vim-replace-operator.git/about/>
" * <https://sanctum.geek.nz/cgit/vim-regex-escape.git/about/>
"

"" Leader,. runs the configured make program into the location list
nnoremap <Leader>.
      \ :<C-U>lmake!<CR>
"" Leader,! repeats the last command, adding a bang
nnoremap <Leader>!
      \ :<Up><Home><S-Right>!<CR>
"" Leader,q formats the current paragraph
nnoremap <Leader>q gqap
"" Leader,r acts as a replacement operator
nmap <Leader>r <Plug>(ReplaceOperator)
xmap <Leader>r <Plug>(ReplaceOperator)
"" Leader,* escapes regex metacharacters
nmap <Leader>* <Plug>(RegexEscape)
xmap <Leader>* <Plug>(RegexEscape)

" And last, but definitely not least, I'm required by Vim fanatic law to
" include a mapping that reloads my whole configuration.  This uses the
" command wrapper defined much earlier in the file, so that filetypes also get
" reloaded afterwards, meaning I don't need to follow <Leader>R with
" a <Leader>F to fix up broken global settings.
"
nnoremap <Leader>R
      \ :<C-U>ReloadVimrc<CR>

" I'll close this file with a few abbreviations.  Perhaps of everything in
" here, I'm least confident that these should be in here, but they've proven
" pretty useful.  First, some 'deliberate' abbreviations for stuff I type
" a lot:
"
inoreabbrev tr@ tom@sanctum.geek.nz
inoreabbrev tr/ <https://sanctum.geek.nz/>

" And then, just automatically fix some things I almsot always spell or type
" wrnog.
"
inoreabbrev almsot almost
inoreabbrev wrnog wrong
inoreabbrev Fielding Feilding
inoreabbrev THe The
inoreabbrev THere There

" Here endeth the literate vimrc.  Let us praise God.
"
" > Consequently, it is soon recognized that they write for the sake of
" > filling up the paper, and this is the case sometimes with the best
" > authors...as soon as this is perceived the book should be thrown away,
" > for time is precious.
" >
" > -- Schopenhauer
