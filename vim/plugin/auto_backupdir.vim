"
" auto_backupdir.vim: Configure 'backupdir' automatically, including trying
" hard to create it.
"
" Author: Tom Ryder <tom@sanctum.geek.nz>
" License: Same as Vim itself
"
if exists('g:loaded_auto_backupdir') || &compatible
  finish
endif
let g:loaded_auto_backupdir = 1

" Define the backup path we want
if exists('$VIM_BACKUPDIR')
  let s:backupdir = $VIM_BACKUPDIR
else

  " This is imperfect in that it will break if you have a backslashed comma in
  " the first component of your &runtimepath, but if you're doing that, you
  " probably already have way bigger problems
  let s:backupdir
      \ = strpart(&runtimepath, 0, stridx(&runtimepath, ','))
      \ . '/backup'
endif

" If the prospective backup directory does not exist, try hard to create it
if !isdirectory(expand(s:backupdir))

  " Try Vim's native mkdir() first
  if exists('*mkdir')
    silent! call mkdir(expand(s:backupdir), 'p', 0700)

  " Failing that, use an OS-dependent command
  " (Fortunately, Unix and Windows are the only OS types in the world)
  elseif has('unix')
    silent! execute '!mkdir -m 0700 -p '
          \ . shellescape(expand(s:backupdir))
  elseif has('win32') || has('win64')
    silent! execute '!mkdir '
          \ . shellescape(expand(s:backupdir))
  endif

endif

" If the directory exists after that...
if isdirectory(expand(s:backupdir))

  " Set the backup directory and turn backups on
  execute 'set backupdir^=' . s:backupdir . '//'
  set backup

" If not, give up and raise an error
else
  echoerr 'Could not create backupdir ' . s:backupdir
endif
