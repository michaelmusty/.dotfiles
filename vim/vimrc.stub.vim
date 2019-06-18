" We have a big, important decision to make here.
"
" Check that we're not running in 'compatible' mode, nor that the environment
" calls for the same, and that we're running Vim v7.0.0 or newer.  If it's all
" clear, we can load the main vimrc file from ~/.vim/vimrc to use Vim in all
" of its incompatible glory, and then stop sourcing the rest of this file.
"
if !&compatible && !exists('$POSIXLY_CORRECT') && v:version >= 700
  runtime vimrc
  finish
endif

" If we got this far, it means we're running a tiny, 'compatible', and/or
" ancient version of Vim.
"
" So, strip out our user runtime directories from 'runtimepath', force
" 'compatible' on, source your trusty ~/.exrc, put on your dubbed cassette
" copy of Kraftwerk's 'Computerwelt', and start using Sun OS 4.x vi v3.7, from
" July 1985.
"
" Don't grizzle, just use it.  It's good for you, like raisin bran.
"
set runtimepath-=~/.vim
set runtimepath-=~/.vim/after
set compatible
silent! source ~/.exrc
