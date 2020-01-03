" Only do this when not yet done for this buffer
if exists('b:did_ftplugin')
  finish
endif
let b:did_ftplugin = 1

" Specify format for comments (lists, quotes)
setlocal comments+=fb:*  " Bulleted lists
setlocal comments+=fb:-  " Dashed lists
setlocal comments+=fb:+  " Plussed lists (?)
setlocal comments+=n:>   " Mail-style quotes
let &l:commentstring = '> %s'
let b:undo_ftplugin = 'setlocal comments< commentstring<'

" Specify format options (Tim Pope)
setlocal formatoptions+=ln
let &l:formatlistpat = '^\s*\d\+\.\s\+\|^[-*+]\s\+\|^\[^\ze[^\]]\+\]:'
let b:undo_ftplugin .= '|setlocal formatoptions< formatlistpat<'

" Let's try this heading-based fold method out (Tim Pope)
setlocal foldexpr=markdown#Fold()
setlocal foldmethod=expr
let b:undo_ftplugin .= '|setlocal foldexpr< foldmethod<'

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
command -buffer -nargs=1 MarkdownHeading
      \ call markdown#Heading(<f-args>)
nnoremap <buffer> <LocalLeader>=
      \ :<C-U>MarkdownHeading =<CR>
nnoremap <buffer> <LocalLeader>-
      \ :<C-U>MarkdownHeading -<CR>
let b:undo_ftplugin .= '|delcommand MarkdownHeading'
      \ . '|nunmap <buffer> <LocalLeader>='
      \ . '|nunmap <buffer> <LocalLeader>-'
