" Try to run the version of matchit.vim included in the distribution, if there
" is one; extends % to match more than it does by default
silent! runtime macros/matchit.vim

" Disable most core plugin stuff that I don't use
if has('eval')

  " 2html.vim is often useful, so keep that
  " matchparen.vim I use constantly

  " I handle versioning plugins manually, and have never used .vba
  let g:loaded_getscriptPlugin = 'skipped'
  let g:loaded_vimballPlugin = 'skipped'

  " This is what grep, sed, Awk, and Perl are for
  let g:loaded_logiPat = 'skipped'

  " ^Z, my dudes
  let g:loaded_netrwPlugin = 'skipped'

  " Vim servers? What is this, Emacs?
  let g:loaded_rrhelper = 'skipped'

  " System dictionaries plus custom per-machine spell files are fine
  let g:loaded_spellfile_plugin = 'skipped'

  " If I want to read a file or a file archived within it I'll decompress or
  " unarchive it myself; a text editor should not do this
  let g:loaded_gzip = 'skipped'
  let g:loaded_tarPlugin = 'skipped'
  let g:loaded_zipPlugin = 'skipped'

endif
