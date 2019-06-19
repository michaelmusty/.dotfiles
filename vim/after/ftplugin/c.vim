" Set 'commentstring', 'define', and 'include' back to their default C-friendly values
setlocal commentstring&vim
setlocal define&vim include&vim
setlocal include&vim

" Include macros in completion
setlocal complete+=d

" Include system headers on UNIX
if has('unix')
  setlocal path+=/usr/include
endif

" Undo all of the above
let b:undo_ftplugin .= '|setlocal commentstring< complete< include< path<'
