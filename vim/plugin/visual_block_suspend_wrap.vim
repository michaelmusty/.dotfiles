"
" visual_block_suspend_wrap.vim: If 'wrap' is enabled, switch it off after the
" first movement in visual block mode, and put it back after the first
" movement after it's left. My kingdom for a VisualEnter event...
"
if exists('g:visual_block_suspend_wrap') || &compatible
  finish
endif
if !exists('##CursorMoved')
  finish
endif
let g:loaded_visual_block_suspend_wrap = 1

" Flag for whether we've suspended 'wrap'
let s:wrap_suspended = 0

" Function for checking mode and suspending or restoring 'wrap', if applicable
function! s:Check() abort

  " If this is visual block mode...
  if mode() ==# "\<C-V>"

    " ...and 'wrap' is set, suspend it and flag that we did.
    if &wrap
      setlocal nowrap
      let s:wrap_suspended = 1
    endif

  " If it's some other mode, and we've suspended 'wrap' and it's not on,
  " switch it back on and clear the flag
  elseif s:wrap_suspended && !&wrap
    setlocal wrap
    let s:wrap_suspended = 0
  endif

endfunction

" Check the mode after each CursorMoved event, because there isn't a way to
" check for entering or leaving visual mode specifically
augroup visual_block_suspend_wrap
  autocmd!
  autocmd CursorMoved * call s:Check()
augroup END
