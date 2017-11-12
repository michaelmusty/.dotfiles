"
" auto_undodir.vim: Configure 'undodir' automatically, including trying hard
" to create it.
"
" Author: Tom Ryder <tom@sanctum.geek.nz>
" License: Same as Vim itself
"
if exists('g:loaded_auto_undodir') || &compatible
  finish
endif
if !has('persistent_undo')
  finish
endif
let g:loaded_auto_undodir = 1

" Define the undo path we want
if exists('$VIM_UNDODIR')
  let s:undodir = $VIM_UNDODIR
else

  " This is imperfect in that it will break if you have a backslashed comma in
  " the first component of your &runtimepath, but if you're doing that, you
  " probably already have way bigger problems
  let s:undodir 
      \ = strpart(&runtimepath, 0, stridx(&runtimepath, ','))
      \ . '/undo'
endif

" If the prospective undo directory does not exist, try hard to create it
if !isdirectory(expand(s:undodir))

  " Try Vim's native mkdir() first
  if exists('*mkdir')
    silent! call mkdir(expand(s:undodir), 'p', 0700)

  " Failing that, use an OS-dependent command
  " (Fortunately, Unix and Windows are the only OS types in the world)
  elseif has('unix')
    silent! execute '!mkdir -m 0700 -p ' 
          \ . shellescape(expand(s:undodir))
  elseif has('win32') || has('win64')
    silent! execute '!mkdir ' 
          \ . shellescape(expand(s:undodir))
  endif

endif

" If the directory exists after that...
if isdirectory(expand(s:undodir))

  " Set the undo directory and turn persistent undo files on
  execute 'set undodir^=' . s:undodir . '//'
  set undofile

" If not, give up and raise an error
else
  echoerr 'Could not create undodir ' . s:undodir
endif
