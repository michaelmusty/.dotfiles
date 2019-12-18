" Reset window-global value for 'cursorline' based on current colorscheme name
function! colorscheme#UpdateCursorline(colors_name, list) abort
  let l:tab = tabpagenr()
  let l:win = winnr()
  tabdo windo let &g:cursorline = index(a:list, a:colors_name) >= 0
        \| silent doautocmd WinEnter,WinLeave
  execute l:tab . 'tabnext'
  execute l:win . 'wincmd w'
        \| silent doautocmd WinEnter
endfunction
