" Filetype-specific mappings
if &compatible || v:version < 700 || !has('autocmd')
  finish
endif

" No 'loaded' guard; this file is an extension of our .vimrc, and we do want
" to reload it if the .vimrc is re-sourced.

" Set up filetype mapping hooks
augroup filetypemap
  autocmd!

  " Clear existing local leader maps if possible
  autocmd FileType *
        \ silent! call clear_local_maps#Clear()

  " Diff: prune sections
  autocmd FileType diff
        \ nmap <buffer> <LocalLeader>p <Plug>DiffPrune
        \|xmap <buffer> <LocalLeader>p <Plug>DiffPrune

  " HTML: lint, URL-to-link, tidy
  autocmd FileType html
        \ nmap <buffer> <LocalLeader>l <Plug>HtmlLint
        \|nmap <buffer> <LocalLeader>r <Plug>HtmlUrlLink
        \|nmap <buffer> <LocalLeader>t <Plug>HtmlTidy

  " Perl: check, lint, and tidy
  autocmd FileType perl
        \ nmap <buffer> <LocalLeader>c <Plug>PerlCheck
        \|nmap <buffer> <LocalLeader>l <Plug>PerlLint
        \|nmap <buffer> <LocalLeader>t <Plug>PerlTidy

  " PHP: check
  autocmd FileType php
        \ nmap <buffer> <LocalLeader>c <Plug>PhpCheck

  " Shell: check and lint
  autocmd FileType sh
        \ nmap <buffer> <LocalLeader>c <Plug>ShCheck
        \|nmap <buffer> <LocalLeader>l <Plug>ShLint

  " VimL: lint
  autocmd FileType vim
        \ nmap <buffer> <LocalLeader>l <Plug>VimLint

  " Zsh: check
  autocmd FileType zsh
        \ nmap <buffer> <LocalLeader>c <Plug>ZshCheck

augroup END
