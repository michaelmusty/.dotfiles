" Try to run the version of matchit.vim included in the distribution, if there
" is one; extends % to match more than it does by default
silent! runtime macros/matchit.vim

" Match all forms of brackets in pairs (including angle brackets)
set matchpairs=(:),{:},[:],<:>
