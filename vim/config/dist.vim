" Disable most core plugin stuff that I don't use; after/plugin/dist.vim
" clears these variables later
if has('eval')

  " 2html.vim is often useful, so keep that
  " matchparen.vim I use constantly

  " I handle versioning plugins manually, and have never used .vba
  let g:loaded_getscriptPlugin = 1
  let g:loaded_vimballPlugin = 1

  " This is what grep, sed, Awk, and Perl are for
  let g:loaded_logiPat = 1

  " ^Z, my dudes
  let g:loaded_netrwPlugin = 1

  " Vim servers? What is this, Emacs?
  let g:loaded_rrhelper = 1

  " System dictionaries plus custom per-machine spell files are fine
  let g:loaded_spellfile_plugin = 1

  " If I want to read a file or a file archived within it I'll decompress or
  " unarchive it myself; a text editor should not do this
  let g:loaded_gzip = 1
  let g:loaded_tarPlugin = 1
  let g:loaded_zipPlugin = 1

endif
