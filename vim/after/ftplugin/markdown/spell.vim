" markdown/spell.vim: Turn on spell checking for Markdown files

" Don't load if running compatible or too old
if &compatible || v:version < 700
  finish
endif

" Don't load if already loaded
if exists('b:did_ftplugin_markdown_spell')
  finish
endif

" Flag as loaded
let b:did_ftplugin_markdown_spell = 1
let b:undo_ftplugin = b:undo_ftplugin
      \ . '|unlet b:did_ftplugin_markdown_spell'

" Spellcheck documents by default
setlocal spell
let b:undo_ftplugin = b:undo_ftplugin
      \ . '|setlocal spell<'
