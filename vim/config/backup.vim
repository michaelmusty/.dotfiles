" Use backup features if on a UNIX-like system and not using sudo(8)
if !strlen($SUDO_USER) && has('unix')

  " Keep backups with a .bak extension in ~/.vim/backup; the double-slash at
  " the end of the directory is supposed to prod Vim into keeping the full
  " path to the file in its backup filename to avoid collisions, but I don't
  " think it actually works for backups, just undo and swap files
  set backup
  set backupext=.bak
  set backupdir^=~/.vim/backup//

  " This option already includes various temporary directories, but we
  " append to it so that we don't back up anything in a shared memory
  " filesystem either
  set backupskip+=*/shm/*

  " Create the backup directory if necessary and possible
  if !isdirectory($HOME . '/.vim/backup') && exists('*mkdir')
    call mkdir($HOME . '/.vim/backup', 'p', 0700)
  endif

" Don't use backups at all otherwise
else
  set nobackup
  set nowritebackup
endif
