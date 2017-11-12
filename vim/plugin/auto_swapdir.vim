"
" auto_swapdir.vim: Configure 'directory' automatically, including trying hard
" to create it.
"
" Author: Tom Ryder <tom@sanctum.geek.nz>
" License: Same as Vim itself
"
if exists('g:loaded_auto_swapdir') || &compatible
  finish
endif
let g:loaded_auto_swapdir = 1

" Define the swap path we want
if exists('$VIM_SWAPDIR')
  let s:swapdir = $VIM_SWAPDIR
else

  " This is imperfect in that it will break if you have a backslashed comma in
  " the first component of your &runtimepath, but if you're doing that, you
  " probably already have way bigger problems
  let s:swapdir 
      \ = strpart(&runtimepath, 0, stridx(&runtimepath, ','))
      \ . '/swap'
endif

" If the prospective swapfile directory does not exist, try hard to create it
if !isdirectory(expand(s:swapdir))

  " Try Vim's native mkdir() first
  if exists('*mkdir')
    silent! call mkdir(expand(s:swapdir), 'p', 0700)

  " Failing that, use an OS-dependent command
  " (Fortunately, Unix and Windows are the only OS types in the world)
  elseif has('unix')
    silent! execute '!mkdir -m 0700 -p ' 
          \ . shellescape(expand(s:swapdir))
  elseif has('win32') || has('win64')
    silent! execute '!mkdir ' 
          \ . shellescape(expand(s:swapdir))
  endif

endif

" If the directory exists after that...
if isdirectory(expand(s:swapdir))

  " Set the swapfile directory and turn swapfiles on
  execute 'set directory^=' . s:swapdir . '//'
  set swapfile

" If not, give up and raise an error
else
  echoerr 'Could not create swapdir ' . s:swapdir
endif
