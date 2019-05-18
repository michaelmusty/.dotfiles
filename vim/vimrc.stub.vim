" If we have non-tiny Vim version >=7, source real vimrc; this works because
" tiny and/or ancient builds of Vim quietly ignore all code in :if blocks
if v:version >= 700 && !&compatible
  runtime vimrc
  finish
endif

" Otherwise, prevent an old and/or tiny Vim from using any part of our
" configuration, because parts of it will break
set runtimepath-=~/.vim
set runtimepath-=~/.vim/after
