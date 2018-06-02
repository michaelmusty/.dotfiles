" Git commit messages
autocmd BufNewFile,BufRead
      \ COMMIT_EDITMSG,MERGE_MSG,TAG_EDITMSG
      \ setfiletype gitcommit
