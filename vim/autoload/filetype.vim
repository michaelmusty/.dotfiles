" Helper function to run the 'filetypedetect' group on a file with its
" extension stripped off
function! filetype#StripRepeat() abort

  " Check we have the fnameescape() function
  if !exists('*fnameescape')
    return
  endif

  " Expand the match result
  let fn = expand('<afile>')

  " Strip leading and trailing #hashes#
  if fn =~# '^#\+.*#\+$'
    let fn = substitute(fn, '^#\+\(.\+\)#\+$', '\1', '')

  " Strip trailing tilde~
  elseif fn =~# '\~$'
    let fn = substitute(fn, '\~$', '', '')

  " Strip generic .extension
  else
    let fn = expand('<afile>:r')
  endif

  " Re-run the group if there's anything left
  if strlen(fn)
    execute 'doautocmd filetypedetect BufRead ' . fnameescape(fn)
  endif

endfunction

" Helper function to run the 'filetypedetect' group on a file in a temporary
" sudoedit(8) directory, modifying it with an attempt to reverse the temporary
" filename change
function! filetype#SudoRepeat() abort

  " Check we have the fnameescape() function
  if !exists('*fnameescape')
    return
  endif

  " Expand the match result
  let fn = expand('<afile>')

  " myfileXXQGS16A.conf: strip eight chars before final period
  if fn =~# '/[^/]\+\w\{8}\.[^./]\+$'
    let fr = expand('<afile>:r')
    let fe = expand('<afile>:e')
    let fn = strpart(fr, -8, strlen(fr)) . '.' . fe

  " myfile.XXQGS16A: strip extension
  elseif fn =~# '/[^/]\+\.\w\{8}$'
    let fn = expand('<afile>:r')

  " Unrecognised pattern; return, don't repeat
  else
    return
  endif

  " Re-run the group if there's anything left
  if strlen(fn)
    execute 'doautocmd filetypedetect BufRead ' . fnameescape(fn)
  endif

endfunction
