" Only do this when not yet done for this buffer
if exists('b:did_ftplugin')
  finish
endif
let b:did_ftplugin = 1

" Set comment metacharacters
setlocal comments+=fb:-  " Dashed lists
setlocal comments+=fb:*  " Bulleted lists
setlocal comments+=n:>   " Mail quotes
let b:undo_ftplugin = 'setlocal comments<'

" Spellcheck documents we're actually editing (not just viewing)
if has('spell') && &modifiable && !&readonly
  setlocal spell
  let b:undo_ftplugin .= '|setlocal spell<'
endif
