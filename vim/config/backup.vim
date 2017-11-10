" Default to no backup files at all, in a way that even ancient/tiny Vims will
" understand; the auto_backupdir.vim plugin will take care of re-enabling this
set nobackup
set nowritebackup

" If backps are enabled, use a more explicit and familiar backup suffix
set backupext=.bak

" Don't back up files in anything named */shm/; they might be password
" files
set backupskip+=*/shm/*
