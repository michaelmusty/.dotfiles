" Remove surround.vim's insert mode maps
if !exists('g:loaded_surround')
  finish
endif
iunmap <Plug>ISurround
iunmap <Plug>Isurround
iunmap <C-G>S
iunmap <C-G>s
iunmap <C-S>
