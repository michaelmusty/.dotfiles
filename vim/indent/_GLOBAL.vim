" Source this file (probably with :runtime) to explicitly set local indent
" settings for a buffer back to the global settings, in case it was changed
" by a prior filetype (e.g. VimL).
setlocal autoindent<
setlocal expandtab<

" Unfortunately, older versions of Vim (6.2 is known) accept neither the
" `option<` nor `option=` syntax for resetting these numeric values, so we do
" it this clunkier way.
execute 'setlocal shiftwidth='.&g:shiftwidth
execute 'setlocal softtabstop='.&g:softtabstop
execute 'setlocal tabstop='.&g:tabstop
