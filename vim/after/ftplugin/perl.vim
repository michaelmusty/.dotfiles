" Use Perl itself for checking and Perl::Tidy for tidying
compiler perl
setlocal equalprg=perltidy
let b:undo_ftplugin .= '|unlet b:current_compiler'
      \ . '|setlocal equalprg< errorformat< makeprg<'

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
nnoremap <buffer> <silent> <LocalLeader>b
      \ :<C-U>call perl#Boilerplate()<CR>
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
