" Discard Eunuch's remapping of :W.
if has("user_commands")
    command! -bang -complete=file -nargs=? W w<bang> <args>
endif

