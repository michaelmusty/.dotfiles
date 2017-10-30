" Lie to the php.vim indent file and tell it that it's already loaded itself,
" to stop it processing its ridiculous expression-based indenting that never
" seems to do what I want. Just plain autoindent is fine.
let b:did_indent = 1

" Explicitly set indent level; this matches the global default, but it's tidy
" to enforce it in case we changed from a filetype with different value (e.g.
" VimL)
setlocal shiftwidth=4
setlocal softtabstop=4
setlocal tabstop=4
