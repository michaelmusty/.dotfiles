function! alternate_filetypes#() abort
  if exists('b:alternate_filetypes')
    let filetypes = b:alternate_filetypes
    let index = index(filetypes, &filetype)
    if index >= 0
      let &filetype = filetypes[
            \ (index + 1) % len(filetypes)
            \]
    else
      unlet b:alternate_filetypes
    endif
  endif
  set filetype?
endfunction
