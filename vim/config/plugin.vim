" Try to run the version of matchit.vim included in the distribution, if there
" is one; extends % to match more than it does by default
silent! runtime macros/matchit.vim

" netrw plugin configuration
if has('eval')

  " Don't show the preamble banner
  let g:netrw_banner = 0

  " Perform file transfers silently
  let g:netrw_silent = 1

  " Use a tree-style file listing
  let g:netrw_liststyle = 3

  " Don't list the current directory shortcut, and don't show tags files
  let g:netrw_list_hide = '^\.$,^tags$'

endif
