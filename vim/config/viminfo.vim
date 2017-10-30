" Don't keep .viminfo information for files in temporary directories or shared
" memory filesystems; this is because they're used as scratch spaces for tools
" like sudoedit(8) and pass(1) and hence could present a security problem
if has('viminfo') && has('autocmd')
  augroup viminfoskip
    autocmd!
    silent! autocmd BufNewFile,BufReadPre
          \ /tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*,*/shm/*
          \ setlocal viminfo=
  augroup END
endif
