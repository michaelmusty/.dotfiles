" Use Perl itself for checking and Perl::Tidy for tidying
compiler perl
let b:undo_ftplugin .= '|unlet b:current_compiler'
      \ . '|setlocal errorformat< makeprg<'
if executable('perltidy')
  setlocal equalprg=perltidy
  let b:undo_ftplugin .= '|setlocal equalprg<'
endif

" Fold based on indent level, but start with all folds open
setlocal foldmethod=indent
setlocal foldlevel=99
let b:undo_ftplugin .= '|setlocal foldmethod< foldlevel<'

" Add angle brackets to pairs of matched characters for q<...>
setlocal matchpairs+=<:>
let b:undo_ftplugin .= '|setlocal matchpairs<'

" Specify ERE regex (close to perlre) for regex_escape.vim
let b:regex_escape_flavor = 'ere'
let b:undo_ftplugin .= '|unlet b:regex_escape_flavor'

" Stop here if the user doesn't want ftplugin mappings
if exists('no_plugin_maps') || exists('no_perl_maps')
  finish
endif

" Add boilerplate intelligently
command -buffer Boilerplate
      \ call perl#Boilerplate()
nnoremap <buffer> <LocalLeader>b
      \ :<C-U>Boilerplate<CR>
let b:undo_ftplugin .= '|delcommand Boilerplate'
      \ . '|nunmap <buffer> <LocalLeader>b'

" Mappings to choose compiler
nnoremap <buffer> <LocalLeader>c
      \ :<C-U>compiler perl<CR>
nnoremap <buffer> <LocalLeader>l
      \ :<C-U>compiler perlcritic<CR>
let b:undo_ftplugin .= '|nunmap <buffer> <LocalLeader>c'
      \ . '|nunmap <buffer> <LocalLeader>l'

" Mappings to choose 'equalprg'
nnoremap <buffer> <LocalLeader>t
      \ :<C-U>setlocal equalprg=perltidy<CR>
nnoremap <buffer> <LocalLeader>i
      \ :<C-U>setlocal equalprg<<CR>
let b:undo_ftplugin .= '|nunmap <buffer> <LocalLeader>t'
      \ . '|nunmap <buffer> <LocalLeader>i'

" Bump version numbers
nmap <buffer> <LocalLeader>v
      \ <Plug>(PerlVersionBumpMinor)
nmap <buffer> <LocalLeader>V
      \ <Plug>(PerlVersionBumpMajor)
let b:undo_ftplugin .= '|nunmap <buffer> <LocalLeader>v'
      \ . '|nunmap <buffer> <LocalLeader>V'
