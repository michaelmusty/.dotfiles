" Helper function to run the 'filetypedetect' group on a file with its
" extension stripped off
function! filetype#StripRepeat() abort

  " Check we have the fnameescape() function
  if !exists('*fnameescape')
    return
  endif

  " Expand the match result
  let l:fn = expand('<afile>')

  " Strip leading and trailing #hashes#
  if l:fn =~# '^#\+.*#\+$'
    let l:fn = substitute(l:fn, '^#\+\(.\+\)#\+$', '\1', '')

  " Strip trailing tilde~
  elseif l:fn =~# '\~$'
    let l:fn = substitute(l:fn, '\~$', '', '')

  " Strip generic .extension
  else
    let l:fn = expand('<afile>:r')
  endif

  " Re-run the group if there's anything left
  if strlen(l:fn)
    execute 'doautocmd filetypedetect BufRead ' . fnameescape(l:fn)
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
  let l:fn = expand('<afile>')

  " myfileXXQGS16A.conf: strip eight chars before final period
  if l:fn =~# '/[^./]\+\w\{8}\.[^./]\+$'
    let l:fr = expand('<afile>:r')
    let l:fe = expand('<afile>:e')
    let l:fn = strpart(l:fr, -8, strlen(l:fr)) . '.' . l:fe

  " myfile.XXQGS16A: strip extension
  elseif l:fn =~# '/[^./]\+\.\w\{8}$'
    let l:fn = expand('<afile>:r')

  " Unrecognised pattern; return, don't repeat
  else
    return
  endif

  " Re-run the group if there's anything left
  if strlen(l:fn)
    execute 'doautocmd filetypedetect BufRead ' . fnameescape(l:fn)
  endif

endfunction

" Check whether the first line was changed and looks like a shebang, and if
" so, re-run filetype detection
function! filetype#CheckShebang() abort
  if line('''[') == 1 && getline(1) =~# '^#!'
    doautocmd filetypedetect BufRead
  endif
endfunction
