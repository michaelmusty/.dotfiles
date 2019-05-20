" Set comment formats
setlocal comments=:#
setlocal formatoptions+=or
let b:undo_ftplugin .= '|setlocal comments< formatoptions<'

" If subtype is Bash, set 'keywordprg' to han(1df)
if exists('b:is_bash')
  setlocal keywordprg=han
  let b:undo_ftplugin .= '|setlocal keywordprg<'
endif

" Choose check compiler based on file subtype
if exists('b:is_bash')
  let b:sh_check_compiler = 'bash'
elseif exists('b:is_kornshell')
  let b:sh_check_compiler = 'ksh'
else
  let b:sh_check_compiler = 'sh'
endif
execute 'compiler '.b:sh_check_compiler
let b:undo_ftplugin .= '|unlet b:current_compiler b:sh_check_compiler'
      \ . '|setlocal errorformat< makeprg<'

" Resort to g:is_posix for correct syntax on older runtime files
" 8.1.257 updated the runtime files to include a fix for this
if exists('b:is_posix') && !has('patch-8.0.257')
  let is_posix = 1
endif

" Queue up undo commands to clear the shell language flags that we set for
" this buffer during filetype detection in filetype.vim, or that the stock
" syntax highlighting chose for us
let b:undo_ftplugin .= '|unlet! b:is_bash b:is_kornshell b:is_posix'

" Stop here if the user doesn't want ftplugin mappings
if exists('no_plugin_maps') || exists('no_sh_maps')
  finish
endif

" Mappings to choose compiler
nnoremap <buffer> <expr> <LocalLeader>c
      \ ':<C-U>compiler '.b:sh_check_compiler.'<CR>'
nnoremap <buffer> <LocalLeader>l
      \ :<C-U>compiler shellcheck<CR>
let b:undo_ftplugin .= '|nunmap <buffer> <LocalLeader>c'
      \ . '|nunmap <buffer> <LocalLeader>l'

" Mapping to insert '\'' with Alt+'; not sure I'll keep this just yet
if has('gui_running')
  inoremap <buffer> <M-'> '\''
  let b:undo_ftplugin .= '|iunmap <buffer> <M-''>'
else
  inoremap <buffer> <Esc>' '\''
  let b:undo_ftplugin .= '|iunmap <buffer> <Esc>'''
endif
