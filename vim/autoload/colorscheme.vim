" Reset window-global value for 'cursorline' based on current colorscheme name
function! colorscheme#UpdateCursorline(colors_name, list) abort

  " Record current tab and window number so we can jump back once we're done
  let l:tab = tabpagenr()
  let l:win = winnr()

  " Set the window-global value for 'cursorline' in each window of each tab;
  " on if the current colorscheme is in the whitelist, and off otherwise; fire
  " the WinEnter and WinLeave events so any other 'cursorline' related hooks
  " can run too
  "
  let l:cursorline = index(a:list, a:colors_name) >= 0
  tabdo windo let &g:cursorline = l:cursorline
        \| silent doautocmd WinEnter,WinLeave

  " Move back to the tab and window the user started in
  execute l:tab . 'tabnext'
  execute l:win . 'wincmd w'
        \| silent doautocmd WinEnter

endfunction
