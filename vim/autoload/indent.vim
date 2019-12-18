function! indent#spaces(...) abort
  setlocal expandtab
  let &l:shiftwidth = a:0
        \ ? a:1
        \ : 0
  let &l:softtabstop = has#('patch-7.3.693')
        \ ? -1
        \ : &l:shiftwidth
  call indent#undo()
endfunction

function! indent#tabs() abort
  setlocal noexpandtab shiftwidth< softtabstop<
  call indent#undo()
endfunction

function! indent#undo() abort
  if exists('b:undo_indent_set')
    return
  endif
  let l:undo = 'call indent#reset()'
  if exists('b:undo_indent')
    let b:undo_indent .= '|'.l:undo
  else
    let b:undo_indent = l:undo
  endif
  let b:undo_indent_set = 1
endfunction

function! indent#reset() abort
    setlocal expandtab< shiftwidth< softtabstop< tabstop<
endfunction
