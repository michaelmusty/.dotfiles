" Spellcheck documents we're actually editing (not just viewing)
if &modifiable && !&readonly
  setlocal spell
  let b:undo_ftplugin .= '|setlocal spell<'
endif

" Tolerate leading lowercase letters in README.md files, for things like
" headings being filenames
if expand('%:t') ==# 'README.md'
  setlocal spellcapcheck=
  let b:undo_ftplugin .= '|setlocal spellcapcheck<'
endif

" Stop here if the user doesn't want ftplugin mappings
if exists('no_plugin_maps') || exists('no_markdown_maps')
  finish
endif

" Quote operator
nnoremap <buffer> <expr> <LocalLeader>q
      \ quote#Quote()
xnoremap <buffer> <expr> <LocalLeader>q
      \ quote#Quote()
let b:undo_ftplugin .= '|nunmap <buffer> <LocalLeader>q'
      \ . '|xunmap <buffer> <LocalLeader>q'

" Quote operator with reformatting
nnoremap <buffer> <expr> <LocalLeader>Q
      \ quote#QuoteReformat()
xnoremap <buffer> <expr> <LocalLeader>Q
      \ quote#QuoteReformat()
let b:undo_ftplugin .= '|nunmap <buffer> <LocalLeader>Q'
      \ . '|xunmap <buffer> <LocalLeader>Q'

" Autoformat headings
command! -buffer -nargs=1 MarkdownHeading
      \ call markdown#Heading(<f-args>)
nnoremap <buffer> <LocalLeader>=
      \ :<C-U>MarkdownHeading =<CR>
nnoremap <buffer> <LocalLeader>-
      \ :<C-U>MarkdownHeading -<CR>
let b:undo_ftplugin .= '|delcommand MarkdownHeading'
      \ . '|nunmap <buffer> <LocalLeader>='
      \ . '|nunmap <buffer> <LocalLeader>-'
