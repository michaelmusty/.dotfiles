if exists('loaded_utc')
  finish
endif
let loaded_utc = 1

" Define a :UTC command wrapper, implemented with a script-local function of
" the same name.  Use expand('$TZ') to ensure we're getting the value of the
" current timezone from the environment, and cache that in a local variable
" just long enough to manipulate the environment into using UTC for a command.
"
" While this is a tidy way to abstract the operation for the map, I don't like
" the function implementation much at all.  It works OK in stable versions of
" Vim, but changing an environment variable just long enough to affect the
" outcome of a command as a side effect seems a bit gross.
"
" Worse, the whole thing presently seems to be broken in v8.1.1487; the
" timezone first chosen seems to 'stick' permanently, and the mapping each
" produce timestamps in that zone.  I haven't worked out why this happens yet.
" Using the new getenv() and setenv() functions does not seem to fix it.  It
" works fine in Debian GNU/Linux's packaged v8.0.x.

function! s:UTC(command) abort
  let tz = expand('$TZ')
  let $TZ = 'UTC' | execute a:command | let $TZ = tz
endfunction

" The :UTC command itself completes another command name, and accepts one
" required argument, which it passes in quoted form to the helper function.
"
command! -bar -complete=command -nargs=1 UTC
      \ call s:UTC(<q-args>)
