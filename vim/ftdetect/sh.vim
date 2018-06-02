" Shell script files; these are hard to detect accurately

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
      \ |   if getline(1) =~ '^#!.*bash$'
      \ |     let b:is_bash = 1
      \ |     setfiletype sh
      \ |   elseif getline(1) =~ '^#!.*ksh$'
      \ |     let b:is_ksh = 1
      \ |     setfiletype sh
      \ |   elseif getline(1) =~ '^#!.*sh$'
      \ |     let b:is_posix = 1
      \ |     setfiletype sh
      \ |   endif
      \ | endif
