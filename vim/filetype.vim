" Override filetypes.vim
if exists('g:did_load_filetypes')
  finish
endif
let g:did_load_filetypes = 1

" Use only the rules in ftdetect
augroup filetypedetect
  autocmd!

  " AWK files
  autocmd BufNewFile,BufRead
        \ *.awk
        \ setfiletype awk
  autocmd BufNewFile,BufRead
        \ *
        \   if getline(1) =~# '\m^#!.*\<[gm]\?awk\>'
        \ |   setfiletype awk
        \ | endif
  " C files
  autocmd BufNewFile,BufRead
        \ *.c,*.h
        \ setfiletype c
  " C++ files
  autocmd BufNewFile,BufRead
        \ *.c++,*.cpp,*.cxx,*.hh
        \ setfiletype cpp
  " CSS files
  autocmd BufNewFile,BufRead
        \ *.css
        \ setfiletype css
  " CSV files
  autocmd BufNewFile,BufRead
        \ *.csv
        \ setfiletype csv
  " Diff and patch files
  autocmd BufNewFile,BufRead
        \ *.diff,*.patch,*.rej
        \ setfiletype diff
  " Git commit messages
  autocmd BufNewFile,BufRead
        \ COMMIT_EDITMSG,MERGE_MSG,TAG_EDITMSG
        \ setfiletype gitcommit
  " Git config files
  autocmd BufNewFile,BufRead
        \ *.git*/config,.gitconfig,.gitmodules
        \ setfiletype gitconfig
  " GnuPG configuration files
  autocmd BufNewFile,BufRead
        \ *gnupg/options,*gnupg/gpg.conf
        \ setfiletype gpg
  " HTML files
  autocmd BufNewFile,BufRead
        \ *.html,*.htm
        \ setfiletype html
  " Java files
  autocmd BufNewFile,BufRead
        \ *.java,*.jav
        \ setfiletype java
  " JSON files
  autocmd BufNewFile,BufRead
        \ *.js
        \ setfiletype javascript
  " JSON files
  autocmd BufNewFile,BufRead
        \ *.json
        \ setfiletype json
  " Lex files
  autocmd BufNewFile,BufRead
        \ *.l,*.lex
        \ setfiletype lex
  " Lua files
  autocmd BufNewFile,BufRead
        \ *.lua
        \ setfiletype lua
  " m4 files
  autocmd BufNewFile,BufRead
        \ *.m4
        \ setfiletype m4
  " Mail messages
  autocmd BufNewFile,BufRead
        \ *.msg,mutt-*-*-*
        \ setfiletype mail
  " Makefiles
  autocmd BufNewFile,BufRead
        \ Makefile,makefile
        \ setfiletype make
  " Markdown files
  autocmd BufNewFile,BufRead
        \ *.markdown,*.md
        \ setfiletype markdown
  " Add automatic commands to detect .muttrc files
  autocmd BufNewFile,BufRead
        \ Muttrc,.muttrc,*muttrc.d/*.rc
        \ setfiletype muttrc
  " Perl 5 files
  autocmd BufNewFile,BufRead
        \ *.pl,*.pm,*.t,Makefile.PL
        \ setfiletype perl
  autocmd BufNewFile,BufRead
        \ *
        \   if getline(1) =~# '\m^#!.*\<perl\>'
        \ |   setfiletype perl
        \ | endif
  " Perl 6 files
  autocmd BufNewFile,BufRead
        \ *.p6,*.pl6,*.pm6
        \ setfiletype perl6
  autocmd BufNewFile,BufRead
        \ *
        \   if getline(1) =~# '\m^#!.\<perl6\>'
        \ |   setfiletype perl6
        \ | endif
  " PHP files
  autocmd BufNewFile,BufRead
        \ *.php
        \ setfiletype php
  autocmd BufNewFile,BufRead
        \ *
        \   if getline(1) =~# '\m^#!.\<php\>'
        \ |   setfiletype php
        \ | endif
        \ | if getline(1) =~? '\m^<?php\>'
        \ |   setfiletype php
        \ | endif
  " Perl 5 POD files
  autocmd BufNewFile,BufRead
        \ *.pod
        \ setfiletype pod
  " Perl 6 POD files
  autocmd BufNewFile,BufRead
        \ *.pod6
        \ setfiletype pod6
  " Python files
  autocmd BufNewFile,BufRead
        \ *.py
        \ setfiletype python
  autocmd BufNewFile,BufRead
        \ *
        \ if getline(1) =~# '\m^#!.*\<python[23]\?\>'
        \ |   setfiletype python
        \ | endif
  " Readline configuration file
  autocmd BufNewFile,BufRead
        \ .inputrc,inputrc
        \ setfiletype readline
  " Remind files
  autocmd BufNewFile,BufRead
        \ *.rem,*.remind,.reminders
        \ setfiletype remind
  " Bash filename patterns
  autocmd BufNewFile,BufRead
        \ *.bash,
        \.bash_aliases,
        \.bash_logout,
        \.bash_profile,
        \.bashrc,
        \bash-fc-*,
        \bash_profile,
        \bashrc
        \ let b:is_bash = 1
        \ | setfiletype sh
  " Korn shell filename patterns
  autocmd BufNewFile,BufRead
        \ *.ksh,
        \.kshrc,
        \kshrc
        \ let b:is_kornshell = 1
        \ | setfiletype sh
  " POSIX/Bourne shell filename patterns
  autocmd BufNewFile,BufRead
        \ *.sh,
        \.profile,
        \.shinit,
        \.shrc,
        \.xinitrc,
        \/etc/default/*,
        \configure,
        \profile,
        \shinit,
        \shrc,
        \xinitrc
        \ let b:is_posix = 1
        \ | setfiletype sh
  " If this file has a shebang, and we haven't already decided it's Bash or
  " Korn shell, use the shebang to decide
  autocmd BufNewFile,BufRead
        \ *
        \   if !exists('b:is_bash') && !exists('b:is_kornshell')
        \ |   if getline(1) =~# '\m^#!.*\<bash\>'
        \ |     let b:is_bash = 1
        \ |     setfiletype sh
        \ |   elseif getline(1) =~# '\m^#!.*\<ksh\>'
        \ |     let b:is_ksh = 1
        \ |     setfiletype sh
        \ |   elseif getline(1) =~# '\m^#!.*\<sh\>'
        \ |     let b:is_posix = 1
        \ |     setfiletype sh
        \ |   endif
        \ | endif
  " tmux configuration files
  autocmd BufNewFile,BufRead
        \ .tmux.conf,tmux.conf
        \ setfiletype tmux
  " roff files
  autocmd BufNewFile,BufRead
        \ *.[1-9],*.[1-9]df
        \ setfiletype nroff
  " Tab-separated (TSV) files
  autocmd BufNewFile,BufRead
        \ *.tsv
        \ setfiletype tsv
  " VimL files
  autocmd BufNewFile,BufRead
        \ *.vim,vimrc,*[._]vimrc,exrc,*[._]exrc
        \ setfiletype vim
  " .viminfo files
  autocmd BufNewFile,BufRead
        \ .viminfo
        \ setfiletype viminfo
  " Add automatic commands to find Xresources subfiles
  autocmd BufNewFile,BufRead
        \ .Xresources,*/.Xresources.d/*
        \ setfiletype xdefaults
  " XHTML files
  autocmd BufNewFile,BufRead
        \ *.xhtml,*.xht
        \ setfiletype xhtml
  " XML files
  autocmd BufNewFile,BufRead
        \ *.xml
        \ setfiletype xml
  " Yacc files
  autocmd BufNewFile,BufRead
        \ *.y,*.yy
        \ setfiletype yacc
  " YAML files
  autocmd BufNewFile,BufRead
        \ *.yaml
        \ setfiletype yaml
  " Z shell files
  autocmd BufNewFile,BufRead
        \ *.zsh,.zprofile,zprofile,.zshrc,zshrc
        \ setfiletype zsh
  autocmd BufNewFile,BufRead
        \ *
        \   if getline(1) =~# '^#!.*\<zsh\>'
        \ |   setfiletype zsh
        \ | endif

  runtime! ftdetect/*.vim
augroup END

