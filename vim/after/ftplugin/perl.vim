" Extra configuration for Perl filetypes
if &filetype !=# 'perl' || v:version < 700 || &compatible 
  finish
endif

" Use Perl itself for checking and Perl::Tidy for tidying
compiler perl
setlocal equalprg=perltidy
let b:undo_ftplugin .= '|unlet b:current_compiler'
      \ . '|setlocal equalprg< errorformat< makeprg<'

" Add angle brackets to pairs of matched characters for q<...>
setlocal matchpairs+=<:>
let b:undo_ftplugin .= '|setlocal matchpairs<'

" Function to add boilerplate intelligently
function! s:Boilerplate() abort

  " Flag whether the buffer started blank
  let l:blank = line2byte(line('$') + 1) <= 2

  " This is a .pm file, guess its package name from path
  if expand('%:e') ==# 'pm'

    let l:match = matchlist(expand('%:p'), '.*/lib/\(.\+\).pm$')
    if len(l:match)
      let l:package = substitute(l:match[1], '/', '::', 'g')
    else
      let l:package = expand('%:t:r')
    endif

  " Otherwise, just use 'main'
  else
    let l:package = 'main'
  endif

  " Lines always to add
  let l:lines = [
        \ 'package '.l:package.';',
        \ '',
        \ 'use strict;',
        \ 'use warnings;',
        \ 'use utf8;',
        \ '',
        \ 'use 5.006;',
        \ '',
        \ 'our $VERSION = ''0.01'';',
        \ ''
        \ ]

  " Conditional lines depending on package
  if l:package ==# 'main'
    let l:lines = ['#!perl'] + l:lines
  else
    let l:lines = l:lines + ['', '1;']
  endif

  " Add all the lines in the array
  for l:line in l:lines
    call append(line('.') - 1, l:line)
  endfor

  " If we started in a completely empty buffer, delete the current blank line
  if l:blank
    delete
  endif

  " If we added a trailing '1' for a package, move the cursor up two lines
  if l:package !=# 'main'
    -2
  endif

endfunction

" Stop here if the user doesn't want ftplugin mappings
if exists('g:no_plugin_maps') || exists('g:no_perl_maps')
  finish
endif

" Add boilerplate intelligently
nnoremap <buffer> <silent> <LocalLeader>b
      \ :<C-U>call <SID>Boilerplate()<CR>
let b:undo_ftplugin .= '|nunmap <buffer> <LocalLeader>b'

" Mappings to choose compiler
nnoremap <buffer> <LocalLeader>c
      \ :<C-U>compiler perl<CR>
nnoremap <buffer> <LocalLeader>l
      \ :<C-U>compiler perlcritic<CR>
let b:undo_ftplugin .= '|nunmap <buffer> <LocalLeader>c'
      \ . '|nunmap <buffer> <LocalLeader>l'

" Bump version numbers
nmap <buffer> <LocalLeader>v
      \ <Plug>(PerlVersionBumpMinor)
nmap <buffer> <LocalLeader>V
      \ <Plug>(PerlVersionBumpMajor)
let b:undo_ftplugin .= '|nunmap <buffer> <LocalLeader>v'
      \ . '|nunmap <buffer> <LocalLeader>V'
