" sh/han.vim: Use han(1df) as 'keywordprg' for Bash scripts

" Don't load if running compatible or too old
if &compatible || v:version < 700
  finish
endif

" Don't load if already loaded
if exists('b:did_ftplugin_sh_han')
  finish
endif

" Don't load if this isn't Bash or if han(1df) isn't available
if !exists('b:is_bash') || !executable('han')
  finish
endif

" Flag as loaded
let b:did_ftplugin_sh_han = 1
let b:undo_ftplugin = b:undo_ftplugin
      \ . '|unlet b:did_ftplugin_sh_han'

" Set 'keywordprg' to han(1df)
setlocal keywordprg=han
let b:undo_ftplugin = b:undo_ftplugin
      \ . '|setlocal keywordprg<'
