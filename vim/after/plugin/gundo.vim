" Only run this is function available
if !exists(':GundoToggle')
    finish
endif

" Gundo key binding
nnoremap <silent> <leader>g :<C-U>:GundoToggle<CR>

