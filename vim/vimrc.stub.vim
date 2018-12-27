" If we have non-tiny Vim version >=7, source real vimrc; this works because
" tiny and/or ancient builds of Vim quietly ignore all code in :if blocks
if v:version >= 700
  runtime vimrc
  finish
endif

" Otherwise, prevent Vim from using any part of our configuration
set runtimepath-=~/.vim
set runtimepath-=~/.vim/after
if has('win32') || has('win64')
  set runtimepath-=~/vimfiles
  set runtimepath-=~/vimfiles/after
endif
