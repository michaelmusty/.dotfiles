" Default to no backup files at all, in a way that even ancient/tiny Vims will
" understand; the auto_cache_dirs.vim plugin will take care of re-enabling
" this with a 'backupdir' setting
set nobackup
set nowritebackup

" If backups are enabled, use a more explicit and familiar backup suffix
set backupext=.bak

" Don't back up files in anything named */shm/; they might be password
" files
set backupskip+=*/shm/*
