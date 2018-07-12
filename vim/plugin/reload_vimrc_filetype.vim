"
" reload_vimrc_filetype.vim: Add hook to reload active buffer's filetype when
" vimrc reloaded, so that we don't end up indenting four spaces in an open
" VimL file, etc. Requires Vim 7.1 or 7.0 with patch 187 (SourceCmd event.)
"
" Author: Tom Ryder <tom@sanctum.geek.nz>
" License: Same as Vim itself
"
if exists('g:loaded_reload_vimrc_filetype') || &compatible
  finish
endif
if !has('autocmd') || v:version < 700 || v:version == 700 && !has('patch187')
  finish
endif
let g:loaded_reload_vimrc_filetype = 1

" This SourceCmd intercepts :source for .vimrc
augroup reload_vimrc_filetype
  autocmd SourceCmd $MYVIMRC
        \ source <afile>
        \|doautocmd filetypedetect BufRead
        \|echomsg 'Reloaded vimrc: '.expand('<afile>')
augroup END
