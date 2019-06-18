" Check that we're not running in 'compatible' mode, nor that the environment
" calls for the same, and that we're running Vim v7.0.0 or newer.  If it's all
" clear, we can load the main vimrc file from ~/.vim/vimrc, and then stop
" sourcing the rest of this file.
"
if !&compatible && !exists('$POSIXLY_CORRECT') && v:version >= 700
  runtime vimrc
  finish
endif

" If we get this far, it means we're running a tiny, 'compatible', and/or
" ancient version of Vim.  Force 'compatible' on, remove our user runtime
" directory, and start vi v3.7 from July 1985.  Don't grizzle, just use it.
" It's good for you, like raisin bran.
"
set compatible
set runtimepath-=~/.vim
set runtimepath-=~/.vim/after
