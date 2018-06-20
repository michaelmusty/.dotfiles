" gitcommit/quote.vim: Make angle-bracket quote characters behave like they do
" in mail messages, inserting the comment leader automatically on new lines
" and auto-formatting them.

" Don't load if running compatible or too old
if &compatible || v:version < 700
  finish
endif

" Don't load if already loaded
if exists('b:did_ftplugin_gitcommit_quote')
  finish
endif

" Flag as loaded
let b:did_ftplugin_gitcommit_quote = 1
let b:undo_ftplugin = b:undo_ftplugin
      \ . '|unlet b:did_ftplugin_gitcommit_quote'

" Use trailing whitespace to denote continued paragraph
setlocal comments+=n:>
setlocal formatoptions+=c
let b:undo_ftplugin = b:undo_ftplugin
      \ . '|setlocal comments<'
      \ . '|setlocal formatoptions<'
