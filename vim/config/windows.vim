" Configuration for window features
if has('windows')

  " Show the status in a distinct bar above the command line only if there's
  " more than one window on the screen or in the current tab
  set laststatus=1

  " Don't resize windows we're not splitting (Tmux-like; think Mondrian)
  set noequalalways

  " New split windows appear below or to the right of the existing window,
  " not above or to the left per the default
  set splitbelow
  if has('vertsplit')
    set splitright
  endif

  " Only show the tab bar if there's more than one tab
  if exists('&showtabline')
    set showtabline=1
  endif

  " Get rid of visually noisy folding characters
  if has('folding')
    let &fillchars = 'diff: ,fold: ,vert: '
  endif
endif
