"
" cursorline_current: If 'cursorline' is globally on, only enable it for the
" current window, and only when not in insert mode. Essentially, make
" 'cursorline' follow the actual normal-mode cursor as much as possible.
"
" Author: Tom Ryder <tom@sanctum.geek.nz>
" License: Same as Vim itself
"
if exists('g:loaded_cursorline_current') || &compatible
  finish
endif
if !has('autocmd') || !has('windows') || v:version < 700
  finish
endif
let g:loaded_cursorline_current = 1

" Suspend 'cursorline' when a window is inactive or inserting
function! s:Suspend() abort
  let w:cursorline_current_cache = &l:cursorline
  setlocal nocursorline
endfunction

" Restore 'cursorline' when a window is active and non-insert
function! s:Restore() abort

  " If we don't have a value for 'cursorline' from a previous s:Suspend(), use
  " the global value as the default
  if !exists('w:cursorline_current_cache')
    let w:cursorline_current_cache = &g:cursorline
  endif

  " Restore local value to the cached value and clear it
  let &l:cursorline = w:cursorline_current_cache
  unlet w:cursorline_current_cache

endfunction

" Call s:Suspend() on all windows besides the current one
function! s:Load() abort

  " Cache current window index
  let l:wcur = winnr()

  " Iterate through all the windows and suspend all but the current one
  for l:wnum in range(1, winnr('$'))
    if l:wnum != l:wcur
      execute l:wnum . 'wincmd w'
      call s:Suspend()
    endif
  endfor

  " Return to the window in which we started
  execute l:wcur . 'wincmd w'

endfunction

" Set up hooks for toggling 'cursorline'
augroup cursorline_current
  autocmd!

  " Turn off 'cursorline' for other windows on load
  autocmd VimEnter * call s:Load()

  " Turn off 'cursorline' when leaving a window
  autocmd WinLeave * call s:Suspend()
  autocmd WinEnter * call s:Restore()

  " Turn off 'cursorline' when in insert mode
  autocmd InsertEnter * call s:Suspend()
  autocmd InsertLeave * call s:Restore()

augroup END
