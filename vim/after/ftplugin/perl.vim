" Extra configuration for Perl filetypes
if &filetype != 'perl' || &compatible || v:version < 700
  finish
endif

" Use Perl itself for checking and Perl::Tidy for tidying
compiler perl
setlocal equalprg=perltidy
let b:undo_ftplugin = b:undo_ftplugin
      \ . '|unlet b:current_compiler'
      \ . '|setlocal equalprg<'
      \ . '|setlocal errorformat<'
      \ . '|setlocal makeprg<'

" Stop here if the user doesn't want ftplugin mappings
if exists('g:no_plugin_maps') || exists('g:no_perl_maps')
  finish
endif

" Mappings to choose compiler
nnoremap <buffer> <LocalLeader>c
      \ :<C-U>compiler perl<CR>
nnoremap <buffer> <LocalLeader>l
      \ :<C-U>compiler perlcritic<CR>
let b:undo_ftplugin = b:undo_ftplugin
      \ . '|nunmap <buffer> <LocalLeader>c'
      \ . '|nunmap <buffer> <LocalLeader>l'

" Bump version numbers
nmap <buffer> <LocalLeader>v
      \ <Plug>PerlVersionBumpMinor
nmap <buffer> <LocalLeader>V
      \ <Plug>PerlVersionBumpMajor
let b:undo_ftplugin = b:undo_ftplugin
      \ . '|nunmap <buffer> <LocalLeader>v'
      \ . '|nunmap <buffer> <LocalLeader>V'
