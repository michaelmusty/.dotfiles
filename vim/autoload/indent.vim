" Set the current buffer to space indent
function! indent#spaces(...) abort
  setlocal expandtab

  " If an argument was provided, use that for the number of spaces; otherwise,
  " set 'shiftwidth' to 0, which then copies 'tabstop'
  let &l:shiftwidth = a:0
        \ ? a:1
        \ : 0

  " If we have the patch that supports it, set 'softtabstop' to dynamically
  " mirror the value of 'shiftwidth'; failing that, just copy it
  let &l:softtabstop = has#('patch-7.3.693')
        \ ? -1
        \ : &l:shiftwidth

  call indent#undo()
endfunction

" Set the current buffer to tab indent
function! indent#tabs() abort
  setlocal noexpandtab
  setlocal shiftwidth< softtabstop<
  call indent#undo()
endfunction

" Add commands to b:undo_indent to clean up buffer-local indentation changes
" on a change of filetype
function! indent#undo() abort

  " Check and set a flag so that we only do this once per buffer
  if exists('b:undo_indent_type_set')
    return
  endif
  let b:undo_indent_type_set = 1

  " Either set or append relevant commands to b:undo_indent
  let l:undo = 'setlocal expandtab< shiftwidth< softtabstop< tabstop<'
  if exists('b:undo_indent')
    let b:undo_indent .= '|'.l:undo
  else
    let b:undo_indent = l:undo
  endif

endfunction
