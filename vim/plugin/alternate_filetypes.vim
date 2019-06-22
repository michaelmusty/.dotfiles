function! s:AlternateFileType() abort
  let filetypes = get(b:, 'alternate_filetypes', [&filetype])
  if &filetype !=# filetypes[0]
    let &filetype = filetypes[0]
  endif
  set filetype?
endfunction
command -bar AlternateFileType
      \ call s:AlternateFileType()
nnoremap <Plug>(AlternateFileType)
      \ :<C-U>AlternateFileType<CR>
nmap <Leader># <Plug>(AlternateFileType)
nmap <Leader>3 <Leader>#
