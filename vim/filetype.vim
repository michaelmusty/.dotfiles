" Override system filetype.vim if sufficiently new and not 'compatible'
if exists('did_load_filetypes') || v:version < 700 || &compatible
  finish
endif
let did_load_filetypes = 1

" Use our own filetype detection rules
augroup filetypedetect
  autocmd!

  " Unwrap hashes, tildes, generic extensions, and Debian packaging working
  " extensions (if we can do so safely), and repeat the filetype detection to
  " see if there's a match beneath them
  autocmd BufNewFile,BufRead
        \ #?*#
        \,?*~
        \,?*.{bak,example,in,new,old,orig,sample,test}
        \,?*.dpkg-{bak,dist,new,old}
        \ call filetype#repeat#Strip()

  " Stuff Tom cares about enough and edits often enough to type based on
  " filename patterns follows.

  " Apache config
  autocmd BufNewFile,BufRead
        \ .htaccess
        \,*/apache*/?*.conf
        \ setfiletype apache
  " Assembly language files
  autocmd BufNewFile,BufRead
        \ ?*.s
        \ setfiletype asm
  " AWK files
  autocmd BufNewFile,BufRead
        \ ?*.awk
        \ setfiletype awk
  " BIND zone file
  autocmd BufNewFile,BufRead
        \ */bind/db.?*
        \,*/namedb/db.?*
        \,named.root
        \ setfiletype bindzone
  " C files
  autocmd BufNewFile,BufRead
        \ ?*.c
        \,?*.h
        \,*/proto/?*.pro
        \ setfiletype c
  " C++ files
  autocmd BufNewFile,BufRead
        \ ?*.cpp
        \,?*.cxx
        \,?*.c++
        \,?*.hh
        \ setfiletype cpp
  " crontab(5) files
  autocmd BufNewFile,BufRead
        \ crontab
        \,crontab.*
        \,cron.d/*
        \ setfiletype crontab
  " CSS files
  autocmd BufNewFile,BufRead
        \ ?*.css
        \ setfiletype css
  " CSV files
  autocmd BufNewFile,BufRead
        \ ?*.csv
        \ setfiletype csv
  " Diff and patch files
  autocmd BufNewFile,BufRead
        \ ?*.diff
        \,?*.patch
        \,?*.rej
        \ setfiletype diff
  " INI format files
  autocmd BufNewFile,BufRead
        \ ?*.ini
        \,perlcriticrc
        \,.perlcriticrc
        \ setfiletype dosini
  " DOT graphs
  autocmd BufNewFile,BufRead
        \ ?*.dot
        \ setfiletype dot
  " Forth
  autocmd BufNewFile,BufRead
        \ ?*.fs,?*.ft
        \ setfiletype forth
  " fstab(5) files
  autocmd BufNewFile,BufRead
        \ fstab
        \ setfiletype fstab
  " GDB init files
  autocmd BufNewFile,BufRead
        \ .gdbinit
        \ setfiletype gdb
  " Git commit messages
  autocmd BufNewFile,BufRead
        \ COMMIT_EDITMSG
        \,MERGE_MSG
        \,TAG_EDITMSG
        \ setfiletype gitcommit
  " Git config files
  autocmd BufNewFile,BufRead
        \ *.git/config
        \,.gitconfig
        \,.gitmodules
        \,gitconfig
        \ setfiletype gitconfig
  " Git rebase manifests
  autocmd BufNewFile,BufRead
        \ git-rebase-todo
        \ setfiletype gitrebase
  " GnuPG configuration files
  autocmd BufNewFile,BufRead
        \ *gnupg/options
        \,*gnupg/gpg.conf
        \ setfiletype gpg
  " UNIX group file
  autocmd BufNewFile,BufRead
        \ /etc/group
        \,/etc/group-
        \,/etc/group.edit
        \,/etc/gshadow
        \,/etc/gshadow-
        \,/etc/gshadow.edit
        \ setfiletype group
  " GTK settings files
  autocmd BufNewFile,BufRead
        \ .gktrc*,
        \,gktrc*
        \ setfiletype gtkrc
  " Vim help files
  autocmd BufNewFile,BufRead
        \ ~/.vim/doc/?*.txt
        \,*/vim-*/doc/?*.txt
        \,*/vim/*/doc/?*.txt
        \,*/*.vim/doc/?*.txt
        \,$VIMRUNTIME/doc/?*.txt
        \ setfiletype help
  " HTML files
  autocmd BufNewFile,BufRead
        \ ?*.html
        \,?*.htm
        \ setfiletype html
  " hosts(5) file
  autocmd BufNewFile,BufRead
        \ /etc/hosts
        \ setfiletype hostconf
  " inittab(5) files
  autocmd BufNewFile,BufRead
        \ inittab
        \ setfiletype inittab
  " Java files
  autocmd BufNewFile,BufRead
        \ ?*.java
        \,?*.jav
        \ setfiletype java
  " JSON files
  autocmd BufNewFile,BufRead
        \ ?*.js
        \ setfiletype javascript
  " JSON files
  autocmd BufNewFile,BufRead
        \ ?*.json
        \ setfiletype json
  " Lex files
  autocmd BufNewFile,BufRead
        \ ?*.l
        \,?*.lex
        \ setfiletype lex
  " Lisp
  autocmd BufNewFile,BufRead
        \ ?*.lisp
        \,?*.el
        \,.emacs
        \,emacs
        \ setfiletype lisp
  " Lua files
  autocmd BufNewFile,BufRead
        \ ?*.lua
        \ setfiletype lua
  " m4 files
  autocmd BufNewFile,BufRead
        \ ?*.m4
        \ setfiletype m4
  " Mail messages
  autocmd BufNewFile,BufRead
        \ ?*.msg
        \,mutt-*-[0-9]\+-[0-9]\+-[0-9]\+
        \ setfiletype mail
  " Mail messages
  autocmd BufNewFile,BufRead
        \ aliases
        \ setfiletype mailaliases
  " Makefiles
  autocmd BufNewFile,BufRead
        \ Makefile
        \,makefile
        \,GNUmakefile
        \ setfiletype make
  " Markdown files
  autocmd BufNewFile,BufRead
        \ ?*.markdown
        \,?*.md
        \ setfiletype markdown
  " Mutt configuration files
  autocmd BufNewFile,BufRead
        \ Muttrc
        \,*/.muttrc.d/*.rc
        \,.muttrc
        \,muttrc
        \,/etc/Muttrc.d/*
        \ setfiletype muttrc
  " BIND configuration file
  autocmd BufNewFile,BufRead
        \ named.conf
        \,rndc.conf
        \,rndc.key
        \ setfiletype named
  " Nano configuration file
  autocmd BufNewFile,BufRead
        \ *.nanorc
        \,*/etc/nanorc
        \ setfiletype nanorc
  " netrc file
  autocmd BufNewFile,BufRead
        \ .netrc
        \,netrc
        \ setfiletype netrc
  " roff files
  autocmd BufNewFile,BufRead
        \ ?*.roff
        \,?*.[1-9]
        \,*/man[1-9]*/?*.[1-9]*
        \ setfiletype nroff
  " UNIX password and shadow files
  autocmd BufNewFile,BufRead
        \ /etc/passwd
        \,/etc/passwd-
        \,/etc/passwd.edit
        \,/etc/shadow
        \,/etc/shadow-
        \,/etc/shadow.edit
        \ setfiletype passwd
  " Perl 5 files
  autocmd BufNewFile,BufRead
        \ ?*.pl
        \,?*.pm
        \,*/t/?*.t
        \,*/xt/?*.t
        \,Makefile.PL
        \ setfiletype perl
  " Perl 6 files
  autocmd BufNewFile,BufRead
        \ ?*.p6
        \,?*.pl6
        \,?*.pm6
        \ setfiletype perl6
  " PHP files
  autocmd BufNewFile,BufRead
        \ ?*.php
        \ setfiletype php
  " Perl 5 POD files
  autocmd BufNewFile,BufRead
        \ ?*.pod
        \ setfiletype pod
  " Perl 6 POD files
  autocmd BufNewFile,BufRead
        \ ?*.pod6
        \ setfiletype pod6
  " Python files
  autocmd BufNewFile,BufRead
        \ ?*.py
        \,?*.sage
        \ setfiletype python
  " Readline configuration file
  autocmd BufNewFile,BufRead
        \ .inputrc
        \,inputrc
        \ setfiletype readline
  " Remind files
  autocmd BufNewFile,BufRead
        \ .reminders
        \,?*.rem
        \,?*.remind
        \ setfiletype remind
  " resolv.conf files
  autocmd BufNewFile,BufRead
        \ resolv.conf
        \ setfiletype resolv
  " robots.txt files
  autocmd BufNewFile,BufRead
        \ robots.txt
        \ setfiletype robots
  " Ruby
  autocmd BufNewFile,BufRead
        \ ?*.rb
        \ setfiletype ruby
  " sed files
  autocmd BufNewFile,BufRead
        \ ?*.sed
        \ setfiletype sed
  " Services files
  autocmd BufNewFile,BufRead
        \ /etc/services
        \ setfiletype services
  " Bash shell
  autocmd BufNewFile,BufRead
        \ ?*.bash
        \,.bash_aliases
        \,.bash_completion
        \,.bash_logout
        \,.bash_profile
        \,.bashrc
        \,bash-fc.?*
        \,bash_aliases
        \,bash_completion
        \,bash_logout
        \,bash_profile
        \,bashrc
        \ let b:is_bash = 1
        \|setfiletype sh
  " Korn shell
  autocmd BufNewFile,BufRead
        \ ?*.ksh
        \,.kshrc
        \,kshrc
        \ let b:is_kornshell = 1
        \|setfiletype sh
  " POSIX/Bourne shell
  autocmd BufNewFile,BufRead
        \ ?*.sh
        \,$ENV
        \,.profile
        \,.shinit
        \,.shrc
        \,.xinitrc
        \,/etc/default/*
        \,configure
        \,profile
        \,shinit
        \,shrc
        \,xinitrc
        \ let b:is_posix = 1
        \|setfiletype sh
  " SQL
  autocmd BufNewFile,BufRead
        \ ?*.sql
        \ setfiletype sql
  " OpenSSH configuration
  autocmd BufNewFile,BufRead
        \ ssh_config,*/.ssh/config
        \ setfiletype sshconfig
  " sudoers(5)
  autocmd BufNewFile,BufRead
        \ sudoers
        \,sudoers.tmp
        \ setfiletype sshdconfig
  " OpenSSH server configuration
  autocmd BufNewFile,BufRead
        \ sshd_config
        \ setfiletype sudoers
  " Subversion commit
  autocmd BufNewFile,BufRead
        \ svn-commit*.tmp
        \ setfiletype svn
  " Systemd unit files
  autocmd BufNewFile,BufRead
        \ */systemd/*.*
        \ setfiletype systemd
  " TCL
  autocmd BufNewFile,BufRead
        \ ?*.tcl
        \ setfiletype tcl
  " Terminfo
  autocmd BufNewFile,BufRead
        \ ?*.ti
        \ setfiletype terminfo
  " TextEditorAnywhere text field
  autocmd BufNewFile,BufRead
        \ TextEditorAnywhere_??_??_??.txt
        \ setfiletype textarea
  " Tidy config
  autocmd BufNewFile,BufRead
        \ .tidyrc
        \,tidyrc
        \ setfiletype tidy
  " tmux configuration files
  autocmd BufNewFile,BufRead
        \ .tmux.conf
        \,tmux.conf
        \ setfiletype tmux
  " Tab-separated (TSV) files
  autocmd BufNewFile,BufRead
        \ ?*.tsv
        \ setfiletype tsv
  " VimL files
  autocmd BufNewFile,BufRead
        \ ?*.vim
        \,.exrc
        \,vimrc
        \,vimrc.*
        \,[._]vimrc
        \,gvimrc
        \,gvimrc.*
        \,[._]gvimrc
        \ setfiletype vim
  " .viminfo files
  autocmd BufNewFile,BufRead
        \ .viminfo
        \,viminfo
        \ setfiletype viminfo
  " .wgetrc files
  autocmd BufNewFile,BufRead
        \ .wgetrc
        \,wgetrc
        \ setfiletype wget
  " Add automatic commands to find Xresources subfiles
  autocmd BufNewFile,BufRead
        \ .Xresources
        \,*/.Xresources.d/*
        \,Xresources
        \,*/Xresources.d/*
        \ setfiletype xdefaults
  " XHTML files
  autocmd BufNewFile,BufRead
        \ ?*.xhtml
        \,?*.xht
        \ setfiletype xhtml
  " XML files
  autocmd BufNewFile,BufRead
        \ ?*.xml
        \ setfiletype xml
  " Perl XS
  autocmd BufNewFile,BufRead
        \ ?*.xs
        \ setfiletype xs
  " Yacc files
  autocmd BufNewFile,BufRead
        \ ?*.y
        \,?*.yy
        \ setfiletype yacc
  " YAML files
  autocmd BufNewFile,BufRead
        \ ?*.yml
        \,?*.yaml
        \ setfiletype yaml
  " Z shell files
  autocmd BufNewFile,BufRead
        \ ?*.zsh
        \,.zprofile
        \,.zshrc
        \,zprofile
        \,zshrc
        \ setfiletype zsh

  " If it's a new file in a bin, libexec, or scripts subdir that has a
  " Makefile.PL sibling, and I'm editing it, it's almost definitely Perl.
  autocmd BufNewFile
        \ ?*/bin/?*
        \,?*/libexec/?*
        \,?*/scripts/?*
        \ if filereadable(expand('<afile>:p:h:h') . '/Makefile.PL')
        \|  setfiletype perl
        \|endif

  " Load any extra rules in ftdetect directories
  runtime! ftdetect/*.vim

  " Clumsy attempt at typing files in `sudo -e` if a filename hasn't already
  " been found
  autocmd BufNewFile,BufRead
        \ /var/tmp/?*????????.*
        \,/var/tmp/?*.????????
        \ if !did_filetype()
        \|  call filetype#repeat#Sudo()
        \|endif

  " Generic text, config, and log files, if no type assigned yet
  autocmd BufNewFile,BufRead
        \ ?*.text
        \,?*.txt
        \,INSTALL
        \,README
        \,/etc/issue
        \,/etc/motd
        \ setfiletype text
  autocmd BufNewFile,BufRead
        \ ?*.cfg
        \,?*.conf
        \,?*.config
        \,/etc/*
        \ setfiletype conf
  autocmd BufNewFile,BufRead
        \ */log/*
        \,?*.log
        \ setfiletype messages

  " If we still don't have a filetype, run the scripts.vim file that performs
  " cleverer checks including looking at actual file contents--but only my
  " custom one; don't load the system one at all.
  autocmd BufNewFile,BufRead,StdinReadPost
        \ *
        \ if !did_filetype()
        \|  runtime scripts.vim
        \|endif

  " MUSTY filetype

  " Magma filetype
  " hack in vimrc instead :)
  " autocmd BufNewFile,BufRead
  "       \ *.mag  set filetype=magma omnifunc=CompleteMagma
  "       \,*.mag let do_syntax_sel_menu = 1|runtime! synmenu.vim|aunmenu &Syntax
  "       \,*.mag cal SetSyn("matlab")
  "       \,*.mag cal SetSyn("magma")
  "       \ *.m  set filetype=magma omnifunc=CompleteMagma
  "       \,*.m let do_syntax_sel_menu = 1|runtime! synmenu.vim|aunmenu &Syntax
  "       \,*.m cal SetSyn("matlab")
  "       \,*.m cal SetSyn("magma")
  " Magma commenting
  autocmd FileType magma setlocal commentstring=//\ %s

  " tex/latex filetype
  autocmd BufNewFile,BufRead
        \ *.tex set filetype=tex

augroup END
