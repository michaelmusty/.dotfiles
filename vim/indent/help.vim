" Only do this when not done yet for this buffer
if exists('b:did_indent')
  finish
endif
let b:did_indent = 1

" Use hard tabs for editing Vim help files
setlocal noexpandtab
setlocal shiftwidth=0
let b:undo_indent = 'setlocal expandtab< shiftwidth<'
if &softtabstop != -1
  let &softtabstop = &shiftwidth
  let b:undo_indent = 'setlocal softtabstop<'
endif
