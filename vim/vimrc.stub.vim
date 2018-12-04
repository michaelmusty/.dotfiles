" If we have Vim version >=7, and (implicitly) +eval, source real vimrc
if v:version >= 700
  runtime vimrc

" If not, prevent Vim from using any part of our configuration
else
  if has('win32') || has('win64')
    set runtimepath-=~/vimfiles
    set runtimepath-=~/vimfiles/after
  else
    set runtimepath-=~/.vim
    set runtimepath-=~/.vim/after
  endif
endif
